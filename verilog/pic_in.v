`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:03:52 03/11/2019 
// Design Name: 
// Module Name:    pic_in 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pic_in
#(
	parameter									bits						=	16		,	//quantization bit number
	parameter									bits_shift				=	4		,	//we can shift but not multy
	parameter									channel_num 			= 	1		,	//number of the channel of the picture
	parameter									channel_height_num	=	4		,
	parameter									channel_length_num	=	4		,
	parameter									channel_paralell_num	=	16		,	//channel_height_num*channel_length_num
	parameter									channel_all_num		=	16		,	//channel_paralell_num*channel_num
	parameter									bits_channel			=	256	,	//bit number of all data,
																								//which is bits*channel_all_num
   parameter									length   				=  100	,	//length of input picture 
	parameter									length_2					=	7		,	//bit number of length
	parameter									height					=	252	,	//height of input picture
	parameter									height_2					=	10		,	//bit number of height
	parameter									filter_size 			= 	5		,	//size of filter is n*n,default 5*5
	parameter									filter_size_2			=	3		,	//the bits of the filter size
	parameter 									stride_height			= 	4		,	//stride of conv in the first conv_layer
	parameter 									stride_height_2		= 	3		,	//bit of stride
	parameter 									stride_length			= 	4		,	//stride of conv in the first conv_layer
	parameter 									stride_length_2		= 	3		,	//bit of stride
	parameter									zero_pad 				= 	0		,	//padding
	parameter									first_height			=	157	,	//convolution number first time in height
	parameter									first_length			=	1		,	//convolution number first time in length
	parameter									weight_num				=	25		,
	parameter									weight_num_2			=	5		,
	parameter									conv_num					=	4		,
	parameter									state_reset				=	0		,	//state to reset
	parameter									state_output			=	1			//state to output data
	)		
	(		
	input			 											clk_in,
	input														rst_n,	
	input														start,				//start to output
	output reg		[bits_channel-1:0]				map,					//picture data
	output reg												ready,					
	output reg		[(conv_num<<bits_shift)-1:0]	weight
    );

//***************************************************************************
//output control,output these blocks one by one,parallel output per channel**
//***************************************************************************
//**************************picture_parameter********************************
reg														state								;	//two states:reset,output
reg						[length_2-1:0]				cnt_length_start				;	//length of the start data
reg						[filter_size_2-1:0]		cnt_length_offset				;	//length offset of current data
reg						[height_2-1:0]				cnt_height_first				;	//length of the first convolution data
reg						[height_2-1:0]				cnt_height_start				;	//height of the start data
reg						[filter_size_2-1:0]		cnt_height_offset				;	//height offset of current data
//**************************weight_parameter*********************************
reg						[weight_num_2-1:0]		cnt_weight_output				;
always@(posedge clk_in or negedge rst_n)
begin
	if(~rst_n)
	begin
		state										<=							state_reset			;
	end
	else
	begin
		if(state == state_reset)
		begin
			cnt_length_start					<=							0						;
			cnt_length_offset					<=							0						;
			cnt_height_first					<=							0						;
			cnt_height_start					<=							0						;
			cnt_height_offset					<=							0						;
			cnt_weight_output					<=							0						;
			ready									<=							1'b0					;
			if(start)
				state								<=							state_output		;
		end
		else if(state == state_output)
		begin
			ready										<=							1'b1											;
			//************************************************************************
			///**************************picture output*******************************
			//************************************************************************
			if(cnt_height_offset == filter_size-1)						//卷积列的最后一个数
			begin
				cnt_height_offset					<=							0												;
				if(cnt_length_offset == filter_size-1)					//卷积行的最后一个数,要执行下一组卷积，卷积按列增
				begin
					cnt_length_offset				<=							0												;
					if(length - filter_size - cnt_length_start < stride_length)	//行上面的最后一个卷积
					begin
						cnt_length_start		<=							0												;
						if(height - filter_size - cnt_height_start < stride_height)//列上面最后一个卷积
						begin
							state						<=							state_reset									;	
						end
						else
						begin
							cnt_height_first		<=							cnt_height_first + stride_height		;
							cnt_height_start		<=							cnt_height_first + stride_height		;
						end
					end
					else
					begin
						cnt_length_start			<=							cnt_length_start + stride_length		;
					end
				end
				else
				begin
					cnt_length_offset				<=							cnt_length_offset + 1'b1				;
				end
			end
			else
			begin
				cnt_height_offset					<=							cnt_height_offset + 	1'b1				;
			end
			//********************************************************************************
			//******************************parameters input**********************************
			//********************************************************************************
			if(cnt_weight_output == weight_num-1)
			begin
				cnt_weight_output 				<=							0									;
			end
			else
			begin
				cnt_weight_output					<=							cnt_weight_output + 1'b1	;
			end
		end
	end
end


wire 				[14:0]					addra			[0:channel_paralell_num-1]					;	
wire				[bits-1:0]				douta			[0:channel_all_num-1]						;
genvar i,j,k;
generate
	for(i = 0; i < channel_num; i = i + 1)
	begin:outdata_channel
		for(j = 0; j < channel_height_num; j = j + 1)
		begin:outdata_height
			for(k = 0; k < channel_length_num; k = k + 1)
			begin:outdata_length
				input_data Input_Data (
				  .clka(clk_in), // input clka
				  .ena(1'b1),
				  .addra(addra[j*channel_length_num+k]), // input [14 : 0] addra
				  .douta(douta[j*channel_length_num+k]) // output [15 : 0] douta
				);

				always@(posedge clk_in)
				begin
					map[((j*channel_length_num+k)<<bits_shift)+bits-1:(j*channel_length_num+k<<bits_shift)]			<=					douta[j*channel_length_num+k]	;		
				end
				assign addra[j*channel_length_num+k]	=	((cnt_height_start+cnt_height_offset+j)<<6) +((cnt_height_start+cnt_height_offset+j)<<5)+((cnt_height_start+cnt_height_offset+j)<<2)+ cnt_length_start+cnt_length_offset + k	;
			end
		end
	end
endgenerate
wire					[(conv_num<<bits_shift)-1:0]		weight_temp	;
weight1 Weight1 (
  .clka(clk_in), // input clka
  .addra(cnt_weight_output), // input [4 : 0] addra
  .douta(weight_temp) // output [31 : 0] douta
);

always@(posedge clk_in)
begin
	weight							<=							weight_temp				;
end
endmodule

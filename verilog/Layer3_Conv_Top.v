`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:01:36 03/12/2019 
// Design Name: 
// Module Name:    Layer3_Conv_Top 
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
module Layer3_Conv_Top#(
	parameter									bits						=	16		,	//quantization bit number
	parameter									bits_shift				=	4		,	//we can shift but not multy
	parameter									channel_num				=	16		,
	parameter									channel_in_num 		=	8		,	//输入数据4通道
	parameter									channel_in_num_2		=	4		,
	parameter 									conv_num					=	128	,	//4*8
	parameter									filter_size				=	25		,
	parameter									filter_size_2			=	5		
	)
	(
	input																clk_in,
	input 															rst_n,
	input 	[(channel_in_num<<bits_shift)-1:0]			data_in,
	input																start,
	input		[(conv_num<<bits_shift)-1:0]					weights,
	output	reg [(channel_num<<bits_shift)-1:0]			data_out,
	output															ready
    );

reg				[(channel_in_num<<bits_shift)-1:0]			data_in_reg										;
wire				[bits-1:0]				data_in_conv			[0:channel_in_num-1]							; 
wire				[bits-1:0]				weight_in_conv			[0:conv_num-1]									;
wire				[bits-1:0]				bias_in_conv			[0:conv_num-1]									;
wire											ready_conv				[0:conv_num-1]									;
wire	signed	[(bits<<1)+filter_size_2:0]					data_conv				[0:conv_num-1]		;
wire  signed	[(bits<<1)-1+filter_size_2+channel_in_num_2-1:0]				data_channel[0:channel_num-1]				;
wire	signed	[(bits<<1)-1:0]		bias						[0:channel_num-1]								;
assign 										ready			=			ready_conv[0]									;
assign										bias[15]		=			32'b11111111111101001101111100110010	;			
assign										bias[14]		=			32'b11111111111100100010011110000010	;
assign										bias[13]		=			32'b00000000000110101101101110111011	;
assign										bias[12]		=			32'b00000000001010101000001010110001	;
assign										bias[11]		=			32'b00000000000011011100010110111101	;
assign										bias[10]		=			32'b11111111111111100000010000000011	;
assign										bias[9]		=			32'b00000000000111010111110000110100	;
assign										bias[8]		=			32'b00000000001000011111100101010101	;
assign										bias[7]		=			32'b11111111111100101100100000010100	;			
assign										bias[6]		=			32'b00000000000010000111011110000110	;
assign										bias[5]		=			32'b00000000000110101010101001011111	;
assign										bias[4]		=			32'b00000000001001101101000010100000	;
assign										bias[3]		=			32'b00000000001011001100000001011101	;
assign										bias[2]		=			32'b11111111111100001001111011111100	;
assign										bias[1]		=			32'b00000000000100000000001100001100	;
assign										bias[0]		=			32'b00000000000010000000000100101000	;
genvar i,j,k,l;
generate
	for(i = 0; i < channel_num; i = i + 1)
	begin:conv_channel
		for(l = 0; l < channel_in_num; l = l + 1)
		begin:conv_in_channel
			Conv_unsign_sign layer_conv(
				.clk_in			(clk_in)											,
				.rst_n			(rst_n)											,
				.data_in			(data_in_conv[l])								,	
				.weight			(weight_in_conv[i*channel_in_num+l])	,
				.bias				(bias[i])										,
				.start			(start)											,
				.data_out		(data_conv[i*channel_in_num+l])			,
				.ready			(ready_conv[i*channel_in_num+l])
				);
		end
		assign	data_channel[i]			=		data_conv[i*channel_in_num]+data_conv[i*channel_in_num+1]+
															data_conv[i*channel_in_num+2]+data_conv[i*channel_in_num+3]+
															data_conv[i*channel_in_num+4]+data_conv[i*channel_in_num+5]+
															data_conv[i*channel_in_num+6]+data_conv[i*channel_in_num+7]-
															((bias[i]<<2)+(bias[i]<<1)+bias[i]);
		always@(posedge clk_in)
		begin
			if(data_channel[i] > 0)
				data_out[(i<<bits_shift)+bits-1:(i<<bits_shift)]		<=		data_channel[i][bits-1+14:14];
			else
				data_out[(i<<bits_shift)+bits-1:(i<<bits_shift)]		<=		0					;
		end
	end
	for(j = 0; j < channel_in_num; j = j + 1)
	begin:conv_data_in
		assign data_in_conv[j]			=			data_in_reg[(j<<bits_shift)+bits-1:(j<<bits_shift)]	;
	end
	for(k = 0; k < channel_num*channel_in_num; k = k + 1)
	begin:conv_parameters_in
		assign weight_in_conv[k]		=			weights[(k<<bits_shift)+bits-1:(k<<bits_shift)]	;
	end
endgenerate	
always@(posedge clk_in)
begin
	data_in_reg								<=			data_in														;
end

integer w_file;
initial w_file = $fopen("mult3.txt");
always @(*)
begin
    $fdisplay(w_file,"%d",data_out[255:240]);
end 
endmodule

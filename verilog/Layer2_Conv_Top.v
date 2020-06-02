`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:54:36 03/12/2019 
// Design Name: 
// Module Name:    Layer2_Conv_Top 
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
module Layer2_Conv_Top#(
	parameter									bits						=	16		,	//quantization bit number
	parameter									bits_shift				=	4		,	//we can shift but not multy
	parameter									channel_num				=	8		,
	parameter									channel_in_num 		=	16		,	//输入数据4*4通道
	parameter									channel_in_num_2		=	5		,
	parameter									channel_out_num		=	32		,
	parameter									channel_para_num		=	4		,
	parameter									channel_serial_num	=	4		,
	parameter 									conv_num					=	128	,	//16*8
	parameter									weight_num				=	32		,	//8*4
	parameter									filter_size				=	25		,
	parameter									filter_size_2			=	5		
	)
	(
	input																clk_in,
	input 															rst_n,
	input 	[(channel_in_num<<bits_shift)-1:0]			data_in,
	input																start,
	input		[(weight_num<<bits_shift)-1:0]				weights,
	output	reg [(channel_out_num<<bits_shift)-1:0]	data_out,
	output															ready
    );

reg				[(channel_in_num<<bits_shift)-1:0]			data_in_reg										;
wire				[bits-1:0]				data_in_conv			[0:channel_in_num-1]							; 
wire				[bits-1:0]				weight_in_conv			[0:channel_num*channel_serial_num-1]	;
wire				[bits-1:0]				bias_in_conv			[0:conv_num-1]									;
wire											ready_conv				[0:conv_num-1]									;
wire	signed	[(bits<<1)+filter_size_2:0]					data_conv				[0:conv_num-1]		;
wire  signed	[(bits<<1)-1+filter_size_2+channel_in_num_2-1:0]				data_channel[0:channel_out_num-1]		;
wire	signed	[(bits<<1)-1:0]		bias						[0:channel_num-1]								;
assign 										ready			=			ready_conv[0]									;
assign										bias[7]		=			32'b00000010001011011111100000011100	;			
assign										bias[6]		=			32'b11111101001011100000000000010100	;
assign										bias[5]		=			32'b00000000000000110001001111001001	;
assign										bias[4]		=			32'b00000010101101000111110100101000	;
assign										bias[3]		=			32'b11111110100011010011000000000010	;
assign										bias[2]		=			32'b00000011001101011110101001010100	;
assign										bias[1]		=			32'b11111111011000010011100110110010	;
assign										bias[0]		=			32'b00000101100110100110000001011000	;
genvar i,j,k,l,m,n;
generate
	for(i = 0; i < channel_num; i = i + 1)
	begin:conv_channel_1
		for(l = 0; l < channel_para_num; l = l + 1)
		begin:conv_channel_2
			for (m = 0; m < channel_serial_num; m = m + 1)
			begin:conv_channel_3
				Conv_unsign_sign layer_conv(
					.clk_in			(clk_in)												,
					.rst_n			(rst_n)												,
					.data_in			(data_in_conv[l*channel_serial_num+m])		,	
					.weight			(weight_in_conv[i*channel_serial_num+m])	,
					.bias				(bias[i])											,
					.start			(start)												,
					.data_out		(data_conv[(i*channel_para_num+l)*channel_serial_num+m])				,
					.ready			(ready_conv[(i*channel_para_num+l)*channel_serial_num+m])
					);
			end
			assign	data_channel[i*channel_para_num+l]		=		data_conv[(i*channel_para_num+l)*channel_serial_num]+
																					data_conv[(i*channel_para_num+l)*channel_serial_num+1]+
																					data_conv[(i*channel_para_num+l)*channel_serial_num+2]+
																					data_conv[(i*channel_para_num+l)*channel_serial_num+3]-
																					((bias[i]<<1)+bias[i]);
		end
	end
	for (n = 0; n < channel_out_num; n = n + 1)
	begin:data_out_para
		always@(posedge clk_in)
		begin
			if(data_channel[n] > 0)
				data_out[(n<<bits_shift)+bits-1:(n<<bits_shift)]		<=		data_channel[n][bits-1+19:19];
			else
				data_out[(n<<bits_shift)+bits-1:(n<<bits_shift)]		<=		0					;
		end
	end
	for(j = 0; j < channel_in_num; j = j + 1)
	begin:conv_data_in
		assign data_in_conv[j]			=			data_in_reg[(j<<bits_shift)+bits-1:(j<<bits_shift)]	;
	end
	for(k = 0; k < channel_num*channel_serial_num; k = k + 1)
	begin:conv_parameters_in
		assign weight_in_conv[k]		=			weights[(k<<bits_shift)+bits-1:(k<<bits_shift)]	;
	end
endgenerate	
always@(posedge clk_in)
begin
	data_in_reg								<=			data_in														;
end

integer w_file4,w_file3;
initial w_file4 = $fopen("mult2_4.txt");
initial w_file3 = $fopen("mult2_3.txt");
always @(*)
begin
    $fdisplay(w_file3,"%d",data_out[495:480]);
	 $fdisplay(w_file4,"%d",data_out[511:496]);
end
endmodule

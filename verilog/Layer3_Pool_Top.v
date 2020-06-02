`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:05:51 03/12/2019 
// Design Name: 
// Module Name:    Layer3_Pool_Top 
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
module Layer3_Pool_Top
#(
	parameter									bits						=	16		,	//quantization bit number
	parameter									bits_shift				=	4		,	//we can shift but not multy
	parameter									channel_num				=	16		
	)
	(
	input																clk_in,
	input 															rst_n,
	input 	[(channel_num<<bits_shift)-1:0]				data_in,
	input																start,
	output	[(channel_num<<bits_shift)-1:0]				data_out,
	output															ready
    );



integer w_file;
initial w_file = $fopen("pool3_1.txt");
always @(*)
begin
    $fdisplay(w_file,"%d",data_out[255:240]);
end 

wire			ready_temp[0:channel_num-1];
assign		ready						=					ready_temp[0]					;
genvar i;
generate
	for (i = 0; i < channel_num; i = i + 1)
	begin:pooling
		maxpool 
			#(
			.bits				(bits)	,
			.pool_size		(4)	,
			.pool_size_2	(3)	
			)
			layer_pool(
			.clk_in			(clk_in),
			.rst_n			(rst_n),
			.data_in			(data_in[(i<<bits_shift)+bits-1:(i<<bits_shift)]),
			.start			(start),
			.data_out		(data_out[(i<<bits_shift)+bits-1:(i<<bits_shift)]),
			.ready			(ready_temp[i])
			);
		
	end
endgenerate
endmodule

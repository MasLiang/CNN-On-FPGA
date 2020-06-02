`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:15:49 03/12/2019 
// Design Name: 
// Module Name:    Layer2_Pool_Top 
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
module Layer2_Pool_Top
#(
	parameter									bits						=	16		,	//quantization bit number
	parameter									bits_shift				=	4		,	//we can shift but not multy
	parameter									channel_bits			=	64		,	//channel_paralell_num*bits
	parameter									channel_bits_shift	=	6		,
	parameter									channel_in_num			=	32		,
	parameter									channel_out_num		=	8	
	)
	(
	input																clk_in,
	input 															rst_n,
	input 	[(channel_in_num<<bits_shift)-1:0]			data_in,
	input																start,
	output	[(channel_out_num<<bits_shift)-1:0]			data_out,
	output															ready
    );


wire			ready_temp[0:channel_out_num-1];
assign		ready						=					ready_temp[0]					;
genvar i;
generate
	for (i = 0; i < channel_out_num; i = i + 1)
	begin:pooling
		maxpool_one_clk layer_pool(
			.clk_in			(clk_in),
			.rst_n			(rst_n),
			.data_in			(data_in[(i<<channel_bits_shift)+channel_bits-1:(i<<channel_bits_shift)]),
			.start			(start),
			.data_out		(data_out[(i<<bits_shift)+bits-1:(i<<bits_shift)]),
			.ready			(ready_temp[i])
			);
		
	end
endgenerate

integer w_file2,w_file3,w_file4,w_file5,w_file6,w_file7,w_file8;
initial w_file2 = $fopen("pool2_2.txt");
initial w_file3 = $fopen("pool2_3.txt");
initial w_file4 = $fopen("pool2_4.txt");
initial w_file5 = $fopen("pool2_5.txt");
initial w_file6 = $fopen("pool2_6.txt");
initial w_file7 = $fopen("pool2_7.txt");
initial w_file8 = $fopen("pool2_8.txt");
always @(*)
begin
    $fdisplay(w_file2,"%d",data_out[111:96]);
	 $fdisplay(w_file3,"%d",data_out[95:80]);
	 $fdisplay(w_file4,"%d",data_out[79:64]);
	 $fdisplay(w_file5,"%d",data_out[63:48]);
	 $fdisplay(w_file6,"%d",data_out[47:32]);
	 $fdisplay(w_file7,"%d",data_out[31:16]);
	 $fdisplay(w_file8,"%d",data_out[15:0]);
end
endmodule

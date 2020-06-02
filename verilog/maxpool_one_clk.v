`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:45:07 03/11/2019 
// Design Name: 
// Module Name:    maxpool_one_clk 
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
module maxpool_one_clk
	#(
	parameter			bits				=		16	,
	parameter			bits_shift		=		4	,
	parameter 			pool_size		=		4	,
	parameter			pool_size_2		=		3	,
	parameter			clk_num			=		2	
	)
	(
	input																	clk_in		,
	input																	rst_n			,
	input			[(pool_size<<bits_shift)-1:0]					data_in		,
	input 																start			,
	output		[bits-1:0]											data_out		,
	output		reg													ready		
    );

reg 					[pool_size_2-1:0]					cnt										;
wire	unsigned		[bits-1:0]							data_temp	[0:clk_num-1]			;
reg															flag										;
wire	unsigned		[bits-1:0]							data_in_reg		[0:pool_size-1]	;
genvar i,j ;
generate
	for (i = 0; i < pool_size; i = i + 1)
	begin
		assign	data_in_reg[i]						=				data_in[(i<<bits_shift)+bits-1:(i<<bits_shift)];
	end
	for (j = 0; j < clk_num; j = j + 1)
	begin
		assign	data_temp[j]						=				(data_in_reg[(j<<1)+1]<data_in_reg[j<<1])?data_in_reg[(j<<1)]:data_in_reg[(j<<1)+1];
	end
endgenerate

assign		data_out = (data_temp[0]< data_temp[1])?data_temp[1]:data_temp[0];
always@(posedge clk_in or negedge rst_n)
begin
	if(~rst_n)
	begin
		cnt							<=							0;
		ready							<=							1'b0;
		flag							<=							1'b0;
	end
	else
	begin
		if(start||flag)
		begin
			if(cnt < clk_num-1)
			begin
				ready										<=								1'b1;
				flag										<=								1'b1;
				cnt										<=								cnt	+	1'b1;
			end
			else
			begin
				flag										<=								1'b0;
				cnt										<=								1'b0;
				ready										<=								1'b0;
			end
		end
	end
end


endmodule

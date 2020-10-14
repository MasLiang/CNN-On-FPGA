`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:06:10 03/12/2019 
// Design Name: 
// Module Name:    maxpool 
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
module maxpool
#(
	parameter			bits				=		8	,
	parameter 			pool_size		=		4	,
	parameter			pool_size_2		=		3	
	)
	(
	input 																clk_in		,
	input 																rst_n			,
	input 	unsigned		[bits-1:0]								data_in		,
	input 																start			,
	output 	reg			[bits-1:0]								data_out		,
	output	reg														ready
    );

reg 					[pool_size_2-1:0]					cnt			;
reg	unsigned		[bits-1:0]							data_temp	;
reg															flag			;
always@(posedge clk_in or negedge rst_n)
begin
	if(~rst_n)
	begin
		cnt							<=							0;
		data_temp					<=							0;
		ready							<=							1'b0;
		flag							<=							1'b0;
	end
	else
	begin
		if(start||flag)
		begin
			if(cnt < pool_size-1)
			begin
				ready										<=								1'b0;
				flag										<=								1'b1;
				cnt										<=								cnt	+	1'b1;
				if(data_temp	<	data_in)
					data_temp							<=								data_in;
			end
			else
			begin
				flag										<=								1'b0;
				cnt										<=								1'b0;
				if(data_temp	<	data_in)
					data_out								<=								data_in;
				else
					data_out								<=								data_temp;
				data_temp								<=								0;
				ready										<=								1'b1;
			end
		end
	end
end
endmodule

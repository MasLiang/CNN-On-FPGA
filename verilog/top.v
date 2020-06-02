`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:29:56 03/11/2019 
// Design Name: 
// Module Name:    top 
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
module top(
	input clk_in,
	input rst_n
    );

wire clk_50			;
wire clk_100		;
wire clk_200		;
wire [255:0]l1d1	;
wire l1r1			;
wire [63:0]l1w1	;
wire [1023:0]l1d2	;
wire l1r2			;
wire [255:0]l1d3	;
wire l1r3			;
wire [255:0]l2d1	;
wire l2r1			;
wire [511:0]l2w1	;
wire [511:0]l2d2	;
wire l2r2			;
wire [127:0]l2d3 	;
wire l2r3			;
wire [255:0]l3d1 	;
wire l3r1			;
wire [2047:0]l3w1	;
wire [255:0]l3d2 	;
wire l3r2			;			
wire [255:0]l3d3 	;
wire l3r3			;
wire [255:0]l4d1 	;
wire l4r1			;
//clock control
clock_pll clock_control
   (
    .CLK_IN1		(clk_in)		,
    .CLK_OUT1		(clk_50)		,
    .CLK_OUT2		(clk_100)	,
    .CLK_OUT3		(clk_200)	,
    .RESET			(~rst_n)		,
    .LOCKED			()
	 );

//layer1
pic_in layer0(		
	.clk_in			(clk_200)	,
	.rst_n			(rst_n)		,	
	.start			(1'b1)		,				
	.map				(l1d1)		,				
	.ready			(l1r1)		,
	.weight			(l1w1)		
    );
Layer1_Conv_Top layer1_conv(
	.clk_in			(clk_200)	,
	.rst_n			(rst_n)		,
	.data_in			(l1d1)		,
	.start			(l1r1)		,
	.weights			(l1w1)		,
	.data_out		(l1d2)		,
	.ready			(l1r2)
    );
Layer1_Pool_Top layer1_pool
	(
	.clk_in			(clk_200)	,	
	.rst_n			(rst_n)		,
	.data_in			(l1d2)		,
	.start			(l1r2)		,
	.data_out		(l1d3)		,
	.ready			(l1r3)
    );
pool1_out_buffer layer1_pool_buffer(
	.clk_in			(clk_200)	,
	.rst_n			(rst_n)		,
	.start			(l1r3)		,
	.data_in			(l1d3)		,
	.data_out		(l2d1)		,
	.ready			(l2r1)		,
	.weight			(l2w1)
    );
	 
//layer2

Layer2_Conv_Top layer2_conv(
	.clk_in			(clk_200)	,
	.rst_n			(rst_n)		,
	.data_in			(l2d1)		,
	.start			(l2r1)		,
	.weights			(l2w1)		,
	.data_out		(l2d2)		,
	.ready			(l2r2)
    );
Layer2_Pool_Top layer2_pool
	(
	.clk_in			(clk_200)	,	
	.rst_n			(rst_n)		,
	.data_in			(l2d2)		,
	.start			(l2r2)		,
	.data_out		(l2d3)		,
	.ready			(l2r3)
    );
pool2_out_buffer layer2_pool_buffer(
	.clk_in			(clk_200)	,
	.rst_n			(rst_n)		,
	.start			(l2r3)		,
	.data_in			(l2d3)		,
	.data_out		(l3d1)		,
	.ready			(l3r1)		,
	.weight			(l3w1)
    );

//layer3

Layer3_Conv_Top layer3_conv(
	.clk_in			(clk_200)	,
	.rst_n			(rst_n)		,
	.data_in			(l3d1)		,
	.start			(l3r1)		,
	.weights			(l3w1)		,
	.data_out		(l3d2)		,
	.ready			(l3r2)
    );
conv3_out_buffer layer3_conv_buffer
	(
	.clk_in			(clk_200)	,
	.rst_n			(rst_n)		,
	.start			(l3r2)		,
	.data_in			(l3d2)		,
	.data_out		(l3d3)		,
	.ready			(l3r3)
    );
Layer3_Pool_Top layer3_pool
	(
	.clk_in			(clk_200)	,	
	.rst_n			(rst_n)		,
	.data_in			(l3d3)		,
	.start			(l3r3)		,
	.data_out		(l4d1)		,
	.ready			(l4r1)
    );

//full_connection
ful_conn  layer4_full_connect(
	.clk_in		(clk_200),
	.rst_n		(rst_n),
	.start		(l4r1),
	.data_in		(l4d1),
	.ready		(),
	.data_out	()
    );
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:06:36 03/12/2019 
// Design Name: 
// Module Name:    ful_conn 
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
module ful_conn
	#(
	parameter				bits									=						16		,
	parameter				bits_shift							=						4		,
	parameter				all_add_num							=						4032	,	//16*9*28
	parameter				all_add_num_2						=						12		,
	parameter				all_add_num_serial				=						252	,	//9*28
	parameter				all_add_num_serial_2				=						8		,
	parameter				channel_in_num						=						16		,
	parameter				channel_in_shift					=						4		,
	parameter				channel_out_num					=						4		,
	parameter				channel_first_full_conn			=						100	,
	parameter				channel_first_paralell_num		=						25		,
	parameter				channel_first_serial_num		=						16		,
	parameter				channel_first_mult_serial_num	=						4		,
	parameter				channel_first_serial_num_2		=						5		,
	parameter				channel_first_mult_serial_num_2=						3		,
	parameter				channel_second_full_conn		=						4		,
	parameter				channel_second_paralell_num	=						1		,
	parameter				channel_second_serial_num		=						4		,
	parameter				mult_num								=						100	,
	parameter				mult_weight_bits					=						1600	,	//400*16/4
	parameter				state_reset							=						0		,
	parameter				state_first_full_conn			=						1		,
	parameter				state_first_bias					=						2		,
	parameter				state_second_full_conn			=						3		,
	parameter				state_second_bias					=						4		,
	parameter				state_output						=						5		,
	parameter				state_num_2							=						3		
	)
	(
	input																						clk_in	,
	input																						rst_n		,
	input																						start		,
	input						[(channel_in_num<<bits_shift)-1:0]					data_in	,
	output																					ready		,
	output		reg		[(channel_out_num<<bits_shift)-1:0]					data_out
    );

									
//////////////////////////////////////////////////////////////////////////////////
/////////////////////////weight1//////////////////////////////////////////////////
wire							[mult_weight_bits-1:0]					weight1[0:3]		;	
wire							[9:0]											addra			;
reg							[9:0]											addra_reg	;
assign						addra						=					addra_reg	;
weight1_fullconn_1 Weight1(.clka(clk_in),.addra(addra),.douta(weight1[3]));
weight2_fullconn_1 Weight2(.clka(clk_in),.addra(addra),.douta(weight1[2]));
weight3_fullconn_1 Weight3(.clka(clk_in),.addra(addra),.douta(weight1[1]));
weight4_fullconn_1 Weight4(.clka(clk_in),.addra(addra),.douta(weight1[0]));

/////////////////////////bias1//////////////////////////////////////////////////
wire							[(channel_first_full_conn<<(bits_shift+1))-1:0]			bias1												;
wire	signed				[(bits<<1)-1:0]													bias1_temp[0:channel_first_full_conn-1];
bias_fullconn_1 Bias1 (.clka(clk_in),.addra(0),.douta(bias1));
///////////////////////weight2//////////////////////////////////////////////////
wire							[1599:0]										weight21;
wire							[1599:0]										weight22;
wire							[1599:0]										weight23;
wire							[1599:0]										weight24;
assign weight21[799:0]=800'b00000001001010000000010100001110000011101011101111111011110011101110100100111110000101111110101111111100100001000010000011011011111101111010000111101110101110111111111110011101000010010011101100011011001100001111100001001111000010100111100111101011101110000000101111101100111100011110011100000101001101010010001001110100000110000100010100010001101110001101010101111001111111111011100011001011000100010000001011011111000001010000011111011100001110111111010001001010000000001000101011111010111010111111010110000001000001111010000011101100111010000000000101010010111101001010001011101011011101111111011100011110111001111000110111110101001111111111101001001011000010010010000011111110001010010001101101101011000111000101010011110000101011111111110011001000000010000001101000000101100110001101101000110001;
assign weight21[1599:800]=800'b11001001001001001111111100111011111011011010000011010010001110011111001100011010000110111111011100001001011010001111000111011000000101110000001111111000101011111111011000000100111101001000001111111000100010011110100110110011101100000000010111110011110101001110100001100111110001001001001000101110010101110001000110001111000110011100011100010001001000010000100001111111000000000000000111110110000110000000110000001010000011000001001000001001000100110001100001000111111010111101010000000110100001011111100101101001101110011010001111011101100010110010010110101001111001010111010111010011110100010000010000110110000110001111000111111011000011001110111010010011000001001100101000000110011100010000101111110001101111101001101100000101011001100000111001100000001000010001011100101011011010100000100000111110;
assign weight22[799:0]=800'b00010101101001101111010111001000101011011001011100001000011111101111001110010111111101011010010100110001010110011111001001110101000101111011100000001001100100001111011011110111111110011000110000001100101010000000101100001100111111101111001000001000110110000000010000010000001000100111111111111010110100110000001111011111111100010111000000001100000111111110101010000111111110110100000011011000100101110000110100111011111011100110110100000000101111101110010111101010000001001110111111101011011101101110110111100001000010110100111111110010000000011111010100111000000110001011001100000101101110001111011110101111000010011111010111011101010001110000100001001101000010101110101111011101010101001111111110110101000101000111100111010111111001001100011010111011111111011010110111011011000011010000110110101010;
assign weight22[1599:800]=800'b00011100000000100000011010110001111101101101111000010111100011001111010011000110111011000110101011110110100010011101000010101111111001100001011000000111000001101110000110110100111100001111100011000010111101101111110100101111000111000100100011100001011110001111100111010111111010011100101111101000000010101111101101110001000100010000101111011110100011011101010010011010111111100011011011111011101000011111011100011110111110110010000100010001001000110000001011010100111111100010011100111000100001011111100101110101000100001111000111010000101101111111010000010111000011000100010011001011011110011111111100001011111111000001100011001000010101100000110100001001111101100011101111111110010100000000110000110100000111101111101000000100011001101110011101110001111100111000111111100101100001000000010000000010;
assign weight23[799:0]=800'b11100001010000110000011110101110110111110111011111111111111110001111010110101000000100011011010111101100001011101111111100111010110010111100111100000011011000111111111110101001111110110110111000000110011000111111010010101110000001111011000000000010100101100000001101111111110010011011110100001001110011110000110010110101000110010111101011010110001000000001000101010110000001100001001000011110010001111110001111110100111011111010000000101100010001100000110110001100111010110110110011110001111101101111111111001100111001111110101100001100000001011111010100100010110011000001110011111010010010110000001101001001000100100110110000000001011000101111011100010110111101010010101011101011000110000000011000000100111111000110111011110100101110110010000010001011111011100101100100100101000110101111110000111000;
assign weight23[1599:800]=800'b11001110001011001111001011011011111111010110010011011010001001001111001110001110111111110011110111111100001111100000110101000010000100101100110011011110100010000001001010101001000100100111010000011101000000001101110000101000000110100110110100111110101001011111010101110011000110011101000011111011001111011111111100000011110110111011001100010110011010011110101111100100111100100000100100001000110011100000010101001111111101110100111011101011100001010001010010010000000111100001010011100100101100000000101001000010000110001011001100001101101101110010000100111110111111011101010000011111011100001110101000100111111011001000010100011011011100110000100011101100111011000000011000001111001010010001001011110000111111101001110000001010110011001111010100011000000110110111100011110110000100000000011011000101;
assign weight24[799:0]=800'b11111111100011110001010010001101111111110010011111110100011111000000110000111100110111101101010011101011001101011101001011110100000010010111010000001101011000110000101010010111111111100101100011011101011111110000101110011101000010111000100000010100000001111111000000010110000111111010000100000000010010001110000000101000110111110001011100000001000010110000011111111101000000011000011100010101110100011110111100011110000110001001000011110101111011100001001110110000111110111011001000010000111110111111101110101101111111101110001000011110111000011111110100011111111111000001110000000111011101110000000100001101111000110101110100011000111000011111101101011111111111100010000000011011111100101101111110111000110111011001001000100110000110001111000111000101000011111011011011010111011110000001110010001110;
assign weight24[1599:800]=800'b00101101000000111101110101101000111101000111111011111100011010111111011011010011111010111100111000000010001101100001010100101111111101011110010111111100011000110001011001000101110111011100111011110110011000110000111010101111000001000110010111000101101001110001000111110011000110011110110111000010100001011101100011000101110101001010011000000011001011100000100001010011111111011010011011110100011111111111001100100111000001010101100000001001000011011110001101011001111001110100010111111100100010101111110111000000110110010001011100110010101010011100111000010100110101110011100100011000101010011111011001111011111010100110010100001001011001000000011001010000000010110101110111111100001001101111110010000001110100000110111000000101010111111110111110011011110000011010001110111100100110110000001110100011;


//weight1_fullconn_2 Weight5 (.clka(clk_in),.addra(1'b0),.douta(weight2[0]));
//weight2_fullconn_2 Weight6 (.clka(clk_in),.addra(1'b0),.douta(weight2[1]));
//weight3_fullconn_2 Weight7 (.clka(clk_in),.addra(1'b0),.douta(weight2[2]));
//weight4_fullconn_2 Weight8 (.clka(clk_in),.addra(1'b0),.douta(weight2[3]));
////////////////////////////////////////////////////////////////////////////////////////////////

reg			[state_num_2-1:0]										state															;
reg	signed[all_add_num_2+(bits<<1)-1:0]						first_add_result	[0:channel_first_full_conn-1]	;
wire	signed[all_add_num_2+(bits<<1)-1:0]						first_add_result_temp[0:channel_first_paralell_num-1]	;
reg			[channel_first_serial_num_2-1:0]					cnt_first													;
wire			[bits-1:0]												a[0:mult_num-1]											;
wire signed	[bits-1:0]												b[0:mult_num-1]											;
wire signed	[(bits<<1)-1:0]										p[0:mult_num-1]											;
reg			[channel_first_serial_num-1:0]					first_flag													;
reg			[all_add_num_serial_2-1:0]							cnt_all_add_num_serial									;
reg																		start_delay_1												;
reg																		start_delay_2												;
reg																		start_delay_3												;
reg			[(channel_in_num<<bits_shift)-1:0]				data_in_reg													;
reg			[channel_first_serial_num_2-1:0]					cnt_add_first												;
reg																		start_add_flag												;
reg			[channel_first_serial_num-1:0]					first_flag_delay											;
wire	signed[all_add_num_2+(bits<<1)-1:0]						first_result		[0:channel_first_full_conn-1]	;
wire	signed[39:0]													second_result												;
reg	signed[39:0]													data_out_temp		[0:channel_second_full_conn-1];
reg			[1:0]														cnt_second													;
wire	signed[31:0]bias2[0:3];
assign bias2[3]=32'b00000000011111000010101001001000;
assign bias2[2]=32'b11111111101100101010110111000001;
assign bias2[1]=32'b00000000001000100001100000111010;
assign bias2[0]=32'b00000000001101101111110111011001;
			
always@(posedge clk_in or negedge rst_n)
begin
	if(!rst_n)
	begin
		cnt_add_first								<=							0							;
	end
	else
	begin
		start_delay_2						<=								start_delay_1				;
		start_delay_3						<=								start_delay_2				;
		first_flag_delay					<=								first_flag					;
		if(start_add_flag|(start_delay_1&(!start_delay_2)))
		begin
			if(cnt_add_first < channel_first_serial_num-1)
			begin
				start_add_flag						<=							1'b1						;
				cnt_add_first						<=							cnt_add_first + 1'b1	;
			end
			else
			begin
				start_add_flag						<=							1'b0						;
				cnt_add_first						<=							1'b0						;
			end
		end
	end
end


genvar i,j,k,m,n,o,q;
generate
	for ( i = 0; i < mult_num; i = i + 1)
	begin:multy
		mult mult_16_unsign_sign (.clk(clk_in),.a(a[i]),.b(b[i]),.p(p[i]));	
	end
	
	for(n = 0; n < 25; n = n + 1)
	begin:weigt_in_1
		for(m = 0; m < 4; m = m + 1)
		begin:weigt_in_2
			assign a[n*4+m] = ((state == state_first_full_conn)|(state == state_first_bias))	?
									((cnt_first[1:0]!=2'b00)?
									((cnt_first[1:0]!=2'b01)?
									((cnt_first[1:0]!=2'b10)?
									(data_in[((m+12)<<bits_shift)+bits-1:((m+12)<<bits_shift)]):
									(data_in[((m+8)<<bits_shift)+bits-1:((m+8)<<bits_shift)])):
									(data_in[((m+4)<<bits_shift)+bits-1:((m+4)<<bits_shift)])):
									(data_in[(m<<bits_shift)+bits-1:(m<<bits_shift)]))	:
//									(data_in[((15-m)<<bits_shift)+bits-1:((15-m)<<bits_shift)]):
//									(data_in[((11-m)<<bits_shift)+bits-1:((11-m)<<bits_shift)])):
//									(data_in[((7-m)<<bits_shift)+bits-1:((7-m)<<bits_shift)])):
//									(data_in[((3-m)<<bits_shift)+bits-1:((3-m)<<bits_shift)]))	:
									((first_result[99-(n*4+m)]>0)?first_result[99-(n*4+m)][bits-1+14:14]:0)	;
			assign b[n*4+m] =	((state == state_first_full_conn)|(state == state_first_bias))	?
									((cnt_first[1:0]!=2'b00)?
									((cnt_first[1:0]!=2'b01)?
									((cnt_first[1:0]!=2'b10)?
									(weight1[3][((n*4+m)<<bits_shift)+bits-1:((n*4+m)<<bits_shift)]):
									(weight1[2][((n*4+m)<<bits_shift)+bits-1:((n*4+m)<<bits_shift)])):
									(weight1[1][((n*4+m)<<bits_shift)+bits-1:((n*4+m)<<bits_shift)])):
									(weight1[0][((n*4+m)<<bits_shift)+bits-1:((n*4+m)<<bits_shift)])):
									((cnt_second==0)?
									(weight21[((n*4+m)<<bits_shift)+bits-1:((n*4+m)<<bits_shift)]):
									((cnt_second==1)?
									(weight22[((n*4+m)<<bits_shift)+bits-1:((n*4+m)<<bits_shift)]):
									((cnt_second==2)?
									(weight23[((n*4+m)<<bits_shift)+bits-1:((n*4+m)<<bits_shift)]):
									(weight24[((n*4+m)<<bits_shift)+bits-1:((n*4+m)<<bits_shift)]))));
		end
	end
	
	for ( j = 0; j < channel_first_mult_serial_num; j = j + 1)
	begin:add_first
		for ( k = 0; k < channel_first_paralell_num; k = k + 1)
		begin:add_first_temp
			assign first_add_result_temp[k] = p[k<<2]+p[(k<<2)+1]+p[(k<<2)+2]+p[(k<<2)+3];
			always@(posedge clk_in or negedge rst_n)
			begin
				if(~rst_n)
				begin
					first_add_result[j*channel_first_paralell_num+k]		<=			0		;
				end
				else
				begin
					if(start_add_flag|(start_delay_1&(!start_delay_2)))
					first_add_result[j*channel_first_paralell_num+k]		<=			first_add_result[j*channel_first_paralell_num+k]+
																										(first_flag_delay[j]?first_add_result_temp[24-k]:0)		;
				end
			end
		end
	end
	
	for (q = 0; q < channel_first_full_conn; q = q + 1)
	begin:first_fullconn
		assign bias1_temp[q]	= bias1[(q<<(bits_shift+1))+(bits<<1)-1:(q<<(bits_shift+1))]	;
		assign first_result[q] = first_add_result[q] + bias1_temp[99-q]							;
	end
	
endgenerate

assign second_result	 = 	p[0]+p[1]+p[2]+p[3]+p[4]+p[5]+p[6]+p[7]+p[8]+p[9]+
									p[10]+p[11]+p[12]+p[13]+p[14]+p[15]+p[16]+p[17]+p[18]+p[19]+
									p[20]+p[21]+p[22]+p[23]+p[24]+p[25]+p[26]+p[27]+p[28]+p[29]+
									p[30]+p[31]+p[32]+p[33]+p[34]+p[35]+p[36]+p[37]+p[38]+p[39]+
									p[40]+p[41]+p[42]+p[43]+p[44]+p[45]+p[46]+p[47]+p[48]+p[49]+
									p[50]+p[51]+p[52]+p[53]+p[54]+p[55]+p[56]+p[57]+p[58]+p[59]+
									p[60]+p[61]+p[62]+p[63]+p[64]+p[65]+p[66]+p[67]+p[68]+p[69]+
									p[70]+p[71]+p[72]+p[73]+p[74]+p[75]+p[76]+p[77]+p[78]+p[79]+
									p[80]+p[81]+p[82]+p[83]+p[84]+p[85]+p[86]+p[87]+p[88]+p[89]+
									p[90]+p[91]+p[92]+p[93]+p[94]+p[95]+p[96]+p[97]+p[98]+p[99];

reg flag;

always@(posedge clk_in or negedge rst_n)
begin
	if(!rst_n)
	begin
		state									<=								state_reset					;
		start_delay_1						<=								0								;
	end
	else
	begin
		data_in_reg							<=								data_in						;
		start_delay_1						<=								start							;
		if(state == state_reset)
		begin
			cnt_first						<=								0								;
			state								<=								state_first_full_conn	;
			cnt_all_add_num_serial		<=								0								;
			first_flag						<=								1								;
			addra_reg						<=								0								;
			flag								<=								1'b0							;
			cnt_second						<=								0								;
		end
		else if(state == state_first_full_conn)
		begin	
			if((start&(~start_delay_1))|flag)
			begin
				if((cnt_first[1:0]==2'b11)&(cnt_first!=15))
				begin	
					first_flag					<=								first_flag	<< 1		;
				end
				else if(cnt_first == 15)
				begin
					first_flag					<=								1							;
				end
				else if(cnt_first[1:0]==2'b10)
				begin	
					addra_reg					<=								addra_reg + 1'b1		;
				end
				if(cnt_first == 0)
				begin
					flag							<=								1'b1						;
					first_flag					<=								1							;
					cnt_first					<=								cnt_first + 1'b1		;
				end
				else if(cnt_first < channel_first_serial_num-1)
				begin
					cnt_first					<=								cnt_first + 1'b1		;
				end
				else if(cnt_first == channel_first_serial_num-1)
				begin
					cnt_first					<=								0							;
					flag							<=								1'b0						;	
					if(cnt_all_add_num_serial < all_add_num_serial-1)
					begin
						cnt_all_add_num_serial	<=							cnt_all_add_num_serial + 1'b1;
					end
					else
					begin
						state							<=							state_first_bias		;
						cnt_all_add_num_serial	<=							0							;
					end
				end
			end
		end
		else if(state == state_first_bias)
		begin
			if(!start_add_flag)
			state										<=							state_second_full_conn	;
		end
		else if(state == state_second_full_conn)
		begin
			if(cnt_second == channel_second_serial_num-1)
			begin
				cnt_second								<=						0							;
				state										<=						state_second_bias		;
			end
			else
			begin
				cnt_second								<=						cnt_second + 1'b1		;
			end
			if(cnt_second != 0)
			begin
				data_out_temp[cnt_second-1]		<=						second_result+bias2[cnt_second-1]		;				
			end
		end
		else if(state == state_second_bias)
		begin
			data_out_temp[3]						<=							second_result+bias2[3];	
			state										<=							state_output			;
		end
		else
		begin
			data_out[15:0]							<=							data_out_temp[0][39:24];
			data_out[31:16]						<=							data_out_temp[1][39:24];
			data_out[47:32]						<=							data_out_temp[2][39:24];
			data_out[63:48]						<=							data_out_temp[3][39:24];
		end
	end
end   
endmodule

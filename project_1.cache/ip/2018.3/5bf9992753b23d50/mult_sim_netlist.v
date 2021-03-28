// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sat Mar 27 20:01:55 2021
// Host        : LAPTOP-MCS08PPN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ mult_sim_netlist.v
// Design      : mult
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z045fbg676-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult,mult_gen_v12_0_14,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_14,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (CLK,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [31:0]P;

  wire [15:0]A;
  wire [15:0]B;
  wire CLK;
  wire [31:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "16" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "31" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mult_gen_v12_0_14 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "1" *) (* C_A_WIDTH = "16" *) (* C_B_TYPE = "0" *) 
(* C_B_VALUE = "10000001" *) (* C_B_WIDTH = "16" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "1" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "31" *) 
(* C_OUT_LOW = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynq" *) (* downgradeipidentifiedwarnings = "yes" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mult_gen_v12_0_14
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [15:0]A;
  input [15:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [31:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [15:0]A;
  wire [15:0]B;
  wire CLK;
  wire [31:0]P;
  wire [47:0]NLW_i_mult_PCASC_UNCONNECTED;
  wire [1:0]NLW_i_mult_ZERO_DETECT_UNCONNECTED;

  assign PCASC[47] = \<const0> ;
  assign PCASC[46] = \<const0> ;
  assign PCASC[45] = \<const0> ;
  assign PCASC[44] = \<const0> ;
  assign PCASC[43] = \<const0> ;
  assign PCASC[42] = \<const0> ;
  assign PCASC[41] = \<const0> ;
  assign PCASC[40] = \<const0> ;
  assign PCASC[39] = \<const0> ;
  assign PCASC[38] = \<const0> ;
  assign PCASC[37] = \<const0> ;
  assign PCASC[36] = \<const0> ;
  assign PCASC[35] = \<const0> ;
  assign PCASC[34] = \<const0> ;
  assign PCASC[33] = \<const0> ;
  assign PCASC[32] = \<const0> ;
  assign PCASC[31] = \<const0> ;
  assign PCASC[30] = \<const0> ;
  assign PCASC[29] = \<const0> ;
  assign PCASC[28] = \<const0> ;
  assign PCASC[27] = \<const0> ;
  assign PCASC[26] = \<const0> ;
  assign PCASC[25] = \<const0> ;
  assign PCASC[24] = \<const0> ;
  assign PCASC[23] = \<const0> ;
  assign PCASC[22] = \<const0> ;
  assign PCASC[21] = \<const0> ;
  assign PCASC[20] = \<const0> ;
  assign PCASC[19] = \<const0> ;
  assign PCASC[18] = \<const0> ;
  assign PCASC[17] = \<const0> ;
  assign PCASC[16] = \<const0> ;
  assign PCASC[15] = \<const0> ;
  assign PCASC[14] = \<const0> ;
  assign PCASC[13] = \<const0> ;
  assign PCASC[12] = \<const0> ;
  assign PCASC[11] = \<const0> ;
  assign PCASC[10] = \<const0> ;
  assign PCASC[9] = \<const0> ;
  assign PCASC[8] = \<const0> ;
  assign PCASC[7] = \<const0> ;
  assign PCASC[6] = \<const0> ;
  assign PCASC[5] = \<const0> ;
  assign PCASC[4] = \<const0> ;
  assign PCASC[3] = \<const0> ;
  assign PCASC[2] = \<const0> ;
  assign PCASC[1] = \<const0> ;
  assign PCASC[0] = \<const0> ;
  assign ZERO_DETECT[1] = \<const0> ;
  assign ZERO_DETECT[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "16" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "31" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mult_gen_v12_0_14_viv i_mult
       (.A(A),
        .B(B),
        .CE(1'b0),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_i_mult_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_i_mult_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
g7azmhtm6FcP7uNFjuXJjN8Z6yccOPk3SSjzvKB27peFKmnPmQmov5+YTGwYqqN9LpdyiUExk8K6
vPnJqontvQ==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
MFrqn2K0Cr7TmQ5al162oDGiY83d+AkTWOgFyXPYrTNznygR/tx44RAp24ytphNK9p6shs2EFMg/
Qqz0l8DCWiVEoJ/T8vMpnAn7Y+poGVGS1qAR3qE2njrl81VcGBZJeFaWIudhfr/DLTuuf2T/dWDU
YpelM3KbfYNPPiPy8PU=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FZca5XZouG+/BYoQ8qrJTmnJanku4IprIWRkO6VciHehE5WehR0wsZJhfKlqLEeY1oTPA4bXaxmY
NjYkrop4EOwW8t47/hj2kFLI1OKUAE/TAhCGg/aNSOViUbB3dUomG/y+TBuDt9L6g0Arj1vb/5Pt
IChc5ZdEfRr1lJMTpFfP+5qmEH6lePPdzgPZATPB4Zrj0P6EyiEsU1FKBuAKd9iYNGiLCxVomaz0
3/RwK2Nl+/l4mc7PJt5Hso+4s1qHb4s2wD+OgbIwdH26ZkEnKVFpaLiuWQKu9uhDLGnsBMPf7XDE
p29f+mrvP9Zi/3nonA2aBKrTwR7XuH+ZYoakxA==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
jP68OjlYJglq3zpmKrXOhq7Sex8XNW8fQKp4hUNmuw06OOoKhQASNTnjtyVjAIk/VXb64ViBu1ds
cNMJybDSWBhnChfJq4h9PNybShGJXxSm3NDOo5wUHKf10Eti3fSotB9rVks+tNdTEZo4O97kgfdD
G1FNOqlsYcQiShEGLLiEQ2yYtgJBxJ+jc8mFjIEfPhAYy1ElrvtFEpnhkNS2LfE7xdWOQdO/XoKK
ibeY08pgncTI3pvO6TMbXushf0AX2S7hgfk8ysZrT+0gktqFrJnyR6oljS6VVPLtRNW2vo/cC8XQ
Bzvwwt4cpSo5KLS4XxB6qClZipItck2AUEdIbQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2017_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
o7jAZIoXlFbFtDYmtXhfRBlb07dhBb6Wp03mlT4T0FXtvccSHWhWZgc+VUNwt6TohLihOwvSipPP
XVXpGL4pUVYNdQBCVpFzhMkt6jhyUgsF5t10yI5Of6YEfQrDHigceoBukM3+/zJHPprrPQE6FUvC
wXSGhBCXnHJs1R+n4l0714w8/WftPQhlD9QGQp1qT2VARQXUKBRxcRjxe9TcLfs0P4xnN7uHu0R6
JTmV+MHmhGpetSZGx+B2Wa1MQofUPURqwE70IwBoUhdXH8+39DT5I6x2+wMY6RcVATnhNd2BCgPd
RzAhwfrcqRiU9aB+eNNdFR8ve9M2nGMmV2JxZg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Cl1Dz+fZIDYEIQuUd0pSg+5jknmtX/JERd+yOZ2SRaVra/4pU/eCTjEXMzhz4VFGYB6dgUxMsGBk
nL2WNdn/uaSPpi6mNF0UHQvZik4pUkYPrnRbFveVqW8i1t95SG0RW96uD19206lWrp5U1lqc4fH7
sfKHi8ZpU3MAg0DOO0E=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Qqp76m2aV9ue8Qai7QUavb+lhRYdu/txrnwYLzwTe0vS0S2OD1vxr8VeIT3bF/ZuXlTGm4S/UCSF
bgOPp7VqEOeGNfsSPK+VpQ+foQMENCQYccwKquBDSg/sLjpPK9uuoGLBLxjw2OwsRzplVFXiPcRN
LYK1/FmCP7RJBNgmhh/ti99a+WSl6i2YIIRGocNplQlG8FXq8ZTTHd/x2Gtdf/zGvJOy/fNsos6S
Oq9yJ0rMmbGeWbri5c04gZM08pUmXBsivgOHm2IVEZZFM4SBqrsi0xa52hs2kelc3iKJcWiTvU3X
0fJP9qNFuIjXBPPZvEYwhVtIh6DwiIC2viSscQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bhqoBBokFjdCFhK/II1Xm0OJLhrBRzf+Nv6QJzBaoqoI4z9PfuKO28rAdfIlSQxxM7bcTYaiP9in
qcKciv+8XxjTpz7uYIYPWaBjBMSBoGODbEiIElLGUtWgfczkSJNGUTUhzuP9k1dQ6XO8a8JXFJ5l
x+qtaTWCPTQZ5b69/+GeLD916GnxEZNZfmD6FubWqCt5HvXl65sDol0XyhhOhjMe+tUHA+UkeSx5
n6dwLC4e/3d269ibI3eQxHanWI6ljM9JBlfAG+pvqqbWQxocPbvoiBcFSeNKnMxo9i8icpQXGTd3
ZnH/6ORFohnBarFOuN4Wtv8iegV7E+ui5Qk53w==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
VrIMjYirS5urEjmq+ifqo7qHvXDWzm+b7Vx1FmXKF/iSDeybysi33jCNuWIwLW+OCG2qwNSr9Iej
jp0nH3pSPt6bOUfpppB3qCVCXZIPFUMLjW8cjNWPFXWmRPRJQ7pCi2Nefc4sPlkHmTud0G43hDIr
+NXvFbrAC0bcOhlmrI9Xt+83Mnk/kgRr6hgOZeDVjRKVVonQ34cjwSL5hsWJngdRqH+icJ6+4c/9
rmrIOJq8L2Mzxsojeib9XPpRlwdnrUH15tskgJlJy27u1wwndKbH+MyFt/R+FGqHI7JYA/CRLpsY
mQTgSgZGube01MYxLPEaY0Xn07w7qG5bVWc00w==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 8016)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif

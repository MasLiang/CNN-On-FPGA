// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sat Mar 27 20:01:46 2021
// Host        : LAPTOP-MCS08PPN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ clock_pll_stub.v
// Design      : clock_pll
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z045fbg676-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(CLK_OUT1, CLK_OUT2, CLK_OUT3, RESET, LOCKED, 
  CLK_IN1)
/* synthesis syn_black_box black_box_pad_pin="CLK_OUT1,CLK_OUT2,CLK_OUT3,RESET,LOCKED,CLK_IN1" */;
  output CLK_OUT1;
  output CLK_OUT2;
  output CLK_OUT3;
  input RESET;
  output LOCKED;
  input CLK_IN1;
endmodule

// megafunction wizard: %ALTSQRT%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: ALTSQRT 

// ============================================================
// File Name: SQRT.v
// Megafunction Name(s):
// 			ALTSQRT
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 18.1.0 Build 625 09/12/2018 SJ Standard Edition
// ************************************************************


//Copyright (C) 2018  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module SQRT (
	radical,
	q,
	remainder);

	input	[35:0]  radical;
	output	[17:0]  q;
	output	[18:0]  remainder;

	wire [17:0] sub_wire0;
	wire [18:0] sub_wire1;
	wire [17:0] q = sub_wire0[17:0];
	wire [18:0] remainder = sub_wire1[18:0];

	altsqrt	ALTSQRT_component (
				.radical (radical),
				.q (sub_wire0),
				.remainder (sub_wire1)
				// synopsys translate_off
				,
				.aclr (),
				.clk (),
				.ena ()
				// synopsys translate_on
				);
	defparam
		ALTSQRT_component.pipeline = 0,
		ALTSQRT_component.q_port_width = 18,
		ALTSQRT_component.r_port_width = 19,
		ALTSQRT_component.width = 36;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Stratix IV"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: PIPELINE NUMERIC "0"
// Retrieval info: CONSTANT: Q_PORT_WIDTH NUMERIC "18"
// Retrieval info: CONSTANT: R_PORT_WIDTH NUMERIC "19"
// Retrieval info: CONSTANT: WIDTH NUMERIC "36"
// Retrieval info: USED_PORT: q 0 0 18 0 OUTPUT NODEFVAL "q[17..0]"
// Retrieval info: USED_PORT: radical 0 0 36 0 INPUT NODEFVAL "radical[35..0]"
// Retrieval info: USED_PORT: remainder 0 0 19 0 OUTPUT NODEFVAL "remainder[18..0]"
// Retrieval info: CONNECT: @radical 0 0 36 0 radical 0 0 36 0
// Retrieval info: CONNECT: q 0 0 18 0 @q 0 0 18 0
// Retrieval info: CONNECT: remainder 0 0 19 0 @remainder 0 0 19 0
// Retrieval info: GEN_FILE: TYPE_NORMAL SQRT.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL SQRT.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL SQRT.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL SQRT.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL SQRT_inst.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL SQRT_bb.v TRUE
// Retrieval info: LIB_FILE: altera_mf

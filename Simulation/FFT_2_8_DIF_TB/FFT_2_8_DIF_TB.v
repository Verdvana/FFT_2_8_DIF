//------------------------------------------------------------------------------
//
//Module Name:					FFT_2_8_DIF_TB.v
//Department:					Xidian University
//Function Description:	   基2的八点频率抽取FFT变化实现
//
//------------------------------------------------------------------------------
//
//Version 	Design		Coding		Simulata	  Review		Rel data
//V1.0		Verdvana		Verdvana				        			2019-11-9
//
//-----------------------------------------------------------------------------------

`timescale 1ns/1ns

module FFT_2_8_DIF_TB;

reg clk;
reg rst_n;

reg valid;

reg [15:0] data_in;

wire [36:0] data_out;

FFT_2_8_DIF u_FFT_2_8_DIF(

		.clk(clk),
		.rst_n(rst_n),
		
		.valid(valid),
		
		.data_in(data_in),
		.data_out(data_out)

);

initial begin

	clk = 0;
	forever #(10) 
	clk = ~clk;
	
end

task task_rst;
begin
	rst_n <= 0;
	repeat(2)@(negedge clk);
	rst_n <= 1;
end
endtask

task task_sysinit;
begin
	valid <= 0;
	data_in <= 0;
end
endtask

initial
begin
	task_sysinit;
	task_rst;
	#10;
	
	valid <= 1;
	
	data_in <= 15'd12;
	
	#20;
	
	data_in <= 15'd49;
	
	#20;
	
	data_in <= 15'd2;
	
	#20;
	
	data_in <= 15'd48;
	
	#20;
	
	data_in <= 15'd70;
	
	#20;
	
	data_in <= 15'd13;
	
	#20;
	
	data_in <= 15'd5;
	
	#20;
	
	data_in <= 15'd6;
	
	#20;
	
	
	
	
	
	
	
	
end

endmodule

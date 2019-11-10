//------------------------------------------------------------------------------
//
//Module Name:					FFT_2_8_DIF.v
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

module FFT_2_8_DIF(
	
	/******** 时钟和复位 ********/
		input				clk,			//时钟
		input				rst_n,		//复位
	/******** 数据有效 ********/	
		input				valid,		//数据有效
	/******* 数据输入输出 *******/	
		input	 [15:0]	data_in,		//输入数据
		output [17:0]	data_out		//输出数据

);



//-----------------------------------------------------
//状态计数

reg [3:0] status_cnt;				//状态计数器

always@(posedge clk or negedge rst_n) begin

	if(!rst_n)
		status_cnt <= 4'b0;
	
	else if(valid) begin
		
		if(status_cnt == 4'b1001)	//十个状态：前八个状态将八个数据寄存，后两个状态用于傅里叶变换和数据输出
			
			status_cnt <= 4'b0;
		
		else
			
			status_cnt <= status_cnt + 1'b1;
	
	end
		
	else
		status_cnt <= 4'b0;

end



//-----------------------------------------------------
//数据寄存

reg [15:0] in_r [0:7];

always@(posedge clk) begin

	if(valid) begin
	
		in_r[7] <= data_in;
		in_r[6] <= in_r[7];
		in_r[5] <= in_r[6];
		in_r[4] <= in_r[5];
		in_r[3] <= in_r[4];
		in_r[2] <= in_r[3];
		in_r[1] <= in_r[2];
		in_r[0] <= in_r[1];		//从前往后排列八个数据
		
	end

	else begin
		
		in_r[0] <= 15'b0;
		in_r[1] <= 15'b0;
		in_r[2] <= 15'b0;
		in_r[3] <= 15'b0;
		in_r[4] <= 15'b0;
		in_r[5] <= 15'b0;
		in_r[6] <= 15'b0;
		in_r[7] <= 15'b0;
		
	end
	
end




//-----------------------------------------------------
//第一次蝶形变换

parameter w = 8'd181;	//旋转因子（0.707+0.707i） 扩大256倍

reg signed [24:0]	x1_r [0:3];
reg signed [24:0]	x1_i [0:3];
reg signed [24:0]	x2_r [0:3];
reg signed [24:0]	x2_i [0:3];

always@(status_cnt) begin

	case(status_cnt)
		
		4'b1001: begin
			
			x1_r[0] = (in_r[0] + in_r[4]) * 256;
			x1_r[1] = (in_r[1] + in_r[5]) * 256;
			x1_r[2] = (in_r[2] + in_r[6]) * 256;
			x1_r[3] = (in_r[3] + in_r[7]) * 256;
			
			x1_i[0] = 0;
			x1_i[1] = 0;
			x1_i[2] = 0;
			x1_i[3] = 0;
			
			x2_r[0] = (in_r[0] - in_r[4]) * 256;
			x2_r[1] = (in_r[1] - in_r[5]) * w;
			x2_r[2] = (in_r[2] - in_r[6]) * 0;
			x2_r[3] =-(in_r[3] - in_r[7]) * w;
			
			x2_i[0] = (in_r[0] - in_r[4]) * 0;
			x2_i[1] =-(in_r[1] - in_r[5]) * w;
			x2_i[2] =-(in_r[2] - in_r[6]) * 256;
			x2_i[3] =-(in_r[3] - in_r[7]) * w;
		
		end
	
	endcase

end

//-----------------------------------------------------
//第二次蝶形变换

wire signed [25:0]	x3_r [0:1];
wire signed [25:0]	x3_i [0:1];
wire signed [25:0]	x4_r [0:1];
wire signed [25:0]	x4_i [0:1];
wire signed [25:0]	x5_r [0:1];
wire signed [25:0]	x5_i [0:1];
wire signed [25:0]	x6_r [0:1];
wire signed [25:0]	x6_i [0:1];

assign x3_r[0] =  (x1_r[0] + x1_r[2]) ;
assign x3_i[0] =  (x1_i[0] + x1_i[2]) ;
assign x3_r[1] =  (x1_r[1] + x1_r[3]) ;
assign x3_i[1] =  (x1_i[1] + x1_i[3]) ;

assign x4_r[0] =  (x1_r[0] - x1_r[2]) ;
assign x4_i[0] =  (x1_i[0] - x1_i[2]) ;
assign x4_r[1] =  (x1_i[1] - x1_i[3]) ;
assign x4_i[1] = -(x1_r[1] - x1_r[3]) ;

assign x5_r[0] =  (x2_r[0] + x2_r[2]) ;
assign x5_i[0] =  (x2_i[0] + x2_i[2]) ;
assign x5_r[1] =  (x2_r[1] + x2_r[3]) ;
assign x5_i[1] =  (x2_i[1] + x2_i[3]) ;

assign x6_r[0] =  (x2_r[0] - x2_r[2]) ;
assign x6_i[0] =  (x2_i[0] - x2_i[2]) ;
assign x6_r[1] =  (x2_i[1] - x2_i[3]) ;
assign x6_i[1] = -(x2_r[1] - x2_r[3]) ;


//-----------------------------------------------------
//第三次蝶形变换

wire signed [17:0] y_r [0:7];	
wire signed [17:0] y_i [0:7];	 

assign y_r[0] = ( x3_r[0] + x3_r[1] ) / 256;
assign y_i[0] = ( x3_i[0] + x3_i[1] ) / 256;
                              
assign y_r[4] = ( x3_r[0] - x3_r[1] ) / 256;
assign y_i[4] = ( x3_i[0] - x3_i[1] ) / 256;
                              
assign y_r[2] = ( x4_r[0] + x4_r[1] ) / 256;
assign y_i[2] = ( x4_i[0] + x4_i[1] ) / 256;
                              
assign y_r[6] = ( x4_r[0] - x4_r[1] ) / 256;
assign y_i[6] = ( x4_i[0] - x4_i[1] ) / 256;
                              
assign y_r[1] = ( x5_r[0] + x5_r[1] ) / 256;
assign y_i[1] = ( x5_i[0] + x5_i[1] ) / 256;
                              
assign y_r[5] = ( x5_r[0] - x5_r[1] ) / 256;
assign y_i[5] = ( x5_i[0] - x5_i[1] ) / 256;
                              
assign y_r[3] = ( x6_r[0] + x6_r[1] ) / 256;
assign y_i[3] = ( x6_i[0] + x6_i[1] ) / 256;
                              
assign y_r[7] = ( x6_r[0] - x6_r[1] ) / 256;
assign y_i[7] = ( x6_i[0] - x6_i[1] ) / 256;

//-----------------------------------------------------
//取模（未开方）

wire signed [36:0]	y [0:7]; 

assign y[0] = y_r[0] * y_r[0] + y_i[0] * y_i[0];
assign y[1] = y_r[1] * y_r[1] + y_i[1] * y_i[1];
assign y[2] = y_r[2] * y_r[2] + y_i[2] * y_i[2];
assign y[3] = y_r[3] * y_r[3] + y_i[3] * y_i[3];
assign y[4] = y_r[4] * y_r[4] + y_i[4] * y_i[4];
assign y[5] = y_r[5] * y_r[5] + y_i[5] * y_i[5];
assign y[6] = y_r[6] * y_r[6] + y_i[6] * y_i[6];
assign y[7] = y_r[7] * y_r[7] + y_i[7] * y_i[7];

//-----------------------------------------------------
//顺序输出

reg [36:0] result;

always@(status_cnt) begin

	case(status_cnt)
			
		4'b0000: result  = y[0];
		4'b0001: result  = y[1];
		4'b0010: result  = y[2];
		4'b0011: result  = y[3];
		4'b0100: result  = y[4];
		4'b0101: result  = y[5];
		4'b0110: result  = y[6];
		4'b0111: result  = y[7];
		default: result  = 36'bZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ;
		
	endcase
	
end

//-----------------------------------------------------
//开方
wire [17:0] q;

SQRT	SQRT_inst (
	.radical ( result[35:0] ),
	.q ( q ),
	.remainder ( remainder_sig )
	);
	
assign data_out = (status_cnt == 4'b1000 | status_cnt == 4'b1001) ? 18'bz : q;
		

endmodule





`timescale 1ns/1ps

module tb_sbg_b;

reg clk;
reg [2-1:0] XY;
wire NS_strike;
wire NS_ball;
wire NS_out;
wire Z;

sbg_b sbg_b( .clk( clk ),
			.XY( XY ),
			.NS_strike( NS_strike ),
			.NS_ball( NS_ball ),
			.NS_out( NS_out ),
			.Z( Z ) );

// Save the simulation result
initial
begin
	$dumpfile("sbg_b.vcd");
	$dumpvars;
	$monitor;
end

// Clock signal
initial begin
	clk = 1'b1;
end

// Clock period is 10
always begin
	#5 clk = ~clk;
end

// Initiate variables
initial begin
	sbg_b.NS_strike = 1'b0;
	sbg_b.NS_ball = 1'b0;
	sbg_b.NS_out = 1'b0;
	sbg_b.PS_strike = 1'b0;
	sbg_b.PS_ball = 1'b0;
	sbg_b.PS_out = 1'b0;
	sbg_b.Z = 1'b0;
end

// XY 00: Hit
// XY 01: Out
// XY 10: Ball
// XY 11: Strike

initial begin

	// Hit
	XY = 2'b00;
		
	//  Based on balls
	#19 XY = 2'b10;
	#10 XY = 2'b11;
	#10 XY = 2'b10;
		
	// Hit
	#10 XY = 2'b10;
	#10 XY = 2'b11;
	#10 XY = 2'b00;
	
	// Hit
	#10 XY = 2'b11;
	#10 XY = 2'b10;
	#10 XY = 2'b00;	
	
	// Based on balls
	#10 XY = 2'b11;	
	#10 XY = 2'b10;
	#10 XY = 2'b10;	
	
	// Strike out 
	#10 XY = 2'b11;
	#10 XY = 2'b10;
	#10 XY = 2'b11;
	
	// Out
	#10 XY = 2'b10;
	#10 XY = 2'b11;	
	#10 XY = 2'b01;		
	
	#15 $finish;
	
end

endmodule

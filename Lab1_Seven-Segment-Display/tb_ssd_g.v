`timescale 1ns/1ps

module tb_ssd_g;

reg [4-1:0] X;
wire [7-1:0] Y_gate;

ssd_g ssd_g_1( .X(X), .Y_gate(Y_gate) );

// Save the simulation result
initial
begin
	$dumpfile("ssd_g.vcd");
	$dumpvars;
	$monitor;
end

// Change the value of input 'X'
initial
begin
	#10; X=4'b0000; // 0
	#10; X=4'b0001; // 1
	#10; X=4'b0010; // 2
	#10; X=4'b0011; // 3
	#10; X=4'b0100; // 4
	#10; X=4'b0101; // 5
	#10; X=4'b0110; // 6
	#10; X=4'b0111; // 7
	#10; X=4'b1000; // 8
	#10; X=4'b1001; // 9
	#10; $finish;
end

endmodule
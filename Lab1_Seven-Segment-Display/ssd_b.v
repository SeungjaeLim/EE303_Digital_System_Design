module ssd_b (
input [4-1:0] X,
output reg [7-1:0] Y_behavior
);

// Write verilog(.v) code that converts decimal number (4bits) into 7 segments representation(7bits)
// You must write verilog code in 'behavioural level'

always @ (X) // If the value of input 'X' changes
begin
	case(X)
		// Example
		4'b0000: Y_behavior = 7'b0111111; // If the value of input 'X' is 4'b0000
		/* Fill the below  */
		4'b0001: Y_behavior = 7'b0110000; // If the value of input 'X' is 4'b0001 d1
		4'b0010: Y_behavior = 7'b1011011; // If the value of input 'X' is 4'b0010 d2
		4'b0011: Y_behavior = 7'b1111001; // If the value of input 'X' is 4'b0011 d3
		4'b0100: Y_behavior = 7'b1110100; // If the value of input 'X' is 4'b0100 d4
		4'b0101: Y_behavior = 7'b1101101; // If the value of input 'X' is 4'b0101 d5
		4'b0110: Y_behavior = 7'b1100111; // If the value of input 'X' is 4'b0110 d6
		4'b0111: Y_behavior = 7'b0111000; // If the value of input 'X' is 4'b0111 d7
		4'b1000: Y_behavior = 7'b1111111; // If the value of input 'X' is 4'b1000 d8
		4'b1001: Y_behavior = 7'b1111100; // If the value of input 'X' is 4'b1001 d5
		/* Fill the above  */		
		default: Y_behavior = 7'bxxxxxxx; // Don't care condition
	endcase
end

endmodule
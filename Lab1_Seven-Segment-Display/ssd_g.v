module ssd_g (
input [4-1:0] X,
output [7-1:0] Y_gate
);

// Write verilog(.v) code that converts decimal number (4bits) into 7 segments representation(7bits)
// You must write verilog code in 'gate level'

// Example
assign Y_gate[6] = X[3] | (~X[2]) & X[1] | X[2] & (~X[0]) | X[2] & (~X[1]) ;

/* Fill the below  */
assign Y_gate[5] = X[0] | (~X[1]) | X[2] ;
assign Y_gate[4] = (~X[2]) | X[1] & X[0] | (~X[1]) & (~X[0]) ;
assign Y_gate[3] = X[3] | X[2] & X[0] | (~X[2]) & (~X[0]) | X[1] & X[0] ;
assign Y_gate[2] = X[3] | X[2] & (~X[1]) | (~X[1]) & (~X[0]) | X[2] & (~X[0]) ;
assign Y_gate[1] = (~X[2]) & (~X[0]) | X[1] & (~X[0]);
assign Y_gate[0] = (~X[2]) & (X[1]) | (~X[2]) & (~X[0]) | X[1] & (~X[0]) | X[2] & (~X[1]) & X[0]; 
/* Fill the above  */
endmodule
module sbg_g(
input clk,
input [2-1:0] XY,
output reg NS_strike,
output reg NS_ball,
output reg NS_out,
output reg Z );

// You must write verilog code in 'gate level'

/*
XY 00: Hit
XY 01: Out
XY 10: Ball
XY 11: Strike
*/

/* Register declare */

reg PS_strike;
reg PS_ball;
reg PS_out;
reg [2-1:0] XY_reg;

/* Wire declare */

wire NS_strike_wire;
wire NS_ball_wire;
wire NS_out_wire;
wire Z_wire;

/* You can declare additional reg, wires */

/* Complement */
wire PS_strike_not;	// S'
wire PS_ball_not; 	// B'
wire PS_out_not; 	// O'
wire X_not; 		// X'
wire Y_not; 		// Y'

/* S(NS) */
wire strike_and_Sn; 			//XYS'
wire ball_and_S_and_Bn; 		//XY'SB'

/* B(NS) */
wire ball_and_Bn; 				//XY'B'
wire strike_and_Sn_and_B; 		//XYS'B

/* O(NS) */
wire hit_or_ball_and_O; 		//Y'O
wire out_and_On; 				//X'YO'
wire ball_or_strike_and_O; 		//XS'O
wire out_or_strike_and_S_and_On;//YSO'

/* Z */
wire out_and_O;					//X'YO
wire out_or_strike_and_S_and_O; //YSO

/* Sequential circuit */

always @ (posedge clk) begin

	PS_strike <= NS_strike;
	PS_ball <= NS_ball;
	PS_out <= NS_out;
	XY_reg <= XY;
	
end

/* Combinational circuit */

always @ (*) begin
	/* Very Important! */
	// Do NOT modify this part
	// Use NS_strike_wire, NS_ball_wire, NS_out_wire, and Z_wire as gate output!
	// Do NOT use NS_strike, NS_ball, NS_out, Z as gate output!
	NS_strike = NS_strike_wire;
	NS_ball = NS_ball_wire;
	NS_out = NS_out_wire;
	Z = Z_wire;

end

/* Complement */
not not1( PS_strike_not, PS_strike );
not not1( PS_ball_not, PS_ball);
not not1( PS_out_not, PS_out);
not notl( X_not, XY_reg[1]);
not notl( Y_not, XY_reg[0]);

/* S(NS) = XYS' + XY'SB' */
and and1( strike_and_Sn, XY_reg[1], XY_reg[0], PS_strike_not );
and and1( ball_and_S_and_Bn , XY_reg[1], Y_not, PS_strike, PS_ball_not);
or or1( NS_strike_wire, strike_and_Sn, ball_and_S_and_Bn);

/* B(NS) = XY'B' + XYS'B */
and and1( ball_and_Bn, XY_reg[1], Y_not, PS_ball_not);
and and1( strike_and_Sn_and_B , XY_reg[1], XY_reg[0], PS_strike_not, PS_ball);
or or1( NS_ball_wire, ball_and_Bn, strike_and_Sn_and_B);

/* O(NS) = Y'O + X'YO' + XS'O + YSO' */
and and1( hit_or_ball_and_O, Y_not, PS_out);
and and1( out_and_On, X_not, XY_reg[0], PS_out_not);
and and1( ball_or_strike_and_O, XY_reg[1], PS_strike_not, PS_out);
and and1( out_or_strike_and_S_and_On, XY_reg[0], PS_strike, PS_out_not);
or or1( NS_out_wire, hit_or_ball_and_O, out_and_On, ball_or_strike_and_O, out_or_strike_and_S_and_On);

/* Z = X'YO + YSO */
and and1( out_and_O, X_not, XY_reg[0], PS_out);
and and1( out_or_strike_and_S_and_O, XY_reg[0], PS_strike, PS_out);
or or1( Z_wire, out_and_O, out_or_strike_and_S_and_O);

endmodule
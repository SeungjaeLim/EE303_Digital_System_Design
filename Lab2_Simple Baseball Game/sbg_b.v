module sbg_b(
input clk,
input [2-1:0] XY,
output reg NS_strike,
output reg NS_ball,
output reg NS_out,
output reg Z );

// You must write verilog code in 'behavioural level'

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

/* Sequential circuit */

always @ (posedge clk) begin
	
	PS_strike <= NS_strike;
	PS_ball <= NS_ball;
	PS_out <= NS_out;
	XY_reg <= XY;

end

/* Combinational circuit */

always @ (*) begin

	case( XY_reg )
		
		2'b00: begin // Hit
			NS_strike = 1'b0;
			NS_ball = 1'b0;
		end
	
		2'b01: begin // Out
			NS_strike = 1'b0;
			NS_ball = 1'b0;
			if( PS_out == 0 )	// out count is 0
				begin	// set out count
					NS_out = 1'b1;
				end
			else 				// out count is 1	
				begin	// reset out count, game end
					NS_out = 1'b0;
					Z = 1'b1;
				end
		end

		2'b10: begin // Ball
			if( PS_ball == 0 ) 	// ball count is 0
				begin	// set ball count
					NS_ball = 1'b1;
				end
			else				// ball count is 1
				begin	// reset strike, ball count
					NS_strike = 1'b0;
					NS_ball = 1'b0;
				end
		end

		2'b11: begin // Strike
			if( PS_strike == 0 )	// strike count is 0
				begin	// set strike count
					NS_strike = 1'b1;
				end
			else					// strike count is 1
				begin
					if( PS_out == 0 )	// out count is 0
						begin	// reset strike, ball set out count
							NS_strike = 1'b0;
							NS_ball = 1'b0;
							NS_out = 1'b1;
						end
					else				// out count is 1
						begin	// reset all, game end
							NS_strike = 1'b0;
							NS_ball = 1'b0;
							NS_out = 1'b0;
							Z = 1'b1;
						end	
				end
		end

	endcase

end

endmodule
// countboard_controller.v

module countboard_controller(clk, strike, ball, single, double, triple, homerun, out,
        strike_count_1, strike_count_2, ball_count_1, ball_count_2, ball_count_3, out_count_1, out_count_2, finish);
    input clk, strike, ball, single, double, triple, homerun, out;
    output reg strike_count_1, strike_count_2, ball_count_1, ball_count_2, ball_count_3, out_count_1, out_count_2, finish;

    // Fill the below

    reg [1:0] num_strikes; // counter strike
    reg [2:0] num_balls; // counter ball
    reg [1:0] num_outs; // counter out

    initial begin   // Initialize some values
        // initialize count
        num_strikes = 0;
        num_balls = 0;
        num_outs = 0;

        // clear count board
        assign strike_count_1 = 1'b0;
        assign strike_count_2 = 1'b0;
        assign ball_count_1 = 1'b0;
        assign ball_count_2 = 1'b0;
        assign ball_count_3 = 1'b0;
        assign out_count_1 = 1'b0;
        assign out_count_2 = 1'b0;

        //clear output
        assign finish = 1'b0;
    end

    always @(posedge clk) begin     // Identify input for each rising clock edge
        if (strike) begin
            // when get strike
            num_strikes <= num_strikes + 1;
        end
        else if (ball) begin
            // when get ball
            num_balls <= num_balls + 1;
        end
        else if (out) begin
            // when get out
            num_outs <= num_outs + 1;
        end
        else if (single | double | triple | homerun) begin
            // when get hit
            num_strikes <= 1'b0;
            num_balls <= 1'b0;
        end
    end
    
    always @(num_strikes) begin     // When 'num_strikes' changes
        if (num_strikes == 1) begin
            // 1 strike
            assign strike_count_1 = 1'b1;
            assign strike_count_2 = 1'b0;
        end
        else if (num_strikes == 2) begin
            // 2 strike
            assign strike_count_1 = 1'b1;
            assign strike_count_2 = 1'b1;
        end
        else if (num_strikes == 3) begin
            // 3 strike
            num_outs <= num_outs + 1;     
            assign strike_count_1 = 1'b0;
            assign strike_count_2 = 1'b0;
            num_strikes <= 1'b0;
        end
        else if (num_strikes == 0) begin
            // when clear strike
            assign strike_count_1 = 1'b0;
            assign strike_count_2 = 1'b0;
        end
    end

    always @(num_balls) begin // When 'num_balls' changes
        if (num_balls == 1) begin
            // 1 ball
            assign ball_count_1 = 1'b1;
            assign ball_count_2 = 1'b0;
            assign ball_count_3 = 1'b0;
        end
        else if (num_balls == 2) begin
            // 2 ball
            assign ball_count_1 = 1'b1;
            assign ball_count_2 = 1'b1;
            assign ball_count_3 = 1'b0;
        end
        else if (num_balls == 3) begin
            // 3 ball
            assign ball_count_1 = 1'b1;
            assign ball_count_2 = 1'b1;
            assign ball_count_3 = 1'b1;
        end
        else if (num_balls == 4) begin 
            // 4 ball - ball, strike count reset
            assign ball_count_1 = 1'b0;
            assign ball_count_2 = 1'b0;
            assign ball_count_3 = 1'b0;
            num_balls <= 1'b0;
            num_strikes <= 1'b0;
        end
        else if (num_balls == 0) begin
            // when clear ball
            assign ball_count_1 = 1'b0;
            assign ball_count_2 = 1'b0;
            assign ball_count_3 = 1'b0;
        end

    end

    always @(num_outs) begin //When 'num_outs' changes
        // clear strike
        num_strikes <= 1'b0;
        num_balls <= 1'b0;
        if (num_outs == 1) begin
            // 1 out
            assign out_count_1 = 1'b1;
            assign out_count_2 = 1'b0;
        end
        if (num_outs == 2) begin
            // 2 out
            assign out_count_1 = 1'b1;
            assign out_count_2 = 1'b1;
        end
        if (num_outs == 3) begin
            // 3 out -> end
            assign out_count_1 = 1'b0;
            assign out_count_2 = 1'b0;
            assign finish = 1'b1;
        end
        if (num_outs == 0) begin
            // when clear out
            assign out_count_1 = 1'b0;
            assign out_count_2 = 1'b0;
        end
    end

endmodule

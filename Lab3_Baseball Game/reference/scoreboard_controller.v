// scoreboard_controller.v

module scoreboard_controller(clk, ball, single, double, triple, homerun, ball_count_3, runner_1st, runner_2nd, runner_3rd,
        score_y0, score_y1, score_y2, score_y3, score_y4, score_y5, score_y6);
    input clk, ball, single, double, triple, homerun, ball_count_3, runner_1st, runner_2nd, runner_3rd;
    output reg score_y0, score_y1, score_y2, score_y3, score_y4, score_y5, score_y6;

    reg [3:0] game_score; // total game score
    reg [2:0] scoring; // type of scoring
    reg [2:0] num_balls_score; // counter ball
    reg [2:0] prev_base; // base previous information
   
    initial begin // Initialize some values
        // initialize register
        scoring = 0;
        game_score = 0;
        num_balls_score = 0;
        prev_base = 0;

        // clear score board
        assign score_y0 = 1'b1;
        assign score_y1 = 1'b1;
        assign score_y2 = 1'b1;
        assign score_y3 = 1'b1;
        assign score_y4 = 1'b1;
        assign score_y5 = 1'b1;
        assign score_y6 = 1'b0;
    end

    always @(posedge clk) begin     
    // identify scoring type
        scoring <= 3'b000; // clear scoring type

        // load prev base information
        prev_base[2] <= runner_3rd;
        prev_base[1] <= runner_2nd;
        prev_base[0] <= runner_1st;

        if (ball) begin
            // ball
            num_balls_score <= num_balls_score + 1;
        end
        else if (single) begin
            // single hit
            scoring <= 3'b001;
        end
        else if (double) begin
            // double hit
            scoring <= 3'b010;
        end
        else if (triple) begin
            // triple hit
            scoring <= 3'b011;
        end
        else if (homerun) begin
            // homerun
            scoring <= 3'b100;
        end
    end

    always @(num_balls_score) begin
        if (num_balls_score == 4) begin
            // 4 ball
            if(prev_base[2] == 1) begin
                if(prev_base[1] == 1) begin
                    if(prev_base[0] == 1) begin
                        // every base is full
                        game_score = game_score + 1;
                    end
                end
            end
            num_balls_score <= 3'b000; // clear ball count
        end
        
    end

    always @(scoring) begin
        if (scoring == 1) begin 
            // single hit
            if(prev_base[2] == 1) begin
                game_score = game_score + 1;
            end
        end
        else if (scoring == 2) begin 
            // double hit
            if(prev_base[1] == 1) begin
                game_score = game_score + 1;
            end
            if (prev_base[2] == 1) begin
                game_score = game_score + 1;
            end
        end
        else if (scoring == 3) begin
            // triple hit
            if(prev_base[0] == 1) begin
                game_score = game_score + 1;
            end
            if(prev_base[1] == 1) begin
                game_score = game_score + 1;
            end
            if (prev_base[2] == 1) begin
                game_score = game_score + 1;
            end
        end
        else if (scoring == 4) begin 
            // home run
            game_score = game_score + 1;
            if(prev_base[0] == 1) begin
                game_score = game_score + 1;
            end
            if(prev_base[1] == 1) begin
                game_score = game_score + 1;
            end
            if (prev_base[2] == 1) begin
                game_score = game_score + 1;
            end
        end
    end

    always @(game_score) begin
        // gate level design with lab1
        assign score_y6 = game_score[3] | (~game_score[2]) & game_score[1] | game_score[2] & (~game_score[0]) | game_score[2] & (~game_score[1]) ;
        assign score_y5 = game_score[0] | (~game_score[1]) | game_score[2] ;
        assign score_y4 = (~game_score[2]) | game_score[1] & game_score[0] | (~game_score[1]) & (~game_score[0]) ;
        assign score_y3 = game_score[3] | game_score[2] & game_score[0] | (~game_score[2]) & (~game_score[0]) | game_score[1] & game_score[0] ;
        assign score_y2 = game_score[3] | game_score[2] & (~game_score[1]) | (~game_score[1]) & (~game_score[0]) | game_score[2] & (~game_score[0]) ;
        assign score_y1 = (~game_score[2]) & (~game_score[0]) | game_score[1] & (~game_score[0]);
        assign score_y0 = (~game_score[2]) & (game_score[1]) | (~game_score[2]) & (~game_score[0]) | game_score[1] & (~game_score[0]) | game_score[2] & (~game_score[1]) & game_score[0]; 
    end

endmodule

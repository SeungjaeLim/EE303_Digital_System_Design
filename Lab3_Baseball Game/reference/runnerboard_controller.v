// runnerboard_controller.v

module runnerboard_controller(clk, ball, single, double, triple, homerun, ball_count_3,
        runner_1st, runner_2nd, runner_3rd);
    input clk, ball, single, double, triple, homerun, ball_count_3;
    output reg runner_1st, runner_2nd, runner_3rd;

    reg [2:0] num_balls_runner; // counter ball
    reg [2:0] run_base; // counter # of base run

    initial begin   // Initialize some values
        // initialize register
        num_balls_runner = 0;
        run_base = 0;

        // clear runner board
        assign runner_1st = 1'b0;
        assign runner_2nd = 1'b0;
        assign runner_3rd = 1'b0;
    end
    
    always @(posedge clk) begin     
        run_base <= 3'b000; // clear type of hit
        if (ball) begin
            // get ball
            num_balls_runner <= num_balls_runner + 1;
        end
        else if (single) begin
            // single hit
            run_base <= 3'b001;
        end
        else if (double) begin
            // double hit
            run_base <= 3'b010;
        end
        else if (triple) begin
            // triple hit
            run_base <= 3'b011;
        end
        else if (homerun) begin
            // home run
            run_base <= 3'b100;
        end
    end

    always @(num_balls_runner) begin
        if (num_balls_runner == 4) begin
            // 4 ball
            if(runner_1st == 0) begin
                // 1st base clear
                assign runner_1st = 1'b1;
            end
            else if(runner_2nd == 0) begin
                // push 1st base
                assign runner_2nd = 1'b1;
            end
            else if(runner_3rd == 0) begin
                // push 1st, 2nd base
                assign runner_3rd = 1'b1;
            end
            num_balls_runner <= 3'b000; // clear ball count
        end
    end

    always @(run_base) begin
        if (run_base == 1) begin 
            // single hit
            if(runner_2nd == 1) begin
                assign runner_3rd = 1'b1;
            end
            if(runner_1st == 1) begin
                assign runner_2nd = 1'b1;
            end
            assign runner_1st = 1'b1;
        end
        else if (run_base == 2) begin 
        // double hit
            if(runner_1st == 1) begin
                assign runner_3rd = 1'b1;
            end
            assign runner_2nd = 1'b1;
            assign runner_1st = 1'b0;
        end
        else if (run_base == 3) begin
        // triple hit
            assign runner_3rd = 1'b1;
            assign runner_2nd = 1'b0;
            assign runner_1st = 1'b0;
        end
        else if (run_base == 4) begin
        // home run
            assign runner_3rd = 1'b0;
            assign runner_2nd = 1'b0;
            assign runner_1st = 1'b0;
        end
    end

endmodule

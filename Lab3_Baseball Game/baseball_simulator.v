// baseball_simulator.v

// Uncomment below if you are implementing with reference modules
`include "reference/countboard_controller.v"
`include "reference/runnerboard_controller.v"
`include "reference/scoreboard_controller.v"
//

module baseball_simulator(CLK, STRIKE, BALL, SINGLE, DOUBLE, TRIPLE, HOMERUN, OUT,
        STRIKE_COUNT_1, STRIKE_COUNT_2, BALL_COUNT_1, BALL_COUNT_2, BALL_COUNT_3, OUT_COUNT_1, OUT_COUNT_2, 
        RUNNER_1st, RUNNER_2nd, RUNNER_3rd, SCORE_y0, SCORE_y1, SCORE_y2, SCORE_y3, SCORE_y4, SCORE_y5, SCORE_y6, FINISH);
    input CLK, STRIKE, BALL, SINGLE, DOUBLE, TRIPLE, HOMERUN, OUT;
    output STRIKE_COUNT_1, STRIKE_COUNT_2, BALL_COUNT_1, BALL_COUNT_2, BALL_COUNT_3, OUT_COUNT_1, OUT_COUNT_2, 
        RUNNER_1st, RUNNER_2nd, RUNNER_3rd, SCORE_y0, SCORE_y1, SCORE_y2, SCORE_y3, SCORE_y4, SCORE_y5, SCORE_y6, FINISH;

    // Fill the below

    // Consider implementing with these modules
    
    countboard_controller u0(CLK, STRIKE, BALL, SINGLE, DOUBLE, TRIPLE, HOMERUN, OUT,
            STRIKE_COUNT_1, STRIKE_COUNT_2, BALL_COUNT_1, BALL_COUNT_2, BALL_COUNT_3, OUT_COUNT_1, OUT_COUNT_2, FINISH);
    runnerboard_controller u1(CLK, BALL, SINGLE, DOUBLE, TRIPLE, HOMERUN, BALL_COUNT_3,
            RUNNER_1st, RUNNER_2nd, RUNNER_3rd);
    scoreboard_controller u2(CLK, BALL, SINGLE, DOUBLE, TRIPLE, HOMERUN, BALL_COUNT_3, RUNNER_1st, RUNNER_2nd, RUNNER_3rd,
            SCORE_y0, SCORE_y1, SCORE_y2, SCORE_y3, SCORE_y4, SCORE_y5, SCORE_y6);

    // Fill the above

endmodule


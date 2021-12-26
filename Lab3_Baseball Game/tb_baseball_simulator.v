// tb_baseball_simulator.v

`timescale 1ns/1ps

module tb_baseball_simulator;

integer input_file;
integer scan_file;
reg [127:0] captured_input;
`define NULL 0
`define INPUT_FILE_NAME "input_file.txt"

reg clk;
reg strike, ball, single, double, triple, homerun, out;
wire strike_count_1, strike_count_2, ball_count_1, ball_count_2, ball_count_3, out_count_1, out_count_2,
     runner_1st, runner_2nd, runner_3rd, score_y0, score_y1, score_y2, score_y3, score_y4, score_y5, score_y6, finish;

baseball_simulator dut(clk, strike, ball, single, double, triple, homerun, out,
        strike_count_1, strike_count_2, ball_count_1, ball_count_2, ball_count_3, out_count_1, out_count_2,
        runner_1st, runner_2nd, runner_3rd, score_y0, score_y1, score_y2, score_y3, score_y4, score_y5, score_y6, finish);

initial begin
    input_file = $fopen(`INPUT_FILE_NAME, "r");
    if (input_file == `NULL) begin
        $display("ERROR: Cannot open input file!");
        $finish;
    end
end

initial
begin
    $dumpfile("tb_baseball_simulator.vcd");
    $dumpvars;
    $monitor;
end

// Clock signal
initial begin
    clk = 1'b1;
end

always begin
    #5 clk = ~clk;
end

always @(negedge clk) begin
    if (finish == 1'b1) begin   // 'Finish' reported by simulator
        $finish;
        $fclose(input_file);
    end
    if (!$feof(input_file)) begin   // Read input file line-by-line to identify next input signal
        // Reset all signals
        strike = 0;
        ball = 0;
        single = 0;
        double = 0;
        triple = 0;
        homerun = 0;
        out = 0;

        // Read current line of the input file and generate signal accordingly
        scan_file = $fscanf(input_file, "%s\n", captured_input);
        case(captured_input)
            "STRIKE": strike = 1;
            "BALL": ball = 1;
            "SINGLE": single = 1;
            "DOUBLE": double = 1;
            "TRIPLE": triple = 1;
            "HOMERUN": homerun = 1;
            "OUT": out = 1;
            default: $display("Warning: Ambigous input received");
        endcase
    end
    else begin   // No more input signal to read
        $finish;
        $fclose(input_file);
    end
end

always @(negedge clk) begin
end

endmodule

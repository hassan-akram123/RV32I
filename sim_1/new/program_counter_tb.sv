`timescale 1ns / 1ps

module program_counter_tb;

    // Testbench signals
    logic clk;
    logic rst;
    logic [31:0] pc;

    // Instantiate the program_counter module
    progam_counter uut (
        .clk(clk),
        .rst(rst),
        .pc(pc)
    );

    // Clock generation (period = 10ns)
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;

        // Apply reset for 20ns
        #20;
        rst = 0;

        // Run for some cycles
        #100;

        // Finish simulation
        $finish;
    end

    // Monitor PC value at every positive edge of clock
    initial begin
        $display("Time(ns)   Reset   PC");
        $monitor("%0t       %b       %h", $time, rst, pc);
    end

endmodule

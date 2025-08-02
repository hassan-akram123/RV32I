`timescale 1ns / 1ps

module top_module_tb;

    // Testbench signals
    logic clk;
    logic rst;
    

    // Instantiate DUT
    top_module uut (
        .clk(clk),
        .rst(rst)
        
    );

    // Clock generation: 10ns period
    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize inputs
        rst      = 1;
       

        // Reset pulse
        #10;
        rst=0;
       #230;
         $finish;
    end

    // Monitor for debugging
//    initial begin
//        $monitor("Time=%0t | PC=%h | Instr=%h | ALUSel=%b | rs1=%d | rs2=%d | rd=%d | Data1=%h | Data2=%h | ALU_Out=%h | Mem_Out=%h | DataIn=%h",
//                  $time,
//                  uut.pc,
//                  uut.instruction,
//                  uut.ALUSel,
//                  uut.rs1_addr,
//                  uut.rs2_addr,
//                  uut.rd_addr,
//                  uut.data_out_1,
//                  uut.data_out_2,
//                  uut.ALU_data_out,
//                  uut.main_mem_data_out,
//                  uut.data_in);
//    end

endmodule

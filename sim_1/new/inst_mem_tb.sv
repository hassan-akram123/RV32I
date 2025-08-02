`timescale 1ns / 1ps

module inst_mem_tb;

    // Testbench signals
    logic [31:0] addr;
    logic [31:0] instruction;

    // Instantiate your inst_mem module
    inst_mem uut3 (
        .addr(addr),
        .instruction(instruction)
    );

    // Test sequence
    initial begin
        // Set address and read instructions one by one

        $display("Reading instructions from inst_mem.mem...");

        // Read instruction at address 0x0
        addr = 32'h0000_0000;
        #10;
        $display("Instruction @ 0x%h: %b", addr, instruction);

        // Read instruction at address 0x4
        addr = 32'h0000_0004;
        #10;
        $display("Instruction @ 0x%h: %b", addr, instruction);

        // Read instruction at address 0x8
        addr = 32'h0000_0008;
        #10;
        $display("Instruction @ 0x%h: %b", addr, instruction);

        // Read instruction at address 0xC
        addr = 32'h0000_000C;
        #10;
        $display("Instruction @ 0x%h: %b", addr, instruction);

        // Read instruction at address 0x10
        addr = 32'h0000_0010;
        #10;
        $display("Instruction @ 0x%h: %b", addr, instruction);


  $finish;
    end

endmodule
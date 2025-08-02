`timescale 1ns / 1ps

module imm_gen_tb;

    // Testbench signals
    logic [31:0] instruction;
    logic [31:0] immediate;

    // Instantiate imm_gen module
    imm_gen uut4 (
        .instruction(instruction),
        .immediate(immediate)
    );

    // Test sequence
    initial begin
        $display("=== Immediate Generator Test ===");

        // Test Load instruction (e.g. lw x1, 12(x2)) imm=12
        instruction = 32'b000000000110_00010_010_00001_0000011;
        
        $display("Load imm: %0d (0x%h)", immediate, immediate);
#10;
        // Test Store instruction (e.g. sw x1, 20(x2)) imm=20
        instruction = 32'b0000011_0100_00010_010_00001_0100011;
        #10;
        $display("Store imm: %0d (0x%h)", immediate, immediate);

        // Test Immediate type (addi x1, x2, -8)
        instruction = 32'b11111111000_00010_000_00001_0010011;
        #10;
        $display("I-Type imm (addi -8): %0d (0x%h)", immediate, immediate);

        // Test Shift immediate (slli x1, x2, 4)
        instruction = 32'b000000000100_00010_001_00001_0010011;
        #10;
        $display("Shift imm (slli 4): %0d (0x%h)", immediate, immediate);

        $finish;
    end

endmodule

`timescale 1ns / 1ps

module data_mem_tb;

    // Testbench signals
    logic [31:0] inp_addr;
    logic [31:0] inp_data;
    logic [31:0] data_out;
    logic        write_en;
    logic [2:0]  func3;
    logic        clk;

    // Instantiate your data_mem module
    data_mem uut2 (
        .inp_addr(inp_addr),
        .inp_data(inp_data),
        .data_out(data_out),
        .write_en(write_en),
        .func3(func3),
        .clk(clk)
    );

    // Clock generation (period = 10ns)
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        inp_addr = 0;
        inp_data = 0;
        write_en = 0;
        func3    = 3'b000;

        // Wait 10ns
        #10;

        // Write a full word to address 0 (store word)
        inp_addr  = 32'h0000_0000;
        inp_data  = 32'hDEADBEEF;
        func3     = 3'b010;
        write_en  = 1;
        #10;
        write_en  = 0;

        // Load full word from address 0 (load word)
        func3     = 3'b010;
        #10;
        $display("Load Word @ 0x0: %h", data_out);

        // Load byte (signed) from address 0 (should be 0xEF)
        func3     = 3'b000;
        inp_addr  = 32'h0000_0000;
        #10;
        $display("Load Byte (signed) @ 0x0: %h", data_out);

        // Load half-word (signed) from address 0 (should be 0xBEEF)
        func3     = 3'b001;
        inp_addr  = 32'h0000_0000;
        #10;
        $display("Load Half-Word (signed) @ 0x0: %h", data_out);

        // Load byte (unsigned) from address 0 (should be 0xEF)
        func3     = 3'b100;
        inp_addr  = 32'h0000_0000;
        #10;
        $display("Load Byte (unsigned) @ 0x0: %h", data_out);

        // Load half-word (unsigned) from address 0 (should be 0xBEEF)
        func3     = 3'b101;
        inp_addr  = 32'h0000_0000;
        #10;
        $display("Load Half-Word (unsigned) @ 0x0: %h", data_out);

        // Store byte (0xAA) to address 0
        inp_addr  = 32'h0000_0004;
        inp_data  = 32'hDDEEFFAA;
        func3     = 3'b010;
        write_en  = 1;
        #10;
        write_en  = 0;

        // Load word again to see byte updated
        func3     = 3'b010;
        #10;
        
         func3     = 3'b000;
         #10;
         
         func3     = 3'b001;
                  #10;
                  
                  func3     = 3'b100;
                           #10;
               
        $display("Word after Byte Store @ 0x0: %h", data_out);

        // Finish simulation
        #20;
        $finish;
    end

endmodule

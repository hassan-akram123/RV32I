`timescale 1ns / 1ps

module reg_file_tb;

    // Testbench signals
    logic [31:0] data_in;
    logic [4:0] rs1, rs2, rsw;
    logic [31:0] data_out_1, data_out_2;
    logic clk, rst, RegWEn;

    // Instantiate the reg_file
    reg_file uut5 (
        .data_in(data_in),
        .rs1(rs1),
        .rs2(rs2),
        .rsw(rsw),
        .data_out_1(data_out_1),
        .data_out_2(data_out_2),
        .clk(clk),
        .rst(rst),
        .RegWEn(RegWEn)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        $display("=== Register File Test ===");
        clk = 0;
        rst = 0;
        RegWEn = 0;
        data_in = 0;
        rs1 = 0;
        rs2 = 0;
        rsw = 0;

        // Wait 10ns for initial state
        #10;

        // Write 42 to register x5
        data_in = 32'd42;
        rsw = 5'd5;
        RegWEn = 1;
        #10;

        // Disable write
        RegWEn = 0;
        #10;

        // Read from x5 and x0 (should be 42 and 0)
        rs1 = 5'd5;
        rs2 = 5'd0;
        #5;
        $display("Read x5 = %0d (Expected 42), Read x0 = %0d (Expected 0)", data_out_1, data_out_2);
        
        data_in = 32'd62;
                rsw = 5'd7;
                RegWEn = 1;
                #10;
        
                // Disable write
                RegWEn = 0;
                #10;
        
                // Read from x7 and x0 (should be 62 and 0)
                rs1 = 5'd7;
                rs2 = 5'd0;
                #5;
                $display("Read x5 = %0d (Expected 42), Read x0 = %0d (Expected 0)", data_out_1, data_out_2);


        // Write to x0 (should be ignored)
        data_in = 32'd123;
        rsw = 5'd0;
        RegWEn = 1;
        #10;
        RegWEn = 0;
        #5;

        // Read from x0 again
        rs1 = 5'd0;
        #5;
        $display("Read x0 after write attempt = %0d (Expected 0)", data_out_1);

        $finish;
    end

endmodule

`timescale 1ns / 1ps

module branch_comp_tb;

    // Inputs
    logic [31:0] A, B;
    logic BrUn;
    logic [2:0] Comp_Sel;

    // Outputs
    logic Eq, Lt;

    // Instantiate the Unit Under Test (UUT)
    branch_comp uut (
        .A(A),
        .B(B),
        .BrUn(BrUn),
        .Comp_Sel(Comp_Sel),
        .Eq(Eq),
        .Lt(Lt)
    );

    // Test procedure
    initial begin
        $display("Time\tComp_Sel\tA\t\tB\t\tBrUn\tEq\tLt");

        // Test EQ (Comp_Sel = 000)
        A = 32'd10; B = 32'd10; Comp_Sel = 3'b000; BrUn = 0;
        #10 $display("%0t\t%b\t\t%0d\t%0d\t%b\t%b\t%b", $time, Comp_Sel, A, B, BrUn, Eq, Lt);

        // Test NE (Comp_Sel = 001)
        A = 32'd10; B = 32'd20; Comp_Sel = 3'b001; BrUn = 0;
        #10 $display("%0t\t%b\t\t%0d\t%0d\t%b\t%b\t%b", $time, Comp_Sel, A, B, BrUn, Eq, Lt);

        // Test LT (signed) (Comp_Sel = 100)
        A = -32'sd5; B = 32'sd3; Comp_Sel = 3'b100; BrUn = 0;
        #10 $display("%0t\t%b\t\t%0d\t%0d\t%b\t%b\t%b", $time, Comp_Sel, A, B, BrUn, Eq, Lt);

        // Test LT (unsigned) (Comp_Sel = 100)
        A = 32'd5; B = 32'd3; Comp_Sel = 3'b100; BrUn = 1;
        #10 $display("%0t\t%b\t\t%0d\t%0d\t%b\t%b\t%b", $time, Comp_Sel, A, B, BrUn, Eq, Lt);

        // Test GE (signed) (Comp_Sel = 101)
        A = 32'sd5; B = 32'sd5; Comp_Sel = 3'b101; BrUn = 0;
        #10 $display("%0t\t%b\t\t%0d\t%0d\t%b\t%b\t%b", $time, Comp_Sel, A, B, BrUn, Eq, Lt);

        // Test GE (unsigned) (Comp_Sel = 101)
        A = 32'd2; B = 32'd5; Comp_Sel = 3'b101; BrUn = 1;
        #10 $display("%0t\t%b\t\t%0d\t%0d\t%b\t%b\t%b", $time, Comp_Sel, A, B, BrUn, Eq, Lt);

        // Test SLTU (unsigned less than) (Comp_Sel = 110)
        A = 32'd5; B = 32'd10; Comp_Sel = 3'b110; BrUn = 0;
        #10 $display("%0t\t%b\t\t%0d\t%0d\t%b\t%b\t%b", $time, Comp_Sel, A, B, BrUn, Eq, Lt);

        // Test SGEU (unsigned greater equal) (Comp_Sel = 111)
        A = 32'd20; B = 32'd20; Comp_Sel = 3'b111; BrUn = 0;
        #10 $display("%0t\t%b\t\t%0d\t%0d\t%b\t%b\t%b", $time, Comp_Sel, A, B, BrUn, Eq, Lt);

        $finish;
    end

endmodule

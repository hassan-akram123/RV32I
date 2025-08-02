module branch_comp(
    input  logic [31:0] A, B,
    input  logic        BrUn,
    input  logic [2:0]  Comp_Sel,
    output logic        Eq,
    output logic        Lt
);

    logic signed [31:0] a, b;
 logic eq_flag;
    always_comb begin
        
        Eq = 1'b0;
        Lt = 1'b0;
        
        
        eq_flag = (A == B);
        
        a = $signed(A);
        b = $signed(B);

        case (Comp_Sel)
            3'b000: Eq = eq_flag;                                
            3'b001: Eq = eq_flag;                            
            3'b100: Lt = (a < b);          
            3'b101: Lt =  (a >= b);        
            3'b110: Lt = (A < B);                              
            3'b111: Lt = (A >= B);                             
            
        endcase
    end

endmodule

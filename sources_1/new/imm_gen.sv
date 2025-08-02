`timescale 1ns / 1ps

module imm_gen(
    input  logic [31:7] instruction,
    input  logic [2:0]  imm_sel,         // select immediate type
    output logic [31:0] immediate
);

logic [11:0] imm_i, imm_s, imm_b;
logic [20:0] imm_j;
logic [24:0] imm_u;
logic [2:0] funct3;

assign funct3 = instruction[14:12]; // instruction[14:12] remains at same position in [31:7]

always_comb begin
    // Extract immediates by type
    imm_i = instruction[31:20];
    imm_s = {instruction[31:25], instruction[11:7]};
    imm_b = {instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
    imm_j = {instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
    imm_u = instruction[31:7];

    // Default immediate
    immediate = 32'b0;

    case (imm_sel)
        3'b000: begin // I-type
            if (funct3 == 3'b101) // Shift instructions
                immediate = {20'b0, imm_i};
            else
                immediate = {{20{imm_i[11]}}, imm_i};
        end
        3'b001: immediate = {{20{imm_s[11]}}, imm_s};  // S-type
        
        3'b010:immediate = {{20{instruction[31]}},     // Sign-extend from bit 31
                             instruction[31],            // imm[12]
                             instruction[30:25],         // imm[10:5]
                             instruction[11:7]};    // B-type
                             
        3'b011: immediate = {imm_u, 12'b0};            // U-type (LUI, AUIPC)
        3'b100: immediate = {{11{imm_j[20]}}, imm_j};  // J-type
        3'b110:  immediate = {{20{imm_i[11]}}, imm_i}; //L type
        3'b101: immediate = 32'b0;                     // R-type (no immediate)
        default: immediate = 32'b0;
    endcase
end

endmodule

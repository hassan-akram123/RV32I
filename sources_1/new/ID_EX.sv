`timescale 1ns / 1ps

module ID_EX(
    input  logic        clk,
    input  logic        rst,
    input  logic        ID_EX_flush,
   
    input  logic [31:0] PC_ID,
    input  logic [31:0] rs1,
    input  logic [31:0] rs2,
    input  logic [31:0] immediate,
    input  logic [31:0] INST_ID,

    input  logic        BrUn,
    input  logic        MemRW,
    input  logic        ASel,
    input  logic        BSel,
    input  logic        RegWEn,
    input  logic        PCSel,
    input  logic [3:0]  ALUSel,
    input  logic [1:0]  WBSel,

    output logic [31:0] PC_EX,
    output logic [31:0] rs1_EX,
    output logic [31:0] rs2_EX,
    output logic [31:0] immediate_EX,
    output logic [31:0] INST_EX,

    output logic        BrUn_EX,
    output logic        MemRW_EX,
    output logic        ASel_EX,
    output logic        BSel_EX,
    output logic [3:0]  ALUSel_EX,
    output logic [1:0]  WBSel_EX,
    output logic        PCSel_EX,
    output logic        RegWEn_EX
);

    always_ff @(posedge clk) begin
        if (rst) begin
            PC_EX        <= 32'b0;
            rs1_EX       <= 32'b0;
            rs2_EX       <= 32'b0;
            immediate_EX <= 32'b0;
            INST_EX      <= 32'b0;

            BrUn_EX      <= 1'b0;
            MemRW_EX     <= 1'b0;
            ASel_EX      <= 1'b0;
            BSel_EX      <= 1'b0;
            ALUSel_EX    <= 4'b0;
            WBSel_EX     <= 2'b0;
            RegWEn_EX    <= 1'b0;
            PCSel_EX     <= 1'b0;
        end
       
        else if (ID_EX_flush) begin
            PC_EX        <= 32'b0;
            rs1_EX       <= 32'b0;
            rs2_EX       <= 32'b0;
            immediate_EX <= 32'b0;
            INST_EX      <= 32'h00000013; // Optional NOP

            BrUn_EX      <= 1'b0;
            MemRW_EX     <= 1'b0;
            ASel_EX      <= 1'b0;
            BSel_EX      <= 1'b0;
            ALUSel_EX    <= 4'b0;
            WBSel_EX     <= 2'b0;
            RegWEn_EX    <= 1'b0;
            PCSel_EX     <= 1'b0;
        end
        else begin
            PC_EX        <= PC_ID;
            rs1_EX       <= rs1;
            rs2_EX       <= rs2;
            immediate_EX <= immediate;
            INST_EX      <= INST_ID;

            BrUn_EX      <= BrUn;
            MemRW_EX     <= MemRW;
            ASel_EX      <= ASel;
            BSel_EX      <= BSel;
            ALUSel_EX    <= ALUSel;
            WBSel_EX     <= WBSel;
            RegWEn_EX    <= RegWEn;
            PCSel_EX     <= PCSel;
        end
    end

endmodule

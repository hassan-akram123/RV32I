`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2025 11:27:37 PM
// Design Name: 
// Module Name: EX_MEM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module EX_MEM(
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] PC_EX,
    input  logic [31:0] ALU_data_out,
    input  logic [31:0] rs2_EX,
    input  logic [31:0] INST_EX,
    input  logic        MemRW_EX,
    input  logic [1:0]  WBSel_EX,
    input logic        PCSel_EX,
    input logic        RegWEn_EX,
    
    output logic [31:0] PC_MEM,
    output logic [31:0] ALU_MEM,
    output logic [31:0] rs2_MEM,
    output logic [31:0] INST_MEM,
    output logic       MemRW_MEM,
    output logic [1:0]  WBSel_MEM,
    output logic  RegWEn_MEM,
    output logic PCSel_MEM
);


always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        PC_MEM   <= 32'b0;
        ALU_MEM  <= 32'b0;
        rs2_MEM  <= 32'b0;
        INST_MEM <= 32'b0;
        MemRW_MEM<=0;
        WBSel_MEM<=0;
        RegWEn_MEM  <=0;
        PCSel_MEM  <=0;
    end else begin
        PC_MEM   <= PC_EX;
        ALU_MEM  <= ALU_data_out;
        rs2_MEM  <= rs2_EX;
        INST_MEM <= INST_EX;
        MemRW_MEM<= MemRW_EX;
        WBSel_MEM<= WBSel_EX;
        RegWEn_MEM  <=RegWEn_EX;
        PCSel_MEM  <=PCSel_EX;
    end
end

endmodule

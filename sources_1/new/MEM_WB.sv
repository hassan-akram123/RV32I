`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2025 11:51:57 PM
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] PC_MEM_4,
    input  logic [31:0] ALU_MEM,
    input  logic [31:0] data_mem_out,
    input  logic [31:0] INST_MEM,
    input   logic [1:0]  WBSel_MEM,
    input  logic  RegWEn_MEM,
    input logic PCSel_MEM,
    
    output logic [31:0] PC_WB_4,
    output logic [31:0] ALU_WB,
    output logic [31:0] MEM_WB,
    output logic [31:0] INST_WB,
    output logic [1:0]  WBSel_WB,
    output logic RegWEn_WB,
    output logic PCSel_WB
);


always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        PC_WB_4 <= 32'b0;
        ALU_WB  <= 32'b0;
        MEM_WB  <= 32'b0;
        INST_WB <= 32'b0;
        WBSel_WB <=0;
        RegWEn_WB<= 0;
        PCSel_WB<= 0;
    end else begin
        PC_WB_4 <= PC_MEM_4;
        ALU_WB  <= ALU_MEM;
        MEM_WB  <= data_mem_out;
        INST_WB <= INST_MEM;
        WBSel_WB <= WBSel_MEM;
        RegWEn_WB<= RegWEn_MEM;
        PCSel_WB<= PCSel_MEM;
    end
end

endmodule


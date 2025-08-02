`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2025 10:53:50 PM
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
    input logic clk,
    input logic rst,
    input logic IF_ID_Write,
    input logic IF_ID_flush,
    input logic [31:0] inst,
    input logic [31:0] pc,
    output logic [31:0] PC_ID,
    output logic [31:0] INST_ID
);
    
    always_ff @(posedge clk) begin
        if (rst) begin
            PC_ID   <= 32'b0;
            INST_ID <= 32'b0;
        end 
        else if (IF_ID_flush) begin  // Flush has higher priority
            PC_ID   <= 32'b0;
            INST_ID <= 32'h00000013;  // NOP (addi x0, x0, 0)
        end
        else if (IF_ID_Write) begin 
            PC_ID   <= pc;
            INST_ID <= inst;
        end
        // No need for "else" block - registers hold value automatically
    end
    
endmodule

    


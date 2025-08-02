`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2025 12:36:49 AM
// Design Name: 
// Module Name: hazard_detection
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


module hazard_detection(
  input logic MemRW_EX,
  input logic branch_taken,
  input logic [4:0] rs1_ID,rs2_ID,rd_EX,
  output logic IF_ID_Write,PC_Write,stall,
  output logic IF_ID_flush, ID_EX_flush 
    );
    always_comb begin
    
    stall = 0;
    IF_ID_Write = 1;
    PC_Write = 1;
    IF_ID_flush = 0;
    ID_EX_flush = 0;
    
    if (MemRW_EX && ((rd_EX==rs1_ID) || (rd_EX==rs2_ID))) begin
        stall=1;
        IF_ID_Write=0;
        PC_Write=0;
    end
    if (branch_taken) begin
    IF_ID_flush = 1;
    ID_EX_flush = 1;  
    end
    
    end
    
endmodule

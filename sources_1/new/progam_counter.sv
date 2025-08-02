`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2025 11:51:26 AM
// Design Name: 
// Module Name: progam_counter
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


module progam_counter(
input logic clk,
input logic rst,
input logic PC_Write,
input logic [31:0] next_pc,
output logic [31:0] pc
    );
    
    always@(posedge clk) begin
    if (rst) begin pc <=0; end
    else if (PC_Write) begin pc<= next_pc; end
    else pc<=pc;
    end
   
endmodule

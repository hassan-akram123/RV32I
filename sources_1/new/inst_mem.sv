`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2025 11:58:19 AM
// Design Name: 
// Module Name: inst_mem
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


module inst_mem(
input logic [31:0] addr,
output logic [31:0] instruction
    );
    
    logic [31:0] memory [0:23];
    
    initial begin
   $readmemb( "C:/Users/Hassan Akram/Downloads/r_type.mem", memory);
  
    end
    assign instruction = memory[addr[31:2]];
    
endmodule

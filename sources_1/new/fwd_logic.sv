`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2025 12:36:27 AM
// Design Name: 
// Module Name: fwd_logic
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


module fwd_logic(
    input  logic [3:0] rs1_EX, rs2_EX,
    input  logic       RegWEn_MEM, RegWEn_WB,
    input  logic [3:0] EX_MEM_rd, MEM_WB_rd,
    output logic [1:0] fwd_A, fwd_B
);

    always_comb begin
        
        if (EX_MEM_rd == rs1_EX && RegWEn_MEM && EX_MEM_rd != 0)
            fwd_A = 2'b01;  
        else if (MEM_WB_rd == rs1_EX && RegWEn_WB && MEM_WB_rd != 0)
            fwd_A = 2'b10;  
        else
            fwd_A = 2'b00;  

        
        if (EX_MEM_rd == rs2_EX && RegWEn_MEM && EX_MEM_rd != 0)
            fwd_B = 2'b01;  
        else if (MEM_WB_rd == rs2_EX && RegWEn_WB && MEM_WB_rd != 0)
            fwd_B = 2'b10;  
        else
            fwd_B = 2'b00;  
    end

endmodule

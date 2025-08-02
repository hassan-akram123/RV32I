`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2025 03:58:52 PM
// Design Name: 
// Module Name: reg_file
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


module reg_file(
input logic [31:0] data_in,
input logic [4:0] rs1,rs2,rsw,
output logic [31:0] data_out_1,data_out_2,
input logic clk,
input logic rst,
input RegWEn
    );
    
    
    
    logic [31:0] regfile [7:0];  
    assign regfile[0]=0;
    
 
    assign data_out_1 = regfile[rs1];
    assign data_out_2 = regfile[rs2];

  
    always_ff @(posedge clk) begin
    
        if (rst) begin
            for (int i = 0; i < 8; i++) begin
                regfile[i] <= 32'b0;
            end
        end
       else if (RegWEn && rsw != 5'd0) begin 
            regfile[rsw] <= data_in;
        end
        regfile[0] <= 32'b0; 
        regfile[1]<=32'h00000000;
        regfile[2]<=32'hdeadbeef;
    end

endmodule
    

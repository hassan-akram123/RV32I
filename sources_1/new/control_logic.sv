`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/26/2025 01:21:37 AM
// Design Name: 
// Module Name: control_logic
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


module control_logic(
 input logic inst_30, // funct7 
 input logic [2:0] func3,
 input logic [4:0] inst, // opcode
 input logic BrEq,BrLT,
 
 output logic RegWEn,BrUn,MemRW,// done
 output logic ASel,BSel,PCSel,//done
 output logic [3:0] ALUSel, // done 
 output logic [1:0] WBSel,
 output logic [2:0] ImmSel ,// done
  output logic branch_taken 
    );
    
    
    always_comb begin
     
    logic is_branch_inst;
    logic branch_condition_met; 
     
    RegWEn=0;
    BrUn=0;
    MemRW=0;
    PCSel=0;
    ASel=0;
    BSel=1;
    WBSel=1;
    is_branch_inst=0; 
    branch_condition_met=0; 
//    if (BrEq || BrLT) begin 
//    PCSel=1;
//    ASel=1;
//    end

    
    case(inst) 
    5'b01100://R Type
     begin ImmSel = 3'b101;
      RegWEn=1;
      ASel=0;
      BSel=0;
      case(func3)
       3'b000: ALUSel = (inst_30) ? 4'b0001 : 4'b0000;
       3'b001: ALUSel = 4'b0010;
       3'b010: ALUSel = 4'b0011;
       3'b011: ALUSel = 4'b0100;
      endcase
        end
     
     
    5'b00100:// I type 
     begin 
     ImmSel = 3'b000; 
     RegWEn=1; 
     ASel=0; 
      case (func3)
      3'b000: ALUSel = 4'b0000;
      3'b100: ALUSel = 4'b0101;
      3'b101: ALUSel = 4'b0110;
      3'b110: ALUSel = 4'b1000;
      3'b111: ALUSel = 4'b1001;
      endcase     
      end   
    
   5'b11001:// jalr
        begin 
        
            ImmSel = 3'b000; 
            RegWEn=1;
            ALUSel = 4'b1010;
            ASel=0; 
            WBSel=2;
            PCSel=1;
        end
        
        
    5'b00000:// L 
     begin  
        ImmSel = 3'b110;
        ALUSel = 4'b1010;  
        RegWEn=1;
        ASel=0;   
        WBSel=0; 
     end
    
    
    5'b01000: // S type
    begin
         ImmSel = 3'b001;
         ALUSel = 4'b1010;
         MemRW=1;
         ASel=0;   
    end
    
    5'b11011: // j type
     begin 
        ImmSel = 3'b100; 
        RegWEn=1; 
        ALUSel = 4'b1010; 
        ASel=1; 
        WBSel=2;
        PCSel=1;
     end 
    
    5'b11000: // B type
    begin
     ImmSel=3'b010;
     ALUSel = 4'b1010;  
     ASel=1;
     is_branch_inst=1;    
     
     case(func3)
     3'b000: branch_condition_met = BrEq; // BEQ
     3'b001: branch_condition_met = ~BrEq;// BNE 
     3'b100: branch_condition_met = BrLT; // BLT
     3'b101: branch_condition_met = BrLT; // BGE
     3'b110: begin BrUn = 1; branch_condition_met = BrLT; end
     3'b111: begin BrUn = 1; branch_condition_met = BrLT; end
     endcase
     
     if (branch_condition_met) begin
              PCSel = 1;
     end
    end 
    
    5'b01101: // LUI 
     begin 
        ImmSel=3'b011; 
        RegWEn=1; 
        ALUSel= 4'b1100;
     end 
     
     
     5'b00101: // AUPIC
     begin 
          ImmSel=3'b011; 
          RegWEn=1; 
          ALUSel= 4'b1010;
          ASel=1; 
     end 
    endcase
    
     branch_taken = is_branch_inst & branch_condition_met;
     
     if(branch_taken) begin
         RegWEn=0;
         MemRW=0;
     end  

    end
    
    
    
    
    
endmodule

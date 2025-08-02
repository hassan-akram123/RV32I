`timescale 1ns / 1ps

module top_module(
    input logic clk,
    input logic rst   
);

   
    logic [31:0] pc, next_pc;
    logic [31:0] instruction;
    logic [2:0] Comp_Sel, ImmSel ;
    logic [31:0] immediate;
    logic [31:0] data_out_1, data_out_2, reg_data_in,ALU_data_in1,ALU_data_in2;
    logic [4:0] rs1_addr, rs2_addr, rd_addr;
    logic [3:0] ALUSel;
    logic [31:0] ALU_data_out;
    logic [31:0] main_mem_data_out;
    logic MemRW,ASel,BSel,PCSel,RegWEn;
    logic [1:0]WBSel;
    logic  BrUn, BrEq,BrLT;
    
    
    logic [31:0] PC_ID, INST_ID;
    logic [31:0] PC_EX, rs1_EX, rs2_EX, immediate_EX, INST_EX;
    logic [31:0] PC_MEM, ALU_MEM, rs2_MEM, INST_MEM,PC_MEM_4;
    logic [31:0] PC_WB_4, ALU_WB, MEM_WB, INST_WB;

    logic MemRW_EX,ASel_EX,BSel_EX,BrUN_EX,RegWEn_EX,PCSel_EX;
    logic [1:0]WBSel_EX;
    logic [3:0] ALUSel_EX;

    logic MemRW_MEM,RegWEn_MEM,PCSel_MEM;
    logic [1:0]WBSel_MEM;

    logic [1:0]WBSel_WB;
    logic RegWEn_WB,PCSel_WB;
    
    logic IF_ID_Write,PC_Write,stall,branch_taken;
    logic [1:0] fwd_A, fwd_B;
    
    progam_counter pc_unit (
        .clk(clk),
        .rst(rst),
        .PC_Write(PC_Write),
        .next_pc(next_pc),
        .pc(pc)
    );  

    inst_mem imem (
        .addr(pc),
        .instruction(instruction)
    );
    
    
 IF_ID if_id_reg (
        .clk(clk),
        .rst(rst),
        .IF_ID_Write(IF_ID_Write),
        .IF_ID_flush(branch_taken),  // <== Connect flush signal
        .inst(instruction),
        .pc(pc),
        .PC_ID(PC_ID),
        .INST_ID(INST_ID)
    );


  
    imm_gen immediate_gen (
        .instruction(INST_ID[31:7]),
        .imm_sel(ImmSel),
        .immediate(immediate)
    );

    reg_file regs (
        .data_in(reg_data_in),
        .rs1(rs1_addr),
        .rs2(rs2_addr),
        .rsw(rd_addr),
        .data_out_1(data_out_1),
        .data_out_2(data_out_2),
        .clk(clk),
        .rst(rst),
        .RegWEn(RegWEn_WB)
    );
    
   // ID/EX Pipeline Register
     ID_EX id_ex_reg (
          .clk(clk),
          .rst(rst),
          .ID_EX_flush(branch_taken),
          .PC_ID(PC_ID),
          .rs1(data_out_1),
          .rs2(data_out_2),
          .immediate(immediate),
          .INST_ID(INST_ID),
      
          .BrUn(BrUn),
          .MemRW(MemRW),
          .ASel(ASel),
          .BSel(BSel),
          .RegWEn(RegWEn),
          .PCSel(PCSel),         
          .ALUSel(ALUSel),
          .WBSel(WBSel),
      
          .PC_EX(PC_EX),
          .rs1_EX(rs1_EX),
          .rs2_EX(rs2_EX),
          .immediate_EX(immediate_EX),
          .INST_EX(INST_EX),
      
          .BrUn_EX(BrUN_EX),
          .MemRW_EX(MemRW_EX),
          .ASel_EX(ASel_EX),
          .BSel_EX(BSel_EX),  
          .ALUSel_EX(ALUSel_EX),
          .WBSel_EX(WBSel_EX),
          .PCSel_EX(PCSel_EX),
          .RegWEn_EX(RegWEn_EX)
      );


    

    branch_comp bcomp (
        .A(rs1_EX),
        .B(rs2_EX),
        .BrUn(BrUN_EX),
        .Comp_Sel(Comp_Sel),
        .Eq(BrEq),
        .Lt(BrLT)
    );

    alu_logic alu (
        .data_rs1(ALU_data_in1),
        .data_rs2(ALU_data_in2),
        .ALUSel(ALUSel_EX),
        .rd(ALU_data_out)
    );
   
   
   EX_MEM ex_mem_reg (
        .clk(clk),
        .rst(rst),
        .PC_EX(PC_EX),
        .ALU_data_out(ALU_data_out),
        .rs2_EX(rs2_EX),
        .INST_EX(INST_EX),
        .MemRW_EX(MemRW_EX),
        .WBSel_EX(WBSel_EX),
        .PCSel_EX(PCSel_EX),
        .RegWEn_EX(RegWEn_EX),


        .PC_MEM(PC_MEM),
        .ALU_MEM(ALU_MEM),
        .rs2_MEM(rs2_MEM),
        .INST_MEM(INST_MEM),
        .MemRW_MEM(MemRW_MEM),
        .WBSel_MEM(WBSel_MEM),
        .RegWEn_MEM(RegWEn_MEM),
        .PCSel_MEM(PCSel_MEM)
    );
    
    data_mem mem (
        .inp_addr(ALU_MEM),
        .inp_data(rs2_MEM),
        .data_out(main_mem_data_out),
        .MemRW(MemRW_MEM),
        .func3(INST_MEM[14:12]),
        .clk(clk),
        .rst(rst)
    );
    
    MEM_WB mem_wb_reg (
        .clk(clk),
        .rst(rst),
        .PC_MEM_4(PC_MEM_4),
        .ALU_MEM(ALU_MEM),
        .data_mem_out(main_mem_data_out),
        .INST_MEM(INST_MEM),
        .WBSel_MEM(WBSel_MEM),
        .RegWEn_MEM(RegWEn_MEM),
        .PCSel_MEM(PCSel_MEM),


        .PC_WB_4(PC_WB_4),
        .ALU_WB(ALU_WB),
        .MEM_WB(MEM_WB),
        .INST_WB(INST_WB),
        .WBSel_WB(WBSel_WB),
        .RegWEn_WB(RegWEn_WB),
        .PCSel_WB(PCSel_WB)
    );
    
    control_logic control_logic_inst (
        .inst_30(INST_ID[30]),
        .func3(INST_ID[14:12]),
        .inst(INST_ID[6:2]),
        .BrEq(BrEq),
        .BrLT(BrLT),
        
        .RegWEn(RegWEn),// done
        .BrUn(BrUn),// done
        .MemRW(MemRW), // done
        .ASel(ASel),
        .BSel(BSel),
        .PCSel(PCSel),
        .ALUSel(ALUSel),
        .WBSel(WBSel),
        .ImmSel(ImmSel),
        .branch_taken(branch_taken)
    ); 
    
    fwd_logic fwd(
        .rs1_EX(INST_EX[19:15]),
        .rs2_EX(INST_EX[24:20]),
        .RegWEn_MEM(RegWEn_MEM),
        .RegWEn_WB(RegWEn_WB),
        .EX_MEM_rd(INST_MEM[11:7]),
        .MEM_WB_rd(INST_WB[11:7]),
        .fwd_A(fwd_A),
        .fwd_B(fwd_B)
    );


    hazard_detection haz_det(
    .MemRW_EX(MemRW_EX),
    .branch_taken(branch_taken),
    .rs1_ID(rs1_addr),
    .rs2_ID(rs2_addr),
    .rd_EX(INST_EX[11:7]),
    .IF_ID_Write(IF_ID_Write),
    .PC_Write(PC_Write),
    .stall(stall)
    );

    always_comb begin
    
     PC_MEM_4= PC_MEM +4;
     
            if (PCSel_MEM)
               next_pc = ALU_MEM;
           else
               next_pc = pc + 4;
     
     
     case(fwd_A)
         2'b00: 
      begin
             if (ASel_EX)
                ALU_data_in1 = PC_EX;
             else
                ALU_data_in1 = rs1_EX;
      end
        2'b01:  ALU_data_in1 = ALU_MEM;
        2'b10:  ALU_data_in1 = ALU_WB;
     endcase
     
     case(fwd_B)
          2'b00: begin
                 if (BSel_EX)
                     ALU_data_in2 = immediate_EX;
                 else
                     ALU_data_in2 = rs2_EX;

           end
          2'b01:  ALU_data_in2 = ALU_MEM;
          2'b10:  ALU_data_in2 = ALU_WB;
     endcase
      
    Comp_Sel=0; 
        
       
        
       if (WBSel_WB == 2'b00)
            reg_data_in = MEM_WB;
        else if (WBSel_WB == 2'b01)
            reg_data_in = ALU_WB;
        else if (WBSel_WB == 2'b10)
            reg_data_in = PC_WB_4;
        else
            reg_data_in = 32'b0; // optional default

        case (INST_ID[6:0])
            7'b0110011: begin
                
                rs1_addr = INST_ID[19:15];
                rs2_addr = INST_ID[24:20];
                rd_addr  = INST_WB[11:7];
            end

            7'b0010011: begin
                
                rs1_addr = INST_ID[19:15];
                rd_addr  = INST_WB[11:7];
            end

            7'b0000011: begin
              
                rs1_addr = INST_ID[19:15];
                rd_addr  = INST_WB[11:7];
            end

            7'b0100011: begin
               
                rs1_addr = INST_ID[19:15];
                rs2_addr = INST_ID[24:20];
            end

            7'b1100111: begin
              
                rs1_addr = INST_ID[19:15];
                rd_addr  = INST_WB[11:7];
            end

            7'b1101111: begin
             
                rd_addr  = INST_WB[11:7];
            end

            7'b1100011: begin
               
                case (INST_ID[14:12])
                    
                    3'b000: Comp_Sel = INST_ID[14:12];
                    3'b100: Comp_Sel = INST_ID[14:12];  
                    3'b101: Comp_Sel = INST_ID[14:12];  
                    3'b110: Comp_Sel = INST_ID[14:12];
                    3'b111: Comp_Sel = INST_ID[14:12];
                endcase
                rs1_addr = INST_ID[19:15];
                rs2_addr = INST_ID[24:20];
            end
            
            7'b0110111: begin // LUI
               
                rd_addr= INST_WB[11:7];
            end 
            
            7'b0010111: begin // AUIPC
               
                rd_addr= INST_WB[11:7];
            end       
            
            default: begin
                            rd_addr= 0;
                            rs1_addr = 0;
                            rs2_addr = 0;
            end
           
        endcase

        
    end

endmodule



module alu_logic(
    input  logic [31:0] data_rs1, data_rs2,
    input  logic [3:0]  ALUSel,

    output logic [31:0] rd
);
// the prg_count from the top module will be given
// via a mux from 
    always_comb begin
        case (ALUSel)
            4'b0000: rd = data_rs1 + data_rs2;
            4'b0001: rd = data_rs2 - data_rs1;
            4'b0010: rd = data_rs2 << data_rs1[4:0];
            4'b0011: rd = ($signed(data_rs2) < $signed(data_rs1)) ? 32'd1 : 0;
            4'b0100: rd = (data_rs2 < data_rs1) ? 32'd1 : 0;
            4'b0101: rd = data_rs1 ^ data_rs2;
            4'b0110: rd = data_rs1 >> data_rs2[4:0];
            4'b0111: rd = data_rs1 >>> data_rs2[4:0];
            4'b1000: rd = data_rs1 | data_rs2;
            4'b1001: rd = data_rs1 & data_rs2;
            4'b1010: rd = data_rs1 + data_rs2;  // jalr ,jal and AUPIC
          //  4'b1011: rd = prg_count + immediate; // jal have to remove
            4'b1100: rd = data_rs2;
           // 4'b1101: rd = immediate+prg_count;  // to be removed
            default: rd = 32'd0;
        endcase
    end

endmodule
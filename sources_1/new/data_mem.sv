module data_mem (
    input  logic [31:0] inp_addr,
    input  logic [31:0] inp_data,
    output logic [31:0] data_out,
    input  logic        MemRW,
    input  logic [2:0]  func3,
    input  logic        clk,
    input  logic        rst
);

    logic [31:0] main_memory [0:10];
    logic [31:0] word;
    logic [7:0]  selected_byte_load;

    // Memory Initialization
    initial begin
        for (int i = 0; i < 11; i++)
            main_memory[i] = 32'h00000000;
    end

    // Write Operations (Sequential)
    always_ff @(posedge clk) begin
        if (MemRW) begin
            case (func3)
                3'b000: begin // SB
                    case (inp_addr[1:0])
                        2'b00: main_memory[inp_addr[31:2]][7:0]   <= inp_data[7:0];
                        2'b01: main_memory[inp_addr[31:2]][15:8]  <= inp_data[7:0];
                        2'b10: main_memory[inp_addr[31:2]][23:16] <= inp_data[7:0];
                        2'b11: main_memory[inp_addr[31:2]][31:24] <= inp_data[7:0];
                    endcase
                end
                3'b001: begin // SH
                    case (inp_addr[1:0])
                        2'b00: main_memory[inp_addr[31:2]][15:0]  <= inp_data[15:0];
                        2'b10: main_memory[inp_addr[31:2]][31:16] <= inp_data[15:0];
                    endcase
                end
                3'b010: begin // SW
                    main_memory[inp_addr[31:2]] <= inp_data;
                end
            endcase
        end
    end

    // Read Operations (Combinational)
    always_comb begin
        if (MemRW) begin
            data_out = 32'b0; // Disable read during write
        end else begin
            word = main_memory[inp_addr[31:2]];

            case (func3)
                3'b000: begin // LB
                    case (inp_addr[1:0])
                        2'b00: selected_byte_load = word[7:0];
                        2'b01: selected_byte_load = word[15:8];
                        2'b10: selected_byte_load = word[23:16];
                        2'b11: selected_byte_load = word[31:24];
                    endcase
                    data_out = {{24{selected_byte_load[7]}}, selected_byte_load};
                end

                3'b001: begin // LH
                    case (inp_addr[1:0])
                        2'b00: data_out = {{16{word[15]}}, word[15:0]};
                        2'b10: data_out = {{16{word[31]}}, word[31:16]};
                        default: data_out = 0;
                    endcase
                end

                3'b010: begin // LW
                    data_out = word;
                end

                3'b100: begin // LBU
                    case (inp_addr[1:0])
                        2'b00: selected_byte_load = word[7:0];
                        2'b01: selected_byte_load = word[15:8];
                        2'b10: selected_byte_load = word[23:16];
                        2'b11: selected_byte_load = word[31:24];
                    endcase
                    data_out = {24'b0, selected_byte_load};
                end

                3'b101: begin // LHU
                    case (inp_addr[1:0])
                        2'b00: data_out = {16'b0, word[15:0]};
                        2'b10: data_out = {16'b0, word[31:16]};
                        default: data_out = 0;
                    endcase
                end

                default: data_out = 0;
            endcase
        end
    end

endmodule

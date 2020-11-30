/*
*Copyright 2020 wy, virusxiewy99@live.cn
*
*decoder.v - as the name, it's a simple decoder for RV32I 
* 
*/

module decoder (
    input wire [31:0] instr,
    input wire [31:0] addr,

    output wire is_illegal_instr,
    output wire rs1en,
    output wire rs2en
    output wire [4:0] rs1_addr,
    output wire [4:0] rs2_addr,
    output wire [4:0] rd,
    output wire [31:0] imm,
    output wire rd_wen    
);
    wire [6:0] opcode = instr[6:0];
    wire [2:0] rv32_func3 = instr[14:12];
    wire [6:0] rv32_func7 = instr[31:25];
    wire [4:0] rd = instr[11:7];
    wire [4:0] rs1 = instr[19:15];
    wire [4:0] rs2 = instr[24:20];
    
    always @(*) begin
        case (opcode)
            `INST_TYPE_I: begin
                case (funct3)
                    `INST_ADDI, `INST_SLTI, `INST_SLTIU, `INST_XORI, `INST_ORI, `INST_ANDI, `INST_SLLI, `INST_SRI: begin
                        rd_wen = `WriteEnable;
                        rs1_addr = rs1;
                        rs2_addr = `ZeroReg;
                        imm = {{20{inst_i[31]}}, inst_i[31:20]};
                    end
                    default: begin
                        rd_wen = `WriteDisable;
                        rd = `ZeroReg;
                        rs1_addr = `ZeroReg;
                        rs2_addr = `ZeroReg;
                    end
                endcase
            end

            `INST_TYPE_R_M: begin
                if ((rv32_func7 == 7'b0000000) || (rv32_func7 == 7'b0100000)) begin
                    case (rv32_func3)
                        `INST_ADD_SUB, `INST_SLL, `INST_SLT, `INST_SLTU, `INST_XOR, `INST_SR, `INST_OR, `INST_ADD : begin
                            reg_we_o = `WriteEnable;
                            reg_waddr_o = rd;
                            reg1_raddr_o = rs1;
                            reg2_raddr_o = rs2;
                            op1_o = reg1_rdata_i;
                            op2_o = reg2_rdata_i;
                        end 
                        default: 
                    endcase
                end
            end
            default: 
        endcase
    end

endmodule
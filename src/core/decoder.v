/*
*Copyright 2020 wy, virusxiewy99@live.cn
*
*decoder.v - as the name, it's a simple decoder for RV32I 
* 
*/

`include "../include/define.v"

module decoder (
    input wire [31:0] inst_i,
    input wire [31:0] addr_i,

    output wire is_illegal_instr_o,
    output wire rs1en_o,
    output wire rs2en_o,
    output wire [4:0] rs1_addr_o,
    output wire [4:0] rs2_addr_o,
    output wire [4:0] rd_addr_o,
    output wire [31:0] imm_o,
    output wire rd_wen_o    
);
    wire [6:0] opcode = inst_i[6:0];
    wire [2:0] rv32_func3 = inst_i[14:12];
    wire [6:0] rv32_func7 = inst_i[31:25];
    wire [4:0] rd = inst_i[11:7];
    wire [4:0] rs1 = inst_i[19:15];
    wire [4:0] rs2 = inst_i[24:20];
    
    always @(*) begin
        is_illegal_instr_o = 1'b1;
        rs1en_o = 1'b0;
        rs2en_o = 1'b0;
        rs1_addr_o = `ZeroReg;
        rs2_addr_o = `ZeroReg;
        rd_addr_o = `ZeroReg;
        imm_o = 32'b0;
        rd_wen_o = `WriteDisable;

        case (opcode)
            `INST_TYPE_I: begin
                case (rv32_funct3)
                    `INST_ADDI, `INST_SLTI, `INST_SLTIU, `INST_XORI, `INST_ORI, `INST_ANDI, `INST_SLLI, `INST_SRI: begin
                        rd_wen_o = `WriteEnable;
                        rs1_addr_o = rs1;
                        rs2_addr_o = `ZeroReg;
                        imm_o = {{20{inst_i[31]}}, inst_i[31:20]};
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
                            rd_wen_o = `WriteEnable;
                            rd_addr_o = rd;
                            rs1_addr_o = rs1;
                            rs2_raddr_o = rs2;
                        end 
                        default: begin
                            rd_wen = `WriteDisable;
                            rd = `ZeroReg;
                            rs1_addr = `ZeroReg;
                            rs2_addr = `ZeroReg;
                        end
                    endcase
                end else if (rv32_func7 == 7'b0000001) begin
                    case (rv32_func3)
                        `INST_MUL, `INST_MULHU, `INST_MULH, `INST_MULHSU: begin
                            rd_wen_o = `WriteEnable;
                            rd_addr_o = rd;
                            rs1_addr_o = rs1;
                            rs2_raddr_o = rs2;
                        end
                        `INST_DIV, `INST_DIVU, `INST_REM, `INST_REMU: begin
                            reg_we_o = `WriteDisable;
                            reg_waddr_o = rd;
                            reg1_raddr_o = rs1;
                            reg2_raddr_o = rs2;
                            op1_o = reg1_rdata_i;
                            op2_o = reg2_rdata_i;
                            op1_jump_o = inst_addr_i;
                            op2_jump_o = 32'h4;
                        end 
                    endcase
                end
            end 
            default: 
        endcase
    end

endmodule
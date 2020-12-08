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
    output wire imm_en_o,
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
        imm_en_o = 1'b0;
        rs1_addr_o = `ZeroReg;
        rs2_addr_o = `ZeroReg;
        rd_addr_o = `ZeroReg;
        imm_o = 32'b0;
        rd_wen_o = `WriteDisable;

        case (opcode)
            `INST_TYPE_I: begin
                case (rv32_func3)
                    `INST_ADDI, `INST_SLTI, `INST_SLTIU, `INST_XORI, `INST_ORI, `INST_ANDI, `INST_SLLI, `INST_SRI: begin
                        if(rd != `ZeroReg) begin
                            is_illegal_instr_o = 1'b0;
                            rd_wen_o = `WriteEnable;
                            rd_addr_o = rd;
                            rs1_en_o = 1'b1;
                            rs1_addr_o = rs1;
                            imm_en_o = 1'b1;
                            imm_o = {{20{inst_i[31]}}, inst_i[31:20]}; 
                        end
                    end
                    default :
                endcase
            end

            `INST_TYPE_R: begin
                if ((rv32_func7 == 7'b0000000) || (rv32_func7 == 7'b0100000)) begin
                    case (rv32_func3)
                        `INST_ADD_SUB, `INST_SLL, `INST_SLT, `INST_SLTU, `INST_XOR, `INST_SR, `INST_OR, `INST_ADD : begin
                            if (rd != `ZeroReg) begin
                                is_illegal_instr_o = 1'b0;
                                rd_wen_o = `WriteEnable;
                                rd_addr_o = rd;
                                rs1en_o = 1'b1;
                                rs1_addr_o = rs1;
                                rs1en_o = 1'b1;
                                rs2_raddr_o = rs2; 
                            end
                        end 
                        default :
                    endcase
                end
            end

            `TNST_TYPE_L:begin
                case (rv32_func3)
                    `INST_LB, `INST_LH, `INST_LW, `INST_LBU, `INST_LHU: begin
                        if (rd != `ZeroReg) begin
                            is_illegal_instr_o = 1'b0;
                            rd_wen_o = `WriteEnable;
                            rd_addr_o = rd;
                            rs1en_o = 1'b1;
                            rs1_addr_o = rs1;
                            imm_en_o = 1'b1;
                            op2_o = {{20{inst_i[31]}}, inst_i[31:20]};
                        end
                    end
                    default: 
                endcase
            end 

            `INST_TYPE_S: begin
                case (rv32_func3)
                    `INST_SB, `INST_SW, `INST_SH: begin
                        is_illegal_instr_o = 1'b0;
                        rd_wen_o = `WriteDisable;
                        rs1en_o = 1'b1;
                        rs1_addr_o = rs1;
                        rs2en_o = 1'b1;
                        rs2_raddr_o = rs2;
                        imm_en_o = 1'b1;
                        imm_o = {{20{inst_i[31]}}, inst_i[31:25], inst_i[11:7]};
                    end
                    default: begin
                        reg1_raddr_o = `ZeroReg;
                        reg2_raddr_o = `ZeroReg;
                        reg_we_o = `WriteDisable;
                        reg_waddr_o = `ZeroReg;
                    end
                endcase
            end

            default: 
        endcase
    end

endmodule
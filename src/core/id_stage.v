/*
*Copyright 2020 wy, virusxiewy99@live.cn
*
*id_stage.v - the second stage of 5
*include a decoder module and a regfile
* 
*/
module id_stage (
    input wire clk_i,
    input wire rst_ni,

    input wire[31:0] instr_i,
    input wire[31:0] addr_i,
    input wire write_back,
    input wire write_addr,
    output wire is_illegal_instr_o
);
    wire rs1en, rs1en, rden;
    wire imm_en;
    wire[4:0] rs1_addr, rs2_addr;
    wire [31:0] imm;
    decoder decoder_i(.inst_i(inst_i),
                      .addr_i(addr_i),
                      
                      .is_illegal_instr_o(is_illegal_instr_o),
                      .rs1en_o(rs1en),
                      .rs1en_o(rs2en),
                      .rs1_addr_o(rs1_addr),
                      .rs2_addr_o(rs2_addr),
                      .rd_wen_o(rden),
                      .imm_en_o(imm_en),
                      .imm_o(imm));

    regfile regfile_i(.clk_i(clk_i),
                      .rst_ni(rst_ni),
                      
                      .we_i(write_back),
                      .waddr(write_addr),
                      .rs);
endmodule
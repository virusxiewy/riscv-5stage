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

    input [31:0] instr_i,
    input [31:0] addr,

    output 
);
    decoder decoder_i();
    regfile regfile_i();
endmodule
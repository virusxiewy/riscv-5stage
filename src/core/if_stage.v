/*
*Copyright 2020 wy, virusxiewy99@live.cn
*
*if_stage.v - the first stage of 5
*include a module that generate the PC and a module fetch intruction from memory 
* 
*/


module if_stage (
    input wire clk_i,
    input wire rst_ni,
    input wire reboot_i,
    input wire [31:0] boot_addr_i,
    input wire jump_flag,
    input wire [31:0] jump_addr_i,
    input wire [`Hold_Flag_Bus]hold_flag_i,

    output wire [31:0] fetch_pc,
    output wire [31:0] fetch_instr
);
    wire [31:0] pc;
    pc_reg pc_reg_i(.clk_i(clk_i),
                    .rst_ni(rst_ni),
                    .reboot_i(reboot_i),
                    .boot_addr_i(boot_addr_i),
                    .jump_flag(jump_flag),
                    .jump_addr_i(jump_addr_i),
                    .hold_flag_i(hold_flag_i),
                    .addr(pc));

    im im_i (.clk_i(clk_i),
            .addr(pc),
            .data(fetch_instr));

    assign fetch_pc = pc;

endmodule
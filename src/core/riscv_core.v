/*
*Copyright 2020 wy, virusxiewy99@live.cn
*
*risv_core.v - top modole of the core
* 
*/

module riscv_core (
    input wire clk_i,
    input wire rst_ni,

    input wire reboot,
    input wire[31:0] boot_addr 
);

    wire jump_en; //jump signal
    wire[31:0] jump_addr; 
    wire[`Hold_Flag_Bus] hold_flag;

    ctrl ctrl_i(.clk_i(clk_i),
                .rst_ni(rst_ni));

    if_stage if_stage_i(.clk_i(clk_i),
                        .rst_ni(rst_ni),
                        .reboot_i(reboot),
                        .boot_addr_i(boot_addr),
                        .jump_flag(jump_en),
                        .jump_addr_i(jump_addr),
                        .hold_flag_i(hold_flag),
                        
                        .fetch_pc_o(),
                        .fetch_instr_o(instr));

    id_stage id_stage_i(.clk_i(clk_i),
                        .rst_ni(rst_ni),
                        );
    
    ex_stage ex_stage_i(.clk_i(clk_i),
                        .rst_ni(rst_ni));

    wb_stage wb_stage_i(.clk_i(clk_i),
                        .rst_ni(rst_ni));

    


endmodule
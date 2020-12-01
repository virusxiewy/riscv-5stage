/*
*Copyright 2020 wy, virusxiewy99@live.cn
*
*risv_core.v - top modole of the core
* 
*/

module riscv_core (
    input wire clk_i,
    input wire rst_ni,

    input wire[31:0] boot_addr 
);
    ctrl ctrl_i(.clk_i(clk_i),
                .rst_ni(rst_ni));

    frontend froutend_i(.clk_i(clk_i),
                        .rst_ni(rst_ni));

    if_stage if_stage_i(.clk_i(clk_i),
                        .rst_ni(rst_ni));

    id_stage id_stage_i(.clk_i(clk_i),
                        .rst_ni(rst_ni),
                        );
    
    ex_stage ex_stage_i(.clk_i(clk_i),
                        .rst_ni(rst_ni));

    wb_stage wb_stage_i(.clk_i(clk_i),
                        .rst_ni(rst_ni));

    


endmodule
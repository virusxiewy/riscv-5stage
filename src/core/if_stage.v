module if_stage (
    input wire clk_i,
    input wire rst_ni,

    input wire [31:0] instr_addr,
    output wire[31:0] fetch_instr,

    input wire [`Hold_Flag_Bus]hold_flag_i;
);
    
endmodule
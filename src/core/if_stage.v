module if_stage (
    input wire clk_i;
    input wire rst_ni;

    input wire boot_i;
    input wire [INSTR_ADDR-1:0] boot_addr_i;
    input wire [INSTR_ADDR-1:0] instr_addr;
    output wire[INSTR_WITDH-1:0] fetch_instr;
);
    
endmodule
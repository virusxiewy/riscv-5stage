module pc_reg (
    input wire clk_i,
    input wire rst_ni,

    input wire reboot_i,
    input wire [31:0] boot_addr_i,
    input wire jump_flag,
    input wire [31:0] jump_addr_i,
    input wire [`Hold_Flag_Bus]hold_flag_i,
    output wire[31:0] addr


);
    reg [31:0]pc;
    
    always @(posedge clk ) begin
        if (rst_ni == 1'b0 || reboot_i == 1'b1) begin
            pc <= boot_addr_i;
        end else if (jump_flag == 1'b1) begin
            pc <= jump_addr_i;
        end else if  (hold_flag_i >= `hold_PC) begin
            pc <= pc;
        end else begin
            pc <= pc + 32'h4;
        end 
    end 
    assign addr = pc;

endmodule
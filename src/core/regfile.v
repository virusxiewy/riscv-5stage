/*
*Copyright 2020 wy, virusxiewy99@live.cn
*
*regfile.v - regfile in riscv-5stage cpu
* 
*/

module regfile (
    input wire clk_i,
    input wire rst_ni,

    input wire we_i,
    input wire [31:0] waddr_i,
    input wire [31:0] wdata_i,

    input wire [31:0] raddr_1,
    input wire [31:0] raddr_2,
    output wire [31:0] rdata_1,
    output wire [31:0] rdata_2
);
    reg [31:0] mem [32:0];

    assign mem[0] = 32'b0;

    always @(posedge clk_i) begin
        if (!rst_ni) begin
            if(we_i) begin
                if(waddr_i != `ZeroReg) begin
                    mem[waddr_i] <= wdata_i;   
                end else begin
                    $display("fatal:trying to write x0!!!");
                end
            end
        end 
    end    
    
    always @(posedge clk_i) begin
        if (raddr_1 == `ZeroReg) begin
            rdata_1 <= 32'b0;
        end else if (raddr_1 == waddr_i && we_i) begin
            rdata_1 <= wdata_i;
        end else begin
            rdata_1 <= mem[raddr_1];
        end
    end

        always @(posedge clk_i) begin
        if (raddr_2 == `ZeroReg) begin
            rdata_2 <= 32'b0;
        end else if (raddr_2 == waddr_i && we_i) begin
            rdata_2 <= wdata_i;
        end else begin
            rdata_2 <= mem[raddr_2];
        end
    end


endmodule
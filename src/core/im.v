/*
*Copyright 2020 wy, virusxiewy99@live.cn
*
*im.v - instruction memory
* Given a 32-bit address the data is latched and driven
* on the rising edge of the clock.
*/

module im (
    input wire clk_i,
    input wire [31:0] addr_i,
    output wire [31:0] data_o
);
    
    parameter NMEN = 128;   //number of memory entries,
                            //not the same as the memory size 
    parameter IM_DATA = "im_data.txt";  //file to read data from
    
    reg [31:0] memory [127:0]; //32-bit memory with 128 entries

    initial begin
        $readmemh(IM_DATA, mem, 0, NMEM-1);
    end
    assign data_o = memory[addr_i[6:0]][31:0];

endmodule
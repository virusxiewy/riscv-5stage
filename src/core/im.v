/*
*im.v - instruction memory
* Given a 32-bit address the data is latched and driven
* on the rising edge of the clock.
*/

module im (
    input wire clk_i,
    input wire [31:0] addr,
    output wire [31:0] data;
)
    parameter NMEN = 128;   //number of memory entries,
                            //not the same as the memory size 
    parameter IM_DATA = "im_data.txt";  //file to read data from
    
    reg [31:0] mem [127:0]; //32-bit memory with 128 entries

    initial begin
        $readmemh(IM_DATA, mem, 0, NMEM-1);
    end
    assign data = mem[addr[6:0]][31:0];

endmodule
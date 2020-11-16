/*
*Copyright 2020 wy, virusxiewy99@live.cn
*
*decoder.v - as the name, it's a simple decoder for RV32I 
* 
*/

module decoder (
    input wire[31:0] instr,

    output wire is_illegal_instr,
    output wire rs1en,
    output wire rs2en
    output wire [4:0] rs1_addr,
    output wire [4:0] rs2_addr,
    output wire rd_wen,    
);

    wire [31:0] rv32_instr = instr;
    wire [6:0] opcode = rv32_instr[6:0];
    
    wire opcode_1_0_00  = (opcode[1:0] == 2'b00);
    wire opcode_1_0_01  = (opcode[1:0] == 2'b01);
    wire opcode_1_0_10  = (opcode[1:0] == 2'b10);
    wire opcode_1_0_11  = (opcode[1:0] == 2'b11);
    wire rv32 = (~(i_instr[4:2] == 3'b111)) & opcode_1_0_11;

    wire [4:0]  rv32_rd     = rv32_instr[11:7];
    wire [2:0]  rv32_func3  = rv32_instr[14:12];
    wire [4:0]  rv32_rs1    = rv32_instr[19:15];
    wire [4:0]  rv32_rs2    = rv32_instr[24:20];
    wire [6:0]  rv32_func7  = rv32_instr[31:25];

    wire opcode_4_2_000 = (opcode[4:2] == 3'b000);
    wire opcode_4_2_001 = (opcode[4:2] == 3'b001);
    wire opcode_4_2_010 = (opcode[4:2] == 3'b010);
    wire opcode_4_2_011 = (opcode[4:2] == 3'b011);
    wire opcode_4_2_100 = (opcode[4:2] == 3'b100);
    wire opcode_4_2_101 = (opcode[4:2] == 3'b101);
    wire opcode_4_2_110 = (opcode[4:2] == 3'b110);
    wire opcode_4_2_111 = (opcode[4:2] == 3'b111);

    wire rv32_func3_000 = (rv32_func3 == 3'b000);
    wire rv32_func3_001 = (rv32_func3 == 3'b001);
    wire rv32_func3_010 = (rv32_func3 == 3'b010);
    wire rv32_func3_011 = (rv32_func3 == 3'b011);
    wire rv32_func3_100 = (rv32_func3 == 3'b100);
    wire rv32_func3_101 = (rv32_func3 == 3'b101);
    wire rv32_func3_110 = (rv32_func3 == 3'b110);
    wire rv32_func3_111 = (rv32_func3 == 3'b111);

    wire rv32_func7_0000000 = (rv32_func7 == 7'b0000000);
    wire rv32_func7_0100000 = (rv32_func7 == 7'b0100000);
    wire rv32_func7_0000001 = (rv32_func7 == 7'b0000001);
    wire rv32_func7_0000101 = (rv32_func7 == 7'b0000101);
    wire rv32_func7_0001001 = (rv32_func7 == 7'b0001001);
    wire rv32_func7_0001101 = (rv32_func7 == 7'b0001101);
    wire rv32_func7_0010101 = (rv32_func7 == 7'b0010101);
    wire rv32_func7_0100001 = (rv32_func7 == 7'b0100001);
    wire rv32_func7_0010001 = (rv32_func7 == 7'b0010001);
    wire rv32_func7_0101101 = (rv32_func7 == 7'b0101101);
    wire rv32_func7_1111111 = (rv32_func7 == 7'b1111111);
    wire rv32_func7_0000100 = (rv32_func7 == 7'b0000100); 
    wire rv32_func7_0001000 = (rv32_func7 == 7'b0001000); 
    wire rv32_func7_0001100 = (rv32_func7 == 7'b0001100); 
    wire rv32_func7_0101100 = (rv32_func7 == 7'b0101100); 
    wire rv32_func7_0010000 = (rv32_func7 == 7'b0010000); 
    wire rv32_func7_0010100 = (rv32_func7 == 7'b0010100); 
    wire rv32_func7_1100000 = (rv32_func7 == 7'b1100000); 
    wire rv32_func7_1110000 = (rv32_func7 == 7'b1110000); 
    wire rv32_func7_1010000 = (rv32_func7 == 7'b1010000); 
    wire rv32_func7_1101000 = (rv32_func7 == 7'b1101000); 
    wire rv32_func7_1111000 = (rv32_func7 == 7'b1111000); 
    wire rv32_func7_1010001 = (rv32_func7 == 7'b1010001);  
    wire rv32_func7_1110001 = (rv32_func7 == 7'b1110001);  
    wire rv32_func7_1100001 = (rv32_func7 == 7'b1100001);  
    wire rv32_func7_1101001 = (rv32_func7 == 7'b1101001);

    
endmodule
module alu (
    input wire clk_i,
    input wire rst_ni,

    input wire[3:0] op_type,
    input wire[6:0] fu_op,
    input wire[63:0] operand_a,
    input wire[63:0] operand_b,
    input wire[63:0] imm,

    output wire[63:0] result_o,
    output wire alu_branch_o
);
    reg adder_operand_b_negate;
    reg adder_z_flag;
    wire[64:0] adder_a, adder_b;
    wire[64:0] adder_result_ext;
    wire[63:0] adder_result;

    always @(*) begin
        adder_operand_b_negate = 1'b0;
        case (fu_op)
            `EQ, `NE, `SUB, `SUBW: adder_operand_b_negate = 1'b1;
            default: ;
        endcase
    end
    assign adder_a = {operand_a, 1'b1};
    assign adder_b = {operand_b, 1'b0} ^ {65{adder_op_b_negate}};
    assign adder_result_ext = $unsigned(adder_in_a) + $unsigned(adder_in_b);
    assign adder_result = adder_result_ext[64:1];
    assign adder_z_flag = ~|adder_result;

    
endmodule
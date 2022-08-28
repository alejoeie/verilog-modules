`ifndef ALU_4_BITS
`define ALU_4_BITS

`include"alu_1_bit.v"

module alu_4_bits(f, cout, a, b, cin, M);
    input [3:0] a, b;
    input cin;
    input[1:0] M;
    output [3:0] f;
    output cout;
    output c1, c2, c3;

    alu_1_bit first_alu(.f(f[0]), .cout(cout),.a(a[0]), .b(b[0]), .cin(cin), .M(M));
    alu_1_bit second_alu(.f(f[1]), .cout(c1),.a(a[1]), .b(b[1]), .cin(cout), .M(M));
    alu_1_bit third_alu(.f(f[2]), .cout(c2),.a(a[2]), .b(b[2]), .cin(c1), .M(M));
    alu_1_bit fourth_alu(.f(f[3]), .cout(c3),.a(a[3]), .b(b[3]), .cin(c2), .M(M));

endmodule

`endif
`ifndef ALU_1_BIT
`define ALU_1_BIT
`include "and.v"
`include "or.v"
`include "xor.v"
`include "mux_4_bits.v"
`include "full_adder.v"

module alu_1_bit(f, cout, a, b, cin, M);
    input a, b, cin;
    input [1:0]M;
    wire n1, n2, n3;
    wire fa;
    output cout;
    output f;


    fulladder_bh f_adder(fa, cout, a ,b ,cin);
    and_bh n_and(n1, a, b);
    or_bh n_or(n2, a, b);
    xor_bh n_xor(n3, a , b);
    mux_4bits n_mux(f, fa, n1, n2, n3, M);

    // y, fa, a, b, c


endmodule
`endif
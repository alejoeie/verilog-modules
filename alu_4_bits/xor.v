`ifndef XOR_BH
`define XOR_BH

module xor_bh(y, a, b);
    input a,b;
    output reg y;

    always@(*)
        y = a ^ b;

endmodule
`endif
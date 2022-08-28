`ifndef OR_BH
`define OR_BH

module or_bh(y, a, b);
    input a,b;
    output reg y;

    always@(*)
        y = a | b;

endmodule
`endif
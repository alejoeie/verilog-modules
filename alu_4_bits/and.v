`ifndef AND_BH
`define AND_BH

module and_bh(y, a, b);
    input a,b;
    output reg y;

    always@(*)
        y = a & b;

endmodule
`endif
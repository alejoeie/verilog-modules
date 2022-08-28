`ifndef MUX_4_BITS
`define MUX_4_BITS

module mux_4bits (
    y, fa, a, b, c, M
);
    input fa, a, b, c ;
    input[1:0] M;
    output reg y;
    
    always @(*)
        case(M)
            2'b00: y = fa;
            2'b01: y = a;
            2'b10: y = b;
            2'b11: y = c;
        default $display("error, y=%b,%b", M[0], M[1]);
        endcase

endmodule

`endif
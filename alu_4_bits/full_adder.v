`ifndef FULLADDER_BH
`define FULLADDER_BH

module fulladder_bh(s,c, a, b, cin);
    input a,b;
    input cin;
    output reg s, c;

    always@(*) begin
        s = a ^ b ^ cin;
        c = a & b | b & cin | cin & a;
    end
endmodule
`endif
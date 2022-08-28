`ifndef fa_tb
`define fa_tb
`include "full_adder.v"
module fa_tb;
    reg a, b;
    reg cin;
    wire s, c;
    fulladder_bh fa1(.s(s), .c(c), .a(a), .b(b), .cin(cin));

    initial 
    $monitor("time: %d, s = %b, c = %b, a = %b, b = %b, cin = %b", $time, s, c, a, b, cin);

    initial begin
        $dumpfile("fulladder_bench.v");
        $dumpvars(0, fa_tb);
        a = 0;
        b = 0;
        cin = 0;
        begin
            #10; {a,b,cin}=000;
            #10; {a,b,cin}=001;
            #10; {a,b,cin}=010;
            #10; {a,b,cin}=011;
            #10; {a,b,cin}=100;
            #10; {a,b,cin}=101;
            #10; {a,b,cin}=110;
            #10; {a,b,cin}=111;
        end
    end


endmodule

`endif
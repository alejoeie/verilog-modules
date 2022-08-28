`ifndef ALU_BENCH
`define ALU_BENCH
`include "alu_4_bits.v"

module alu_bench;
    reg[3:0] a, b;
    reg cin;
    reg [1:0] M;
    wire  [3:0] f;
    wire cout;

    alu_4_bits alu_test(f, cout, a, b, cin, M);
    initial
    $monitor("time=%d, a = %b, b = %b, cin = %b, M = %b, f = %b, cout = %b", $time, a, b, cin, M, f, cout);

    initial begin
        $dumpfile("alu_bench.vcd");
        $dumpvars(0, alu_bench);
        a = 4'b0000;
        b = 4'b0000;
        M = 2'b00;
        cin = 0;
        begin
            #10; a = 4'b0000; b = 4'b0000; M = 2'b00; cin=1;
            #10; a = 4'b0001; b = 4'b0001; M = 2'b01; cin=0;
            #10; a = 4'b0010; b = 4'b0010; M = 2'b10; cin=1;
            #10; a = 4'b0011; b = 4'b0011; M = 2'b11; cin=0;
            #10; a = 4'b0100; b = 4'b0100; M = 2'b00; cin=1;
            #10; a = 4'b0101; b = 4'b0101; M = 2'b01; cin=0;
            #10; a = 4'b0110; b = 4'b0110; M = 2'b10; cin=1;
            #10; a = 4'b0111; b = 4'b0111; M = 2'b11; cin=0;
            #10; a = 4'b1000; b = 4'b1000; M = 2'b00; cin=1;
            #10; a = 4'b1001; b = 4'b1001; M = 2'b01; cin=0;
            #10; a = 4'b1010; b = 4'b1010; M = 2'b10; cin=1;
            #10; a = 4'b1011; b = 4'b1011; M = 2'b11; cin=0;
            #10; a = 4'b1100; b = 4'b1100; M = 2'b00; cin=1;
            #10; a = 4'b1101; b = 4'b1101; M = 2'b01; cin=0;
            #10; a = 4'b1110; b = 4'b1110; M = 2'b10; cin=1;
            #10; a = 4'b1111; b = 4'b1111; M = 2'b11; cin=0;
        end
    end



endmodule




`endif
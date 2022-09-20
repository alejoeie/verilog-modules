/* ++++++++++++++++++++++++++++++++++++++++++++++
Tarea 1 - testbench del contador sincrónico de 4 bits.

Descripción conductual de un contador sincrónico 
de 4 bits.

Autor: Alejandro Zuniga Perez
Carne: B59097 
   ++++++++++++++++++++++++++++++++++++++++++++++ */
`ifndef COUNTER_BENCH
`define COUNTER_BENCH
// `include"counter_16_synth_rtlil.v"
`include "cmos_cells.v"
`include"tester.v"
`include"counter_full_synth.v"

module counter_bench;
    wire RCO,ENB, CLK, w1, w2, w3;
    wire [3:0] Q;
    wire [15:0] Q_16_bits;
    wire [3:0] D;
    wire [15:0] D_16_bits;
    wire [1:0] MODO;
    // reg [3:0] D;
    // reg CLK; 
    // reg [1:0] MODO;
    // reg ENB;
    // wire[3:0] Q;
    // reg[3:0] Q_temp;
    // wire RCO;

    initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(-1, counter_bench);
    end
    counter_4_bits dut(.Q(Q), .RCO(RCO), .D(D), .ENB(ENB), .CLK(CLK), .MODO(MODO));
    counter_16_bits dut_16_bits(.Q(Q_16_bits), .w1(w1), .w2(w2), .w3(w3), .D(D_16_bits), .ENB(ENB), .CLK(CLK), .MODO(MODO));
    tester_h t1(.w1(w1), .w2(w2), .w3(w3), .D(D), .D_16_bits(D_16_bits), .ENB(ENB), .CLK(CLK), .MODO(MODO), .Q(Q), .Q_16_bits(Q_16_bits), .RCO(RCO));



endmodule

`endif
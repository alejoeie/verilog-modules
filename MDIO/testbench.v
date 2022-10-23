`include "/home/tetra/Documents/UCR/Digitales_II/Tarea III/tester.v"
`include "/home/tetra/Documents/UCR/Digitales_II/Tarea III/mdio.v"
`ifndef TB_V
`define TB_V
module testbench();
    wire MDC;
    wire MDIO_OE;
    wire MDIO_OUT;
    wire [15:0] RD_DATA;
    wire DATA_RDY;
    wire MDIO_START;
    wire [31:0] T_DATA;
    wire CLK;
    wire RESET;
    wire MDIO_IN;

    MDIO mdio_dut (.MDC(MDC), 
                    .MDIO_OE(MDIO_OE), 
                    .MDIO_OUT(MDIO_OUT), 
                    .RD_DATA(RD_DATA), 
                    .DATA_RDY(DATA_RDY), 
                    .MDIO_START(MDIO_START), 
                    .T_DATA(T_DATA), 
                    .CLK(CLK), 
                    .RESET(RESET), 
                    .MDIO_IN(MDIO_IN));

    tester mdio_test (.MDC(MDC), 
                    .MDIO_OE(MDIO_OE), 
                    .MDIO_OUT(MDIO_OUT), 
                    .RD_DATA(RD_DATA), 
                    .DATA_RDY(DATA_RDY), 
                    .MDIO_START(MDIO_START), 
                    .T_DATA(T_DATA), 
                    .CLK(CLK), 
                    .RESET(RESET), 
                    .MDIO_IN(MDIO_IN));

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(-1, testbench);
        $monitor("CLK = %b, MDC = %b, MDIO_START = %b", CLK, MDC, MDIO_START);
    end


endmodule
`endif
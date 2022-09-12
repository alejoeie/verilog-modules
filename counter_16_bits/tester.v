/* ++++++++++++++++++++++++++++++++++++++++++++++
Tarea 1 - Probador del contador sincrónico de 4 bits.

Descripción conductual de un contador sincrónico 
de 4 bits.

Autor: Alejandro Zuniga Perez
Carne: B59097 
   ++++++++++++++++++++++++++++++++++++++++++++++ */
`ifndef TESTER_H
`define TESTER_H
`include"counter_4_bits.v"
module tester_h(w1, w2, w3, D, D_16_bits, ENB, CLK, MODO, Q, Q_16_bits,RCO);

    output reg [3:0] D;
    output reg [15:0] D_16_bits;
    output reg [1:0] MODO;
    output reg CLK;
    output reg ENB;

    input [3:0] Q;
    input [15:0] Q_16_bits;
    input w1, w2, w3;
    input RCO;

    initial 
    $monitor("Time = %d, D = %d, ENB = %b, MODO = %b, Q = %d, RCO=%b", $time,D,ENB,MODO,Q, RCO);
    
    initial
    {CLK, ENB} = 0;
    
    always begin
       #1 CLK = ~CLK;
    end


    initial begin
        $display("\nCuenta descendente 1 en 1.");
        D = 4'b0000;
        MODO = 2'b11;
        ENB = 1;
        
        #1; #1;
        MODO = 2'b00;
            #1;#1;
            #1;#1;
            #1;#1;
            #1;#1;
            #1;#1;
            #1;#1;
            #1;#1;
            #1;#1;
            #1;#1;
            #1;#1;
            #1;#1;
            #1;#1;
            #1;#1;
            #1;#1;
            #1;#1;
            #1;#1;


            $display("\nCuenta descendente 1 en 1.");
            D=4'b1111;
            MODO = 2'b11;
            ENB = 1;
            

            #1; #1;
            MODO = 2'b01;

            #1; #1;
            #1; #1;
            #1; #1;
            #1; #1;
            #1; #1;
            #1; #1;
            #1; #1;
            #1; #1;
            #1; #1;
            #1; #1;
            #1; #1;
            #1; #1;
            #1; #1;
            #1; #1;
            #1; #1;
            #1; #1;
            #1; #1;

            $display("\nCuenta descendente 3 en 3.");
            D=4'b0000;
            MODO = 2'b11;
            ENB = 1;

            #1; #1;
            MODO = 2'b10;

            #1; #1;
            #1; #1;
            #1; #1;
            #1; #1;
            #1; #1;
            #1; #1;
            #1; #1;
            
            $display("Carga en paralelo.");
            #1;
            D = 4'bXXXX;
            MODO = 4'b11;
            ENB = 1;
            #1;
            #1; D = 4'b0101;
            #2; D = 4'b1101;
            #2; D = 4'b1001;

            #1; #1;

        $monitor("Time = %d, D = %d, ENB = %b, MODO = %b, Q = %d, w1=%b, w2=%b, w3=%b", $time,D_16_bits,ENB,MODO,Q_16_bits,w1, w2, w3);        
        D_16_bits = 16'b0000000000000000;MODO = 2'b11;
        $display("\n++++++++++++++++++CONTADOR DE 16 BITS++++++++++++++++++\n");
        $display("Cuenta ascendente.");
        ENB=1;
        #1; #1;
        MODO = 2'b00;
        #2;#2;
        #2;#2;
        #2;#2;
        #2;#2;
        #2;#2;
        #2;#2;
        #2;#2;
        #2;#2;
        #2;#2;
        #2;#2;
        #2;#2;
        #2;#2;
        #2;#2;
        #2;#2;
        #2;#2;
        #2;#2;
        #2;#2;

        D_16_bits = 16'b1111111111111111; MODO = 2'b11;
        $display("Cuenta descendente");
        ENB = 1;

        #1; #1;
        MODO = 2'b01;
        #2; #2;
        #2; #2;
        #2; #2;
        #2; #2;
        #2; #2;
        #2; #2;
        #2; #2;
        #2; #2;
        #2; #2;
        #1; #1;
        #1; #1;
        #1; #1;
        #1; #1;
        #1; #1;
        #1; #1;

        D_16_bits = 16'b1111111111111111; MODO = 2'b11;
        $display("Cuenta descendente de 3 en 3");
        ENB = 1;

        #1; #1;
        MODO = 2'b10;
        #2; #2;
        #2; #2;
        #2; #2;
        #2; #2;
        #2; #2;
        #2; #2;
        #2; #2;
        #2; #2;
        #2; #2;
        #1; #1;
        #1; #1;
        #1; #1;
        #1; #1;
        #1; #1;
        #1; #1;

        $finish;
    end




endmodule

`endif
/* ++++++++++++++++++++++++++++++++++++++++++++++
Tarea 1 - Módulo del contador sincrónico de 4 bits.

Descripción conductual de un contador sincrónico 
de 4 bits.

Autor: Alejandro Zuniga Perez
Carne: B59097 
   ++++++++++++++++++++++++++++++++++++++++++++++ */
`ifndef COUNTER_4_BITS
`define COUNTER_4_BITS
module counter_4_bits (
    Q,
    RCO,
    D,
    ENB,
    CLK,
    MODO
);
/* Se definen las entradas y salidas del módulo,
las cuales estarán definidas gráficamente en el informe final.
Sin embargo, se definen D, los relojes, el modo, la señal ENB, y
las salidas Q y RCO.*/
    input [3:0] D;
    input [1:0] MODO;
    input ENB;
    input CLK;
    output [3:0] Q;
    reg [3:0] Q_temp;
    reg [3:0] D_temp;
    output reg RCO;
/* Se marca una condición de que cada vez que el reloj cambie de estado
en el flanco positivo o bien, que la señal enable se ejecute o marque un
valor de true, lo que indicará que se estará ejecutando una acción en el 
contador.*/
    always@(posedge CLK)
/* La logica del contador consiste en definir dos estados, representados
por los valores que puede tomar la señal ENB, los cuales son 0 y 1. De 
esta manera, se tiene que si ENB = 0 entonces no acción (los valores de Q
se mantienen en 0 pues no existe ningun estimulo para la salida). De otra
forma, si ENB = 1, se determinará a través de las posibles combinaciones de
MODO los diferentes modos de conteo del sistema. */
        begin
            if(ENB==0) begin
                // Q_temp <= Q_temp;
                Q_temp  <= 4'b0000;
                RCO <= 0;
            end
            else if(ENB==1) begin
            if(MODO==2'b00)begin
                Q_temp <= Q_temp + 1;
                RCO<=0;
                if(Q_temp == 4'b1111) begin
                    RCO<=1;
                end
                
            end
            else if(MODO==2'b01) begin
                Q_temp <= Q_temp - 1;
                RCO<=0;
                if(Q_temp <= 4'b0000)begin
                    RCO <= 1;
                end
            end
            else if(MODO == 2'b10) begin
                RCO <= 0;
                Q_temp <= Q_temp - 3;
                if(Q_temp <= 4'b0000 || Q_temp <= 4'b0001 || Q_temp <= 4'b0010)begin
                    RCO <= 1;
                end
            end
            else if (MODO == 2'b11) begin
                Q_temp <= D;
                RCO <= 0;
            end
            end
        end
// Se asigna la señal Q_temp a la señal Q para efectos de que la simulación
// no tenga problemas al momento de graficar una señal que no sea un reg.

    assign Q = Q_temp;

    
endmodule

/* El contador de 16 bits tendrá un comportamiento 
que permitirá comprobar la eficacia del contador 
de 4 bits, pues consiste en un sistema de 4 contadores
de 4 bits asociados según sus entradas y salidas. */
module counter_16_bits(Q, w1, w2, w3, w4, D, CLK, ENB, MODO);
    input [15:0] D;
    input CLK;
    input [1:0] MODO;
    input ENB;
    output [15:0] Q;
    output w1,w2, w3,w4; //RCO por cada counter de 4 bits.
    reg [15:0] Q_n;
    reg RCO_temp;
    reg ENB_temp;
    // output RCO;
    reg a1, a2, a3, a4;
    wire n1, n2, n3, n4;
    reg [1:0] modo_tmp;
    wire modo_11;
    wire clk1, clk2, clk3, clk4;
    initial begin 
       a1 = 0; 
       a2 = 0; 
       a3 = 0;
       RCO_temp = 0;
    end

    /* Si bien la lógica del contador de 16 bits
    debe ser básica y meramente logística, pues el 
    contador de 4 bits ya debe por sí mismo representar
    los comportamientos a gran escala, es necesario tomar
    en cuenta la funcionalidad de los relojes del módulo
    en cuestión. Sumado a este detalle, existe la necesidad 
    de ampliar la ejecución de cada contador. Es decir, estos
    contadores no entrarán en acción sincrónicamente, sino que
    su ejecución dependerá de los llevos respectivos. Estos 
    llevos son los que marcarán la señal de reloj para que sus 
    acciones sean asincrónicas y estables, para poder cumplir
    con un conteo eficiente.  */
    always @(posedge CLK) begin
        /*En este punto se tiene que si el Modo está en carga
        paralela, los enable de los contadores deben estar activados,
        esto para que carguen el valor deseado.*/
        if (MODO == 2'b11) begin
            {a1, a2, a3, a4}= 0;
        end

        /* Por otro lado, si  alguno de los llevo de los contadores son 0, 
        es posible determinar la entrada en acción de alguno de los contadores
        por efecto de que se guarda un estado anterior, por lo tanto
        significa que al menos uno de los contadores está siendo ejecutado por el 
        cambio de valor desde un RCO en 1 a un RCO en 0.*/
        if (w1 == 0 || w2 == 0 || w3 == 0) begin
            a1 = 1;
            a2 = 1;
            a3 = 1;
            a4 = 1;
        end
        /* Para no generar un comportamiento inesperado en el if anterior, es necesario
        definir otros if adicionales que básicamente harán que cada contador 
        entre en acción de forma pausada y ordenada, siguiendo el orden de conteo,
        desde esta perspectiva, si el llevo del primer contador es 1, seguirá su ejecución
        y por lo tanto volverá a contar naturalmente mientras se habilita el siguiente 
        contador. Lo mismo aplica para los contadores restantes. */
        if (w1 == 1) begin
            RCO_temp <= 1;
            a1 = 1;
            
        end
        if (w2 == 1) begin
            RCO_temp <= 1;
            a2 = 1;
            
        end
        if (w3 == 1) begin
            RCO_temp <= 1;
            a3 = 1;
        end
        if (w4 == 1) begin
            RCO_temp <= 1;
            a4 = 1;
        end
    end 
    // assign RCO = RCO_temp;

    assign modo_11 = (MODO == 2'b11);
    assign clk1 = CLK && modo_11 || w1 && !modo_11;
    assign clk2 = CLK && modo_11 || w2 && !modo_11;
    assign clk3 = CLK && modo_11 || w3 && !modo_11;
    
    /* En este punto se asocian los cuatro contadores de 4 bits considerando especialmente
    la funcionalidad de la señal de reloj. Para efectos de mayor comprensión, favor referir-
    se al reporte escrito, donde se proyectan esquemáticos con el fin de ilustrar al lector
    de forma más amplia. */
    counter_4_bits counter_LSB(.Q(Q[3:0]), .RCO(w1), .D(D[3:0]), .ENB(a1), .CLK(CLK), .MODO(MODO));
    counter_4_bits counter_FSB(.Q(Q[7:4]), .RCO(w2), .D(D[7:4]), .ENB(a2), .CLK(clk1), .MODO(MODO));
    counter_4_bits counter_SSB(.Q(Q[11:8]), .RCO(w3), .D(D[11:8]), .ENB(a3), .CLK(clk2), .MODO(MODO));
    counter_4_bits counter_MSB(.Q(Q[15:12]), .RCO(w4), .D(D[15:12]), .ENB(a4), .CLK(clk3), .MODO(MODO));
    
endmodule

`endif
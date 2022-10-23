module tester (
    input MDC,
    input MDIO_OE,
    input MDIO_OUT,
    input [15:0] RD_DATA,
    input DATA_RDY,
    output reg MDIO_START,
    output reg [31:0] T_DATA,
    output reg CLK,
    output reg RESET,
    output reg MDIO_IN
);


/* instruccion para crear el reloj
   */
always begin
    CLK = 1'b0; #0.5;
    CLK = 1'b1; #0.5;
    // MDIO_IN = ~MDIO_IN; #12;
end

/* Pone todos los registros en cero
*/
initial begin
    // Prueba 1: reiniciar los registros y salidas
    RESET = 1'b0; #1; #1; 
    #1; #1; #1;
    RESET = 1'b1; #1; #1;
end

/*  Instrucciones para el generador
    de transacciones
*/
initial begin
    MDIO_START = 1'b0;
    MDIO_IN = 1'b0;
    // MDC = 1'b0;
    // Prueba 2: Palabra que no cumple con ST = 01 (start of frame)
    T_DATA = 32'b11011001100111101100110100111111; #1; #1; // primera palabra
    #8;
    MDIO_START = 1'b1; #1; #1; // pulso MDIO_START: indica el inicio de transmisión de datos
    // 0110_1001_1001_1110_1100_1101_0011_1111
    //      1101_1001_1010_0110        [19:4]

    
    // MDIO_START = 1'b0; #1; #1; T_DATA = 32'b00101001100111101100110100111111;// se cambia T_DATA durante la transmisión de datos
    #160;
    // Prueba 3: lectura
    MDIO_START = 1'b0; #1; #1;
    T_DATA = 32'b01101001100111101100110100111111; // segunda palabra
    // #1; #1;
    MDIO_START = 1'b1; #1; #1; // pulso MDIO_START: indica el inicio de transmisión de datos
    #160;
    // #1; #1; #1; #1; #1; #1; #1; #1;
    // #1; #1; #1; #1; #1; #1; #1; #1;
    // #1; #1; #1; #1; #1; #1; #1; #1;
    // #1; #1; #1; #1; #1; #1; #1; #1;
    
    // T_DATA = 32'b00101001100111101100110100111111; // se cambia T_DATA durante la transmisión de datos
    MDIO_START = 1'b0; #1; #1;
    T_DATA = 32'b01011001100111101100110011001111; // Escritura
    // #1; #1;
    MDIO_START = 1'b1; #1; #1; // pulso MDIO_START: indica el inicio de transmisión de datos
    // #1; #1; #1; #1; #1; #1; #1; #1;
    // #1; #1; #1; #1; #1; #1; #1; #1;
    // #1; #1; #1; #1; #1; #1; #1; #1;
    // #1; #1; #1; #1; #1; #1; #1; #1;
    // #1; #1; #1; #1;
    #160;
    // MDIO_START = 1'b1; #1; #1;  // pulso MDIO_START durante
    // MDIO_START = 1'b0; #1; #1;  // la transmisión de datos

    // #1; #1; #1; #1; #1; #1; #1; #1;
    // #1; #1; #1; #1; #1; #1; #1; #1;
    // #1; #1; #1; #1; #1; #1; #1; #1;
    // #1; #1; #1; #1; #1; #1; #1; #1;
    // #1; #1; #1; #1; #1; #1; #1; #1;
    // #1; #1; #1; #1; #1; #1; #1; #1;
    // #1; #1; #1; #1; #1; #1; #1; #1;
    // #1; #1; #1; #1; #1; #1; #1; #1;
    // #1; #1; #1; #1; #1; #1; #1; #1;
    // #1; #1; #1; #1; #1; #1; #1; #1;
    // #1; #1; #1; #1; #1; #1; #1; #1;

    // Prueba 4: escritura
    // T_DATA = 32'b00101001100111101100110100111111; // tercera palabra
    // #1; #1; #1; #1;

    // MDIO_START = 1'b1; #1; #1; // pulso MDIO_START: indica el inicio de transmisión de datos
    // MDIO_START = 1'b0; #1; #1;
end

/*  Valores "aleatorios" de
    MDIO_IN.
*/
initial begin
    #175;
    MDIO_IN = 1'b0; #1; #1; #1; #1; 
    MDIO_IN = 1'b1; #1; #1; #1; #1;
    MDIO_IN = 1'b0; #1; #1; #1; #1;
    MDIO_IN = 1'b1; #1; #1; #1; #1;
    MDIO_IN = 1'b1; #1; #1; #1; #1;
    MDIO_IN = 1'b0; #1; #1; #1; #1;
    MDIO_IN = 1'b1; #1; #1; #1; #1;
    MDIO_IN = 1'b0; #1; #1; #1; #1;
    MDIO_IN = 1'b0; #1; #1; #1; #1; 
    MDIO_IN = 1'b0; #1; #1; #1; #1;
    MDIO_IN = 1'b1; #1; #1; #1; #1;
    MDIO_IN = 1'b1; #1; #1; #1; #1;
    MDIO_IN = 1'b0; #1; #1; #1; #1;
    MDIO_IN = 1'b1; #1; #1; #1; #1;
    MDIO_IN = 1'b0; #1; #1; #1; #1;
    MDIO_IN = 1'b1; #1; #1; #1; #1;
    #610;
    $finish;
end

endmodule
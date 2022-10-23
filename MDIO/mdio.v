/*=======================================================================
#                                                                        #
#                                 Tarea 3                                #
#                      Autor: Alejandro Zuniga Perez                     #
#                             MDIO Protocol                              #
#                         Circuitos Digitales II                         #
#                                                                        #
========================================================================== */
`ifndef MDIO_V
`define MDIO_V
module MDIO(// Outputs
	          MDC,
	          MDIO_OE,
	          MDIO_OUT, 
	          RD_DATA,
	          DATA_RDY,
	          // Inputs
	          MDIO_START,
	          T_DATA,
	          CLK,
	          RESET,
	          MDIO_IN
	          );

  output reg MDC; // Salida de reloj para MDIO
  output reg MDIO_OE; // Habilita MDIO_OUT
  output reg MDIO_OUT; // Salida serial
  output reg [15:0] RD_DATA; // Recibe los datos que vienen del PHY.
  output reg DATA_RDY; // Determina cuando la transaccion se ha ejecutado.

  input CLK; // Reloj
  input RESET; // Reinicio del generador. RESET = 1, todo normal.
  input MDIO_START;// Strobe
  input MDIO_IN;
  input [31:0] T_DATA;

  /* MDIO Communication basic frame format */
  reg [1:0] ST;           // Start of frame. 
  reg [1:0] OP;           // OP CODE 
  reg [4:0] PHY;          // Physical address.
  reg [4:0] REG_ADDRESS;  // Register Address.
  reg [1:0] TA;           // Turnaround time to change.
  /* ===================================== */
  reg [15:0] written;
  reg [15:0] read;
  reg [2:0] next_state; /* Es un registro de 3 bits que
  corresponde a los estados presentes dentro de la 
  transaccion. Se han definido los siguientes:
    ST          = 000
    OP          = 001
    PHY         = 010
    REG_ADDRESS = 011
    TA          = 100
    Lectura     = 101
    Escritura   = 110 */
  reg [31:0] q; 
  reg [0:15] temp;
  reg [4:0] count; // Es un registro que controla la cuenta dentro de la transaccion.
  // Funciona para cuando se necesite leer paralelamente.
  reg [5:0]counter;
  always@(posedge CLK) begin
    // MDC controlado por cada mitad del ciclo de reloj (CLK).
    if (~RESET) begin
      MDC <= 0;
    end else begin
      MDC <= !MDC;
    end
  end

  // MDC es una salida que se prueba en el tester.
  always@(posedge CLK) begin
    // Se declara que si reset es 0, el generador vuelve a un estado
    // de apagado.
    if(!RESET) begin
      MDIO_OE <= 1'b0;
      MDIO_OUT <= 1'b0;
      DATA_RDY <= 1'b0;
      RD_DATA <= 16'h0000;
      temp = 16'h0000;
    end
  end
  
  always@(posedge MDC) begin
    // Se secciona el siguiente estado por cada 
    ST = T_DATA[31:30];
    OP = T_DATA[29:28];
    PHY = T_DATA[27:23];
    REG_ADDRESS = T_DATA[22:18];
    TA = T_DATA[17:16];
    q <= 32'b00000000000000000000000000000000;
    next_state <= 3'b000;
    RD_DATA <= 16'h0000;
    
    $display("counter=%d", counter);
    if (RESET == 1) begin
      // Iniciamos la transaccion.
      counter <= 32'b00000;
      q <= T_DATA;
      
      if (MDIO_START) begin
        counter <= counter+1;
        MDIO_OUT <= q[0];
        q<=q>>1;
        
        // Hemos llegado al primer estado, el cual pregunta por ST.
        if (ST == 01) begin
          // $display("shit");
          next_state = 3'b001;// Estamos ahora en el estado OP ya que 
                              // ST es 01
        end else begin
          next_state = 3'b000;
          q <= 32'b00000000000000000000000000000000;
        end
        // end
        
        if (next_state == 3'b001) begin
          $display("Estamos en OP");
          if (OP == 2'b01 || OP == 2'b10) begin
            // Modo escritura o lectura, pasa al siguiente estado que es PHY ADDRESS.
            $display("OP = %b", OP);
            next_state = 3'b010; // PHYSICAL ADD
          end
        end else begin
          next_state = 3'b000; // Vuelve al estado inicial.
        end
        
        if (next_state == 3'b010) begin
          $display("estamos en phy");
          next_state = 3'b011; // Se continua hacia el estado REG_ADDRESS.
        end 

        if (next_state == 3'b011) begin
          $display("estamos en REG ADD");
          next_state = 3'b100; // Estado REGADRESS. 
        end 

        if (next_state == 3'b100) begin
          // En este punto se ha llegado al estado timearound
          if (OP == 2'b01) begin
            // Entramos en el modo escritura. 
            next_state = 3'b110;
          end else if(OP == 2'b10) begin
            // Se ingresa al modo lectura.
            next_state = 3'b101; 
          end
        end

        if (next_state == 3'b110) begin
          // Modo escritura: en este caso se debe tomar en cuenta el comportamiento
          // de MDIO_OE
          written = T_DATA [15:0];
          MDIO_OE = 1'b1;
          if (counter > 31) begin
            MDIO_OE <= 1'b0;
          end
        end

        if (next_state == 3'b101) begin
          // temp <= RD_DATA>>1;
          read <= T_DATA[15:0];
          $display("Estamos aqui en READING %b", T_DATA);
          MDIO_OE <= 1'b1;     // Se pone en 1 durante los primeros 16 ciclos de la transaccion.
          DATA_RDY <= 1'b0;
          
          if (counter >= 5'b01111) begin
            MDIO_OE <= 1'b0; // Una vez que se pasan los ciclos, la salida MDIO_OE se desactiva.
          end

          if(counter >= 5'b01111 && counter < 5'b11111)begin // 01111 = 15
            DATA_RDY <= 1'b1;
          end 
            
          temp[counter] <= MDIO_IN;
          if (DATA_RDY == 1 && counter==5'b10001) begin
            // RD_DATA <= temp;
            RD_DATA <= temp;
          end

          if (count >= 31) begin
             // Indica que la transaccion se ha realizado exitosamente.
            MDIO_OE <= 1'b0;
            // DATA_RDY <= 1'b0;
          end

        end

       
      end

      
    end

  end
endmodule


`endif

// tmp <= 4’b0000;
// 
// else
// 
// tmp <= tmp << 1;
// 
// tmp[0] <= si;

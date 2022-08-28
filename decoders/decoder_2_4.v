`ifndef encoder_2_4
`define encoder_2_4
module encoder_2_4(y, en, I);

  input [1:0]I;
  input en;
  output reg [3:0]y;

  always@(*)
    begin
      case({en, I})
		3'b100: y = 4'b0001;
		3'b101: y = 4'b0010;
		3'b110: y = 4'b0100;
		3'b111: y = 4'b1000;
		3'b000,
		3'b001,
		3'b010,
		3'b011: y = 4'b0000;
	default: $display("Invalid combinations.");
      endcase
    end
endmodule

`endif

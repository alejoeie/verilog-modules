`ifndef decoder_tb
`define decoder_tb

`include "decoder_2_4.v"

module decoder_tb;
    reg [1:0]I;
    reg en;
    wire [3:0]y;

    encoder_2_4 encoder_bits(.y(y), .en(en), .I(I));
    initial $monitor("time: %d, I = %b, EN = %b, y = %b ", $time, I, en, y);

    initial 
        begin
            {en, I} = 3'b000;
            $dumpfile("encoder_bench.vcd");
            $dumpvars(0, decoder_tb);
            begin
                repeat(2);
                    #10; {en, I} = 3'b100;
                    #10; {en, I} = 3'b101;
                    #10; {en, I} = 3'b110;
                    #10; {en, I} = 3'b111;
                    #10; {en, I} = 3'b000;
                    #10; {en, I} = 3'b001;
                    #10; {en, I} = 3'b010;
                    #10; {en, I} = 3'b011;
            end
        end
endmodule

`endif
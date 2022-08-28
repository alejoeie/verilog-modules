run:
	iverilog -o result.out decoder_2_4.v decoder_tb.v

build: 
	vvp result.out

data_visualize: 
	./a.out

gtk_comp: 
	gtkwave encoder_bench.vcd
make all: 
	run

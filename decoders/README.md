## DECODER 2 x 4

This basic logic circuit is based upon a 2 bits input, in which the EN (Enable) signal comes up for controlling the ouput signal.
The idea is to convert from a binary input (01) meaning the number 1 in decimal base, the decoder is going to transform the number 
into a 4 bits number. 

It is a basic practice for obtaning better skills for developing verilog code. 

## COMPILATION. 

On a terminal, run the following commands:

1) make run -> Will run the iverilog command for compiling both verilog files. (TestBench DUT and Verilog module).
2) make build -> Will turn the .out file and print in console the status for the signals.
3) make gtk_comp -> Will open GTKWave for signals visualization.

## REQUIREMENTS.
This project will be built in Icarus Verilog, so you must need to install icarus. 
You will also need to install GTKWave, an open source software for compiling
and visualizing vcd outputs.


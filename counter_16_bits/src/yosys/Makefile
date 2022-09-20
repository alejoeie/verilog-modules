# ++++++++++++++++++++++++++++++++++++++++++++++
#	Tarea 1 - Makefile de compilacion del contador sincronico de 4 bits.
#
#	Descripción conductual de un contador sincrónico 
#	de 4 bits.
#
#	Autor: Alejandro Zuniga Perez
#	Carne: B59097 
#   ++++++++++++++++++++++++++++++++++++++++++++++ 
OBJ_FILE := counter.out
TB := testbench.v
all:
	iverilog -o $(OBJ_FILE) $(TB)
	vvp $(OBJ_FILE)
	gtkwave testbench.vcd
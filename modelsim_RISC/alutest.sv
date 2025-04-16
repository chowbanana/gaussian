//-----------------------------------------------------
// File Name : alu.sv
// Function : testbench for alu
// Version 1 : code template for Cyclone  MLAB 
//             and true dual port sync RAM
// Author: hwxt
// Last rev. 07 April 2025
//-----------------------------------------------------
module alutest;

parameter n = 8;

// logic clk, w1, w2;
logic [n-1:0] a, b;
// logic [n-1:0] Wdata1, Wdata2;
logic [2:0] func;
logic [3:0] flags;
logic [n-1:0] result;

alu  #(.n(n)) alu(.*);

// initial
// begin
//   clk =  0;
//   forever #5ns clk = ~clk;
// end

initial
begin
    #10 func = 0; a = 100000; // RA

    #10 func = 1; b = 100000; // RB

    #10 func = 2; // RADD

    #10 func = 3; // RSUB

    #10 func = 4; // RAND

    #10 func = 5; // ROR

    #10 func = 6; // RXOR

    #10 func = 7; // RNOR

    #10 $stop;
end

	

endmodule // module regstest
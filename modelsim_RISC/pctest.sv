//-----------------------------------------------------
// File Name : pctest.sv
// Function : testbench for program counter
// Version 1 : code template for Cyclone  MLAB 
//             and true dual port sync RAM
// Author: hwxt
// Last rev. 07 April 2025
//-----------------------------------------------------
module pctest;

parameter Psize = 6;

logic clk, reset, PCincr,PCabsbranch,PCrelbranch;
logic [Psize-1:0] Branchaddr;
logic [Psize-1 : 0] PCout ;

pc  #(.Psize(Psize)) pc(.*);

initial
begin
    clk = 0;
    forever #5ns clk = ~clk;
end

initial
begin
    reset = 1;
    #12 reset = 0;
    #10 PCincr = 1;
    #10 PCincr = 0;
    #10 PCincr = 1; // PCout = 2
    #10 PCincr = 0; // need to set to 0 to allow Rbranch = Branchaddr

    #10 PCrelbranch = 1; Branchaddr = 10; // testing relative branch

    #10 PCincr = 1; // PCout = 13

    #10 PCincr = 0; PCabsbranch = 1; Branchaddr = 10; // if 32 will be -ve??

    #10 $stop;
end

	

endmodule // module pctest
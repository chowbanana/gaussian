//-----------------------------------------------------
// File Name : cputest.sv
// Function : testbench for cpu
// Version 1 : code template for Cyclone  MLAB 
//             and true dual port sync RAM
// Author: hwxt
// Last rev. 07 April 2025
//-----------------------------------------------------
module cputest;

parameter n = 8;

logic clk, reset;
logic [n-1:0] outport;

cpu  #(.n(n)) cpu(.*);

initial
begin
    clk = 0;
    forever #5ns clk = ~clk;
end

initial
begin
    reset = 1;
end

	

endmodule // module pctest
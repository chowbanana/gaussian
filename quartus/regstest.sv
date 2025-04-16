//-----------------------------------------------------
// File Name : regstest.sv
// Function : testbench for pMIPS 32 x n registers, %0 == 0
// Version 1 : code template for Cyclone  MLAB 
//             and true dual port sync RAM
// Author: tjk
// Last rev. 25 Oct 2012
//-----------------------------------------------------
module regstest;

parameter n = 8;

// logic clk, w1, w2;
logic clk, w;
// logic [n-1:0] Wdata1, Wdata2;
logic [n-1:0] Wdata;
logic [4:0] rs, rd;
logic [n-1:0] rs_data, rd_data;

regs  #(.n(n)) r(.*);

initial
begin
  clk =  0;
  forever #5ns clk = ~clk;
end

initial
begin
  // ADDI
    w = 1;
    rs = 0; rd = 0;
    Wdata = 0;

  #12 w = 0; // BRA
  #10 w= 1; Wdata = 3; rd = 1; rs = 0; // LDI
  #10 w = 1; Wdata= 11; rd = 6; rs = 1; // LDW 
  // #10 rd = 0; // test reg %0
  // #10 w= 0; rd = 4;
  #10

  $stop;
end

	

endmodule // module regstest
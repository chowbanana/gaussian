//-----------------------------------------------------
// File Name : pc.sv
// Function : picoMIPS Program Counter
// functions: increment, absolute and relative branches
// Author: tjk
// Last rev. 24 Oct 2012
//-----------------------------------------------------
module pc #(parameter Psize = 5) // up to 64 instructions
(input logic clk, n_reset, PCincr ,beq,
 input logic [1:0] Branchaddr,
 output logic [Psize-1 : 0]PCout
);

//------------- code starts here---------
logic[1:0] Rbranch; // temp variable for addition operand
always_comb
   if (PCincr)
      Rbranch = 2'b01;
   else
      Rbranch =  Branchaddr;


always_ff @ ( posedge clk or negedge n_reset) // async reset
   if (!n_reset) // sync reset
      PCout <= {Psize{1'b0}};
   // else if (PCincr) // increment or relative branch
   //    PCout <= PCout + Rbranch; // 1 adder does both
   // else if (PCabsbranch) // absolute branch
   //    PCout <= Branchaddr;
   else if (PCincr)
      PCout <= PCout + Rbranch;
   else if (beq)
      PCout <= Rbranch;
endmodule // module pc
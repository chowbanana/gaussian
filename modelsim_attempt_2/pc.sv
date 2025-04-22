//-----------------------------------------------------
// File Name : pc.sv
// Function : picoMIPS Program Counter
// functions: increment, absolute and relative branches
// Author: tjk
// Last rev. 24 Oct 2012
//-----------------------------------------------------
module pc #(parameter Psize = 5) // up to 64 instructions
(input logic clk, n_reset, PCincr,PCabsbranch,beq,
 input logic [Psize-1:0] Branchaddr,
 output logic [Psize-1 : 0]PCout
);

//------------- code starts here---------
logic[Psize-1:0] Rbranch; // temp variable for addition operand
always_comb
   if (PCincr)
      Rbranch = { {(Psize-1){1'b0}}, 1'b1};
   else if (beq)
      Rbranch =  Branchaddr;
   else
      Rbranch = 0;


always_ff @ ( posedge clk or negedge n_reset) // async reset
   if (!n_reset) // sync reset
      PCout <= {Psize{1'b0}};
   // else if (PCincr) // increment or relative branch
   //    PCout <= PCout + Rbranch; // 1 adder does both
   // else if (PCabsbranch) // absolute branch
   //    PCout <= Branchaddr;
   else if (beq)
      PCout <= Rbranch;
   else
      PCout <= PCout + Rbranch;
endmodule // module pc
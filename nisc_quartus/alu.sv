//-----------------------------------------------------
// File Name   : alu.sv
// Function    : ALU module for picoMIPS
// Version: 1,  only 8 funcs
// Author:  tjk
// Last rev. 23 Oct 12
//-----------------------------------------------------

`include "alucodes.sv"
module alu #(parameter n =8) (
   input logic [n-1:0] a, b, // ALU operands
   input logic [1:0] func, // ALU function code
   output logic [n-1:0] result // ALU result
);
//------------- code starts here ---------

// create an n-bit adder 
// and then build the ALU around the adder
// logic[n-1:0] ar,b1; // temp signals
// always_comb
// begin
//    ar = a+b; // n-bit adder
// end // always_comb
   
// create the ALU, use signal ar in arithmetic operations
always_comb
begin
   result = a; // default
   case(func)
      `RNOP: ;

      `RB:
         result = b;

      `RADD:
         result = a + b;
      
      `RMUL:
      begin
         logic[(2*n)-1:0] mul_temp;
         mul_temp = $signed(a) * $signed(b);
         result = mul_temp[14:7];
      end

   endcase
 end //always_comb

endmodule //end of module ALU
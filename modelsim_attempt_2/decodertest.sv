//---------------------------------------------------------
// File Name   : decodertest.sv
// Function    : testbench for picoMIPS instruction decoder 
// Author: tjk
// ver 1:  // only NOP, ADD, ADDI
// Last revised: 26 Oct 2012
//---------------------------------------------------------

`include "alucodes.sv"
`include "opcodes.sv"
//---------------------------------------------------------
module decodertest;

logic [5:0] opcode; // top 6 bits of instruction
logic [3:0] flags;
logic [2:0] ALUfunc;
logic PCincr,PCabsbranch,PCrelbranch;
logic imm, w;

decoder d(.*);
   

initial 
begin
  opcode = `NOP; flags = 4'b0000;
  #10 opcode = `ADD; 
  #10 opcode = `ADDI; 
  #10 opcode = `BEQ; flags = 4'b0010;
  
  #10 $stop;

end


endmodule //module decoder --------------------------------
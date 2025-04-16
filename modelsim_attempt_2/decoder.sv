//---------------------------------------------------------
// File Name   : decoder.sv
// Function    : picoMIPS instruction decoder 
// Author: tjk
// ver 2:  // NOP, ADD, ADDI, and branches
// Last revised: 26 Oct 2012
//---------------------------------------------------------

`include "alucodes.sv"
`include "opcodes.sv"
//---------------------------------------------------------
module decoder
( 
// top 6 bits of instruction  
input logic [5:0] opcode,
 // ALU flags
input logic [3:0] flags,
// Branch Condition
input logic branch_condition,
// Branch Status
input logic branch_status,
// output signals
//    PC control
output logic PCincr,PCabsbranch,PCrelbranch,
//    ALU control
output logic [2:0] ALUfunc, 
// imm mux control
output logic imm,
// retrieve value from switch
output logic retrieve_switch,
// retrieve value from wave
output logic retrieve_wave,
//   register file control
output logic w,
// Branch Status
output logic LED_status
  );
   
//------------- code starts here ---------
// instruction decoder
logic takeBranch; // temp variable to control conditional branching
always_comb 
begin
  // set default output signal values for NOP instruction
   PCincr = 1'b1; // PC increments by default
	PCabsbranch = 1'b0; PCrelbranch = 1'b0; retrieve_switch = 1'b0; retrieve_wave = 1'b0; LED_status = 1'b0;
   ALUfunc = opcode[2:0];
   $display("opcode: %h ", opcode);
   imm=1'b0; w=1'b0; 
   takeBranch =  1'b0; 
   case(opcode)
     `NOP: ;
     `ADD,`SUB : begin // register-register
	        w = 1'b1; // write result to dest register
	      end
     `ADDI,`SUBI, `MULI: begin // register-immediate
	        w = 1'b1; // write result to dest register
		  imm = 1'b1; // set ctrl signal for imm operand MUX
	      end
      `LDI : begin
	        w = 1'b1; // dest register
			  imm = 1'b1; // direct imm data to data_a
        retrieve_switch = 1'b1;
      end
      `LDW : begin
        w = 1'b1;
        retrieve_wave = 1'b1;
	       end
      `BRA : begin
         if (branch_status == branch_condition) begin
            // takeBranch = 1'b1;
            PCincr = 1'b0;
            PCabsbranch = 1'b1;
         end

         else
          PCincr = 1'b0;

          if (branch_status == 1)
            LED_status = 1'b1;
      end

      //  `BRA1 : begin
      //       if (branch_status == 1)
      //         takeBranch = 1'b1;
      // end

      //  `BRA0 : begin
      //       if (branch_status == 0) begin
      //         takeBranch = 1'b1;
      //         LED_status = 1'b1;
      //       end
      // end
      `DISP : begin
        LED_status = 1'b1;
      end
	 	  
    // branches
	`BEQ: takeBranch = flags[1]; // branch if Z==1
	`BNE: takeBranch = ~flags[1]; // branch if Z==0
	`BGE: takeBranch = ~flags[2]; // branch if N==0
	`BLO: takeBranch = flags[0]; // branch if C==1
	default:
	    $error("unimplemented opcode %h",opcode);
 
  endcase // opcode
  
   if(takeBranch) // branch condition is true;
   begin
      PCincr = 1'b0;
	  PCrelbranch = 1'b1; 
   end


end // always_comb


endmodule //module decoder --------------------------------
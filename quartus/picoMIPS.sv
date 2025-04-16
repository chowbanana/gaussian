//------------------------------------
// File Name   : cpu.sv
// Function    : picoMIPS CPU top level encapsulating module, version 2
// Author      : tjk
// Ver 2 :  PC , prog memory, regs, ALU and decoder, no RAM
// Last revised: 27 Oct 2012
//------------------------------------

`include "alucodes.sv"
module picoMIPS #( parameter n = 8) // data bus width
(input logic clk,  
  input reset, // master reset
  input branch_status,
  input logic [n-1:0] SW,
  output logic[n-1:0] outport // need an output port, tentatively this will be the ALU output
);       

// declarations of local signals that connect CPU modules
// ALU
logic [2:0] ALUfunc; // ALU function
logic [3:0] flags; // ALU flags, routed to decoder
logic imm; // immediate operand signal
logic [n-1:0] Alub; // output from imm MUX
logic retrieve_switch, retrieve_wave;
//
// registers
logic [n-1:0] rs_data, rd_data, Wdata; // Register data
logic w; // register write control
//
// Program Counter 
parameter Psize = 6; // up to 64 instructions
logic PCincr,PCabsbranch,PCrelbranch; // program counter control
logic [Psize-1 : 0]ProgAddress;
// Program Memory
parameter Isize = n+16; // Isize - instruction width
logic [Isize-1:0] I; // I - instruction code
logic [7:0] wave_val;
// LED
logic LED_status;

//------------- code starts here ---------
// module instantiations
pc  #(.Psize(Psize)) progCounter (.clk(clk),.reset(reset),
        .PCincr(PCincr),
        .PCabsbranch(PCabsbranch),
        .PCrelbranch(PCrelbranch),
        .Branchaddr(I[Psize-1:0]), 
        .PCout(ProgAddress) );

prog #(.Psize(Psize),.Isize(Isize)) 
      progMemory (.address(ProgAddress),.I(I));

decoder  D (.opcode(I[Isize-1:Isize-6]),
            .branch_condition(I[n-1]),
            .branch_status(branch_status),
            .PCincr(PCincr),
            .PCabsbranch(PCabsbranch), 
            .PCrelbranch(PCrelbranch),
            .flags(flags), // ALU flags
		  .ALUfunc(ALUfunc),.imm(imm),.w(w), .retrieve_switch(retrieve_switch), .retrieve_wave(retrieve_wave), .LED_status(LED_status));

regs   #(.n(n))  gpr(.clk(clk),.w(w),
        .Wdata(Wdata),
		.rd(I[Isize-7:Isize-11]),  // reg %d number
		.rs(I[Isize-12:Isize-16]), // reg %s number
        .rs_data(rs_data),.rd_data(rd_data));

alu    #(.n(n))  iu(.a(rs_data),.b(Alub),
       .func(ALUfunc),.flags(flags),
       .result(Wdata)); // ALU result -> destination reg

sample_wave wave (.i(rs_data), .wave_val(wave_val));

// create MUX for immediate operand
assign Alub = (imm ? (retrieve_switch ? SW[n-1:0] :I[n-1:0]) : (retrieve_wave ? wave_val: rd_data ));

// connect ALU result to outport
assign outport = (LED_status ? rs_data: 0 );

endmodule
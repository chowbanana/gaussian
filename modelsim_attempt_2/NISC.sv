//------------------------------------
// File Name   : cpu.sv
// Function    : picoMIPS CPU top level encapsulating module, version 2
// Author      : tjk
// Ver 2 :  PC , prog memory, regs, ALU and decoder, no RAM
// Last revised: 27 Oct 2012
//------------------------------------

`include "alucodes.sv"
module NISC #( parameter n = 8) // data bus width
(       input logic clk,  
        input n_reset, // master reset
        input poll,
        input logic [n-1:0] SW,
        output logic[n-1:0] outport // need an output port, tentatively this will be the ALU output
);       

// declarations of local signals that connect CPU modules
//! ALU
logic ALUfunc; // ALU function
logic imm; // immediate operand signal
logic [n-1:0] Alub; // output from imm MUX

//! Registers
logic [n-1:0] rs_data, rd_data, Wdata; // Register data
logic w; // register write control

//! Program Counter 
parameter Psize = 5; // up to 32 instructions
logic PCincr,PCabsbranch; //,PCrelbranch; // program counter control
logic [Psize-1 : 0]ProgAddress;

//! Program Memory
parameter Isize = n+12; // Isize - instruction width
logic [Isize-1:0] I; // I - instruction code
logic [7:0] wave_val;

//! Branch
logic beq, is_branch;

//------------- code starts here ---------
// module instantiations
pc  #(.Psize(Psize)) progCounter (.clk(clk),.n_reset(n_reset), .beq(beq),
        .PCincr(PCincr),
        .Branchaddr(I[1:0]), 
        .PCout(ProgAddress) );

branch b (.a(poll), .b(I[Isize-3]), .is_branch(is_branch), .beq(beq));

prog #(.Psize(Psize),.Isize(Isize)) 
        progMemory (.address(ProgAddress),.I(I));

control_unit c  (//.branch_condition(I[Isize-3]),
                .poll(poll),
                .microinstruction(I[Isize-1:Isize-7]),
                .PCincr(PCincr),
                .led_status(led_status),
                .ALUfunc(ALUfunc),
                .imm(imm),
                .is_branch(is_branch),
                .Wdata_select(Wdata_select),
                .w(w));

regs   #(.n(n))  gpr(.clk(clk),.w(w), .Wdata_select(Wdata_select),
        .switch_val(SW[n-1:0]),
        .Wdata(Wdata),
        .wave_val(wave_val),
        .rd(I[Isize-8:Isize-10]),  // reg %d number
        .rs(I[Isize-11:Isize-13]), // reg %s number
        .rs_data(rs_data),.rd_data(rd_data));

alu    #(.n(n))  iu(.a(rs_data),.b(Alub),
        .func(ALUfunc),
        .result(Wdata)); // ALU result -> destination reg

sample_wave wave (.i(rs_data), .wave_val(wave_val));

// create MUX for immediate operand
// assign Alub = (imm ? (retrieve_switch ? SW[n-1:0] :I[Isize-17:0]) : (retrieve_wave ? wave_val: rd_data ));

assign Alub = (imm ? {I[Isize-14], I[Isize-14:0]} : rd_data);

// connect ALU result to outport
assign outport = (led_status ? rs_data : 0 );

endmodule
// opcodes.sv
//-----------------------------------------------------
// File Name   : opcodes.sv
// Function    : picoMIPS opcode definitions 
//               for example 28 Feb 14
// only 5 opcodes:   NOP, ADD, ADDI, SUBI, BNE
// Note that Opcodes are 6 bits long and
// the opcodes of ALU instructions have the
// required 3-bit ALU code in the lowest 3 bits
// Author:   tjk
// Last rev. 19 Apr 24
//-----------------------------------------------------

//! Using `RNOP (00)
// Branch at SW[8]
`define BRA  4'b0000

//! Using `RB (01)
// Display on LED
`define DISP 4'b0001

// LDW %d, %0, imm; %d = %0 + imm
`define LDW  4'b0101

//! Using `RADD (10)
// ADD %d, %s;  %d = %d+%s
`define ADD  4'b0010

// ADDI %d, %s, imm ;  %d = %s + imm
`define ADDI  4'b0110

// LDI %d, %0, imm; %d = %0 + imm
`define LDI  4'b1010

//! Using `RMUL (11)
// MUL %d, %s;  %d = %d*%s
`define MULI  4'b0011




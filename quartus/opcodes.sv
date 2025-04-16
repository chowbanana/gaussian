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

// NOP
`define NOP  6'b000000

// ADD %d, %s;  %d = %d+%s
`define ADD  6'b000010

// ADDI %d, %s, imm ;  %d = %s + imm
`define ADDI  6'b001010

// LDI %d, %0, imm; %d = %0 + imm
`define LDI  6'b010010

// Branch at SW[8]==1
`define BRA  6'b011110


// `define BRA1  6'b011010

// `define BRA0  6'b100010

// Display on LED
`define DISP 6'b101001

// LDW %d, %0, imm; %d = %0 + imm
`define LDW  6'b100001

// SUB %d, %s, imm ;  %d = %s - %d
`define SUB  6'b000011

// SUBI %d, %s, imm ;  %d = %s - imm
`define SUBI  6'b001011

// BNE %d, %s, imm; PC = (%d!=%s? PC+ imm : PC+1)
`define BNE  6'b011011

// BEQ %d, %s, imm; PC = (%d=%s? PC+ imm : PC+1)
`define BEQ  6'b010011

// BGE %d, %s, imm; PC = (%d>=%s? PC+ imm : PC+1)
`define BGE  6'b100011

// BLO %d, %s, imm; PC = (%d<%s? PC+ imm : PC+1)
`define BLO  6'b101011

// MUL %d, %s;  %d = %d*%s
`define MULI  6'b000111




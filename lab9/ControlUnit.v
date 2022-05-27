`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ETH Zurich
// Engineer: Frank K. Gurkaynak
// 
// Create Date:    08:45:28 03/22/2011 
// Design Name: 
// Module Name:    ControlUnit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ControlUnit(
      input  [5:0] Op,
      input  [5:0] Funct,
      output       Jump,
      output       MemtoReg,
      output       MemWrite,
      output       Branch,
      output [5:0] ALUControl,   // Current ALU is 4 bits, this is 6 bit for future
      output       ALUSrc,
      output       RegDst,
      output       RegWrite
    );
	 
//////////////////////////////////////////////////////////////////////////////////
// DEFINE SOME CONSTANTS to make life easier
localparam [5:0] OP_RTYPE = 6'b000000;  // There is an R-Type of Operation
localparam [5:0] OP_LW    = 6'b100011;  // The Load Word operation
localparam [5:0] OP_SW    = 6'b101011;  // The Store Word operation
localparam [5:0] OP_BEQ   = 6'b000100;  // The Branch on Equal operation
localparam [5:0] OP_ADDI  = 6'b001000;  // The ADDimmediate operation
localparam [5:0] OP_J     = 6'b000010;  // The Jump operation

//////////////////////////////////////////////////////////////////////////////////
// DEFINE THE MAIN CONTROL SIGNALS
// The control signals are mostly based on the table 7.5 on page 379
//
// IMPORTANT:
// Map the don't care statements to '0' 
// (The testbench will assume that these have been mapped to '0', although
//  technically any combination of don't cares mapped as '1' would also 
//  execute the lab7a.asm correctly)

// We will write to registers when OP is Rtype or LW or ADDI 

assign RegWrite = (Op == OP_RTYPE) | (Op == OP_LW) | ( Op == OP_ADDI) ; 	 

// Select the input of the ALU
assign ALUSrc   = (Op == OP_LW) | (Op == OP_SW) | (Op == OP_ADDI) ;

// Simple assignments
assign RegDst   = (Op == OP_RTYPE); // The destination is a register
assign Branch   = (Op == OP_BEQ);   // 1: if there is a branch instruction 
assign MemWrite = (Op == OP_SW);    // 1: for Store Word
assign MemtoReg = (Op == OP_LW);	   // 1: when Load Word
assign Jump     = (Op == OP_J);	   // 1: when Jump

//////////////////////////////////////////////////////////////////////////////////
// THE ALU Controls, these are bit more complex
// 
// The book uses a 2 bit ALU word (page 375) 
// The example here is slightly different to allow easier modifications
// in the next laboratory exercises. Essentially the ALU control is equal
// to the Funct part, however for some of the non-R type instructions
// an ALU operation is needed in the background,  both  LW and SW need 
// to calculate the address by adding the 
assign ALUControl = ALUSrc ? 6'b100000 :  // if LW, SW or ADDI, perform an ADD
                    Branch ? 6'b100010 :  // if BEQ, perform a SUB
					             Funct;   // per default assume an R-Type and do what Funct says
	 


endmodule

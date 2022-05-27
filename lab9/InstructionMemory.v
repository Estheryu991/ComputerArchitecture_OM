`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:34:17 03/21/2011 
// Design Name: 
// Module Name:    InstructionMemory 
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
module InstructionMemory(
     input   [5:0] A,   // Address of the Instruction max 64 instructions
	  output [31:0] RD   // Value at Address
    );

 reg [31:0] InsArr [63:0];  // Array holding the memory 64 entries each 32 bits
 
 initial
   begin
     $readmemh("insmem_h.txt", InsArr);  // Initialize the array with this content
   end
	
 assign RD= InsArr[A];   // The Read Data (RD) output corresponds to the Address (A)

endmodule

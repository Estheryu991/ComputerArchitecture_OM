`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: ETH Zurich
// Engineer: Frank K. Gurkaynak
//
// Create Date:   
// Design Name:   MIPS
// Module Name:   MIPS_test.v
// Project Name:  Lab7a
// Target Device:  
// Tool versions:  
// Description: Simple testbench to test the MIPS
//
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MIPS_test;

	// Inputs
	// For the MIPS test we do not really have inputs to apply,
	// The code is in the InstructionMemory, which in turn reads
	// the file "insmem_h.txt" to initialize its contents

	// Outputs
	// These are not real inputs and outputs. They are here so that
	// We can use a simple testbench to verify that the processor 
	// is actually working.
	wire [31:0] result;  // The "result" output of MIPS
	wire [31:0] PC;      // The Program Counter from MIPS

	reg         clk   ; // Test clock 
	reg         reset ; // reset (active high)


   // The test clock generation
	always            // process always triggers
	  begin
	     clk=1; #50;    // clk is 1 for 50 ns 
		  clk=0; #50;    // clk is 0 for 50 ns
	  end	             // generate a 100 ns clock

	// initialization
	initial
	  begin

     reset = 1;   // apply reset
     #60;         // Wait for reset
     reset= 0;    // Take reset back
	  #1100;      // Wait 12 cycles
	  $stop;       // stop the simulator we should have the correct value
	  end
	
 // instantiate the unit under test
 MIPS uut (
    .CLK(clk),      // The main clock of the system
    .RESET(reset),  // The reset signal active high
    .DATA(result),  // The 'result' signal from MIPS
    .ADDRESS(PC)    // The Program Counter
    );     
endmodule

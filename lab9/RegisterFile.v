`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ETH Zurich
// Engineer: Frank K. Gurkaynak
// 
// Create Date:    17:09:30 03/21/2011 
// Design Name: 
// Module Name:    RegisterFile 
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
module RegisterFile(
          input   [4:0] A1,   // selects one of 32 registers
			 output [31:0] RD1,  // register corresponding to A1
			 input   [4:0] A2,   // selects one of 32 registers
			 output [31:0] RD2,  // register corresponding to A2
			 input   [4:0] A3,   // selects the address for writeback
			 input  [31:0] WD3,  // Write-back data, will be written to addess A3
			 input         WE3,  // Write-enable for third port WE3=1 write WD3 to A3
			 input         CLK   // System clock
    );
   
	
    wire [31:0] Read1;  // output of PortA
	 wire [31:0] Read2;  // output of PortB
  // once everything works do not forget to add a reset here 
  // you should not enable WE while there is a reset
 
  // we instantiate two memories  
	 reg_half i_portA	 (
	   .a(A3), // Bus [4 : 0] 
	   .d(WD3), // Bus [31 : 0] 
	   .dpra(A1), // Bus [4 : 0] 
	   .clk(CLK),
	   .we(WE3),
	   .dpo(Read1)); // Bus [31 : 0] 

	reg_half i_portB (
	   .a(A3), // Bus [4 : 0] 
	   .d(WD3), // Bus [31 : 0] 
	   .dpra(A2), // Bus [4 : 0] 
	   .clk(CLK),
	   .we(WE3),
	   .dpo(Read2)); // Bus [31 : 0]     
	
     // For both ports, if the address is 0 
	  // Then the output will be zero
	  // Otherwise read the output from the register file 

     assign RD1 = (A1 != 4'b0000) ? Read1 : 0; // Port 1
	  assign RD2 = (A2 != 4'b0000) ? Read2 : 0; // Port 2

endmodule

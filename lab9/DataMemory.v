`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ETH Zurich
// Engineer: Frank K. Gurkaynak
// 
// Create Date:    16:44:39 03/21/2011 
// Design Name: 
// Module Name:    DataMemory 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: This is a simple single port data memory
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DataMemory(
             input         CLK,  // Clock signal rising edge
             input   [5:0] A,    // Address for 64 locations
			    input         WE,   // Write Enable 1: Write 0: no write
			    input  [31:0] WD,   // 32-bit data in
			    output [31:0] RD    // 32-bit read data
    );

    reg [31:0] DataArr [63:0];   // This is the variable that holds the memory
    initial
      begin
        $readmemh("datamem_h.txt", DataArr);  // Initialize the array with this content
      end

	 assign RD = DataArr[A];      // Read Data (RD) corresponds to address (A)

    always @ ( posedge CLK )     // At rising edge of CLK
	   begin
		  if (WE)                  // if Write Enable (WE) is set
		     DataArr[A] <= WD;     // Copy Write Data (WD) to the address (A)
		end

endmodule

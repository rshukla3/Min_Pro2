`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:15:55 02/12/2014
// Design Name:   main_logic
// Module Name:   C:/Users/Rohit/Documents/Xilinx_Projects/Mini_Proj_2/tb_main.v
// Project Name:  Mini_Proj_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main_logic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_main;

	// Inputs
	reg clk_25mhz;
	reg clk_100mhz;
	reg rst;
	reg rd_fifo;

	// Outputs
	wire [7:0] pixel_r;
	wire [7:0] pixel_g;
	wire [7:0] pixel_b;

	// Instantiate the Unit Under Test (UUT)
	main_logic uut (
		.clk_25mhz(clk_25mhz), 
		.clk_100mhz(clk_100mhz), 
		.rst(rst), 
		.pixel_r(pixel_r), 
		.pixel_g(pixel_g), 
		.pixel_b(pixel_b), 
		.rd_fifo(rd_fifo)
	);

	initial begin
		// Initialize Inputs
		clk_25mhz = 0;
		clk_100mhz = 0;
		rst = 1;
		rd_fifo = 0;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 1;
		// Add stimulus here
		#30
		rst = 0;
		rd_fifo = 1;
	end
	
	always
		#25 clk_100mhz = !clk_100mhz;
	
	
	always
		#100 clk_25mhz = !clk_25mhz;
      
endmodule


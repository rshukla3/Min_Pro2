`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:59:33 02/12/2014
// Design Name:   vgamult
// Module Name:   C:/Users/Rohit/Documents/Xilinx_Projects/Mini_Proj_2/tb_fifo.v
// Project Name:  Mini_Proj_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vgamult
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_fifo;

	// Inputs
	reg clk_100mhz;
	reg rst;
	reg up;
	reg down;
	reg left;
	reg right;

	// Outputs
	wire [7:0] pixel_r;
	wire [7:0] pixel_g;
	wire [7:0] pixel_b;
	wire hsync;
	wire vsync;
	wire blank;
	wire clk;
	wire clk_n;
	wire [11:0] D;
	wire dvi_rst;

	// Bidirs
	wire scl_tri;
	wire sda_tri;

	// Instantiate the Unit Under Test (UUT)
	vgamult uut (
		.clk_100mhz(clk_100mhz), 
		.rst(rst), 
		.pixel_r(pixel_r), 
		.pixel_g(pixel_g), 
		.pixel_b(pixel_b), 
		.hsync(hsync), 
		.vsync(vsync), 
		.blank(blank), 
		.clk(clk), 
		.clk_n(clk_n), 
		.D(D), 
		.dvi_rst(dvi_rst), 
		.scl_tri(scl_tri), 
		.sda_tri(sda_tri)
	);

	initial begin
		// Initialize Inputs
		clk_100mhz = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 1;  
		// Add stimulus here
		#30
		rst = 0;
	end
	
	always
	 #25 clk_100mhz = !clk_100mhz;
      
endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:39:06 02/10/2014 
// Design Name: 
// Module Name:    main_logic 
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
module main_logic(clk_25mhz, clk_100mhz, rst, pixel_r, pixel_g, pixel_b, rd_fifo);
    input clk_25mhz;
	 input clk_100mhz;
    input rst;
	 input rd_fifo;
    output [7:0] pixel_r;
    output [7:0] pixel_g;
    output [7:0] pixel_b;
	 
	 wire [23:0] fifo_data;	 
	 wire [23:0] rom_data;
	 wire fifo_empty;
	// wire wr_en_fifo;
	 wire rd_en_fifo;
	 wire full_fifo;
	 
	 wire WEN;
	
top_display_rom rom_disp_inst(
    .clk(clk_100mhz), 
	 .rst(rst), 
	 .fifo_full(full_fifo),
    .data(rom_data),
    .WEN(WEN)
);	
		
//	 assign wr_en_fifo = (~full_fifo)&(~rst);
	 assign rd_en_fifo = rd_fifo&(~fifo_empty)&(~rst);
	 
	 xfifo_1 xclk_fifo(
		.rst(rst),
		.wr_clk(clk_100mhz),
		.rd_clk(clk_25mhz),
		.din(rom_data),
		.wr_en(WEN),
		.rd_en(rd_en_fifo),
		.dout(fifo_data),
		.full(full_fifo),
		.empty(fifo_empty)
	 );
	 
	 RD_FIFO read_fifo(
		.fifo_data_rd(fifo_data),
		.pixel_r (pixel_r),
		.pixel_g (pixel_g),
		.pixel_b (pixel_b)
	 );

endmodule

`timescale 1ns/1ps

module top_display_rom (
input clk, rst, fifo_full, done,
output [23:0] data,
output WEN
);

wire [23:0] data_in;
wire [12:0] addr;

ROM ROM_4800 (
	.clka(clk),
	.addra(addr), // Bus [12 : 0] 
	.douta(data_in)); // Bus [23 : 0]

display display_inst (
    .clk(clk),
    .rst(rst),
	.fifo_full(fifo_full),
    .data_in(data_in),
    .addr(addr),
    .WEN(WEN),
    .data_out(data),
	 .done(done)
    );	

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:46:18 02/12/2014 
// Design Name: 
// Module Name:    display_plane 
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
module display_plane(
	clk,
	rst,
	rom_data,
	send_data,
	full_fifo
    );

	input clk;
	input rst;
	input full_fifo;
	output [23:0] rom_data;
	output reg send_data;
	//reg [23:0] rom_data;
	
	reg[12:0]counter;
	
	always @(posedge clk)
	begin
		if(rst)
		begin
			counter <= 13'd0;
			send_data <= 1'b0;
		end
		else
		begin
			case(full_fifo)
			1'b0: if(counter == 13'd4800)
					begin
						counter <= 13'd0;
						send_data <= 1'b0;
					end
					else
					begin
						counter <= counter + 1'd1;
						send_data <= 1'b1;						
					end
			default: counter <= counter;
			endcase
		end
	end
	
	
	ROM_img rom_img(
		.clka(clk),
		.addra(counter),
		.douta(rom_data)
		);

endmodule

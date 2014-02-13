`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    
// Design Name: 
// Module Name:    driver 
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
module display(
    input clk,
    input rst,
	input fifo_full,
    input [23:0] data_in,
    output reg [12:0] addr,
    output reg WEN,
    output [24:0] data_out
    );

	
	
	reg [2:0] h_count_8;
	assign h_flag_8 = (h_count_8 == 3) ? 1'b1 : 1'b0;
	
	reg [6:0] hp_count_80;
	assign hp_flag_80 = (hp_count_80 == 79) ? 1'b1 : 1'b0;

	reg [2:0] v_count_8;
	assign v_flag_8 = (v_count_8 == 3) ? 1'b1 : 1'b0;

	reg [5:0] vp_count_60;
	assign vp_flag_60 = (vp_count_60 == 59) ? 1'b1 : 1'b0;	
	
	reg [12:0] baseaddr;
	
	reg I_WEN;
	
	assign data_out = data_in;
	
	always @ (posedge clk)
	begin
	
	if(rst)
		begin
		h_count_8 <= 3'd0;
		hp_count_80 <= 7'd0;
		v_count_8 <= 3'd0;
		vp_count_60 <= 6'd0;
		baseaddr <= 13'd0;
		addr <= 13'd0;
		end
	else if(!fifo_full) // check if active high or low // fifo is not full then do read and write
		begin
		
		if(hp_flag_80) 
			begin
			hp_count_80 <= 0;
			h_count_8 <= h_count_8 + 1;			
			addr <= baseaddr;
			end
		if(h_flag_8 & hp_flag_80)
			begin
            h_count_8 <= 0;
            vp_count_60 <= vp_count_60 + 1;
            baseaddr <= baseaddr + 80;
            addr <=	baseaddr+80;		
			end
			
		if(vp_flag_60 & h_flag_8 & hp_flag_80)
			begin
			vp_count_60 <= 0;
		    v_count_8 <= v_count_8 + 1;
			baseaddr <= 0;
			addr <= 0;
			end
			
		if(v_flag_8 & vp_flag_60 & h_flag_8 & hp_flag_80)
			begin
			v_count_8 <= 0;
			end
		
		
		if(!hp_flag_80) 
		begin
		addr <= addr + 1;
		hp_count_80 <= hp_count_80 + 1;
		end
		
		end
	
	end
	

always @(posedge clk)
	begin
	if(rst)
	I_WEN <=0;
	else if(fifo_full)
    I_WEN <= 0;
	else 
	I_WEN <= 1;
	end
	
always @(posedge clk)
	begin
	if(rst)
	WEN <= 0;
	else
	WEN <= I_WEN;
	end
	
endmodule

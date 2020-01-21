 `timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/16 14:46:11
// Design Name: 
// Module Name: adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Addi
 
 module pc(input [31:0] NPC, input Clk, input Reset, input en, output [31:0]PC);
	reg [31:0] PC_t;
	assign PC = PC_t;
	always @ (posedge Reset, posedge Clk)
	begin
	   if(Reset==0)
	   begin
	       if(en) PC_t <= NPC;
	   end
	   else
	   begin 
	       PC_t <= 32'h00003000;
	   end 
	end
	
endmodule

`timescale 1ns / 1ns 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/16 14:06:32
// Design Name: 
// Module Name: mux
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_2(input [31:0]A, input [31:0] B, input select, output [31:0]result);
    assign result = (select==0)? A : B;
endmodule 

module mux_3(input [31:0]A, input [31:0] B, input [31:0]C, input [1:0]select, output [31:0]result);
    assign result = (select[1]==1)? C : ((select[0]==0)? A : B);
endmodule 

module mux_4(input [31:0]A, input [31:0] B, input [31:0]C, input[31:0]D, input [1:0]select, output [31:0]result);
    assign result = (select[1]==1)? ((select[0]==0)? C : D) : ((select[0]==0)? A : B);
endmodule 

module mux_5(input [31:0]A, input [31:0] B, input [31:0]C, input[31:0]D, input [31:0]E, input [2:0]select, output [31:0]result);
    assign result = (select[2]==1)? E : ((select[1]==1)? ((select[0]==0)? C : D) : ((select[0]==0)? A : B));
endmodule
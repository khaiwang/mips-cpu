`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/24 15:17:06
// Design Name: 
// Module Name: catenate
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


module catenate(input [31:0] left, input [31:0] right, output [31:0]catenate_result);
    assign catenate_result = {left[31:28], right[27:0]};
endmodule

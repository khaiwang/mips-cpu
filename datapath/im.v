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
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
   module im_8k(addr,dout);
    input [12:2] addr;     
    output wire [31:0] dout;        
    reg [31:0] im [2047:0];
    integer handle;
    assign dout = im[addr-11'b10000000000];
    initial
    begin
        $readmemh("C:/Users/11713/Desktop/4/tests/code-multdiv.txt",im);
    end
    
endmodule

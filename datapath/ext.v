`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/16 15:18:58
// Design Name: 
// Module Name: ext
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


module ext(input [15:0] A, input ext_op,  output [31:0] A_ext);
    wire [31:0] ext_zero;
    wire [31:0] ext_sign;
    assign ext_sign = $signed(A);
    assign ext_zero = {16'b0000000000000000,A[15:0]};
    assign A_ext = (ext_op==0)?ext_zero:ext_sign;
endmodule

module data_ext(input [1:0]A, input [31:0]din, input [2:0]op, output [31:0]dout);
    wire [31:0]init;
    wire [31:0]ubext1;
    wire [31:0]ubext2;
    wire [31:0]ubext3;
    wire [31:0]bext0;
    wire [31:0]bext1;
    wire [31:0]bext2;
    wire [31:0]bext3;
    wire [31:0]uhext1;
    wire [31:0]uhext2;
    wire [31:0]hext0;
    wire [31:0]hext1;
    wire [31:0]hext2;
    wire [31:0]sdin;
    assign sdin = $signed(din);
    assign init = din;
    assign ubext1 = {24'h000000, din[15:8]};
    assign ubext2 = {24'h000000, din[23:16]};
    assign ubext3 = {24'h000000, din[31:24]};
    assign bext0 = $signed(din[7:0]);
    assign bext1 = $signed(din[15:8]);
    assign bext2 = $signed(din[23:16]);
    assign bext3 = $signed(din[31:24]);
    assign uhext1 = {16'h0000, din[23:8]};
    assign uhext2 = {16'h0000, din[31:16]};
    assign hext0 = $signed(din[15:0]);
    assign hext1 = $signed(din[23:8]);
    assign hext2 = $signed(din[31:16]);
    assign dout = op[0]==0?din:(op[1]==0?(op[2]==0?(A[1]==0?(A[0]==0?din:ubext1):(A[0]==0?ubext2:ubext3)):(A[1]==0?(A[0]==0?bext0:bext1):(A[0]==0?bext2:bext3))):((op[2]==0?(A[1]==0?(A[0]==0?din:uhext1):uhext2):(A[1]==0?(A[0]==0?hext0:hext1):hext2))));
endmodule
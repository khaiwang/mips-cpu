`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/16 15:51:37
// Design Name: 
// Module Name: gr
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


module gr(input [4:0]Rreg1, input [4:0]Rreg2, input [4:0]Wreg1, 
        input [31:0]Wdata, input clk, input regwrite, output [31:0]Rdata1, output [31:0]Rdata2);
    reg [31:0] registers [31:0];
    integer i;
    assign Rdata1 = (Rreg1 == 0)?0:registers[Rreg1];
    assign Rdata2 = (Rreg2 == 0)?0:registers[Rreg2];
    always@(negedge clk)
    begin
        if(regwrite)
        begin
            if(Wreg1==0)
            begin
                registers[Wreg1] <= 0;
            end
            else
            begin
                registers[Wreg1] <= Wdata;
            end
        end
    end
    initial
    begin
        for(i=0; i<32; i=i+1)
        begin
            registers[i] = 0;
        end
    end
endmodule

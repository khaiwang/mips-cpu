`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/24 15:31:25
// Design Name: 
// Module Name: tb1
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


module tb1();
    reg Clk,Reset;
    mips mips_tb(.clk(Clk),.reset(Reset));
    integer i;     
    initial        
    begin        
        Clk = 0;        
        Reset = 0;        
        #1
        Clk = 0;        
        Reset = 1;
        #1       
        Reset = 0;   
        for(i=1;i<=50000;i=i+1)            
        begin
            #5            
            Clk = ~Clk;
            
        end      
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/21 03:10:26
// Design Name: 
// Module Name: multdiv
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


module multdiv(input clk, input reset, input [31:0]D1, input [31:0]D2, input hilo, input [1:0]op, input start, input we,
                output busy, output [31:0]hi, output [31:0]lo);
    reg [3:0] timer;
    reg [3:0] stop;
    reg [31:0] hi_reg;
    reg [31:0] lo_reg;
    reg busy_reg;
    
    wire [63:0]mult_result;
    wire [31:0]q;
    wire [31:0]r;
    
    assign mult_result = ((op[0]==1'b0)?(D1*D2):($signed(D1) * $signed(D2)));
    assign q = ((op[0]==1'b0)?(D1/D2):($signed(D1) / $signed(D2)));
    assign r = ((op[0]==1'b0)?(D1%D2):($signed(D1) % $signed(D2)));
    assign hi = hi_reg;
    assign lo = lo_reg;
    assign busy = busy_reg;
    
    always@(posedge clk)
    begin
        if(reset) 
        begin
            hi_reg = 32'h00000000;
            lo_reg = 32'h00000000;
            busy_reg = 1'b0;
            timer = 4'b0000;
            busy_reg = 4'b0000;
        end
        else
        begin
            if(we)
            begin
                if(hilo==1'b0)
                    lo_reg = D1;
                else hi_reg = D1;
            end
            else
            begin
                if(timer < stop)
                begin
                    timer = timer+1;
                    if(timer==stop)
                    begin
                        timer = 4'b0000;
                        stop = 4'b0000;
                        busy_reg = 1'b0;
                    end
                end
                else
                begin
                    if(start==1'b1)
                    begin
                        if(op[1]==1'b1)
                        begin
                            hi_reg = r;
                            lo_reg = q;
                            timer = 4'b0000;
                            stop = 4'b1010;
                            busy_reg = 1'b1;
                        end
                        else
                        begin
                            hi_reg = mult_result[63:32];
                            lo_reg = mult_result[31:0];
                            timer = 4'b0000;
                            stop = 4'b0101;
                            busy_reg = 1'b1;
                        end
                    end
                end
            end
        end
    end
    initial
    begin
        hi_reg = 32'h00000000;
        lo_reg = 32'h00000000;
        busy_reg = 1'b0;
        timer = 4'b0000;
        stop = 4'b0000;
        
    end
                
    
endmodule

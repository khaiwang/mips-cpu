`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/16 11:10:56
// Design Name: 
// Module Name: dm
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
module trans(input [31:0]addr, input [1:0]lencode, output [3:0]be);
    wire [1:0]b_addr;
    wire [3:0]be_init;
    assign b_addr = addr[1:0];
    assign be_init[0] = (~b_addr[0])&&(~b_addr[1]);
    assign be_init[1] = (b_addr[0])&&(~b_addr[1]);
    assign be_init[2] = (~b_addr[0])&&(b_addr[1]);
    assign be_init[3] = (b_addr[0])&&(b_addr[1]);
    assign be[0] = be_init[0];
    assign be[1] = be_init[1]||(be_init[0]&&(lencode==2'b01))||(lencode==2'b10);
    assign be[2] = be_init[2]||(be_init[1]&&(lencode==2'b01))||(lencode==2'b10);
    assign be[3] = be_init[3]||(be_init[2]&&(lencode==2'b01))||(lencode==2'b10);
endmodule

module dm_8k(addr,be,din,we,clk,dout);    
    input [12:2] addr;    
    input [31:0] din; 
    input [3:0] be;
    input we;     
    input clk; //clock    
    output [31:0] dout;
    reg [31:0] dm [2047:0];
    integer i;
    wire [31:0]mask;
    wire [7:0]mask0;
    wire [7:0]mask1;
    wire [7:0]mask2;
    wire [7:0]mask3;
    assign mask0 = $signed(be[0]);
    assign mask1 = $signed(be[1]);
    assign mask2 = $signed(be[2]);
    assign mask3 = $signed(be[3]);
    assign mask = {mask3, mask2, mask1, mask0};
    assign dout = dm[addr[12:2]]&mask;
    always@(negedge clk)
    begin
        if(we)
        begin
            dm[addr[12:2]][7:0] <= (din[7:0]&mask0)|(dm[addr[12:2]][7:0]&(~mask0));
            dm[addr[12:2]][15:8] <= ((din[7:0]&mask1&(~mask0))|(din[15:8]&mask1&mask0)|(dm[addr[12:2]][15:8]&(~mask1)));
            dm[addr[12:2]][23:16] <= (din[7:0]&mask2&~mask1&~mask0)|(din[15:8]&mask2&mask1&~mask0)|(din[23:16]&mask2&mask1&mask0)|(dm[addr[12:2]][23:16]&(~mask2));
            dm[addr[12:2]][31:24] <= (din[7:0]&mask3&~mask2&~mask1&~mask0)|(din[15:8]&mask3&mask2&~mask1&~mask0)|(din[31:24]&mask3&mask2&mask1&mask0)|(dm[addr[12:2]][31:24]&(~mask3));
        end
    end
    initial
    begin 
        for(i=0; i<2047;i=i+1)
        begin
            dm[i]=32'h00000000;
        end
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2025 14:12:06
// Design Name: 
// Module Name: clock_div_2
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


module clock_div_2(
input clk,rst,
output reg q);


always@(posedge clk or posedge rst)
begin
if(rst)
    q <= 0;
else 
    q <= ~q;
end
endmodule

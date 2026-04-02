`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2025 17:14:32
// Design Name: 
// Module Name: d_flipflop
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


module d_flipflop_ro(
input d,clk,rst,
output reg q);

always@(posedge clk or posedge rst)
begin
if(rst)
    q <= 0;
else 
    q <= d;
end

endmodule

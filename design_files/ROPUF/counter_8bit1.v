`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2025 17:12:53
// Design Name: 
// Module Name: counter_8bit1
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

module counter_8bit1(
input clk,rst,
output reg [7:0]op);

always@(posedge clk or posedge rst)
begin
if(rst)
 op <= 8'b0;
else if (op < 8'b10000000)
 op <= op + 8'b00000001;
else 
 op <= 8'b10000000;
end
endmodule

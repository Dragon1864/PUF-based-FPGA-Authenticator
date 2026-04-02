`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.05.2025 11:01:02
// Design Name: 
// Module Name: mux16_1_1
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


module mux16_1_1_ro(
input [15:0]I,
input [3:0]Sl,
output reg op);

always@(*)
begin
case(Sl)
4'b0000 : op = I[0];
4'b0001 : op = I[1];
4'b0010 : op = I[2];
4'b0011 : op = I[3];
4'b0100 : op = I[4];
4'b0101 : op = I[5];
4'b0110 : op = I[6];
4'b0111 : op = I[7];
4'b1000 : op = I[8];
4'b1001 : op = I[9];
4'b1010 : op = I[10];
4'b1011 : op = I[11];
4'b1100 : op = I[12];
4'b1101 : op = I[13];
4'b1110 : op = I[14];
4'b1111 : op = I[15];
endcase
end
endmodule

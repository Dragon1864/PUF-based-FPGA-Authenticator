`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2025 10:55:16
// Design Name: 
// Module Name: HYBRID_PUF_DRIVER_own
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


module RO_PUF_DRIVER_own(
input clk,reset_n,start,
input [7:0]C,
output [15:0]en_ro0,en_ro1,
output out_trig_ro,rstc,rst_dff);

  reg [9:0] cnt;
  always @(posedge clk) begin
     if (!reset_n)
      cnt  <= 10'd0;
     else if (cnt < 10'd49)
        cnt <= cnt + 10'd1;
     else if(start)
        cnt <= 10'd0;
     else 
        cnt <= cnt;
        
   end
  assign rstc    = (cnt == 10'd0)?1:0;
  assign rst_dff = ~reset_n;

  assign en_ro0       = (16'b1 << C[3:0]);
  assign en_ro1       = (16'b1 << C[7:4]);
  assign out_trig_ro = (cnt == 10'd48)?1:0;

endmodule

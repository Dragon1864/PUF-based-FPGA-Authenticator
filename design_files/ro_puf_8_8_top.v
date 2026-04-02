`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2025 11:14:01
// Design Name: 
// Module Name: hybrid_puf_8_8_top
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


module ro_puf_8_8_top(
input clk,reset_n,
input [7:0]C,
output [7:0]R);

wire [15:0]en_ro0,en_ro1;
wire out_trig_ro, rstc, rst_dff, start;

RO_PUF_8_8 h0 (.en_ro0(en_ro0),.en_ro1(en_ro1),.out_trig_ro(out_trig_ro),.rstc(rstc),.rst_dff(rst_dff),.C(C),.R(R));

RO_PUF_DRIVER_own h1 (.clk(clk),.reset_n(reset_n),.start(start),.C(C),.en_ro0(en_ro0),.en_ro1(en_ro1),.out_trig_ro(out_trig_ro),.rstc(rstc),.rst_dff(rst_dff));

pulse_on_change h2 (.clk(clk),.rst_n(reset_n),.C(C),.start(start));


endmodule

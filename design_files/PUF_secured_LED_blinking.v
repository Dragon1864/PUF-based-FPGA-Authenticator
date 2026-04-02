`timescale 1ns / 1ps


module PUF_secured_LED_blinking(
	input clk, reset_n, en,
	input [7:0]C,
	output [7:0]R,
	output [3:0]LED
);


ro_puf_8_8_top a0 (.clk(clk),.reset_n(reset_n),.C(C),.R(R));


blinking_led a1 (.clk(clk),.rst_n(reset_n),.enable(en),.led(LED));


endmodule
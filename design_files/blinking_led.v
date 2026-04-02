`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2026 09:28:00
// Design Name: 
// Module Name: blinking_led
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


module blinking_led(
    input clk,           // 33.333 MHz clock from Zynq PS
    input rst_n,         // Active-low reset from PS
    input enable,        // Enable signal
    output reg [3:0] led      // 4 LEDs on PYNQ-Z2
);

    // Math for a 1 Hz blink rate (0.5 seconds ON, 0.5 seconds OFF)
    // Clock frequency = 33,333,000 Hz
    // Target toggle delay = 0.5 seconds
    // Max count = 33,333,000 / 2 = 16,666,500 cycles
    parameter MAX_COUNT = 24'd16_666_500;
    
    reg [23:0] counter;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 24'd0;
            led <= 4'b0000;
        end else begin
            if (enable) begin
                if (counter >= MAX_COUNT - 1) begin
                    counter <= 24'd0;
                    led <= ~led;  // Toggle all 4 LEDs simultaneously
                end else begin
                    counter <= counter + 1'b1;
                end
            end else begin
                led <= 4'b0000;   
                counter <= 24'd0;
            end
        end
    end

endmodule

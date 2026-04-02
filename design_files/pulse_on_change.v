`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2025 17:59:06
// Design Name: 
// Module Name: pulse_on_change
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


module pulse_on_change(
    input wire clk,
    input wire rst_n,
    input wire [7:0] C,
    output reg start
);

    reg [7:0] C_prev;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            C_prev <= 8'b0;
            start <= 1'b0;
        end else begin
            if (C != C_prev) begin
                start <= 1'b1;    // generate pulse
            end else begin
                start <= 1'b0;    // otherwise 0
            end
            C_prev <= C;          // store current value for next cycle comparison
        end
    end

endmodule

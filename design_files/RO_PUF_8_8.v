`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2025 10:30:07
// Design Name: 
// Module Name: HYBRID_PUF_4_1
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


module RO_PUF_8_8(
input [15:0]en_ro0,en_ro1,
input out_trig_ro, rstc, rst_dff,
input [7:0]C,
output [7:0]R);


ROPUF_4_1_R0 ro0 (.en0(en_ro0),.en1(en_ro1),.out_trig(out_trig_ro),.rstc(rstc),.rstd(rst_dff),.C(C[7:0]),.R(R[0]));


ROPUF_4_1_R1 ro1 (.en0(en_ro0),.en1(en_ro1),.out_trig(out_trig_ro),.rstc(rstc),.rstd(rst_dff),.C(C[7:0]),.R(R[1]));


ROPUF_4_1_R2 ro2 (.en0(en_ro0),.en1(en_ro1),.out_trig(out_trig_ro),.rstc(rstc),.rstd(rst_dff),.C(C[7:0]),.R(R[2]));


ROPUF_4_1_R3 ro3 (.en0(en_ro0),.en1(en_ro1),.out_trig(out_trig_ro),.rstc(rstc),.rstd(rst_dff),.C(C[7:0]),.R(R[3]));


ROPUF_4_1_R4 ro4 (.en0(en_ro0),.en1(en_ro1),.out_trig(out_trig_ro),.rstc(rstc),.rstd(rst_dff),.C(C[7:0]),.R(R[4]));


ROPUF_4_1_R5 ro5 (.en0(en_ro0),.en1(en_ro1),.out_trig(out_trig_ro),.rstc(rstc),.rstd(rst_dff),.C(C[7:0]),.R(R[5]));


ROPUF_4_1_R6 ro6 (.en0(en_ro0),.en1(en_ro1),.out_trig(out_trig_ro),.rstc(rstc),.rstd(rst_dff),.C(C[7:0]),.R(R[6]));


ROPUF_4_1_R7 ro7 (.en0(en_ro0),.en1(en_ro1),.out_trig(out_trig_ro),.rstc(rstc),.rstd(rst_dff),.C(C[7:0]),.R(R[7]));



endmodule

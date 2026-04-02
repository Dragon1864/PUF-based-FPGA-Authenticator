`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2025 17:13:34
// Design Name: 
// Module Name: ROPUF_4_1
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


module ROPUF_4_1_R7(
input [15:0]en0,en1,
input out_trig,rstc,rstd,
input [7:0]C,
output R);

wire [31:0]m;
wire [1:0]cnt;
wire [15:0]d;
wire wr;

ring_osc0_7 r0_7 (en0[0],rstd,m[0]);
ring_osc1_7 r1_7 (en0[1],rstd,m[1]);
ring_osc2_7 r2_7 (en0[2],rstd,m[2]);
ring_osc3_7 r3_7 (en0[3],rstd,m[3]);
ring_osc4_7 r4_7 (en0[4],rstd,m[4]);
ring_osc5_7 r5_7 (en0[5],rstd,m[5]);
ring_osc6_7 r6_7 (en0[6],rstd,m[6]);
ring_osc7_7 r7_7 (en0[7],rstd,m[7]);
ring_osc8_7 r8_7 (en0[8],rstd,m[8]);
ring_osc9_7 r9_7 (en0[9],rstd,m[9]);
ring_osc10_7 r10_7 (en0[10],rstd,m[10]);
ring_osc11_7 r11_7 (en0[11],rstd,m[11]);
ring_osc12_7 r12_7 (en0[12],rstd,m[12]);
ring_osc13_7 r13_7 (en0[13],rstd,m[13]);
ring_osc14_7 r14_7 (en0[14],rstd,m[14]);
ring_osc15_7 r15_7 (en0[15],rstd,m[15]);

mux16_1_0_ro mr0_7 (m[15:0],C[3:0],cnt[0]);

counter_8bit0 c0_7 (cnt[0],rstc,d[7:0]);

ring_osc16_7 r16_7 (en1[0],rstd,m[16]);
ring_osc17_7 r17_7 (en1[1],rstd,m[17]);
ring_osc18_7 r18_7 (en1[2],rstd,m[18]);
ring_osc19_7 r19_7 (en1[3],rstd,m[19]);
ring_osc20_7 r20_7 (en1[4],rstd,m[20]);
ring_osc21_7 r21_7 (en1[5],rstd,m[21]);
ring_osc22_7 r22_7 (en1[6],rstd,m[22]);
ring_osc23_7 r23_7 (en1[7],rstd,m[23]);
ring_osc24_7 r24_7 (en1[8],rstd,m[24]);
ring_osc25_7 r25_7 (en1[9],rstd,m[25]);
ring_osc26_7 r26_7 (en1[10],rstd,m[26]);
ring_osc27_7 r27_7 (en1[11],rstd,m[27]);
ring_osc28_7 r28_7 (en1[12],rstd,m[28]);
ring_osc29_7 r29_7 (en1[13],rstd,m[29]);
ring_osc30_7 r30_7 (en1[14],rstd,m[30]);
ring_osc31_7 r31_7 (en1[15],rstd,m[31]);

mux16_1_1_ro mr1_7 (m[31:16],C[7:4],cnt[1]);

counter_8bit1 c1_7 (cnt[1],rstc,d[15:8]);

d_flipflop_ro dr0_7 (d[7],d[15],rstd,wr);

d_flipflop_ro dr1_7 (wr,out_trig,rstd,R);

endmodule

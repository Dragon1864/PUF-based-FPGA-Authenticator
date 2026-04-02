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


module ROPUF_4_1_R6(
input [15:0]en0,en1,
input out_trig,rstc,rstd,
input [7:0]C,
output R);

wire [31:0]m;
wire [1:0]cnt;
wire [15:0]d;
wire wr;

ring_osc0_6 r0_6 (en0[0],rstd,m[0]);
ring_osc1_6 r1_6 (en0[1],rstd,m[1]);
ring_osc2_6 r2_6 (en0[2],rstd,m[2]);
ring_osc3_6 r3_6 (en0[3],rstd,m[3]);
ring_osc4_6 r4_6 (en0[4],rstd,m[4]);
ring_osc5_6 r5_6 (en0[5],rstd,m[5]);
ring_osc6_6 r6_6 (en0[6],rstd,m[6]);
ring_osc7_6 r7_6 (en0[7],rstd,m[7]);
ring_osc8_6 r8_6 (en0[8],rstd,m[8]);
ring_osc9_6 r9_6 (en0[9],rstd,m[9]);
ring_osc10_6 r10_6 (en0[10],rstd,m[10]);
ring_osc11_6 r11_6 (en0[11],rstd,m[11]);
ring_osc12_6 r12_6 (en0[12],rstd,m[12]);
ring_osc13_6 r13_6 (en0[13],rstd,m[13]);
ring_osc14_6 r14_6 (en0[14],rstd,m[14]);
ring_osc15_6 r15_6 (en0[15],rstd,m[15]);

mux16_1_0_ro mr0_6 (m[15:0],C[3:0],cnt[0]);

counter_8bit0 c0_6 (cnt[0],rstc,d[7:0]);

ring_osc16_6 r16_6 (en1[0],rstd,m[16]);
ring_osc17_6 r17_6 (en1[1],rstd,m[17]);
ring_osc18_6 r18_6 (en1[2],rstd,m[18]);
ring_osc19_6 r19_6 (en1[3],rstd,m[19]);
ring_osc20_6 r20_6 (en1[4],rstd,m[20]);
ring_osc21_6 r21_6 (en1[5],rstd,m[21]);
ring_osc22_6 r22_6 (en1[6],rstd,m[22]);
ring_osc23_6 r23_6 (en1[7],rstd,m[23]);
ring_osc24_6 r24_6 (en1[8],rstd,m[24]);
ring_osc25_6 r25_6 (en1[9],rstd,m[25]);
ring_osc26_6 r26_6 (en1[10],rstd,m[26]);
ring_osc27_6 r27_6 (en1[11],rstd,m[27]);
ring_osc28_6 r28_6 (en1[12],rstd,m[28]);
ring_osc29_6 r29_6 (en1[13],rstd,m[29]);
ring_osc30_6 r30_6 (en1[14],rstd,m[30]);
ring_osc31_6 r31_6 (en1[15],rstd,m[31]);

mux16_1_1_ro mr1_6 (m[31:16],C[7:4],cnt[1]);

counter_8bit1 c1_6 (cnt[1],rstc,d[15:8]);

d_flipflop_ro dr0_6 (d[7],d[15],rstd,wr);

d_flipflop_ro dr1_6 (wr,out_trig,rstd,R);
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2024 09:34:26 AM
// Design Name: 
// Module Name: array_mult
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


module array_mult_structural(
    input [3:0]m,
    input [3:0]q,
    output [7:0]p
    );
    
    wire [12:0]temp_carry;
    wire [12:0]temp_adds;
    
    assign p[0] = m[0] & q[0];
    full_adder f1((m[1] & q[0]), (m[0] & q[1]), 0, p[1], temp_carry[0]);
    full_adder f2((m[2] & q[0]), (m[1] & q[1]), temp_carry[0], temp_adds[0], temp_carry[1]);
    full_adder f3((m[3] & q[0]), (m[2] & q[1]), temp_carry[1], temp_adds[1], temp_carry[2]);
    full_adder f4(0, (m[3] & q[1]), temp_carry[2], temp_adds[2], temp_carry[3]);
    
    
    full_adder f5(temp_adds[0], (m[0] & q[2]), 0, p[2], temp_carry[4]);
    full_adder f6(temp_adds[1], (m[1] & q[2]), temp_carry[4], temp_adds[3], temp_carry[5]);
    full_adder f7(temp_adds[2], (m[2] & q[2]), temp_carry[5], temp_adds[4], temp_carry[6]);
    full_adder f8(temp_carry[3], (m[3] & q[2]), temp_carry[6], temp_adds[5], temp_carry[7]);
    
    full_adder f9(temp_adds[3], (m[0] & q[3]), 0, p[3], temp_carry[8]);
    full_adder f10(temp_adds[4], (m[1] & q[3]), temp_carry[8], p[4], temp_carry[9]);
    full_adder f11(temp_adds[5], (m[2] & q[3]), temp_carry[9], p[5], temp_carry[10]);
    full_adder f12(temp_carry[7], (m[3] & q[3]), temp_carry[10], p[6], p[7]);
    
endmodule



module full_adder (a, b, c, dout, carry);
    input a;
    input b;
    input c;
    output dout;
    output carry;

    assign dout = a ^ b ^ c;   
    assign carry = (a &b ) | (c & (a^b));
endmodule


/*
 * File: project.v
 * Description: 4x4 Array Multiplier with top module tt_um_SarpHS_array_mult
 */

`timescale 1ns / 1ps
`default_nettype none

// Top-Level Module with flattened design
module tt_um_SarpHS_array_mult (
    input  wire [7:0] ui_in,    // 8 input pins from Tiny Tapeout
    output wire [7:0] uo_out,   // 8 output pins to Tiny Tapeout
    input  wire [7:0] uio_in,   // Unused
    output wire [7:0] uio_out,  // Unused
    output wire [7:0] uio_oe,   // Unused
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // Internal signals
    wire [3:0] m = ui_in[3:0];   // First operand
    wire [3:0] q = ui_in[7:4];   // Second operand
    wire [7:0] p;                // Product
    wire [12:0] temp_carry;
    wire [12:0] temp_adds;

    // Partial products and addition chain
    assign p[0] = m[0] & q[0];

    full_adder f1((m[1] & q[0]), (m[0] & q[1]), 1'b0, p[1], temp_carry[0]);
    full_adder f2((m[2] & q[0]), (m[1] & q[1]), temp_carry[0], temp_adds[0], temp_carry[1]);
    full_adder f3((m[3] & q[0]), (m[2] & q[1]), temp_carry[1], temp_adds[1], temp_carry[2]);
    full_adder f4(1'b0, (m[3] & q[1]), temp_carry[2], temp_adds[2], temp_carry[3]);

    full_adder f5(temp_adds[0], (m[0] & q[2]), 1'b0, p[2], temp_carry[4]);
    full_adder f6(temp_adds[1], (m[1] & q[2]), temp_carry[4], temp_adds[3], temp_carry[5]);
    full_adder f7(temp_adds[2], (m[2] & q[2]), temp_carry[5], temp_adds[4], temp_carry[6]);
    full_adder f8(temp_carry[3], (m[3] & q[2]), temp_carry[6], temp_adds[5], temp_carry[7]);

    full_adder f9(temp_adds[3], (m[0] & q[3]), 1'b0, p[3], temp_carry[8]);
    full_adder f10(temp_adds[4], (m[1] & q[3]), temp_carry[8], p[4], temp_carry[9]);
    full_adder f11(temp_adds[5], (m[2] & q[3]), temp_carry[9], p[5], temp_carry[10]);
    full_adder f12(temp_carry[7], (m[3] & q[3]), temp_carry[10], p[6], p[7]);

    // Assign product to outputs
    assign uo_out = p;

    // Unused outputs
    assign uio_out = 8'b0;
    assign uio_oe = 8'b0;

    // List all unused inputs to prevent warnings
    wire _unused = &{ena, clk, rst_n, uio_in};

endmodule

// Full Adder Module
module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule

`default_nettype wire

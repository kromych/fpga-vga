`default_nettype none

// Timescale/precision

`timescale 100 ps / 10 ps

`define TESTING

`include "vga_top.v"

module tb();

    reg clk;

    wire[1:0] red;
    wire[1:0] green;
    wire[1:0] blue;

    wire vsync;
    wire hsync;

    vga_top_800x600x60_down_4x4 _dut(
        .i_clk(clk),
        .o_red(red),
        .o_green(green),
        .o_blue(blue),
        .o_vsync(vsync),
        .o_hsync(hsync));

    // Initialization tasks

    initial
    begin
        clk = 1'b0;
    end

    initial
    begin
        $dumpfile ("./out/vga.vcd");
        $dumpvars;
    end

    initial
    begin
//        $display("\t\ttime,\trealtime,\tclk,\tbusy,\ttx");
//        $monitor("%d,\t%d,\t\t%b,\t%b,\t%b,",$time, $realtime, clk, hsync, vsync);
    end

    initial
    begin
        #300000000 $finish;
    end

    // Tasks to always run

    always
    begin
        #125 clk <= ~clk;
    end

endmodule

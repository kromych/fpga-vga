`default_nettype none

// To fit into 128kbit
//      1) resolution 800x600,
//      2) outputtting 4x4 pixels as a whole
//      3) 4 bit for color: 1 bit for each R/G/B signals, and 1 bit
//         to increase brightness of the color.

module vga_top_800x600x60_down_4x4(i_clk, o_red, o_green, o_blue, o_vsync, o_hsync);

    input wire i_clk;

    output reg[1:0] o_red;
    output reg[1:0] o_green;
    output reg[1:0] o_blue;

    output reg o_hsync;
    output reg o_vsync;

    wire clk40;
    wire clk40_locked;

`ifdef TESTING

    assign clk40 = i_clk;
    assign clk40_locked = 0;

`else

    pll pll40(
        .clock_in(i_clk),
        .clock_out(clk40),
        .locked(clk40_locked));

`endif

    reg [10:0] horz_pos = 0;
    reg [9:0] vert_pos = 0;

    localparam horz_sync_pulse = 128;
    localparam horz_front_porch = 40;
    localparam horz_visible_area = 800;
    localparam horz_back_porch = 88;
    localparam horz_max = horz_sync_pulse + horz_front_porch + horz_visible_area + horz_back_porch;

    localparam vert_sync_pulse = 4;
    localparam vert_front_porch = 1;
    localparam vert_visible_area = 600;
    localparam vert_back_porch = 23;
    localparam vert_max = vert_sync_pulse + vert_front_porch + vert_visible_area + vert_back_porch;

    // sync, back porch, display, front porch ??
    // front porch, display, back porch, sync ??

    always @(posedge clk40)
    begin
        o_hsync <= horz_pos < horz_sync_pulse;
        o_vsync <= vert_pos < vert_sync_pulse;

        if (horz_pos == horz_max - 1)
        begin
            horz_pos <= 0;

            if (vert_pos == vert_max - 1)
            begin
                vert_pos <= 0;
            end
            else
            begin
                vert_pos <= vert_pos + 1;
            end
        end
        else
        begin
            horz_pos <= horz_pos + 1;
        end
    end

    always @(posedge clk40)
    begin
        o_red <= 2'b00;
        o_green <= 2'b00;
        o_blue <= 2'b00;
    end

endmodule

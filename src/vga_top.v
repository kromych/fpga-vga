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

    // Returns (x <= 5)
    function /*automatic*/ leq_5;
        input [2:0] i_num;
        begin
            leq_5 = ~i_num[2]|(~i_num[1]&~i_num[0]);
        end
    endfunction

    // Returns (x <= 4 ? 4 - x : 0)
    function /*automatic*/ [2:0] non_neg_4_minus;
        input [2:0] i_num;
        begin
            non_neg_4_minus = {~i_num[2]&~i_num[1]&~i_num[0], ~i_num[2]&(i_num[1]^i_num[0]), ~i_num[2]&i_num[0]};
        end
    endfunction

`ifdef TESTING

    assign clk40 = i_clk;
    assign clk40_locked = 0;

`else

    pll pll40(
        .clock_in(i_clk),
        .clock_out(clk40),
        .locked(clk40_locked));

`endif

    //
    // Image output
    //

    reg [10:0] horz_pos = 0;
    reg [9:0] vert_pos = 0;
    reg inside_visible_area = 0;

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

        inside_visible_area <= (horz_pos >= horz_sync_pulse + horz_front_porch + horz_back_porch - 1) &&
                               (horz_pos <  horz_max - 1) &&
                               (vert_pos >= vert_sync_pulse + vert_front_porch + vert_back_porch) &&
                               (vert_pos < vert_max);
    end
/*
    //
    // Pattern
    //

    always @(posedge clk40)
    begin
        if (inside_visible_area)
        begin
            o_red <= horz_pos[3:2] & vert_pos[3:2];
            o_green <= horz_pos[6:5];
            o_blue <= vert_pos[6:5];
        end
        else
        begin
            o_red <= 2'b00;
            o_green <= 2'b00;
            o_blue <= 2'b00;
        end
    end
*/
    //
    // Digits
    //

    wire [3:0] digit = horz_pos[8:5];
    wire [2:0] scanline_num = vert_pos[4:2];
    wire [2:0] scanline_pos = non_neg_4_minus(horz_pos[4:2]); // Need to count pixels from the end
    wire [4:0] scanline_pixels;

    digits10_initial digits10(
        .i_digit(digit),
        .i_scanline_num(scanline_num),
        .o_scanline_pixels(scanline_pixels));

    always @(posedge clk40)
    begin
        o_red <= 2'b00;
        o_blue <= 2'b00;

        if (inside_visible_area)
        begin
            o_green <= {leq_5(horz_pos[4:2]) & scanline_pixels[scanline_pos], 1'b1};
        end
        else
        begin
            o_green <= 2'b00;
        end
    end

endmodule

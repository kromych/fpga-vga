`default_nettype none

module vga(
    input  wire logic i_clk,
    input  wire logic i_rst,
    output      logic o_hsync,
    output      logic o_vsync,
    output      logic [10:0] o_hpos,
    output      logic [9:0] o_vpos,
    output      logic o_we,
    );

    localparam HORZ_SYNC_PULSE = 96;
    localparam HORZ_FRONT_PORCH = 16;
    localparam HORZ_VISIBLE_AREA = 640;
    localparam HORZ_BACK_PORCH = 48;

    localparam HORZ_SYNC_PULSE_START = 0;
    localparam HORZ_SYNC_PULSE_END = HORZ_SYNC_PULSE;
    localparam HORZ_VISIBLE_START = HORZ_SYNC_PULSE + HORZ_FRONT_PORCH + HORZ_BACK_PORCH;
    localparam HORZ_VISIBLE_END = HORZ_SYNC_PULSE + HORZ_FRONT_PORCH + HORZ_BACK_PORCH + HORZ_VISIBLE_AREA;
    localparam HORZ_MAX = HORZ_SYNC_PULSE + HORZ_FRONT_PORCH + HORZ_BACK_PORCH + HORZ_VISIBLE_AREA;

    localparam VERT_SYNC_PULSE = 2;
    localparam VERT_FRONT_PORCH = 10;
    localparam VERT_VISIBLE_AREA = 480;
    localparam VERT_BACK_PORCH = 33;

    localparam VERT_SYNC_PULSE_START = 0;
    localparam VERT_SYNC_PULSE_END = VERT_SYNC_PULSE;
    localparam VERT_VISIBLE_START = VERT_SYNC_PULSE + VERT_FRONT_PORCH + VERT_BACK_PORCH;
    localparam VERT_VISIBLE_END = VERT_SYNC_PULSE + VERT_FRONT_PORCH + VERT_BACK_PORCH + VERT_VISIBLE_AREA;
    localparam VERT_MAX = VERT_SYNC_PULSE + VERT_FRONT_PORCH + VERT_BACK_PORCH + VERT_VISIBLE_AREA;

    always_comb begin
        o_hsync = ~(o_hpos >= HORZ_SYNC_PULSE_START && o_hpos < HORZ_SYNC_PULSE_END);
        o_vsync = ~(o_vpos >= VERT_SYNC_PULSE_START && o_vpos < VERT_SYNC_PULSE_END);
        o_we = (o_hpos >= HORZ_VISIBLE_START && o_hpos < HORZ_VISIBLE_END) &&
               (o_vpos >= VERT_VISIBLE_START && o_vpos < VERT_VISIBLE_END);
    end

    always_ff @(posedge i_clk) begin
        if (o_hpos == HORZ_MAX - 1) begin
            o_hpos <= 0;
            o_vpos <= (o_vpos == VERT_MAX - 1) ? 0 : o_vpos + 1;
        end else begin
            o_hpos <= o_hpos + 1;
        end
        if (i_rst) begin
            o_hpos <= 0;
            o_vpos <= 0;
        end
    end

endmodule

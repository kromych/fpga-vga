`default_nettype none

module top(
    input wire  logic i_clk,
    input wire  logic i_btn,
    output      logic o_hsync,
    output      logic o_vsync,
    output      logic[1:0] o_red,    
    output      logic[1:0] o_green,    
    output      logic[1:0] o_blue,    
    output      logic[2:0] o_led,
    );

    logic pixel_clock;
    logic pixel_clock_locked;

    pll pll(
        .clock_in(i_clk),
        .clock_out(pixel_clock),
        .locked(pixel_clock_locked),
    );

    logic[10:0] hpos;
    logic[9:0] vpos;
    logic we;
    logic rst;

    always_ff @(posedge i_clk) begin
        rst <= ~i_btn;
    end

    vga vga(
        .i_clk(pixel_clock),
        .i_rst(rst),
        .o_hsync(o_hsync),
        .o_vsync(o_vsync),
        .o_hpos(hpos),
        .o_vpos(vpos),
        .o_we(we),
    );

    always_ff @(posedge pixel_clock) begin
        if (we) begin
            o_red <= 2'b11;
            o_green <= 2'b11;
            o_blue <= 2'b11;
        end else begin
            o_red <= 2'b00;
            o_green <= 2'b00;
            o_blue <= 2'b00;
        end
    end

    always_ff @(posedge i_clk) begin
        if (rst) begin
            o_led <= 3'b110;
        end else begin
            o_led <= 3'b111;
        end
    end

endmodule

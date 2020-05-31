`default_nettype none

module digits10_case(i_digit, i_line_num, o_line_pixels);

    input wire [3:0] i_digit;
    input wire [2:0] i_line_num;

    output reg [4:0] o_line_pixels;

    wire [6:0] addr = {i_digit, i_line_num};

    always @(*)
    begin
        case (addr)
            // '0'
            7'o00: o_line_pixels = 5'b01110;
            7'o01: o_line_pixels = 5'b10001;
            7'o02: o_line_pixels = 5'b10001;
            7'o03: o_line_pixels = 5'b10001;
            7'o04: o_line_pixels = 5'b01110;
            // '1'
            7'o10: o_line_pixels = 5'b00100;
            7'o11: o_line_pixels = 5'b01100;
            7'o12: o_line_pixels = 5'b11100;
            7'o13: o_line_pixels = 5'b01100;
            7'o14: o_line_pixels = 5'b11111;
            // '2'
            7'o20: o_line_pixels = 5'b01100;
            7'o21: o_line_pixels = 5'b10010;
            7'o22: o_line_pixels = 5'b00010;
            7'o23: o_line_pixels = 5'b00100;
            7'o24: o_line_pixels = 5'b11111;
            // '3'
            7'o30: o_line_pixels = 5'b01110;
            7'o31: o_line_pixels = 5'b10010;
            7'o32: o_line_pixels = 5'b00110;
            7'o33: o_line_pixels = 5'b10001;
            7'o34: o_line_pixels = 5'b01110;
            // '4'
            7'o40: o_line_pixels = 5'b00011;
            7'o41: o_line_pixels = 5'b00101;
            7'o42: o_line_pixels = 5'b01001;
            7'o43: o_line_pixels = 5'b11111;
            7'o44: o_line_pixels = 5'b00001;
            // '5'
            7'o50: o_line_pixels = 5'b11111;
            7'o51: o_line_pixels = 5'b10000;
            7'o52: o_line_pixels = 5'b11111;
            7'o53: o_line_pixels = 5'b00001;
            7'o54: o_line_pixels = 5'b11111;
            // '6'
            7'o60: o_line_pixels = 5'b01111;
            7'o61: o_line_pixels = 5'b10000;
            7'o62: o_line_pixels = 5'b11110;
            7'o63: o_line_pixels = 5'b10001;
            7'o64: o_line_pixels = 5'b01110;
            // '7'
            7'o70: o_line_pixels = 5'b11111;
            7'o71: o_line_pixels = 5'b00001;
            7'o72: o_line_pixels = 5'b00001;
            7'o73: o_line_pixels = 5'b00001;
            7'o74: o_line_pixels = 5'b00001;
            // '8'
            7'o100: o_line_pixels = 5'b11111;
            7'o101: o_line_pixels = 5'b10001;
            7'o102: o_line_pixels = 5'b11111;
            7'o103: o_line_pixels = 5'b10001;
            7'o104: o_line_pixels = 5'b11111;
            // '9'
            7'o110: o_line_pixels = 5'b01110;
            7'o111: o_line_pixels = 5'b10001;
            7'o112: o_line_pixels = 5'b01111;
            7'o113: o_line_pixels = 5'b00010;
            7'o114: o_line_pixels = 5'b11110;

            default: o_line_pixels = 5'b00000;
        endcase
    end

endmodule

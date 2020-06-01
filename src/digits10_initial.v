`default_nettype none

module digits10_initial(i_digit, i_scanline_num, o_scanline_pixels);

    input wire [3:0] i_digit;
    input wire [2:0] i_scanline_num;

    output wire [4:0] o_scanline_pixels;

    reg [4:0] line_pixels [0:15][0:7];
    reg [4:0] tmp;

    assign o_scanline_pixels = line_pixels[i_digit][i_scanline_num];

    integer i, j, k;

    initial
    begin

        // Instead, could use $readmemh("line_pixels.txt", line_pixels) or $readmemh("hex.txt", line_pixels),
        // one value per line

        // '0'
        line_pixels[0][0] = 5'b11111;
        line_pixels[0][1] = 5'b10001;
        line_pixels[0][2] = 5'b10001;
        line_pixels[0][3] = 5'b10001;
        line_pixels[0][4] = 5'b11111;
        // '1'
        line_pixels[1][0] = 5'b11100;
        line_pixels[1][1] = 5'b00100;
        line_pixels[1][2] = 5'b00100;
        line_pixels[1][3] = 5'b00100;
        line_pixels[1][4] = 5'b11111;
        // '2'
        line_pixels[2][0] = 5'b11111;
        line_pixels[2][1] = 5'b00001;
        line_pixels[2][2] = 5'b11111;
        line_pixels[2][3] = 5'b10000;
        line_pixels[2][4] = 5'b11111;
        // '3'
        line_pixels[3][0] = 5'b11111;
        line_pixels[3][1] = 5'b00001;
        line_pixels[3][2] = 5'b11111;
        line_pixels[3][3] = 5'b00001;
        line_pixels[3][4] = 5'b11111;
        // '4'
        line_pixels[4][0] = 5'b10001;
        line_pixels[4][1] = 5'b10001;
        line_pixels[4][2] = 5'b10001;
        line_pixels[4][3] = 5'b11111;
        line_pixels[4][4] = 5'b00001;
        // '5'
        line_pixels[5][0] = 5'b11111;
        line_pixels[5][1] = 5'b10000;
        line_pixels[5][2] = 5'b11111;
        line_pixels[5][3] = 5'b00001;
        line_pixels[5][4] = 5'b11111;
        // '6'
        line_pixels[6][0] = 5'b11111;
        line_pixels[6][1] = 5'b10000;
        line_pixels[6][2] = 5'b11111;
        line_pixels[6][3] = 5'b10001;
        line_pixels[6][4] = 5'b11111;
        // '7'
        line_pixels[7][0] = 5'b11111;
        line_pixels[7][1] = 5'b10001;
        line_pixels[7][2] = 5'b00001;
        line_pixels[7][3] = 5'b00001;
        line_pixels[7][4] = 5'b00001;
        // '8'
        line_pixels[8][0] = 5'b11111;
        line_pixels[8][1] = 5'b10001;
        line_pixels[8][2] = 5'b11111;
        line_pixels[8][3] = 5'b10001;
        line_pixels[8][4] = 5'b11111;
        // '9'
        line_pixels[9][0] = 5'b11111;
        line_pixels[9][1] = 5'b10001;
        line_pixels[9][2] = 5'b11111;
        line_pixels[9][3] = 5'b00001;
        line_pixels[9][4] = 5'b11111;

        for (i = 10; i < 16; i++)
        begin
            for (j = 0; j < 5; j++)
            begin
                line_pixels[i][j] = 5'b00000;
            end
        end

        for (i = 0; i < 16; i++)
        begin
            for (j = 5; j < 8; j++)
            begin
                line_pixels[i][j] = 5'b00000;
            end
        end
    end

endmodule

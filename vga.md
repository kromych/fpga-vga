## [DE-15 socket (graphic adapter output)](https://en.wikipedia.org/wiki/VGA_connector)

    VGA

        5(GND)    4        3(B)         2(G)         1(R)
           10(GND)      9        8(BGND)      7(GGND)    6(RGND)
        15        14(V)   13(H)         12           11

    Pin 1	RED	        Red video
    Pin 2	GREEN	    Green video
    Pin 3	BLUE	    Blue video
    Pin 4	ID2/RES	    Reserved since E-DDC, formerly monitor id. bit 2
    Pin 5	GND	Ground  (HSync)

    Pin 6	RGND	    Red ground
    Pin 7	GGND    	Green ground
    Pin 8	BGND    	Blue ground
    Pin 9	KEY/PWR	    +5 V DC (powers EDID EEPROM chip on some monitors), formerly key
    Pin 10	GND	        Ground (VSync, DDC)

    Pin 11	ID0/RES	    Reserved since E-DDC, formerly monitor id. bit 0
    Pin 12	ID1/SDA	    I2C data since DDC2, formerly monitor id. bit 1
    Pin 13	HSync	    Horizontal sync
    Pin 14	VSync	    Vertical sync
    Pin 15	ID3/SCL	    I2C clock since DDC2, formerly monitor id. bit 3


## [SVGA Signal 800 x 600 @ 60 Hz timing](http://www.tinyvga.com/vga-timing/800x600@60Hz)

### General timing

Signal              | Frequency
--------------------|---------------------
Screen refresh rate	| 60 Hz
Vertical refresh	| 37.878787878788 kHz
Pixel freq.	        | 40.0 MHz

### Horizontal timing (line)

_Polarity of horizontal sync pulse is positive_

Scanline part |	Pixels	| Time (µs)
--------------|---------|----------
Visible area  |	800	    | 20
Front porch	  | 40	    | 1
Sync pulse	  | 128	    | 3.2
Back porch	  | 88	    | 2.2
Whole line	  | 1056	| 26.4

### Vertical timing (frame)

_Polarity of vertical sync pulse is positive_

Frame part	  | Lines  | Time (ms)
--------------|--------|-----------
Visible area  | 600	   | 15.84
Front porch	  | 1	   | 0.0264
Sync pulse	  | 4	   | 0.1056
Back porch	  | 23	   | 0.6072
Whole frame	  | 628	   | 16.5792

## [VGA Signal 640 x 480 @ 73 Hz timing](http://www.tinyvga.com/vga-timing/640x480@73Hz)

Signal              | Frequency
--------------------|---------------------
Screen refresh rate	| 73 Hz
Vertical refresh	| 37.860576923077 kHz
Pixel freq.	        | 31.5 MHz

### Horizontal timing (line)

_Polarity of horizontal sync pulse is negative_

Scanline part |	Pixels	| Time (µs)
--------------|---------|----------
Visible area  | 640     | 20.31746031746
Front porch   |	24	    | 0.76190476190476
Sync pulse    |	40	    | 1.2698412698413
Back porch    | 128	    | 4.0634920634921
Whole line    | 832	    | 26.412698412698

### Vertical timing (frame)

_Polarity of vertical sync pulse is negative_

Frame part	  | Lines  | Time (ms)
--------------|--------|-----------
Visible area  | 480    | 12.678095238095
Front porch   | 9      | 0.23771428571429
Sync pulse    | 2      | 0.052825396825397
Back porch    | 29     | 0.76596825396825
Whole frame   | 520    | 13.734603174603

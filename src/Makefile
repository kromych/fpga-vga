# TinyFPGA BX

CHIP=--lp8k
CHIP_PACKAGE=--package cm81

YOSYS=yosys
SYNTH=synth_ice40
PNR=nextpnr-ice40
PACK=icepack

PCF=vga_tinybx.pcf
MODULES=vga_top.v pll40.v
PROJECT=vga

${PROJECT}.bin: ${PROJECT}.asc
	${PACK} -vvv ${PROJECT}.asc ${PROJECT}.bin 2> pack.log

${PROJECT}.asc: ${PROJECT}.json
	${PNR} ${CHIP} ${CHIP_PACKAGE} --pcf ${PCF} --json ${PROJECT}.json --asc ${PROJECT}.asc -q -l pnr.log

${PROJECT}.json: ${MODULES}
	${YOSYS} -g -p "${SYNTH} -json ${PROJECT}.json" ${MODULES} -q -l synth.log

.PHONY: clean

clean:
	rm -f *.log
	rm -f *.asc
	rm -f *.json
	rm -f *.bin
	rm -f *.vcd
	rm -f *.vvp

.PHONY: all

all: ${PROJECT}.bin

.PHONY: wave

wave: ${PROJECT}.vcd
	gtkwave ${PROJECT}.vcd

${PROJECT}.vcd: ${MODULES} vga_tb.v
	iverilog vga_tb.v -o ${PROJECT}.vvp
	vvp -v ${PROJECT}.vvp -fst-space-speed

.PHONY: upload

upload: ${PROJECT}.bin
	tinyprog -p ${PROJECT}.bin

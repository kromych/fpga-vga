# Project files

MKDIR_P=mkdir -p
OUT_DIR=./out
MODULES=pll40.v digits10_initial.v vga_top.v
PROJECT=fpga-vga

# Yosys

YOSYS=yosys
SYNTH=synth_ice40
PNR=nextpnr-ice40
PACK=icepack

# TinyFPGA BX

CHIP=--lp8k
CHIP_PACKAGE=--package cm81
PCF=./vga_tinybx.pcf

.PHONY: all

all: dirs ${OUT_DIR}/${PROJECT}.bin

.PHONY: dirs

dirs: ${OUT_DIR}

.PHONY: clean

clean:
	rm -rf ${OUT_DIR}

.PHONY: wave

wave: dirs ${OUT_DIR}/${PROJECT}.vcd
	gtkwave ${OUT_DIR}/${PROJECT}.vcd

.PHONY: upload

upload: ${OUT_DIR}/${PROJECT}.bin
	tinyprog -p ${OUT_DIR}/${PROJECT}.bin

${OUT_DIR}/${PROJECT}.bin: dirs ${OUT_DIR}/${PROJECT}.asc
	${PACK} -vvv ${OUT_DIR}/${PROJECT}.asc ${OUT_DIR}/${PROJECT}.bin 2> ${OUT_DIR}/pack.log

${OUT_DIR}/${PROJECT}.asc: dirs ${OUT_DIR}/${PROJECT}.json
	${PNR} ${CHIP} ${CHIP_PACKAGE} --pcf ${PCF} --json ${OUT_DIR}/${PROJECT}.json --asc ${OUT_DIR}/${PROJECT}.asc -q -l ${OUT_DIR}/pnr.log

${OUT_DIR}/${PROJECT}.json: dirs ${MODULES}
	${YOSYS} -q -l ${OUT_DIR}/synth.log -g -p "${SYNTH} -json ${OUT_DIR}/${PROJECT}.json" ${MODULES}

${OUT_DIR}/${PROJECT}.vcd: dirs ${MODULES} vga_tb.v
	iverilog vga_tb.v -o ${OUT_DIR}/${PROJECT}.vvp
	vvp -v ${OUT_DIR}/${PROJECT}.vvp -fst-space-speed

${OUT_DIR}:
	${MKDIR_P} ${OUT_DIR}

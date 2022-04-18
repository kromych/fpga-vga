# Project files

MKDIR_P=mkdir -p
OUT_DIR=${PWD}/out
# PLL=ice-pll40.v
PLL=ecp5-pll40.v
MODULES=${PLL} digits10_initial.v vga_top.v
PROJECT=fpga-vga

# Yosys

YOSYS=yosys
# SYNTH=synth_ice40
# PNR=nextpnr-ice40
# PACK=icepack
SYNTH=synth_ecp5
PNR=nextpnr-ecp5
PACK=ecppack

# Board (TinyFPGA BX, Orange Crab)

# CHIP=--lp8k
# CHIP_PACKAGE=--package cm81
# CONSTRAINTS=--pcf ./pcf/tinybx.pcf
CHIP=--25k
CHIP_PACKAGE=--package CSFBGA285
CONSTRAINTS=--lpf ./pcf/orangecrab.pcf

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
#	tinyprog -p ${OUT_DIR}/${PROJECT}.bin
	openFPGALoader -b orangeCrab ${OUT_DIR}/${PROJECT}.bin

${OUT_DIR}/${PROJECT}.bin: dirs ${OUT_DIR}/${PROJECT}.asc
#	${PACK} -vvv ${OUT_DIR}/${PROJECT}.asc ${OUT_DIR}/${PROJECT}.bin 2> ${OUT_DIR}/pack.log
	${PACK} -v --compress --freq 38.8 --input ${OUT_DIR}/${PROJECT}.asc --bit ${OUT_DIR}/${PROJECT}.bin 2> ${OUT_DIR}/pack.log

${OUT_DIR}/${PROJECT}.asc: dirs ${OUT_DIR}/${PROJECT}.json
#	${PNR} -v ${CHIP} ${CHIP_PACKAGE} ${CONSTRAINTS} --json ${OUT_DIR}/${PROJECT}.json --asc ${OUT_DIR}/${PROJECT}.asc -q -l ${OUT_DIR}/pnr.log
	${PNR} -v ${CHIP} ${CHIP_PACKAGE} ${CONSTRAINTS} --json ${OUT_DIR}/${PROJECT}.json --textcfg ${OUT_DIR}/${PROJECT}.asc -q -l ${OUT_DIR}/pnr.log

${OUT_DIR}/${PROJECT}.json: dirs ${MODULES}
	${YOSYS} -q -l ${OUT_DIR}/synth.log -g -p "read_verilog ${MODULES}; ${SYNTH} -json ${OUT_DIR}/${PROJECT}.json"

${OUT_DIR}/${PROJECT}.vcd: dirs ${MODULES} vga_tb.v
	iverilog -o ${OUT_DIR}/${PROJECT}.vvp vga_tb.v
	vvp -v ${OUT_DIR}/${PROJECT}.vvp -fst-space-speed

${OUT_DIR}:
	${MKDIR_P} ${OUT_DIR}

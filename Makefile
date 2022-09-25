# Project files

MKDIR_P=mkdir -p
OUT_DIR=${PWD}/out
SRC=${PWD}/src
MODULES=${SRC}/ecp5-pll40.sv ${SRC}/vga_800x600.sv ${SRC}/top.sv
#MODULES=${SRC}/ecp5-pll25.sv ${SRC}/vga_640x480.sv ${SRC}/top.sv
PROJECT=fpga-vga

# Yosys

YOSYS=yosys
SYNTH=synth_ecp5
PNR=nextpnr-ecp5
PACK=ecppack

# Board Orange Crab 85F

CHIP=--85k
CHIP_PACKAGE=--package CSFBGA285
CONSTRAINTS=--lpf ${SRC}/pcf/orangecrab.pcf

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
	openFPGALoader -b orangeCrab ${OUT_DIR}/${PROJECT}.bin

${OUT_DIR}/${PROJECT}.bin: dirs ${OUT_DIR}/${PROJECT}.asc
	${PACK} -v --compress --freq 38.8 --input ${OUT_DIR}/${PROJECT}.asc --bit ${OUT_DIR}/${PROJECT}.bin 2> ${OUT_DIR}/pack.log

${OUT_DIR}/${PROJECT}.asc: dirs ${OUT_DIR}/${PROJECT}.json
	${PNR} -v ${CHIP} ${CHIP_PACKAGE} ${CONSTRAINTS} --json ${OUT_DIR}/${PROJECT}.json --textcfg ${OUT_DIR}/${PROJECT}.asc -q -l ${OUT_DIR}/pnr.log

${OUT_DIR}/${PROJECT}.json: dirs ${MODULES}
	${YOSYS} -q -l ${OUT_DIR}/synth.log -g -p "read_verilog -sv ${MODULES}; ${SYNTH} -json ${OUT_DIR}/${PROJECT}.json"

${OUT_DIR}/${PROJECT}.vcd: dirs ${MODULES} tb.sv
	iverilog -o ${OUT_DIR}/${PROJECT}.vvp tb.sv
	vvp -v ${OUT_DIR}/${PROJECT}.vvp -fst-space-speed

${OUT_DIR}:
	${MKDIR_P} ${OUT_DIR}

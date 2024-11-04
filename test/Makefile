# Makefile for Cocotb Testbench

# Simulator and language settings
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Directories
SRC_DIR := $(abspath $(PWD)/../src)

# Verilog source files
VERILOG_SOURCES := $(SRC_DIR)/project.v

# Top-level module in your Verilog design
TOPLEVEL := tt_um_SarpHS_array_mult

# Name of the Python test file (without .py extension)
MODULE := test

# Simulation build directory
SIM_BUILD := sim_build

# Include cocotb makefiles
include $(shell cocotb-config --makefiles)/Makefile.sim

# Clean up simulation files
clean::
	rm -rf $(SIM_BUILD) __pycache__ results.xml

.PHONY: clean

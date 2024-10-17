PLUSARGS += "+UVM_VERBOSITY=UVM_MEDUIM"
TOPLEVEL := top
MODULE   ?= top_module
AHB_FILES ?= $(PWD)/../../hdl/bus_wrapper/SRAM_1024x32_ahb_wrapper.v $(PWD)/../../hdl/controllers/ram_ahb_controller.v
APB_FILES ?= # TODO: Add add APB wrapper file path
WB_FILES ?= $(PWD)/../../hdl/bus_wrapper/SRAM_1024x32_wb_wrapper.v $(PWD)/../../hdl/controllers/ram_wb_controller.v
HDL_FILES ?= $(PWD)/../../hdl/EF_SRAM_1024x32.v $(PWD)/../../hdl/beh_models/EF_SRAM_1024x32.tt_180V_25C.v
VERILOG_SOURCES ?=  $(PWD)/top.v $(AHB_FILES) $(APB_FILES) $(WB_FILES) $(HDL_FILES)
RTL_MACROS += "-Dfunctional" # for removing timing in the behavioral model
BUS_TYPE ?= AHB
ifeq ($(BUS_TYPE),AHB)
    RTL_MACROS += -DBUS_TYPE_AHB
else ifeq ($(BUS_TYPE),WISHBONE)
    RTL_MACROS += -DBUS_TYPE_WISHBONE
endif
SKIP_SYNTHESIS = 1
# RTL_MACROS ?= "-DSKIP_WAVE_DUMP"
YAML_FILE = $(PWD)/../../EF_SRAM_1024x32.yaml # TODO: update yaml file path
MAKEFLAGS += --no-print-directory

# List of tests
TESTS := sram_corners_test sram_write_read_test

# Variable for tag - set this as required
SIM_TAG ?= default_tag

# Define SIM_PATH variable
SIM_PATH := $(PWD)/sim/$(SIM_TAG)

# Check and clone EF_UVM repository at the beginning of the Makefile execution

clone_ef_uvm := $(shell if [ ! -d "EF_UVM" ]; then \
	echo "Cloning the EF_UVM repository..."; \
	git clone https://github.com/efabless/EF_UVM.git; \
fi;)


include EF_UVM/Makefile.test

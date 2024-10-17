`timescale 1ns/1ps

module top();
    reg 		CLK = 0;
    wire 		RESETn = 1;
    wire 		irq;
    // TODO: Add any IP signals here
    `ifdef BUS_TYPE_APB
        wire [31:0]	PADDR;
        wire 		PWRITE;
        wire 		PSEL;
        wire 		PENABLE;
        wire [31:0]	PWDATA;
        wire [31:0]	PRDATA;
        wire 		PREADY;
        // TODO: initialize the ABP wrapper here
        // for example
        // EF_sram_APB dut(.PCLK(CLK), .PRESETn(RESETn), .PADDR(PADDR), .PWRITE(PWRITE), .PSEL(PSEL), .PENABLE(PENABLE), .PWDATA(PWDATA), .PRDATA(PRDATA), .PREADY(PREADY), .IRQ(irq));
    `endif // BUS_TYPE_APB
    `ifdef BUS_TYPE_AHB
        wire [31:0]	HADDR;
        wire 		HWRITE;
        wire 		HSEL = 0;
        wire 		HREADYOUT;
        wire [1:0]	HTRANS=0;
        wire [31:0]	HWDATA;
        wire [31:0]	HRDATA;
        wire 		HREADY;
        wire [2:0]  HSIZE;
        // TODO: initialize the AHB wrapper here
        // for example
        SRAM_1024x32_ahb_wrapper dut(.HCLK(CLK), .HRESETn(RESETn), .HADDR(HADDR), .HWRITE(HWRITE), .HSIZE(HSIZE), .HSEL(HSEL), .HTRANS(HTRANS), .HWDATA(HWDATA), .HRDATA(HRDATA), .HREADY(HREADY),.HREADYOUT(HREADYOUT));
    `endif // BUS_TYPE_AHB
    `ifdef BUS_TYPE_WISHBONE
        wire [31:0] adr_i;
        wire [31:0] dat_i;
        wire [31:0] dat_o;
        wire [3:0]  sel_i;
        wire        cyc_i;
        wire        stb_i;
        reg         ack_o;
        // TODO: initialize the Wishbone wrapper here
        // for example
        SRAM_1024x32_wb_wrapper dut(.wb_clk_i(CLK), .wb_rst_i(~RESETn), .wbs_adr_i(adr_i), .wbs_dat_i(dat_i), .wbs_dat_o(dat_o), .wbs_sel_i(sel_i), .wbs_cyc_i(cyc_i), .wbs_stb_i(stb_i), .wbs_ack_o(ack_o), .wbs_we_i(we_i));
    `endif // BUS_TYPE_WISHBONE
    // monitor inside signals
    `ifndef SKIP_WAVE_DUMP
        initial begin
            $dumpfile ({"waves.vcd"});
            $dumpvars(0, top);
        end
    `endif
    always #10 CLK = !CLK; // clk generator
endmodule
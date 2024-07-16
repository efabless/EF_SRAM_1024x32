// SPDX-FileCopyrightText: 2024 Efabless Corporation and its Licensors, All Rights Reserved
// ========================================================================================
//
//  This software is protected by copyright and other intellectual property
//  rights. Therefore, reproduction, modification, translation, compilation, or
//  representation of this software in any manner other than expressly permitted
//  is strictly prohibited.
//
//  You may access and use this software, solely as provided, solely for the purpose of
//  integrating into semiconductor chip designs that you create as a part of the
//  of Efabless shuttles or Efabless managed production programs (and solely for use and
//  fabrication as a part of Efabless production purposes and for no other purpose.  You
//  may not modify or convey the software for any other purpose.
//
//  Disclaimer: EFABLESS AND ITS LICENSORS MAKE NO WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, WITH REGARD TO THIS MATERIAL, AND EXPRESSLY DISCLAIM
//  ANY AND ALL WARRANTIES OF ANY KIND INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
//  PURPOSE. Efabless reserves the right to make changes without further
//  notice to the materials described herein. Neither Efabless nor any of its licensors
//  assume any liability arising out of the application or use of any product or
//  circuit described herein. Efabless's products described herein are
//  not authorized for use as components in life-support devices.
//
//  If you have a separate agreement with Efabless pertaining to the use of this software
//  then that agreement shall control.

module ram_wb_controller #(parameter AW = 10) (
    // wishbone
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output reg wbs_ack_o,
    output [31:0] wbs_dat_o,
    // sram
    input  [31:0] DO,
    output [31:0] DI,
    output [31:0] BEN,
    output [AW-1:0] AD,
    output EN,
    output R_WB,
    output CLKin
);
    // inputs to ram
    assign EN = wbs_stb_i & wbs_cyc_i;
    assign R_WB = ~wbs_we_i;
    assign CLKin = wb_clk_i;
    assign AD = wbs_adr_i[AW-1:0];
    assign DI = wbs_dat_i;
    assign BEN = {{8{wbs_sel_i[3]}}, {8{wbs_sel_i[2]}}, {8{wbs_sel_i[1]}}, {8{wbs_sel_i[0]}}};

    // outputs from ram
    assign wbs_dat_o = DO;
    always @(posedge wb_clk_i or posedge wb_rst_i) begin
        if (wb_rst_i)
            wbs_ack_o <= 0;

        else if (EN & ~wbs_ack_o)  // ausme it took 1 cycle to read or write
            wbs_ack_o <= 1'b1;
        else
            wbs_ack_o <= 1'b0;
    end

endmodule
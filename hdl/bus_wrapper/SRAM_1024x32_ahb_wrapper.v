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

`ifdef USE_POWER_PINS
    `define USE_PG_PIN
`endif

module SRAM_1024x32_ahb_wrapper #(parameter AW = 12) (
`ifdef USE_POWER_PINS
    inout VPWR,
    inout VGND,
`endif
    // AHB Slave ports
    input                   HCLK,
    input                   HRESETn,
    
    input wire              HSEL,
    input wire [31:0]       HADDR,
    input wire [1:0]        HTRANS,
    input wire              HWRITE,
    input wire              HREADY,
    input wire [31:0]       HWDATA,
    input wire [2:0]        HSIZE,
    output wire             HREADYOUT,
    output wire [31:0]      HRDATA

);

// ram ports
wire [31:0] DO;
wire [31:0] DI;
wire [31:0] BEN;
wire [9:0] AD;
wire EN;
wire R_WB;
wire CLKin;

ram_ahb_controller #(.AW(AW)) ram_controller(
    .HCLK(HCLK),
    .HRESETn(HRESETn),
    .HSEL(HSEL),
    .HADDR(HADDR),
    .HTRANS(HTRANS),
    .HSIZE(HSIZE),
    .HWDATA(HWDATA),
    .HWRITE(HWRITE),
    .HREADY(HREADY),
    .HREADYOUT(HREADYOUT),
    .HRDATA(HRDATA),
    .DO(DO),
    .DI(DI),
    .BEN(BEN),
    .AD(AD),
    .EN(EN),
    .R_WB(R_WB)
);

EF_SRAM_1024x32 SRAM_0 (
`ifdef USE_POWER_PINS
    .vgnd(VGND),
    .vnb(VGND),
    .vpb(VPWR),
    .vpwra(VPWR),
    .vpwrm(),
    .vpwrp(VPWR),
`endif
    .vpwrac(1'b1),
    .vpwrpc(1'b1),
    // access ports
    .DO(DO),
    .DI(DI),
    .BEN(BEN),
    .AD(AD),
    .EN(EN),
    .R_WB(R_WB),
    .CLKin(HCLK),
    // scan ports
    .TM(1'b0),
    .SM(1'b0),
    .ScanInCC(1'b0),
    .ScanInDL(1'b0),
    .ScanInDR(1'b0),
    .ScanOutCC(),
    .WLBI(1'b0),
    .WLOFF(1'b0)
);

endmodule
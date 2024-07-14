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

`timescale 1 ns / 1 ps


`ifdef USE_POWER_PINS
    `define USE_PG_PIN
`endif

module EF_SRAM_1024x32 (DO, ScanOutCC, AD, BEN, CLKin, DI, EN, R_WB, ScanInCC, ScanInDL, ScanInDR, SM, TM, WLBI, WLOFF,
`ifdef USE_PG_PIN
vgnd, vnb, vpb, vpwra,
`endif
vpwrac,
`ifdef USE_PG_PIN
vpwrm,
vpwrp,
`endif
vpwrpc
);
    parameter NB = 32;  // Number of Data Bits
    parameter NA = 10;  // Number of Address Bits
    parameter NW = 1024;  // Number of WORDS
    parameter SEED = 0 ;    // User can define SEED at memory instantiation by .SEED(<Some_Seed_value>)

    output [(NB - 1) : 0] DO;
    output ScanOutCC;

    input [(NB - 1) : 0] DI;
    input [(NB - 1) : 0] BEN;
    input [(NA - 1) : 0] AD;
    input EN;
    input R_WB;
    input CLKin;
    input WLBI;
    input WLOFF;
    input TM;
    input SM;
    input ScanInCC;
    input ScanInDL;
    input ScanInDR;
    input vpwrac;
    input vpwrpc;

`ifdef USE_PG_PIN
    input vgnd;
    input vpwrm;

`ifdef EF_SRAM_PA_SIM
  inout vpwra;
`else
  input vpwra;
`endif


`ifdef EF_SRAM_PA_SIM
  inout vpwrp;
`else
  input vpwrp;
`endif

    input vnb;
    input vpb;
`else
    supply0 vgnd;
    supply0 vnb;
    supply1 vpwra;
    supply1 vpwrm;
    supply1 vpwrp;
    supply1 vpb;
`endif


EF_SRAM_1024x32_macro EF_SRAM_1024x32_inst
(
    .DO(DO),
    .ScanOutCC(ScanOutCC),
    .AD(AD),
    .BEN(BEN),
    .CLKin(CLKin),
    .DI(DI),
    .EN(EN),
    .R_WB(R_WB),
    .ScanInCC(ScanInCC),
    .ScanInDL(ScanInDL),
    .ScanInDR(ScanInDR),
    .SM(SM),
    .TM(TM),
    .WLBI(WLBI),
    .WLOFF(vgnd),
    `ifdef USE_PG_PIN
    .vgnd(vgnd),
    .vnb(vnb),
    .vpb(vpb),
    .vpwra(vpwra),
    `endif
    .vpwrac(vpwrac),
    `ifdef USE_PG_PIN
    .vpwrm(vpwrm),
    .vpwrp(vpwrp),
    `endif
    .vpwrpc(vpwrpc)
);
endmodule
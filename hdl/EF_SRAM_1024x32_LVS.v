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
    inout vpwrac;
    inout vpwrpc;

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
    .DO<31>(DO[31]),
    .DO<30>(DO[30]),
    .DO<29>(DO[29]),
    .DO<28>(DO[28]),
    .DO<27>(DO[27]),
    .DO<26>(DO[26]),
    .DO<25>(DO[25]),
    .DO<24>(DO[24]),
    .DO<23>(DO[23]),
    .DO<22>(DO[22]),
    .DO<21>(DO[21]),
    .DO<20>(DO[20]),
    .DO<19>(DO[19]),
    .DO<18>(DO[18]),
    .DO<17>(DO[17]),
    .DO<16>(DO[16]),
    .DO<15>(DO[15]),
    .DO<14>(DO[14]),
    .DO<13>(DO[13]),
    .DO<12>(DO[12]),
    .DO<11>(DO[11]),
    .DO<10>(DO[10]),
    .DO<9>(DO[9]),
    .DO<8>(DO[8]),
    .DO<7>(DO[7]),
    .DO<6>(DO[6]),
    .DO<5>(DO[5]),
    .DO<4>(DO[4]),
    .DO<3>(DO[3]),
    .DO<2>(DO[2]),
    .DO<1>(DO[1]),
    .DO<0>(DO[0]),
    .ScanOutCC(ScanOutCC),
    .AD<9>(AD[9]),
    .AD<8>(AD[8]),
    .AD<7>(AD[7]),
    .AD<6>(AD[6]),
    .AD<5>(AD[5]),
    .AD<4>(AD[4]),
    .AD<3>(AD[3]),
    .AD<2>(AD[2]),
    .AD<1>(AD[1]),
    .AD<0>(AD[0]),
    .BEN<31>(BEN[31]),
    .BEN<30>(BEN[30]),
    .BEN<29>(BEN[29]),
    .BEN<28>(BEN[28]),
    .BEN<27>(BEN[27]),
    .BEN<26>(BEN[26]),
    .BEN<25>(BEN[25]),
    .BEN<24>(BEN[24]),
    .BEN<23>(BEN[23]),
    .BEN<22>(BEN[22]),
    .BEN<21>(BEN[21]),
    .BEN<20>(BEN[20]),
    .BEN<19>(BEN[19]),
    .BEN<18>(BEN[18]),
    .BEN<17>(BEN[17]),
    .BEN<16>(BEN[16]),
    .BEN<15>(BEN[15]),
    .BEN<14>(BEN[14]),
    .BEN<13>(BEN[13]),
    .BEN<12>(BEN[12]),
    .BEN<11>(BEN[11]),
    .BEN<10>(BEN[10]),
    .BEN<9>(BEN[9]),
    .BEN<8>(BEN[8]),
    .BEN<7>(BEN[7]),
    .BEN<6>(BEN[6]),
    .BEN<5>(BEN[5]),
    .BEN<4>(BEN[4]),
    .BEN<3>(BEN[3]),
    .BEN<2>(BEN[2]),
    .BEN<1>(BEN[1]),
    .BEN<0>(BEN[0]),
    .CLKin(CLKin),
    .DI<31>(DI[31]),
    .DI<30>(DI[30]),
    .DI<29>(DI[29]),
    .DI<28>(DI[28]),
    .DI<27>(DI[27]),
    .DI<26>(DI[26]),
    .DI<25>(DI[25]),
    .DI<24>(DI[24]),
    .DI<23>(DI[23]),
    .DI<22>(DI[22]),
    .DI<21>(DI[21]),
    .DI<20>(DI[20]),
    .DI<19>(DI[19]),
    .DI<18>(DI[18]),
    .DI<17>(DI[17]),
    .DI<16>(DI[16]),
    .DI<15>(DI[15]),
    .DI<14>(DI[14]),
    .DI<13>(DI[13]),
    .DI<12>(DI[12]),
    .DI<11>(DI[11]),
    .DI<10>(DI[10]),
    .DI<9>(DI[9]),
    .DI<8>(DI[8]),
    .DI<7>(DI[7]),
    .DI<6>(DI[6]),
    .DI<5>(DI[5]),
    .DI<4>(DI[4]),
    .DI<3>(DI[3]),
    .DI<2>(DI[2]),
    .DI<1>(DI[1]),
    .DI<0>(DI[0]),
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

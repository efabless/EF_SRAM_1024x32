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

`ifdef TETRAMAX
`define TMAX_MODEL
`endif

`ifdef TMAX_MODEL
`ifdef functional
`else
`define functional
`endif
`endif

`ifdef functional
    `timescale 1 ns / 1 ns
    `delay_mode_distributed
    `delay_mode_unit
`else
    `timescale 1 ns / 1 ps
`endif


`ifdef SBT_MODEL
module EF_SRAM_1024x32_tmx
 (DO, ScanOutCC, AD, BEN, CLKin, DI, EN, R_WB, ScanInCC, ScanInDL, ScanInDR, SM, TM, WLBI, WLOFF 
, vgnd, vnb, vpb, vpwra, vpwrac , vpwrm, vpwrp, vpwrpc);

`else

module EF_SRAM_1024x32_macro
 (DO, ScanOutCC, AD, BEN, CLKin, DI, EN, R_WB, ScanInCC, ScanInDL, ScanInDR, SM, TM, WLBI, WLOFF 
`ifdef USE_PG_PIN
, vgnd, vnb, vpb, vpwra
`endif
, vpwrac 
`ifdef USE_PG_PIN
, vpwrm, vpwrp
`endif
, vpwrpc);

`endif

    parameter NB = 32;  
    parameter NA = 10;  
    parameter NW = 1024;  

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
    inout vpwra;
    inout vpwrp;
    input vnb;
    input vpb;
`endif

    wire R_WB;

    wire ENreg_scan;

    wire [NB - 1: 0] DIreg;
    reg [NB - 1: 0] DOreg;

    reg EN_m;
    reg EN;  

    wire clki ;                 
    wire clki_tm ;              
`ifdef USE_PG_PIN
`else
    wire vgnd ;
`endif

    reg mem0 [0 : 1023] ;
    reg mem1 [0 : 1023] ;
    reg mem2 [0 : 1023] ;
    reg mem3 [0 : 1023] ;
    reg mem4 [0 : 1023] ;
    reg mem5 [0 : 1023] ;
    reg mem6 [0 : 1023] ;
    reg mem7 [0 : 1023] ;
    reg mem8 [0 : 1023] ;
    reg mem9 [0 : 1023] ;
    reg mem10 [0 : 1023] ;
    reg mem11 [0 : 1023] ;
    reg mem12 [0 : 1023] ;
    reg mem13 [0 : 1023] ;
    reg mem14 [0 : 1023] ;
    reg mem15 [0 : 1023] ;
    reg mem16 [0 : 1023] ;
    reg mem17 [0 : 1023] ;
    reg mem18 [0 : 1023] ;
    reg mem19 [0 : 1023] ;
    reg mem20 [0 : 1023] ;
    reg mem21 [0 : 1023] ;
    reg mem22 [0 : 1023] ;
    reg mem23 [0 : 1023] ;
    reg mem24 [0 : 1023] ;
    reg mem25 [0 : 1023] ;
    reg mem26 [0 : 1023] ;
    reg mem27 [0 : 1023] ;
    reg mem28 [0 : 1023] ;
    reg mem29 [0 : 1023] ;
    reg mem30 [0 : 1023] ;
    reg mem31 [0 : 1023] ;


                               
`ifdef USE_PG_PIN
`else
     assign vgnd = 1'b0 ;
`endif

`ifdef EF_SRAM_NO_POWER_SWITCH
`else

`ifdef USE_PG_PIN
    EF_SRAM_1024x32_mux muxvpwra(vpwra, vgnd, vpwrm, vpwrac) ;
    EF_SRAM_1024x32_mux muxvpwrp(vpwrp, vgnd, vpwrm, vpwrpc) ;
`endif

`endif

    or smtm(smtm_w, SM, TM) ;
    or enm(endm_w, EN_m, smtm_w) ;
    and clk_gating (clki, CLKin, endm_w) ;  
    and clk_gating_tm (clki_tm, CLKin, smtm_w) ;  
    always @ (CLKin or EN) if (!CLKin) EN_m = EN ;  

    
`ifdef TMAX_MODEL
`else
     always @(smtm_w) if(!TM) begin
          $display("Warning: Normal mode operations(WRITE/READ) should not be tested with Tetramax model") ; 
     end
`endif


EF_SRAM_1024x32_memory_mode_tmx memory_mode_inst(ENreg_scan, DIreg, EN, SM, clki, clki_tm, vgnd, ScanInCC, ScanInDL, ScanInDR, R_WB, WLOFF, TM, AD, BEN, DI);

    nand nand_ctlcan (ScanOutCC, ENreg_scan, TM);  

    EF_SRAM_1024x32_mux mux_dox_0_ (DO[0], DIreg[0], DOreg[0], TM);
    EF_SRAM_1024x32_mux mux_dox_1_ (DO[1], DIreg[1], DOreg[1], TM);
    EF_SRAM_1024x32_mux mux_dox_2_ (DO[2], DIreg[2], DOreg[2], TM);
    EF_SRAM_1024x32_mux mux_dox_3_ (DO[3], DIreg[3], DOreg[3], TM);
    EF_SRAM_1024x32_mux mux_dox_4_ (DO[4], DIreg[4], DOreg[4], TM);
    EF_SRAM_1024x32_mux mux_dox_5_ (DO[5], DIreg[5], DOreg[5], TM);
    EF_SRAM_1024x32_mux mux_dox_6_ (DO[6], DIreg[6], DOreg[6], TM);
    EF_SRAM_1024x32_mux mux_dox_7_ (DO[7], DIreg[7], DOreg[7], TM);
    EF_SRAM_1024x32_mux mux_dox_8_ (DO[8], DIreg[8], DOreg[8], TM);
    EF_SRAM_1024x32_mux mux_dox_9_ (DO[9], DIreg[9], DOreg[9], TM);
    EF_SRAM_1024x32_mux mux_dox_10_ (DO[10], DIreg[10], DOreg[10], TM);
    EF_SRAM_1024x32_mux mux_dox_11_ (DO[11], DIreg[11], DOreg[11], TM);
    EF_SRAM_1024x32_mux mux_dox_12_ (DO[12], DIreg[12], DOreg[12], TM);
    EF_SRAM_1024x32_mux mux_dox_13_ (DO[13], DIreg[13], DOreg[13], TM);
    EF_SRAM_1024x32_mux mux_dox_14_ (DO[14], DIreg[14], DOreg[14], TM);
    EF_SRAM_1024x32_mux mux_dox_15_ (DO[15], DIreg[15], DOreg[15], TM);
    EF_SRAM_1024x32_mux mux_dox_16_ (DO[16], DIreg[16], DOreg[16], TM);
    EF_SRAM_1024x32_mux mux_dox_17_ (DO[17], DIreg[17], DOreg[17], TM);
    EF_SRAM_1024x32_mux mux_dox_18_ (DO[18], DIreg[18], DOreg[18], TM);
    EF_SRAM_1024x32_mux mux_dox_19_ (DO[19], DIreg[19], DOreg[19], TM);
    EF_SRAM_1024x32_mux mux_dox_20_ (DO[20], DIreg[20], DOreg[20], TM);
    EF_SRAM_1024x32_mux mux_dox_21_ (DO[21], DIreg[21], DOreg[21], TM);
    EF_SRAM_1024x32_mux mux_dox_22_ (DO[22], DIreg[22], DOreg[22], TM);
    EF_SRAM_1024x32_mux mux_dox_23_ (DO[23], DIreg[23], DOreg[23], TM);
    EF_SRAM_1024x32_mux mux_dox_24_ (DO[24], DIreg[24], DOreg[24], TM);
    EF_SRAM_1024x32_mux mux_dox_25_ (DO[25], DIreg[25], DOreg[25], TM);
    EF_SRAM_1024x32_mux mux_dox_26_ (DO[26], DIreg[26], DOreg[26], TM);
    EF_SRAM_1024x32_mux mux_dox_27_ (DO[27], DIreg[27], DOreg[27], TM);
    EF_SRAM_1024x32_mux mux_dox_28_ (DO[28], DIreg[28], DOreg[28], TM);
    EF_SRAM_1024x32_mux mux_dox_29_ (DO[29], DIreg[29], DOreg[29], TM);
    EF_SRAM_1024x32_mux mux_dox_30_ (DO[30], DIreg[30], DOreg[30], TM);
    EF_SRAM_1024x32_mux mux_dox_31_ (DO[31], DIreg[31], DOreg[31], TM);


    and (mem0_wen, !R_WB, BEN[0], !WLOFF, !smtm_w, clki);
    and (mem1_wen, !R_WB, BEN[1], !WLOFF, !smtm_w, clki);
    and (mem2_wen, !R_WB, BEN[2], !WLOFF, !smtm_w, clki);
    and (mem3_wen, !R_WB, BEN[3], !WLOFF, !smtm_w, clki);
    and (mem4_wen, !R_WB, BEN[4], !WLOFF, !smtm_w, clki);
    and (mem5_wen, !R_WB, BEN[5], !WLOFF, !smtm_w, clki);
    and (mem6_wen, !R_WB, BEN[6], !WLOFF, !smtm_w, clki);
    and (mem7_wen, !R_WB, BEN[7], !WLOFF, !smtm_w, clki);
    and (mem8_wen, !R_WB, BEN[8], !WLOFF, !smtm_w, clki);
    and (mem9_wen, !R_WB, BEN[9], !WLOFF, !smtm_w, clki);
    and (mem10_wen, !R_WB, BEN[10], !WLOFF, !smtm_w, clki);
    and (mem11_wen, !R_WB, BEN[11], !WLOFF, !smtm_w, clki);
    and (mem12_wen, !R_WB, BEN[12], !WLOFF, !smtm_w, clki);
    and (mem13_wen, !R_WB, BEN[13], !WLOFF, !smtm_w, clki);
    and (mem14_wen, !R_WB, BEN[14], !WLOFF, !smtm_w, clki);
    and (mem15_wen, !R_WB, BEN[15], !WLOFF, !smtm_w, clki);
    and (mem16_wen, !R_WB, BEN[16], !WLOFF, !smtm_w, clki);
    and (mem17_wen, !R_WB, BEN[17], !WLOFF, !smtm_w, clki);
    and (mem18_wen, !R_WB, BEN[18], !WLOFF, !smtm_w, clki);
    and (mem19_wen, !R_WB, BEN[19], !WLOFF, !smtm_w, clki);
    and (mem20_wen, !R_WB, BEN[20], !WLOFF, !smtm_w, clki);
    and (mem21_wen, !R_WB, BEN[21], !WLOFF, !smtm_w, clki);
    and (mem22_wen, !R_WB, BEN[22], !WLOFF, !smtm_w, clki);
    and (mem23_wen, !R_WB, BEN[23], !WLOFF, !smtm_w, clki);
    and (mem24_wen, !R_WB, BEN[24], !WLOFF, !smtm_w, clki);
    and (mem25_wen, !R_WB, BEN[25], !WLOFF, !smtm_w, clki);
    and (mem26_wen, !R_WB, BEN[26], !WLOFF, !smtm_w, clki);
    and (mem27_wen, !R_WB, BEN[27], !WLOFF, !smtm_w, clki);
    and (mem28_wen, !R_WB, BEN[28], !WLOFF, !smtm_w, clki);
    and (mem29_wen, !R_WB, BEN[29], !WLOFF, !smtm_w, clki);
    and (mem30_wen, !R_WB, BEN[30], !WLOFF, !smtm_w, clki);
    and (mem31_wen, !R_WB, BEN[31], !WLOFF, !smtm_w, clki);

    and (mem_ren, R_WB, !WLOFF, !smtm_w, clki);

    always @ (posedge clki) if (mem0_wen) mem0[AD] <= DIreg[0]; 
    always @ (posedge clki) if (mem1_wen) mem1[AD] <= DIreg[1]; 
    always @ (posedge clki) if (mem2_wen) mem2[AD] <= DIreg[2]; 
    always @ (posedge clki) if (mem3_wen) mem3[AD] <= DIreg[3]; 
    always @ (posedge clki) if (mem4_wen) mem4[AD] <= DIreg[4]; 
    always @ (posedge clki) if (mem5_wen) mem5[AD] <= DIreg[5]; 
    always @ (posedge clki) if (mem6_wen) mem6[AD] <= DIreg[6]; 
    always @ (posedge clki) if (mem7_wen) mem7[AD] <= DIreg[7]; 
    always @ (posedge clki) if (mem8_wen) mem8[AD] <= DIreg[8]; 
    always @ (posedge clki) if (mem9_wen) mem9[AD] <= DIreg[9]; 
    always @ (posedge clki) if (mem10_wen) mem10[AD] <= DIreg[10]; 
    always @ (posedge clki) if (mem11_wen) mem11[AD] <= DIreg[11]; 
    always @ (posedge clki) if (mem12_wen) mem12[AD] <= DIreg[12]; 
    always @ (posedge clki) if (mem13_wen) mem13[AD] <= DIreg[13]; 
    always @ (posedge clki) if (mem14_wen) mem14[AD] <= DIreg[14]; 
    always @ (posedge clki) if (mem15_wen) mem15[AD] <= DIreg[15]; 
    always @ (posedge clki) if (mem16_wen) mem16[AD] <= DIreg[16]; 
    always @ (posedge clki) if (mem17_wen) mem17[AD] <= DIreg[17]; 
    always @ (posedge clki) if (mem18_wen) mem18[AD] <= DIreg[18]; 
    always @ (posedge clki) if (mem19_wen) mem19[AD] <= DIreg[19]; 
    always @ (posedge clki) if (mem20_wen) mem20[AD] <= DIreg[20]; 
    always @ (posedge clki) if (mem21_wen) mem21[AD] <= DIreg[21]; 
    always @ (posedge clki) if (mem22_wen) mem22[AD] <= DIreg[22]; 
    always @ (posedge clki) if (mem23_wen) mem23[AD] <= DIreg[23]; 
    always @ (posedge clki) if (mem24_wen) mem24[AD] <= DIreg[24]; 
    always @ (posedge clki) if (mem25_wen) mem25[AD] <= DIreg[25]; 
    always @ (posedge clki) if (mem26_wen) mem26[AD] <= DIreg[26]; 
    always @ (posedge clki) if (mem27_wen) mem27[AD] <= DIreg[27]; 
    always @ (posedge clki) if (mem28_wen) mem28[AD] <= DIreg[28]; 
    always @ (posedge clki) if (mem29_wen) mem29[AD] <= DIreg[29]; 
    always @ (posedge clki) if (mem30_wen) mem30[AD] <= DIreg[30]; 
    always @ (posedge clki) if (mem31_wen) mem31[AD] <= DIreg[31]; 

    always @ (posedge clki) if (mem_ren) DOreg[0] <= mem0[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[1] <= mem1[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[2] <= mem2[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[3] <= mem3[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[4] <= mem4[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[5] <= mem5[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[6] <= mem6[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[7] <= mem7[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[8] <= mem8[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[9] <= mem9[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[10] <= mem10[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[11] <= mem11[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[12] <= mem12[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[13] <= mem13[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[14] <= mem14[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[15] <= mem15[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[16] <= mem16[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[17] <= mem17[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[18] <= mem18[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[19] <= mem19[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[20] <= mem20[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[21] <= mem21[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[22] <= mem22[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[23] <= mem23[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[24] <= mem24[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[25] <= mem25[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[26] <= mem26[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[27] <= mem27[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[28] <= mem28[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[29] <= mem29[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[30] <= mem30[AD]; 
    always @ (posedge clki) if (mem_ren) DOreg[31] <= mem31[AD]; 

endmodule


module EF_SRAM_1024x32_mux(Z, A, B, S);
    output Z;
    input A;
    input B;
    input S;
    wire tmp1, tmp2 ; 

    and u1 (tmp1, A, S);
    and u2 (tmp2, B, !S);
    or  u3 (Z, tmp1, tmp2);
endmodule


primitive EF_SRAM_1024x32_dff (Q, D, CP);
    output Q;  
    input  D, CP;
    reg    Q;  
    table

        1   (01)      :   ?   :   1;  
        0   (01)      :   ?   :   0;

        1   (x1)      :   1   :   1;  
        0   (x1)      :   0   :   0;                          
        1   (0x)      :   1   :   1;  
        0   (0x)      :   0   :   0; 

        ?   (1x)      :   ?   :   -;  
        ?   (?0)      :   ?   :   -;  

        *    ?        :   ?   :   -;  
    endtable
endprimitive

module EF_SRAM_1024x32_memory_mode_tmx(ENreg_scan, DIreg, EN, SM, clki, clki_tm, vgnd, ScanInCC, ScanInDL, ScanInDR, R_WB, WLOFF, TM, AD, BEN, DI);

    parameter NB = 32;  
    parameter NA = 10;  
    parameter NW = 1024;  

    input EN;
    input SM;
    input clki;
    input clki_tm;
    input vgnd;
    input ScanInCC;
    input ScanInDL;
    input ScanInDR;
    input R_WB;
    input WLOFF;
    input TM;
    input [(NB - 1) : 0] DI;
    input [(NB - 1) : 0] BEN;
    input [(NA - 1) : 0] AD;
                                                                                                                                                   
    output ENreg_scan;
    output [NB - 1: 0] DIreg;
                                                                                                                                                   
    wire [NB - 1: 0] DIreg;
    wire [NB - 1: 0] DImux1;
    wire [NB - 1: 0] DImux2;
    wire [12 - 1: 0] ADmux;
    wire [12 - 1: 0] ADreg_scan;
    wire R_WBmux;
    wire ENmux;
    wire WLOFFmux;
    wire ScanOutA ;
    wire WLOFFreg_scan;
    wire R_WBreg_scan;






    EF_SRAM_1024x32_mux mux_ad_0_ (ADmux[0], ADreg_scan[1], AD[0], SM);
    EF_SRAM_1024x32_dff dff_ad_scan_0_ (ADreg_scan[0], ADmux[0], clki_tm);
    EF_SRAM_1024x32_mux mux_ad_1_ (ADmux[1], ADreg_scan[2], AD[1], SM);
    EF_SRAM_1024x32_dff dff_ad_scan_1_ (ADreg_scan[1], ADmux[1], clki_tm);
    EF_SRAM_1024x32_mux mux_ad_2_ (ADmux[2], ADreg_scan[3], AD[2], SM);
    EF_SRAM_1024x32_dff dff_ad_scan_2_ (ADreg_scan[2], ADmux[2], clki_tm);
    EF_SRAM_1024x32_mux mux_ad_3_ (ADmux[3], ADreg_scan[4], vgnd, SM);
    EF_SRAM_1024x32_dff dff_ad_scan_3_ (ADreg_scan[3], ADmux[3], clki_tm);
    EF_SRAM_1024x32_mux mux_ad_4_ (ADmux[4], ADreg_scan[5], vgnd, SM);
    EF_SRAM_1024x32_dff dff_ad_scan_4_ (ADreg_scan[4], ADmux[4], clki_tm);
    EF_SRAM_1024x32_mux mux_ad_5_ (ADmux[5], ADreg_scan[6], AD[4], SM);
    EF_SRAM_1024x32_dff dff_ad_scan_5_ (ADreg_scan[5], ADmux[5], clki_tm);
    EF_SRAM_1024x32_mux mux_ad_6_ (ADmux[6], ADreg_scan[7], AD[5], SM);
    EF_SRAM_1024x32_dff dff_ad_scan_6_ (ADreg_scan[6], ADmux[6], clki_tm);
    EF_SRAM_1024x32_mux mux_ad_7_ (ADmux[7], ADreg_scan[8], AD[6], SM);
    EF_SRAM_1024x32_dff dff_ad_scan_7_ (ADreg_scan[7], ADmux[7], clki_tm);
    EF_SRAM_1024x32_mux mux_ad_8_ (ADmux[8], ADreg_scan[9], AD[7], SM);
    EF_SRAM_1024x32_dff dff_ad_scan_8_ (ADreg_scan[8], ADmux[8], clki_tm);
    EF_SRAM_1024x32_mux mux_ad_9_ (ADmux[9], ADreg_scan[10], AD[8], SM);
    EF_SRAM_1024x32_dff dff_ad_scan_9_ (ADreg_scan[9], ADmux[9], clki_tm);
    EF_SRAM_1024x32_mux mux_ad_10_ (ADmux[10], ADreg_scan[11], AD[9], SM);
    EF_SRAM_1024x32_dff dff_ad_scan_10_ (ADreg_scan[10], ADmux[10], clki_tm);
    EF_SRAM_1024x32_mux mux_ad_11_ (ADmux[11], ScanInCC, AD[3], SM);
    EF_SRAM_1024x32_dff dff_ad_scan_11_ (ADreg_scan[11], ADmux[11], clki_tm);

                              
    nand nand_adscan (ScanOutA, ADreg_scan[0], TM);              

    EF_SRAM_1024x32_mux mux_rwb (R_WBmux, ADreg_scan[0], R_WB, SM);
    EF_SRAM_1024x32_dff dff_rwb_scan (R_WBreg_scan, R_WBmux, clki_tm);

    EF_SRAM_1024x32_mux mux_wloff (WLOFFmux, R_WBreg_scan, WLOFF, SM);
    EF_SRAM_1024x32_dff dff_wloff_scan (WLOFFreg_scan, WLOFFmux, clki_tm);

    EF_SRAM_1024x32_mux mux_en (ENmux, WLOFFreg_scan, EN, SM);
    EF_SRAM_1024x32_dff dff_en_scan (ENreg_scan, ENmux, clki_tm);



    EF_SRAM_1024x32_mux mux_di0_0_ (DImux1[0], DI[0], BEN[0], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_0_ (DImux2[0], ScanInDL, DImux1[0], SM);
    EF_SRAM_1024x32_dff dff_di_0_ (DIreg[0], DImux2[0], clki);
    EF_SRAM_1024x32_mux mux_di0_1_ (DImux1[1], DI[1], BEN[1], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_1_ (DImux2[1], DIreg[0], DImux1[1], SM);
    EF_SRAM_1024x32_dff dff_di_1_ (DIreg[1], DImux2[1], clki);
    EF_SRAM_1024x32_mux mux_di0_2_ (DImux1[2], DI[2], BEN[2], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_2_ (DImux2[2], DIreg[1], DImux1[2], SM);
    EF_SRAM_1024x32_dff dff_di_2_ (DIreg[2], DImux2[2], clki);
    EF_SRAM_1024x32_mux mux_di0_3_ (DImux1[3], DI[3], BEN[3], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_3_ (DImux2[3], DIreg[2], DImux1[3], SM);
    EF_SRAM_1024x32_dff dff_di_3_ (DIreg[3], DImux2[3], clki);
    EF_SRAM_1024x32_mux mux_di0_4_ (DImux1[4], DI[4], BEN[4], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_4_ (DImux2[4], DIreg[3], DImux1[4], SM);
    EF_SRAM_1024x32_dff dff_di_4_ (DIreg[4], DImux2[4], clki);
    EF_SRAM_1024x32_mux mux_di0_5_ (DImux1[5], DI[5], BEN[5], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_5_ (DImux2[5], DIreg[4], DImux1[5], SM);
    EF_SRAM_1024x32_dff dff_di_5_ (DIreg[5], DImux2[5], clki);
    EF_SRAM_1024x32_mux mux_di0_6_ (DImux1[6], DI[6], BEN[6], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_6_ (DImux2[6], DIreg[5], DImux1[6], SM);
    EF_SRAM_1024x32_dff dff_di_6_ (DIreg[6], DImux2[6], clki);
    EF_SRAM_1024x32_mux mux_di0_7_ (DImux1[7], DI[7], BEN[7], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_7_ (DImux2[7], DIreg[6], DImux1[7], SM);
    EF_SRAM_1024x32_dff dff_di_7_ (DIreg[7], DImux2[7], clki);
    EF_SRAM_1024x32_mux mux_di0_8_ (DImux1[8], DI[8], BEN[8], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_8_ (DImux2[8], DIreg[7], DImux1[8], SM);
    EF_SRAM_1024x32_dff dff_di_8_ (DIreg[8], DImux2[8], clki);
    EF_SRAM_1024x32_mux mux_di0_9_ (DImux1[9], DI[9], BEN[9], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_9_ (DImux2[9], DIreg[8], DImux1[9], SM);
    EF_SRAM_1024x32_dff dff_di_9_ (DIreg[9], DImux2[9], clki);
    EF_SRAM_1024x32_mux mux_di0_10_ (DImux1[10], DI[10], BEN[10], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_10_ (DImux2[10], DIreg[9], DImux1[10], SM);
    EF_SRAM_1024x32_dff dff_di_10_ (DIreg[10], DImux2[10], clki);
    EF_SRAM_1024x32_mux mux_di0_11_ (DImux1[11], DI[11], BEN[11], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_11_ (DImux2[11], DIreg[10], DImux1[11], SM);
    EF_SRAM_1024x32_dff dff_di_11_ (DIreg[11], DImux2[11], clki);
    EF_SRAM_1024x32_mux mux_di0_12_ (DImux1[12], DI[12], BEN[12], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_12_ (DImux2[12], DIreg[11], DImux1[12], SM);
    EF_SRAM_1024x32_dff dff_di_12_ (DIreg[12], DImux2[12], clki);
    EF_SRAM_1024x32_mux mux_di0_13_ (DImux1[13], DI[13], BEN[13], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_13_ (DImux2[13], DIreg[12], DImux1[13], SM);
    EF_SRAM_1024x32_dff dff_di_13_ (DIreg[13], DImux2[13], clki);
    EF_SRAM_1024x32_mux mux_di0_14_ (DImux1[14], DI[14], BEN[14], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_14_ (DImux2[14], DIreg[13], DImux1[14], SM);
    EF_SRAM_1024x32_dff dff_di_14_ (DIreg[14], DImux2[14], clki);
    EF_SRAM_1024x32_mux mux_di0_15_ (DImux1[15], DI[15], BEN[15], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_15_ (DImux2[15], DIreg[14], DImux1[15], SM);
    EF_SRAM_1024x32_dff dff_di_15_ (DIreg[15], DImux2[15], clki);
    EF_SRAM_1024x32_mux mux_di0_16_ (DImux1[16], DI[16], BEN[16], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_16_ (DImux2[16], ScanInDR, DImux1[16], SM);
    EF_SRAM_1024x32_dff dff_di_16_ (DIreg[16], DImux2[16], clki);
    EF_SRAM_1024x32_mux mux_di0_17_ (DImux1[17], DI[17], BEN[17], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_17_ (DImux2[17], DIreg[16], DImux1[17], SM);
    EF_SRAM_1024x32_dff dff_di_17_ (DIreg[17], DImux2[17], clki);
    EF_SRAM_1024x32_mux mux_di0_18_ (DImux1[18], DI[18], BEN[18], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_18_ (DImux2[18], DIreg[17], DImux1[18], SM);
    EF_SRAM_1024x32_dff dff_di_18_ (DIreg[18], DImux2[18], clki);
    EF_SRAM_1024x32_mux mux_di0_19_ (DImux1[19], DI[19], BEN[19], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_19_ (DImux2[19], DIreg[18], DImux1[19], SM);
    EF_SRAM_1024x32_dff dff_di_19_ (DIreg[19], DImux2[19], clki);
    EF_SRAM_1024x32_mux mux_di0_20_ (DImux1[20], DI[20], BEN[20], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_20_ (DImux2[20], DIreg[19], DImux1[20], SM);
    EF_SRAM_1024x32_dff dff_di_20_ (DIreg[20], DImux2[20], clki);
    EF_SRAM_1024x32_mux mux_di0_21_ (DImux1[21], DI[21], BEN[21], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_21_ (DImux2[21], DIreg[20], DImux1[21], SM);
    EF_SRAM_1024x32_dff dff_di_21_ (DIreg[21], DImux2[21], clki);
    EF_SRAM_1024x32_mux mux_di0_22_ (DImux1[22], DI[22], BEN[22], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_22_ (DImux2[22], DIreg[21], DImux1[22], SM);
    EF_SRAM_1024x32_dff dff_di_22_ (DIreg[22], DImux2[22], clki);
    EF_SRAM_1024x32_mux mux_di0_23_ (DImux1[23], DI[23], BEN[23], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_23_ (DImux2[23], DIreg[22], DImux1[23], SM);
    EF_SRAM_1024x32_dff dff_di_23_ (DIreg[23], DImux2[23], clki);
    EF_SRAM_1024x32_mux mux_di0_24_ (DImux1[24], DI[24], BEN[24], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_24_ (DImux2[24], DIreg[23], DImux1[24], SM);
    EF_SRAM_1024x32_dff dff_di_24_ (DIreg[24], DImux2[24], clki);
    EF_SRAM_1024x32_mux mux_di0_25_ (DImux1[25], DI[25], BEN[25], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_25_ (DImux2[25], DIreg[24], DImux1[25], SM);
    EF_SRAM_1024x32_dff dff_di_25_ (DIreg[25], DImux2[25], clki);
    EF_SRAM_1024x32_mux mux_di0_26_ (DImux1[26], DI[26], BEN[26], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_26_ (DImux2[26], DIreg[25], DImux1[26], SM);
    EF_SRAM_1024x32_dff dff_di_26_ (DIreg[26], DImux2[26], clki);
    EF_SRAM_1024x32_mux mux_di0_27_ (DImux1[27], DI[27], BEN[27], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_27_ (DImux2[27], DIreg[26], DImux1[27], SM);
    EF_SRAM_1024x32_dff dff_di_27_ (DIreg[27], DImux2[27], clki);
    EF_SRAM_1024x32_mux mux_di0_28_ (DImux1[28], DI[28], BEN[28], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_28_ (DImux2[28], DIreg[27], DImux1[28], SM);
    EF_SRAM_1024x32_dff dff_di_28_ (DIreg[28], DImux2[28], clki);
    EF_SRAM_1024x32_mux mux_di0_29_ (DImux1[29], DI[29], BEN[29], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_29_ (DImux2[29], DIreg[28], DImux1[29], SM);
    EF_SRAM_1024x32_dff dff_di_29_ (DIreg[29], DImux2[29], clki);
    EF_SRAM_1024x32_mux mux_di0_30_ (DImux1[30], DI[30], BEN[30], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_30_ (DImux2[30], DIreg[29], DImux1[30], SM);
    EF_SRAM_1024x32_dff dff_di_30_ (DIreg[30], DImux2[30], clki);
    EF_SRAM_1024x32_mux mux_di0_31_ (DImux1[31], DI[31], BEN[31], ScanOutA);
    EF_SRAM_1024x32_mux mux_di2_31_ (DImux2[31], DIreg[30], DImux1[31], SM);
    EF_SRAM_1024x32_dff dff_di_31_ (DIreg[31], DImux2[31], clki);

endmodule

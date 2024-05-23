module EF_SRAM_1024x32_wrapper (
    DO, ScanOutCC, AD, BEN, CLKin, DI, EN, R_WB, ScanInCC, ScanInDL, ScanInDR, SM, TM, WLBI, WLOFF,
`ifdef USE_PG_PIN
    vgnd, vnb, vpb, vpwra,
`endif
    vpwrac,
`ifdef USE_PG_PIN
    vpwrm, vpwrp,
`endif
    vpwrpc
);
    parameter NB = 32;  // Number of Data Bits
    parameter NA = 10;  // Number of Address Bits
    parameter NW = 1024;  // Number of WORDS
    parameter SEED = 0;  // User can define SEED at memory instantiation by .SEED(<Some_Seed_value>)

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

EF_SRAM_1024x32_macro EF_SRAM_1024x32_inst (
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
    .WLOFF(WLOFF),
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


    .weak

      rlHDMAArrayEngineCreateEntryByIndex   :?= address($82A470)
      rlHDMAEngineFreeEntryByIndex          :?= address($82A495)

    .endweak

    .virtual $7E4F61

      wWindowColorHDMAModifyableTableDataOffset .word ?       ; $7E4F61
      wWindowColorHDMACurrentlyActiveTableDataOffset .word ?  ; $7E4F63
      wWindowColorHDMAFinishedModifyingFlag .word ?           ; $7E4F65

    .endvirtual

    .virtual $7E4F73

      wWindowColorHDMAYPositionEndPixels .word ?              ; $7E4F73
      wWindowColorHDMAHeightPixels .word ?                    ; $7E4F75
      
    .endvirtual

    .virtual $7EBBAF

      aWindowColorHDMARedTableData1    .fill 224              ; $7EBBAF
      aWindowColorHDMAGreenTableData1  .fill 224              ; $7EBC8F
      aWindowColorHDMABlueTableData1   .fill 224              ; $7EBD6F
      aWindowColorHDMARedTableData2    .fill 224              ; $7EBE4F
      aWindowColorHDMAGreenTableData2  .fill 224              ; $7EBF2F
      aWindowColorHDMABlueTableData2   .fill 224              ; $7EC00F
      aWindowColorHDMARedTable         .fill 8                ; $7EC0EF
      aWindowColorHDMAGreenTable       .fill 8                ; $7EC0F7
      aWindowColorHDMABlueTable        .fill 8                ; $7EC0FF
      aWindowColorHDMAEnabledTileTable .block                 ; $7EC107
        .fill 28                   
      .bend

    .endvirtual



    .section WindowColorHDMASection

      startCode

      rlWindowColorHDMAClearEnabledTileTable ; 85/9132

        .al
        .autsiz
        .databank $7E

        stz aWindowColorHDMAEnabledTileTable
        stz aWindowColorHDMAEnabledTileTable+2
        stz aWindowColorHDMAEnabledTileTable+4
        stz aWindowColorHDMAEnabledTileTable+6
        stz aWindowColorHDMAEnabledTileTable+8
        stz aWindowColorHDMAEnabledTileTable+10
        stz aWindowColorHDMAEnabledTileTable+12
        stz aWindowColorHDMAEnabledTileTable+14
        stz aWindowColorHDMAEnabledTileTable+16
        stz aWindowColorHDMAEnabledTileTable+18
        stz aWindowColorHDMAEnabledTileTable+20
        stz aWindowColorHDMAEnabledTileTable+22
        stz aWindowColorHDMAEnabledTileTable+24
        stz aWindowColorHDMAEnabledTileTable+26

        stz $4EFF,b

        lda #$0020
        sta $4EFD,b
        rtl

        .databank 0

      rsWindowColorHDMASetActiveOnEnabledTiles ; 85/9166

        .al
        .autsiz
        .databank $7E

        lda wWindowColorHDMAModifyableTableDataOffset
        clc
        adc #224 - 16
        tax

        ldy #size(aWindowColorHDMAEnabledTileTable) -1

        -
        lda aWindowColorHDMAEnabledTileTable,y
        and #$00FF
        bne +

          lda #pack([COLDATA_Setting(0, true, true, true), COLDATA_Setting(0, true, true, true)])
          sta aWindowColorHDMARedTableData1+8,x
          sta aWindowColorHDMARedTableData1+10,x
          sta aWindowColorHDMARedTableData1+12,x
          sta aWindowColorHDMARedTableData1+14,x

          sta aWindowColorHDMAGreenTableData1+8,x
          sta aWindowColorHDMAGreenTableData1+10,x
          sta aWindowColorHDMAGreenTableData1+12,x
          sta aWindowColorHDMAGreenTableData1+14,x

          sta aWindowColorHDMABlueTableData1+8,x
          sta aWindowColorHDMABlueTableData1+10,x
          sta aWindowColorHDMABlueTableData1+12,x
          sta aWindowColorHDMABlueTableData1+14,x

        +
        dec y
        lda aWindowColorHDMAEnabledTileTable,y
        and #$00FF
        bne +

          lda #pack([COLDATA_Setting(0, true, true, true), COLDATA_Setting(0, true, true, true)])
          sta aWindowColorHDMARedTableData1,x
          sta aWindowColorHDMARedTableData1+2,x
          sta aWindowColorHDMARedTableData1+4,x
          sta aWindowColorHDMARedTableData1+6,x

          sta aWindowColorHDMAGreenTableData1,x
          sta aWindowColorHDMAGreenTableData1+2,x
          sta aWindowColorHDMAGreenTableData1+4,x
          sta aWindowColorHDMAGreenTableData1+6,x

          sta aWindowColorHDMABlueTableData1,x
          sta aWindowColorHDMABlueTableData1+2,x
          sta aWindowColorHDMABlueTableData1+4,x
          sta aWindowColorHDMABlueTableData1+6,x

        +
        txa
        sec
        sbc #16
        tax
        dec y
        bpl -

        rts

        .databank 0

      rsWindowColorHDMAEnableTiles ; 85/91DA

        .al
        .autsiz
        .databank $7E

        ; wR0 = Y coord
        ; wR1 =  height
        ; Both in the high byte

        lda wR1
        xba
        and #$00FF
        tay

        lda wR0
        xba
        and #$00FF
        tax

        -
        inc aWindowColorHDMAEnabledTileTable,x
        inc x
        dec y
        bne -

        rts

        .databank 0

      rlInitiateWindowColorHDMAs ; 85/91F0

        .al
        .autsiz
        .databank ?

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        .databank $7E

        jsl rlCreateWindowColorHDMAs
        jsl rlWindowColorHDMAClearEnabledTileTable

        plb
        plp
        rtl

        .databank 0

      rlEnableWindowColorHDMA ; 85/9205

        .al
        .autsiz
        .databank ?

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        .databank $7E

        jsr rsWindowColorHDMASetActiveOnEnabledTiles
        jsl rlWindowColorHDMAFlagFinishSwapOffsets
        plb
        plp
        rtl

        .databank 0

      rlSetWindowColorHDMAAreaByTiles ; 85/9219

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wR0 = Y tile coord
        ; wR1 = tile height

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        .databank $7E

        lda wR0
        xba
        sta wR0
        lda wR1
        xba
        sta wR1

        jsr rsWindowColorHDMAFillTableData
        plb
        plp
        rtl

        .databank 0

      rlSetWindowColorHDMAAreaByPixels ; 85/9233

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wR0 = Y pixel coord
        ; wR1 = pixel height

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        .databank $7E

        lda wR0
        pha
        lda wR1
        pha

        lda #0
        sta wR0
        lda #pack([0, size(aWindowColorHDMAEnabledTileTable)])
        sta wR1
        jsr rsWindowColorHDMAEnableTiles

        pla
        sta wR1
        pla
        sta wR0

        lda wR1
        sta wWindowColorHDMAHeightPixels
        lda wR0
        clc
        adc wWindowColorHDMAHeightPixels
        clc
        adc wWindowColorHDMAModifyableTableDataOffset
        sta wWindowColorHDMAYPositionEndPixels

        pea #<>(+)-1
        phx
        phy
        jmp rsWindowColorHDMAFillTableData._9299
        
        +
        plb
        plp
        rtl

        .databank 0

      rsWindowColorHDMAFillTableData ; 85/9273

        .al
        .autsiz
        .databank $7E

        ; Input:
        ; wR0 = Y tile coord
        ; wR1 = tile height

        phx
        phy
        jsr rsWindowColorHDMAEnableTiles

        lda wR1
        xba
        and #$00FF
        asl a
        asl a
        asl a
        sta wWindowColorHDMAHeightPixels

        lda wR0
        xba
        and #$00FF
        asl a
        asl a
        asl a
        clc
        adc wWindowColorHDMAHeightPixels
        clc
        adc wWindowColorHDMAModifyableTableDataOffset
        dec a
        sta wWindowColorHDMAYPositionEndPixels

        _9299
        lda #COLDATA_ApplyRed
        sta wR6
        lda aCurrentWindowColors.wUpperRed
        sta wR8
        lda aCurrentWindowColors.wLowerRed
        sta wR9

        lda wWindowColorHDMAYPositionEndPixels
        clc
        adc #<>aWindowColorHDMARedTableData1
        sta wR7

        jsr rsWindowColorHDMAGenerateTableDataEntries

        lda #COLDATA_ApplyGreen
        sta wR6
        lda aCurrentWindowColors.wUpperGreen
        sta wR8
        lda aCurrentWindowColors.wLowerGreen
        sta wR9

        lda wWindowColorHDMAYPositionEndPixels
        clc
        adc #<>aWindowColorHDMAGreenTableData1
        sta wR7

        jsr rsWindowColorHDMAGenerateTableDataEntries

        lda #COLDATA_ApplyBlue
        sta wR6
        lda aCurrentWindowColors.wUpperBlue
        sta wR8
        lda aCurrentWindowColors.wLowerBlue
        sta wR9

        lda wWindowColorHDMAYPositionEndPixels
        clc
        adc #<>aWindowColorHDMABlueTableData1
        sta wR7

        jsr rsWindowColorHDMAGenerateTableDataEntries

        ply
        plx
        rts

        .databank 0

      rsWindowColorHDMAGenerateTableDataEntries ; 85/92ED

        ; Input:
        ; wR6 = COLDATA_Apply setting
        ; wR7 = table data address
        ; wR8 = upper color intensity
        ; wR9 = lower color intensity

        ; calculated:
        ; wR4  = FPN of the height for each color bar
        ; wR13 = color difference in high byte
        ; wR14 = pixel height

        ; So this routine does funny 8.8 signed fixed point number math.
        ; It grabs the color intensity difference, generates a FPN out of that and
        ; the height of the area and adds the COLDATA_Apply setting to the intensity.
        ; If the color difference is positiv, eg. it gets 'more red' the lower you go,
        ; negate the FPN since the HDMA data table is build from bottom up and the
        ; intensity adds the FPN on each scanline.

        .al
        .autsiz
        .databank $7E

        php
        rep #$30
        ldy #0

        lda wR8
        sec
        sbc wR9
        bpl +

          dec y
          eor #$FFFF
          inc a

        +
        xba
        sta wR13

        lda wWindowColorHDMAHeightPixels
        sta wR14

        jsl rlUnsignedDivide16By16

        lda wR13
        tyx
        beq +

          eor #$FFFF
          inc a

        +
        sta wR4

        lda wR9
        ora wR6
        xba
        sta wR9

        ldx wR7
        dec x

        ldy wWindowColorHDMAHeightPixels
        dec y

        lda wR9
        
        -
        sta $0000,b,x
        clc
        adc wR4
        dec x
        dec y
        bne -

        xba
        sep #$20
        sta $0001,b,x
        plp
        rts

        .databank 0

      rsWindowColorHDMASwapTableDataOffset ; 85/9338

        .al
        .autsiz
        .databank $7E

        lda wWindowColorHDMAModifyableTableDataOffset
        beq +

        stz wWindowColorHDMAModifyableTableDataOffset
        lda #224 * 3
        sta wWindowColorHDMACurrentlyActiveTableDataOffset
        bra ++
        
        +
        stz wWindowColorHDMACurrentlyActiveTableDataOffset
        lda #224 * 3
        sta wWindowColorHDMAModifyableTableDataOffset

        +
        rts

        .databank 0

      rlWindowColorHDMABuildHDMATable ; 85/9352

        .al
        .autsiz
        .databank ?

        lda wWindowColorHDMAFinishedModifyingFlag
        bne +

          rtl

        +
        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        .databank $7E

        rep #$20
        stz wWindowColorHDMAFinishedModifyingFlag

        lda #<>aWindowColorHDMARedTableData1
        ldx #<>aWindowColorHDMARedTable
        jsr rsWindowColorHDMABuildHDMATableEffect

        lda #<>aWindowColorHDMAGreenTableData1
        ldx #<>aWindowColorHDMAGreenTable
        jsr rsWindowColorHDMABuildHDMATableEffect

        lda #<>aWindowColorHDMABlueTableData1
        ldx #<>aWindowColorHDMABlueTable
        jsr rsWindowColorHDMABuildHDMATableEffect

        plb
        plp
        rtl

        .databank 0

      rsWindowColorHDMABuildHDMATableEffect ; 85/9386

        .al
        .autsiz
        .databank $7E

        clc
        adc wWindowColorHDMACurrentlyActiveTableDataOffset
        sta $0001,b,x
        clc
        adc #128
        sta $0004,b,x

        sep #$20
        lda #NTRL_Setting(127, true)
        sta $0000,b,x

        lda #NTRL_Setting(95, true)
        sta $0003,b,x

        stz $0006,b,x
        rep #$20
        rts

        .databank 0

      rlWindowColorHDMAFlagFinishSwapOffsets ; 85/93A6

        .al
        .autsiz
        .databank $7E

        dec wWindowColorHDMAFinishedModifyingFlag
        jsr rsWindowColorHDMASwapTableDataOffset
        rtl

        .databank 0

      rlCreateWindowColorHDMAs ; 85/93AD

        .al
        .autsiz
        .databank $7E

        php
        rep #$30

        lda #<>aWindowColorRedHDMA
        sta lR44
        lda #>`aWindowColorRedHDMA
        sta lR44+1
        lda #0
        sta wR40
        jsl rlHDMAArrayEngineCreateEntryByIndex

        lda #<>aWindowColorGreenHDMA
        sta lR44
        lda #>`aWindowColorGreenHDMA
        sta lR44+1
        lda #1
        sta wR40
        jsl rlHDMAArrayEngineCreateEntryByIndex

        lda #<>aWindowColorBlueHDMA
        sta lR44
        lda #>`aWindowColorBlueHDMA
        sta lR44+1
        lda #2
        sta wR40
        jsl rlHDMAArrayEngineCreateEntryByIndex
        plp
        rtl

        .databank 0

      rlClearWindowColorHDMAs ; 85/93EB

        .al
        .autsiz
        .databank ?

        php
        rep #$30
        lda #0
        jsl rlHDMAEngineFreeEntryByIndex
        lda #1
        jsl rlHDMAEngineFreeEntryByIndex
        lda #2
        jsl rlHDMAEngineFreeEntryByIndex

        sep #$20
        lda #CGADSUB_Setting(CGADSUB_Add, false, false, false, false, false, false, false)
        sta bBufferCGADSUB
        plp
        rtl

        .databank 0

      aWindowColorRedHDMA ; 85/940B
        .structHDMAIndirectEntryInfo rlWindowColorRedHDMAInit,  rlWindowColorRedHDMACycle, aWindowColorRedHDMACode, aWindowColorHDMARedTable, COLDATA, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode0) + $8, `aWindowColorHDMARedTableData1

      aWindowColorGreenHDMA ; 85/9417
        .structHDMAIndirectEntryInfo rlWindowColorRedHDMACycle, rlWindowColorRedHDMACycle, aWindowColorRedHDMACode, aWindowColorHDMAGreenTable, COLDATA, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode0) + $8, `aWindowColorHDMAGreenTableData1

      aWindowColorBlueHDMA ; 85/9423
        .structHDMAIndirectEntryInfo rlWindowColorRedHDMACycle, rlWindowColorRedHDMACycle, aWindowColorRedHDMACode, aWindowColorHDMABlueTable, COLDATA, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode0) + $8, `aWindowColorHDMABlueTableData1

      ; Whoever did the color shading didn't fully know his HDMA stuff,
      ; these entries try to set the DMAP_DMAABusStep.

      rlWindowColorRedHDMAInit ; 85/942F

        ; Enable color math window 1
        ; Only do color math inside the window
        ; Do subtract only on BG1

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #WOBJSEL_Setting(false, false, false, false, true, false, false, false)
        sta bBufferWOBJSEL

        lda #WBGLOG_Setting(WLOG_ORR, WLOG_ORR, WLOG_ORR, WLOG_ORR)
        sta bBufferWBGLOG

        lda #CGWSEL_Setting(false, false, CGWSEL_MathInside, CGWSEL_BlackNever)
        sta bBufferCGWSEL

        lda #CGADSUB_Setting(CGADSUB_Subtract, false, true, false, false, false, false, false)
        sta bBufferCGADSUB

        rep #$20

      rlWindowColorRedHDMACycle ; 85/9443

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      aWindowColorRedHDMACode ; 85/9444

        HDMA_HALT

      ; 85/9446

      endCode

    .endsection WindowColorHDMASection
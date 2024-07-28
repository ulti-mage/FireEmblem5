
  .weak

    rlProcEngineFindProc                          :?= address($829CEC)
    rlClearJoyNewInputs                           :?= address($839B7F)
    rlFadeOutByTimer                              :?= address($80ABC7)
    rlFadeInByTimer                               :?= address($80AB89)
    rlProcEngineCreateProc                        :?= address($829BF1)
    rlProcEngineFreeProc                          :?= address($829D11)
    rlDMAByStruct                                 :?= address($80AE2E)
    rlDMAByPointer                                :?= address($80AEF9)
    rlBlockCopy                                   :?= address($80B340)
    rlEnableVBlank                                :?= address($8082DA)
    rlDisableVBlank                               :?= address($8082E8)
    rlFillTilemapByWord                           :?= address($80E89F)
    rlHDMAArrayEngineCreateEntryByIndex           :?= address($82A470)
    rlFillTilemapRectByWord                       :?= address($80E91F)
    rlDrawMenuText                                :?= address($87E728)
    rlGetMenuTextLength                           :?= address($87E873)
    rlEnableBG3Sync                               :?= address($81B212)
    rlPlaySound                                   :?= address($808C87)
    procFadeWithCallback                          :?= address($82A1BB)
    rlDrawWindowBackgroundFromTilemapInfo         :?= address($87D6FC)
    g2bppMenuTiles                                :?= address($F3CC80)
    aGenericBG1TilemapInfo                        :?= address($83C0FF)
    g4bppUnitWindowBorderTiles                    :?= address($9F8DC0) ; needs a rename
    aUnitWindowUpperBackgroundPalettes            :?= address($9FA9C0)
    procRightFacingCursor                         :?= address($8EB06F)

    rlEnableRightFacingCursorAnimation            :?= address($8EB0BA)
    rlDisableRightFacingCursorAnimation           :?= address($8EB0C1)

    GuideMenuDataEnd    = $FFFE
    GuideMenuNoSubpage  = $FFFF

  .endweak



    GuideMenuConfig .namespace

      ; VRAM positions

        OAMBase = $0000
        BG1Base = $4000
        BG2Base = BG1Base
        BG3Base = $A000

        OAMTilesPosition := OAMBase
        OAMAllocate .function Size
          Return := GuideMenuConfig.OAMTilesPosition
          GuideMenuConfig.OAMTilesPosition += Size
        .endfunction Return

        BG12TilesPosition := BG1Base
        BG12Allocate .function Size
          Return := GuideMenuConfig.BG12TilesPosition
          GuideMenuConfig.BG12TilesPosition += Size
        .endfunction Return


        BG3TilesPosition := BG3Base
        BG3Allocate .function Size
          Return := GuideMenuConfig.BG3TilesPosition
          GuideMenuConfig.BG3TilesPosition += Size
        .endfunction Return


        BorderTilesPosition = BG12Allocate(16 * 3 * size(Tile4bpp))     ; $4000 - $4600

        BG3TilemapPosition = BG3Allocate(32 * 32 * size(word))          ; $A000 - $A800
        MenuTilesPosition = BG3Allocate(40 * 16 * size(Tile2bpp))       ; $A800 - $D000
        UnknownPosition = BG3Allocate($600)                             ; $D000 - $D600

        _ := BG12Allocate($E000 - BG12TilesPosition)
        BG1TilemapPosition = BG12Allocate(32 * 32 * size(word))         ; $E000 - $E800
        _ := BG12Allocate($F000 - BG12TilesPosition)
        BG2TilemapPosition = BG12Allocate(32 * 32 * size(word))         ; $F000 - end of VRAM

        MenuTilesBaseTile = VRAMToTile(MenuTilesPosition, BG3Base, size(Tile2bpp))

        BG12FillTile = TilemapEntry(VRAMToTile(BG1Base, BG1Base, size(Tile4bpp)) + C2I((15, 47)), 0, 0, false, false)

        BG3BlankTile = TilemapEntry(MenuTilesBaseTile + C2I((15, 21)), 0, 0, false, false)

        Body .namespace

          Base = (0, 4)

          Position  = Base
          Size      = (32, 24)

          Title .namespace

            Position  = Base + (2, 0)
            Size      = (8, 22)

          .endnamespace ; Title

          Description .namespace

            Position  = Base + (12, 0)
            Size      = (19, 23)

          .endnamespace ; Description

        .endnamespace ; Body

        ; Pixel coordinates:
        ScrollingArrowTitleUp         = (72, 32)
        ScrollingArrowTitleDown       = (72, 212)

        ScrollingArrowDescriptionUp   = (88, 32)
        ScrollingArrowDescriptionDown = (88, 212)

        DescriptionArrowPosition      = (80, 10)

    .endnamespace ; GuideMenuConfig


    .virtual $7EA937

      wGuideMenuDescriptionScrollOffset .word ?               ; $7EA937
      wGuideMenuDescriptionLineCount .word ?                  ; $7EA939
      wGuideMenuTitleScrollOffset .word ?                     ; $7EA93B
      wGuideMenuDataPointer .word ?                           ; $7EA93D
      wGuideMenuTitleScrollPosition .word ?                   ; $7EA93F
      wGuideMenuCursorProcIndex .word ?                       ; $7EA941
      wGuideMenuMainOptionCounter .word ?                     ; $7EA943
      .word ?                                                 ; $7EA945
      wGuideMenuInputIndex .word ?                            ; $7EA947
      aGuideMenuParentOptionDataBuffer .brept 8               ; $7EA949
        TitleScrollPosition .word ?
        TitleScrollOffset .word ?
        OptionDataOffset .word ?
      .endrept
      wGuideMenuParentSettingDataOffset .word ?               ; $7EA979
      wGuideMenuTitleScrollArrowUpProcIndex .word ?           ; $7EA97B
      wGuideMenuTitleScrollArrowDownProcIndex .word ?         ; $7EA97D
      wGuideMenuDescriptionScrollArrowUpProcIndex .word ?     ; $7EA97F
      wGuideMenuDescriptionScrollArrowDownProcIndex .word ?   ; $7EA981
      wGuideMenuDescriptionArrowSpriteIndex .word ?           ; $7EA983

    .endvirtual


    structGuideMenuDataEntry .struct Description, Title, Preview
      .word <>\Description
      .word <>\Title
      .word <>\Preview
    .endstruct


    .section GuideMenuSection

      .with GuideMenuConfig

      procGuideMenu .structProcInfo "xx", None, None, aProcGuideMenuCode ; 91/8012

      aProcGuideMenuCode ; 91/801A
      
        PROC_CALL_ARGS rlSetFadeTimer, size(+)
        + .block
          .byte 1
        .bend

        -
        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_FALSE -, rlWaitForFadeOut

        PROC_CALL rlBuildGuideMenu

        PROC_CALL_ARGS rlSetFadeTimer, size(+)
        + .block
          .byte 1
        .bend

        -
        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_FALSE -, rlWaitForFadeIn

        PROC_SET_ONCYCLE rlHandleGuideMenuInputs

        PROC_YIELD 1
        PROC_SET_ONCYCLE None
      
        PROC_HALT
      
      rlHandleGuideMenuInputs ; 91/804B
    
        .al
        .autsiz
        .databank ?
    
        stz aProcSystem.aHeaderSleepTimer,b,x

        lda wGuideMenuInputIndex
        asl a
        tax
        jsr (aGuideMenuInputRoutines,x)
        rtl 
    
        .databank 0

      aGuideMenuInputRoutines .binclude "../TABLES/GuideMenuActions.csv.asm" ; 91/8058

      rsGuideMenuDescriptionInputHandler ; 91/805C
    
        .al
        .autsiz
        .databank ?
    
        lda wJoy1New
        bit #(JOY_B | JOY_Left)
        beq +

          ; Exit description

          jsr rsGuideMenuSwitchToTitleInput
          jsr rsGuideMenuEnableDescriptionArrowSpriteModifications

          lda #33
          jsl rlPlaySound

          jsr rsGuideMenuDrawPreview
          bra _End

        ; Continue with description inputs
        +
        jsr rsGuideMenuHandleDescriptionScrolling

        _End
        rts
    
        .databank 0

      rsGuideMenuTitleInputHandler ; 91/8079

        .al
        .autsiz
        .databank ?

        lda wJoy1Repeated
        bit #JOY_Up
        bne _UpPress

        bit #JOY_Down
        bne _DownPress

        lda wJoy1New
        bit #(JOY_Right | JOY_A)
        bne _RightOrAPress

        bit #(JOY_B | JOY_Left)
        bne _LeftOrBPress

        bit #JOY_Start
        bne _StartPress

        _End
        jsr rsGuideMenuUpdateTitleDataIfScrolling
        rts 

        _UpPress
        lda wGuideMenuTitleScrollPosition
        beq _End

          dec a
          sta wGuideMenuTitleScrollPosition

          lda #9
          jsl rlPlaySound

          jsr rsGuideMenuDrawPreview
          jsr rsGuideMenuEnableDescriptionArrowSpriteModifications
          bra _End

        _DownPress
        lda wGuideMenuTitleScrollPosition
        inc a
        cmp wGuideMenuMainOptionCounter
        beq _End

          sta wGuideMenuTitleScrollPosition

          lda #9
          jsl rlPlaySound

          jsr rsGuideMenuDrawPreview
          jsr rsGuideMenuEnableDescriptionArrowSpriteModifications
          bra _End

        _RightOrAPress
        jsr rsGuideMenuHandleTitleRightOrAPress
        bra _End

        _LeftOrBPress
        jsr rsGuideMenuHandleTitleLeftOrBPress
        bra _End

        _StartPress   
        ldx aProcSystem.wOffset,b  
        stz aProcSystem.aHeaderSleepTimer,b,x
        jsl rlProcEngineFreeProc

        jsr rsCloseGuideMenu
        bra _End

        .databank 0

      rsCloseGuideMenu ; 91/80EB

        .al
        .autsiz
        .databank ?

        lda #33
        jsl rlPlaySound

        lda #<>$809D0F
        sta aProcSystem.wInput0,b

        lda #(`procFadeWithCallback)<<8
        sta lR44+1
        lda #<>procFadeWithCallback
        sta lR44
        jsl rlProcEngineCreateProc
        rts 

        .databank 0

      rlBuildGuideMenu ; 91/8107

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aBG1TilemapBuffer
        pha
        rep #$20
        plb

        jsl rlDisableVBlank

        sep #$20
        lda #INIDISP_Setting(true, 0)
        sta bBufferINIDISP
        rep #$20

        sep #$20
        lda #INIDISP_Setting(true, 0)
        sta INIDISP,b
        rep #$20

        lda #<>aBG1TilemapBuffer
        sta wR0
        lda #BG12FillTile
        jsl rlFillTilemapByWord

        lda #<>aBG2TilemapBuffer
        sta wR0
        lda #BG12FillTile
        jsl rlFillTilemapByWord

        lda #<>aBG3TilemapBuffer
        sta wR0
        lda #BG3BlankTile
        jsl rlFillTilemapByWord

        lda #<>aGenericBG1TilemapInfo
        sta aCurrentTilemapInfo.lInfoPointer,b
        lda #>`aGenericBG1TilemapInfo
        sta aCurrentTilemapInfo.lInfoPointer+1,b

        lda lWindowBackgroundPatternPointer
        sta lR18
        lda lWindowBackgroundPatternPointer+1
        sta lR18+1

        lda #TilemapEntry($000, 1, false, false, false)
        sta aCurrentTilemapInfo.wBaseTile,b
        jsl rlDrawWindowBackgroundFromTilemapInfo

        lda #(`aBGPaletteBuffer.aPalette2)<<8
        sta lR18+1
        lda #<>aBGPaletteBuffer.aPalette2
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette1)<<8  
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette1
        sta lR19
        lda #size(Palette)
        sta lR20
        jsl rlBlockCopy

        jsl rlDMAByStruct
          .structDMAToVRAM g4bppUnitWindowBorderTiles, (16 * 3 * size(Tile4bpp)), VMAIN_Setting(true), BorderTilesPosition

        lda #(`aUnitWindowUpperBackgroundPalettes)<<8
        sta lR18+1
        lda #<>aUnitWindowUpperBackgroundPalettes
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette2)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette2
        sta lR19
        lda #size(Palette) * 2
        sta lR20
        jsl rlBlockCopy

        jsl rlDMAByStruct
          .structDMAToVRAM aBG1TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), BG1TilemapPosition

        jsl rlDMAByStruct
          .structDMAToVRAM aBG2TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), BG2TilemapPosition

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), BG3TilemapPosition

        jsl rlGuideMenuDMATextGraphics

        lda #BorderTilesPosition >> 1
        sta wR0
        lda #BG12FillTile
        ldx #1
        jsl rlClearVRAMTilemapEntry

        lda #BG3TilemapPosition >> 1
        sta wR0
        lda #BG3BlankTile
        ldx #0
        jsl rlClearVRAMTilemapEntry

        jsr rsGuideMenuSetTextPalette

        jsl rlInitiateWindowColorHDMAs

        lda #Body.Position[1]
        sta wR0
        lda #Body.Size[1]
        sta wR1
        jsl rlSetWindowColorHDMAAreaByTiles
        jsl rlEnableWindowColorHDMA

        sep #$20
        lda #T_Setting(true, true, true, false, true)
        sta bBufferTM

        lda #T_Setting(false, false, false, false, false)
        sta bBufferTS

        lda #CGWSEL_Setting(false, false, CGWSEL_MathAlways, CGWSEL_BlackNever)
        sta bBufferCGWSEL

        lda #CGADSUB_Setting(CGADSUB_Subtract, false, true, false, false, false, false, false)
        sta bBufferCGADSUB

        lda #2
        sta wJoyRepeatInterval
        rep #$20

        stz wBufferBG1HOFS
        stz wBufferBG2HOFS
        stz wBufferBG3HOFS

        stz wBufferBG1VOFS
        stz wBufferBG2VOFS
        stz wBufferBG3VOFS

        jsr rsPopulateGuideMenu

        lda #(`aGuideMenuDescriptionArrowData)<<8
        sta lR44+1
        lda #<>aGuideMenuDescriptionArrowData
        sta lR44
        jsl $81822E

        txa
        sta wGuideMenuDescriptionArrowSpriteIndex

        sep #$20
        lda #INIDISP_Setting(false, 0)
        sta bBufferINIDISP
        rep #$20

        sep #$20
        lda #INIDISP_Setting(false, 0)
        sta INIDISP,b
        rep #$20

        jsl rlEnableVBlank

        plp
        plb
        rtl 

        .databank 0

      rsGuideMenuSetTextPalette ; 91/8267
    
        .al
        .autsiz
        .databank ?

        lda #(`aGuideMenuTextPalette)<<8
        sta lR18+1
        lda #<>aGuideMenuTextPalette
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette0)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette0
        sta lR19
        lda #size(Palette)
        sta lR20
        jsl rlBlockCopy
        rts 

        .databank 0

      aGuideMenuTextPalette ; 91/8285

        .word $57D4 
        .word $35AD 
        .word $7FFF 
        .word $0421 
        .word $0000 
        .word $11A3 
        .word $6FFB 
        .word $00C0 
        .word $0000 
        .word $5102 
        .word $7FB8 
        .word $1C63 
        .word $0000 
        .word $086F 
        .word $6F5F 
        .word $0844 

      rsPopulateGuideMenu ; 91/82A5
    
        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`wGuideMenuDescriptionScrollOffset
        pha
        rep #$20
        plb

        .databank `wGuideMenuDescriptionScrollOffset

        stz wGuideMenuDescriptionScrollOffset
        stz wGuideMenuTitleScrollOffset
        stz wGuideMenuTitleScrollPosition

        lda #<>aGuideMenuData
        sta @l wGuideMenuDataPointer

        stz wGuideMenuParentSettingDataOffset
        stz wGuideMenuInputIndex

        jsr rsGuideMenuCountMainOptions
        jsr rsGuideMenuCreateRightFacingCursor
        jsr rsGuideMenuPrepareTitles
        jsr rsGuideMenuDisplayTitles
        jsr rsGuideMenuProcScrollingArrow
        jsr rsGuideMenuDrawPreview

        plp
        plb
        rts 

        .databank 0

      rsGuideMenuProcScrollingArrow ; 91/82DA
    
        .al
        .autsiz
        .databank ?

        macroFindAndFreeProc procGuideMenuScrollingArrows

        lda #(`procGuideMenuScrollingArrows)<<8
        sta lR44+1
        lda #<>procGuideMenuScrollingArrows
        sta lR44
        jsl rlProcEngineCreateProc
        rts 

        .databank 0

      procGuideMenuScrollingArrows .structProcInfo "xx", rlGuideMenuScrollingArrowsInit, rlGuideMenuScrollingArrowsCycle, None ; 91/8306

      rlGuideMenuScrollingArrowsInit ; 91/830E

        .al
        .autsiz
        .databank ?

        jsr rsGuideMenuScrollingArrowsSetup

        .databank 0

      rlGuideMenuScrollingArrowsCycle ; 91/8311

        .al
        .autsiz
        .databank ?

        jsr rsGuideMenuHandleScrollingArrowsVisibility
        rtl

        .databank 0

      rsGuideMenuScrollingArrowsSetup ; 91/8315
    
        .al
        .autsiz
        .databank ?

        lda #ScrollingArrowTitleUp[0]
        sta wR0
        lda #ScrollingArrowTitleUp[1]
        sta wR1
        jsl $83CB26
        sta wGuideMenuTitleScrollArrowUpProcIndex

        lda #ScrollingArrowTitleDown[0]
        sta wR0
        lda #ScrollingArrowTitleDown[1]
        sta wR1
        jsl $83CB53
        sta wGuideMenuTitleScrollArrowDownProcIndex

        lda #ScrollingArrowDescriptionUp[0]
        sta wR0
        lda #ScrollingArrowDescriptionUp[1]
        sta wR1
        jsl $83CB26
        sta wGuideMenuDescriptionScrollArrowUpProcIndex

        lda #ScrollingArrowDescriptionDown[0]
        sta wR0
        lda #ScrollingArrowDescriptionDown[1]
        sta wR1
        jsl $83CB53
        sta wGuideMenuDescriptionScrollArrowDownProcIndex

        rts 

        .databank 0

      rsGuideMenuHandleScrollingArrowsVisibility ; 91/835E
    
        .al
        .autsiz
        .databank ?

        ; Disable visibility of all scrolling arrows 

        lda wGuideMenuTitleScrollArrowUpProcIndex
        tax
        lda #-1
        sta aProcSystem.aBody5,b,x

        lda wGuideMenuTitleScrollArrowDownProcIndex
        tax
        lda #-1
        sta aProcSystem.aBody5,b,x

        lda wGuideMenuDescriptionScrollArrowUpProcIndex
        tax
        lda #-1
        sta aProcSystem.aBody5,b,x

        lda wGuideMenuDescriptionScrollArrowDownProcIndex
        tax
        lda #-1
        sta aProcSystem.aBody5,b,x

        lda wGuideMenuInputIndex
        bne _Description

        lda wGuideMenuTitleScrollOffset
        beq +

        ; Enable up scrolling arrow if not all top titles are on screen

        lda wGuideMenuTitleScrollArrowUpProcIndex
        tax
        lda #0
        sta aProcSystem.aBody5,b,x

        jsr rsGuideMenuUpdateTitleScrollArrowUpSpinSpeed

        +
        lda wGuideMenuTitleScrollOffset
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        inc a
        clc
        adc wGuideMenuMainOptionCounter
        clc
        adc wGuideMenuMainOptionCounter
        sec
        sbc #Body.Title.Size[1]
        beq _End
        bcc _End

        ; Enable down scroll arrow if not all lower titles are on screen

        lda wGuideMenuTitleScrollArrowDownProcIndex
        tax
        lda #0
        sta aProcSystem.aBody5,b,x

        jsr rsGuideMenuUpdateTitleScrollArrowDownSpinSpeed
        
        _End
        rts 

        _Description
        lda wGuideMenuDescriptionScrollOffset
        beq +

        ; Enable up scrolling arrow if not all top descriptions are on screen

        lda wGuideMenuDescriptionScrollArrowUpProcIndex
        tax
        lda #0
        sta aProcSystem.aBody5,b,x

        jsr rsGuideMenuUpdateDescriptionScrollArrowUpSpinSpeed
        
        +
        lda wGuideMenuDescriptionScrollOffset
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        inc a
        clc
        adc wGuideMenuDescriptionLineCount
        clc
        adc wGuideMenuDescriptionLineCount
        sec
        sbc #Body.Description.Size[1]
        beq _End
        bcc _End

        ; Enable down scroll arrow if not all lower descriptions are on screen

        lda wGuideMenuDescriptionScrollArrowDownProcIndex
        tax
        lda #0
        sta aProcSystem.aBody5,b,x

        jsr rsGuideMenuUpdateDescriptionScrollArrowDownSpinSpeed
        rts 

        .databank 0

      rsGuideMenuUpdateTitleScrollArrowUpSpinSpeed ; 91/8410
    
        .al
        .autsiz
        .databank ?

        ; Sets the scrolling arrow spin speed to be faster if you are close to the top and
        ; are scrolling up.

        lda #2
        sta aProcSystem.aBody3,b,x

        lda wJoy1Input
        bit #JOY_Up
        beq _End

          lda wGuideMenuTitleScrollOffset
          lsr a
          lsr a
          lsr a
          sec
          sbc wGuideMenuTitleScrollPosition
          bne _End

            lda #8
            sta aProcSystem.aBody3,b,x

        _End
        rts 

      rsGuideMenuUpdateTitleScrollArrowDownSpinSpeed ; 91/8432
    
        .al
        .autsiz
        .databank ?

        ; Sets the scrolling arrow spin speed to be faster if you are close to the bottom and
        ; are scrolling down.

        lda #2
        sta aProcSystem.aBody3,b,x

        lda wJoy1Input
        bit #JOY_Down
        beq _End

          lda wGuideMenuTitleScrollOffset
          lsr a
          lsr a
          lsr a
          sec
          sbc wGuideMenuTitleScrollPosition
          cmp #Body.Title.Size[1]
          bne _End

            lda #8
            sta aProcSystem.aBody3,b,x

        _End
        rts 

        .databank 0

      rsGuideMenuUpdateDescriptionScrollArrowUpSpinSpeed ; 91/8457
    
        .al
        .autsiz
        .databank ?

        ; Sets the scrolling arrow spin speed to be faster if you are are scrolling up.

        lda #2
        sta aProcSystem.aBody3,b,x

        lda wJoy1Input
        bit #JOY_Up
        beq +

          lda #8
          sta aProcSystem.aBody3,b,x

        +
        rts 

        .databank 0

      rsGuideMenuUpdateDescriptionScrollArrowDownSpinSpeed ; 91/846B
    
        .al
        .autsiz
        .databank ?

        ; Sets the scrolling arrow spin speed to be faster if you are are scrolling down.

        lda #2
        sta aProcSystem.aBody3,b,x

        lda wJoy1Input
        bit #JOY_Down
        beq +

          lda #8
          sta aProcSystem.aBody3,b,x

        +
        rts 

        .databank 0

      rsGuideMenuCountMainOptions ; 91/847F
    
        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aGuideMenuData
        pha
        rep #$20
        plb

        .databank `aGuideMenuData

        lda #0
        sta wGuideMenuMainOptionCounter

        lda wGuideMenuDataPointer
        tax

        _Loop
        lda $0000,b,x
        cmp #GuideMenuDataEnd
        beq +

          lda wGuideMenuMainOptionCounter
          inc a
          sta wGuideMenuMainOptionCounter

          txa
          clc
          adc #size(structGuideMenuDataEntry)
          tax
          bra _Loop

        +
        lda wGuideMenuMainOptionCounter
        dec a
        cmp wGuideMenuTitleScrollPosition
        bcs +

          sta wGuideMenuTitleScrollPosition

        +
        plp
        plb
        rts 

        .databank 0

      rsGuideMenuDrawPreview ; 91/84C0
    
        .al
        .autsiz
        .databank ?

        phb 
        php
        sep #$20
        lda #`aGuideMenuData
        pha
        rep #$20
        plb

        .databank `aGuideMenuData

        jsr rsGuideMenuClearDescriptionPreview

        lda wGuideMenuTitleScrollPosition
        asl a
        clc
        adc wGuideMenuTitleScrollPosition
        asl a
        clc
        adc wGuideMenuDataPointer
        tay

        lda $0004,b,y
        beq _End

          inc a
          inc a 
          sta lR18

          jsr rsGuideMenuPrepareDescription
          jsr rsGuideMenuDisplayDescription

        _End
        plp
        plb
        rts 

        .databank 0

      rsGuideMenuHandleTitleRightOrAPress ; 91/84F0
    
        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aGuideMenuData
        pha
        rep #$20
        plb

        .databank `aGuideMenuData

        lda wGuideMenuTitleScrollPosition
        asl a
        clc
        adc wGuideMenuTitleScrollPosition
        asl a
        clc
        adc wGuideMenuDataPointer
        tay

        ; Check if the option we are on even has a description

        lda $0000,b,y
        beq _End

        ; Has one. Check for subpage

        tay
        lda $0000,b,y
        cmp #GuideMenuNoSubpage
        beq _NoSubpage

        phy
        jsr rsGuideMenuSaveParentOptionSettings

        pla
        sta wGuideMenuDataPointer
        jsr rsGuideMenuCountMainOptions

        lda #0
        sta wGuideMenuTitleScrollOffset
        lda #0
        sta wGuideMenuTitleScrollPosition

        jsr rsGuideMenuPrepareTitles
        jsr rsGuideMenuDisplayTitles
        jsr rsGuideMenuDrawPreview
        jsr rsGuideMenuEnableDescriptionArrowSpriteModifications
        bra +

        _NoSubpage
        tya
        inc a
        inc a
        sta lR18

        jsr rsGuideMenuPrepareDescription
        jsr rsGuideMenuDisplayDescription

        lda wGuideMenuDescriptionLineCount
        asl a
        cmp #Body.Description.Size[1]
        beq _OnePageDescription
        bcc _OnePageDescription

        ; Description is too long so, so switch to the input handler that can scroll it
        jsr rsGuideMenuSwitchToDescriptionStatus
        jsr rsGuideMenuEnableDescriptionArrowSpriteModifications

        +
        lda #13
        jsl rlPlaySound

        _End
        plp
        plb
        rts

        _OnePageDescription
        jsr rsGuideMenuHideDescriptionArrowSprite
        bra _End

      rsGuideMenuHandleTitleLeftOrBPress ; 91/856D
    
        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aGuideMenuData
        pha
        rep #$20
        plb

        .databank `aGuideMenuData

        jsr rsGuideMenuLoadParentOptionSettings
        bcs _NoParentOption

          jsr rsGuideMenuCountMainOptions
          jsr rsGuideMenuPrepareTitles
          jsr rsGuideMenuDisplayTitles
          jsr rsGuideMenuDrawPreview
          jsr rsGuideMenuEnableDescriptionArrowSpriteModifications

          lda #33
          jsl rlPlaySound

        _NoParentOption
        plp
        plb
        rts 

        .databank 0

      rsGuideMenuPrepareTitles ; 91/8595
    
        .al
        .autsiz
        .databank ?

        ; Writes all the titles to the aBG1TilemapBuffer

        phb
        php
        sep #$20
        lda #`aGuideMenuData
        pha
        rep #$20
        plb

        .databank `aGuideMenuData

        lda #(`$918009)<<8
        sta aCurrentTilemapInfo.lInfoPointer+1,b
        lda #<>$918009
        sta aCurrentTilemapInfo.lInfoPointer,b

        lda #$2080
        sta aCurrentTilemapInfo.wBaseTile,b

        jsr rsGuideMenuClearTitles

        sep #$20
        lda #`aGuideMenuData
        sta lR18+2
        rep #$20

        ldx #0

        lda wGuideMenuDataPointer
        tay

          _Loop
          lda $0000,b,y
          cmp #GuideMenuDataEnd
          beq _End

            lda $0002,b,y
            sta lR18
            jsl rlDrawMenuText

            txa
            clc
            adc #pack([0, 2])
            tax

            tya
            clc
            adc #size(structGuideMenuDataEntry)
            tay
            bra _Loop

        _End
        plp
        plb
        rts 

        .databank 0

      rsGuideMenuClearTitles ; 91/85E6

        .al
        .autsiz
        .databank ?

        lda #<>aBG1TilemapBuffer
        sta wR0

        lda #Body.Title.Size[0]
        sta wR1
        lda #32
        sta wR2

        lda #BG3BlankTile
        jsl rlFillTilemapRectByWord
        rts 

        .databank 0

      rsGuideMenuDisplayTitles ; 91/85FD
    
        .al
        .autsiz
        .databank ?

        ; Copies the aBG1TilemapBuffer titles to the aBG3TilemapBuffer and displays them.

        phb
        php
        sep #$20
        lda #`aGuideMenuData
        pha
        rep #$20
        plb

        .databank `aGuideMenuData

        lda wGuideMenuTitleScrollOffset
        and #$FFF8
        asl a
        asl a
        asl a
        clc
        adc #<>aBG1TilemapBuffer
        sta lR18

        sep #$20
        lda #`aBG1TilemapBuffer
        sta lR18+2
        rep #$20

        lda #(`aBG3TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer
        sta lR19

        lda #Body.Title.Position[0]
        sta wR0
        lda #Body.Title.Position[1]
        sta wR1
        lda #Body.Title.Size[0]
        sta wR2
        lda #Body.Title.Size[1]
        sta wR3
        jsl rlCopyPackedTilemapSlice

        jsl rlEnableBG3Sync

        plp
        plb
        rts 

        .databank 0

      rsGuideMenuPrepareDescription ; 91/8648
    
        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aGuideMenuData
        pha
        rep #$20
        plb

        .databank `aGuideMenuData

        lda #0
        sta wGuideMenuDescriptionScrollOffset

        lda lR18
        pha

        jsr rsGuideMenuClearDescriptionPreview

        pla
        sta lR18

        lda #(`$918000)<<8
        sta aCurrentTilemapInfo.lInfoPointer+1,b
        lda #<>$918000
        sta aCurrentTilemapInfo.lInfoPointer,b

        lda #$2080
        sta aCurrentTilemapInfo.wBaseTile,b

        sep #$20
        lda #`aGuideMenuData
        sta lR18+2
        rep #$20

        lda lR18
        pha

        ldx #pack([0, 0])
        jsl rlGuideMenuPrepareDescriptionText

        pla
        sta lR18

        jsl rlGuideMenuCountDescriptionLines

        lda wR0
        sta wGuideMenuDescriptionLineCount

        plp
        plb
        rts 

        .databank 0

      rsGuideMenuClearDescriptionPreview ; 91/8696
    
        .al
        .autsiz
        .databank ?

        lda #<>aBG1TilemapBuffer + $10
        sta wR0

        lda #Body.Description.Size[0]
        sta wR1
        lda #32 * 2
        sta wR2

        lda #BG3BlankTile
        jsl rlFillTilemapRectByWord
        rts 

        .databank 0

      rsGuideMenuDisplayDescription ; 91/86AD
    
        .al
        .autsiz
        .databank ?

        ; Copies the aBG1TilemapBuffer description to the aBG3TilemapBuffer and displays it.

        phb
        php

        sep #$20
        lda #`aGuideMenuData
        pha
        rep #$20
        plb

        .databank `aGuideMenuData

        lda wGuideMenuDescriptionScrollOffset
        and #$FFF8
        asl a
        asl a
        asl a
        clc
        adc #<>aBG1TilemapBuffer + $10
        sta lR18

        sep #$20
        lda #`aBG1TilemapBuffer
        sta lR18+2
        rep #$20

        lda #(`aBG3TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer
        sta lR19

        lda #Body.Description.Position[0]
        sta wR0
        lda #Body.Description.Position[1]
        sta wR1
        lda #Body.Description.Size[0]
        sta wR2
        lda #Body.Description.Size[1]
        sta wR3
        jsl rlCopyPackedTilemapSlice

        jsl rlEnableBG3Sync

        plp
        plb
        rts 

        .databank 0

      rsGuideMenuCreateRightFacingCursor ; 91/86F8
    
        .al
        .autsiz
        .databank ?

        lda wGuideMenuTitleScrollPosition
        jsr rsGuideMenuGetCursorPosition

        lda #(`procRightFacingCursor)<<8
        sta lR44+1
        lda #<>procRightFacingCursor
        sta lR44
        jsl rlProcEngineCreateProc
        sta wGuideMenuCursorProcIndex
        rts 

        .databank 0

      rsGuideMenuUpdateTitleRightFacingCursor ; 91/8712
    
        .al
        .autsiz
        .databank ?

        lda wGuideMenuTitleScrollPosition
        jsr rsGuideMenuGetCursorPosition

        lda wGuideMenuCursorProcIndex
        tax
        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody1,b,x
        rts 

        .databank 0

      rsGuideMenuUpdateTitleDataIfScrolling ; 91/872B
    
        .al
        .autsiz
        .databank ?

        jsr rsGuideMenuUpdateTitlesScrollingUp
        jsr rsGuideMenuUpdateTitlesScrollingDown

        lda wGuideMenuTitleScrollOffset
        bit #$0008
        bne +

          jsr rsGuideMenuUpdateTitleRightFacingCursor

        +
        rts 

        .databank 0

      rsGuideMenuUpdateTitlesScrollingUp ; 91/873E
    
        .al
        .autsiz
        .databank ?

        lda wGuideMenuTitleScrollOffset
        beq _End

          lda wGuideMenuTitleScrollOffset
          clc
          adc #8
          lsr a
          lsr a
          lsr a
          lsr a
          eor #$FFFF
          inc a
          clc
          adc wGuideMenuTitleScrollPosition
          bne _End

            ; Needs to scroll up
            lda wGuideMenuTitleScrollOffset
            sec
            sbc #8
            sta wGuideMenuTitleScrollOffset
            jsr rsGuideMenuDisplayTitles

        _End
        rts 

        .databank 0

      rsGuideMenuUpdateTitlesScrollingDown ; 91/876B
    
        .al
        .autsiz
        .databank ?

        lda wGuideMenuTitleScrollPosition
        inc a
        cmp wGuideMenuMainOptionCounter
        beq _End

          lda wGuideMenuTitleScrollOffset
          lsr a
          lsr a
          lsr a
          lsr a
          eor #$FFFF
          inc a
          clc
          adc wGuideMenuTitleScrollPosition
          cmp #(Body.Title.Size[1] / 2) - 1
          bne _End

            ; Needs to scroll down
            lda wGuideMenuTitleScrollOffset
            clc
            adc #8
            sta wGuideMenuTitleScrollOffset
            jsr rsGuideMenuDisplayTitles

        _End
        rts 

        .databank 0

      rsGuideMenuGetCursorPosition ; 91/879C
    
        .al
        .autsiz
        .databank ?

        ; Handles cursor and description arrow

        ; A = Y pos

        asl a
        clc
        adc #Body.Position[1]
        asl a
        asl a
        asl a
        sec
        sbc wGuideMenuTitleScrollOffset
        sta aProcSystem.wInput1,b

        lda #Body.Position[0]
        sta aProcSystem.wInput0,b

        rts

        .databank 0

      rsGuideMenuSaveParentOptionSettings ; 91/87B3
    
        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`wGuideMenuParentSettingDataOffset
        pha
        rep #$20
        plb

        .databank `wGuideMenuParentSettingDataOffset

        phx
        ldx wGuideMenuParentSettingDataOffset
        lda @l wGuideMenuTitleScrollPosition
        sta @l aGuideMenuParentOptionDataBuffer[0].TitleScrollPosition,x
        lda @l wGuideMenuTitleScrollOffset
        sta @l aGuideMenuParentOptionDataBuffer[0].TitleScrollOffset,x
        lda @l wGuideMenuDataPointer
        sta @l aGuideMenuParentOptionDataBuffer[0].OptionDataOffset,x

        lda @l wGuideMenuParentSettingDataOffset
        clc
        adc #size(aGuideMenuParentOptionDataBuffer[0])
        sta @l wGuideMenuParentSettingDataOffset
        plx

        plp
        plb
        rts

        .databank 0

      rsGuideMenuLoadParentOptionSettings ; 91/87E9
    
        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`wGuideMenuParentSettingDataOffset
        pha
        rep #$20
        plb

        .databank `wGuideMenuParentSettingDataOffset

        phx
        lda @l wGuideMenuParentSettingDataOffset
        beq +

          sec
          sbc #size(aGuideMenuParentOptionDataBuffer[0])
          sta @l wGuideMenuParentSettingDataOffset

          tax
          lda @l aGuideMenuParentOptionDataBuffer[0].TitleScrollPosition,x
          sta @l wGuideMenuTitleScrollPosition
          lda @l aGuideMenuParentOptionDataBuffer[0].TitleScrollOffset,x
          sta @l wGuideMenuTitleScrollOffset
          lda @l aGuideMenuParentOptionDataBuffer[0].OptionDataOffset,x
          sta @l wGuideMenuDataPointer
          plx
          plp
          plb
          clc
          rts 

        +
        plx
        plp
        plb
        sec
        rts 

        .databank 0

      rsGuideMenuHandleDescriptionScrolling ; 91/8825
    
        .al
        .autsiz
        .databank ?

        lda wJoy1Repeated
        bit #JOY_Up
        bne _UpPress
        
        bit #JOY_Down
        bne _DownPress

        rts

        _UpPress
        lda wGuideMenuDescriptionScrollOffset
        beq +

          lda wGuideMenuDescriptionScrollOffset
          sec
          sbc #8
          sta wGuideMenuDescriptionScrollOffset
          jsr rsGuideMenuDisplayDescription

        +
        rts 

        _DownPress
        lda wGuideMenuDescriptionScrollOffset
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        inc a
        clc
        adc wGuideMenuDescriptionLineCount
        clc
        adc wGuideMenuDescriptionLineCount
        cmp #Body.Description.Size[1]
        beq +
        bcc +

          lda wGuideMenuDescriptionScrollOffset
          clc
          adc #8
          sta wGuideMenuDescriptionScrollOffset
          jsr rsGuideMenuDisplayDescription

        +
        rts 

        .databank 0

      rlGuideMenuCountDescriptionLines ; 91/8874
    
        .al
        .autsiz
        .databank ?

        ; Outputs: 
        ; wR0 = count

        phb
        php

        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

        stz wR0

        ldx lR18
        dec x
        dec x

        _Loop
        ; Check for end of a text string
        inc x
        inc x
        lda $0000,b,x
        bne _Loop

          ; Check if appending more text or not 
          lda $0002,b,x
          cmp #$FFFF
          bne +

            inc x
            inc x
            bra _Loop

          ; If not appending text it's a new line, check for end of description

          +
          inc wR0
          lda $0002,b,x
          bne _Loop

        plp
        plb
        rtl 

        .databank 0

      rsGuideMenuSwitchToDescriptionStatus ; 91/88A1
    
        .al
        .autsiz
        .databank ?

        lda #aGuideMenuInputRoutines.Description
        sta wGuideMenuInputIndex

        lda wGuideMenuCursorProcIndex
        tax
        jsl rlDisableRightFacingCursorAnimation

        sep #$20
        lda #1
        sta wJoyRepeatInterval
        rep #$20

        rts 

        .databank 0

      rsGuideMenuSwitchToTitleInput ; 91/88BA
    
        .al
        .autsiz
        .databank ?

        lda #aGuideMenuInputRoutines.Title
        sta wGuideMenuInputIndex

        lda wGuideMenuCursorProcIndex
        tax
        jsl rlEnableRightFacingCursorAnimation

        sep #$20
        lda #2
        sta wJoyRepeatInterval
        rep #$20
        rts 

        .databank 0

      rlGuideMenuDMATextGraphics ; 91/88D3
    
        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct
          .structDMAToVRAM g2bppMenuTiles, (40 * 16 * size(Tile2bpp)), VMAIN_Setting(true), MenuTilesPosition

        jsl rlDMAByStruct
          .structDMAToVRAM aDecompressionBuffer, $0600, VMAIN_Setting(true), UnknownPosition

        rtl

        .databank 0

      rsGuideMenuHideDescriptionArrowSprite ; 91/88EE
    
        .al
        .autsiz
        .databank ?

        phx
        lda wGuideMenuDescriptionArrowSpriteIndex
        tax
        stz aActiveSpriteSystem.aCodeOffset,b,x
        stz aActiveSpriteSystem.aFrameOffset,b,x
        plx
        rts 

        .databank 0

      rsGuideMenuEnableDescriptionArrowSpriteModifications ; 91/88FC
    
        .al
        .autsiz
        .databank ?

        ; The routine to update the arrows' sprite checks for this.

        phx
        lda wGuideMenuDescriptionArrowSpriteIndex
        tax
        lda #1
        sta aActiveSpriteSystem.aUnknown000944,b,x 
        plx
        rts 

        .databank 0

      rsGuideMenuDisableDescriptionArrowSpriteModifications ; 91/890A
    
        .al
        .autsiz
        .databank ?

        phx
        lda wGuideMenuDescriptionArrowSpriteIndex
        tax
        lda #0
        sta aActiveSpriteSystem.aUnknown000944,b,x
        plx
        rts 

        .databank 0

      aGuideMenuDescriptionArrowData ; 91/8918

        ; This is the yellow arrow between the titles and descriptions, that only
        ; shows up when an option has a description or subpage

        .addr rlGuideMenuDescriptionArrowInit
        .addr rlGuideMenuDescriptionArrowCycle
        .addr aGuideMenuDescriptionArrowRightSpriteData

      rlGuideMenuDescriptionArrowInit ; 91/891E

        .al
        .autsiz
        .databank ?

        phx
        jsr rsGuideMenuEnableDescriptionArrowSpriteModifications
        jsl rlGuideMenuDescriptionArrowCycle
        plx
        rtl 

        .databank 0

      rlGuideMenuDescriptionArrowCycle ; 91/8928

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`aGuideMenuData
        pha
        rep #$20
        plb

        .databank `aGuideMenuData

        jsr rsGuideMenuUpdateDescriptionArrowPosition
        jsr rsGuideMenuHandleDescriptionArrowSpriteCode

        plp
        plb
        rtl 

        .databank 0

      rsGuideMenuUpdateDescriptionArrowPosition ; 91/893B

        .al
        .autsiz
        .databank ?

        lda wGuideMenuTitleScrollOffset
        bit #$0008
        bne _End

          lda wGuideMenuTitleScrollPosition
          jsr rsGuideMenuGetCursorPosition

          lda aProcSystem.wInput0,b
          clc
          adc #DescriptionArrowPosition[0]
          sta aActiveSpriteSystem.aXCoordinate,b,x

          lda aProcSystem.wInput1,b
          clc
          adc #DescriptionArrowPosition[1]
          sta aActiveSpriteSystem.aYCoordinate,b,x

        _End
        rts 

        .databank 0

      rsGuideMenuHandleDescriptionArrowSpriteCode ; 91/8960

        .al
        .autsiz
        .databank ?

        ; This determines what kind of sprite to display: the left one, the right one or none.

        lda wGuideMenuDescriptionArrowSpriteIndex
        tax
        lda aActiveSpriteSystem.aUnknown000944,b,x
        beq _End

        lda wGuideMenuInputIndex
        cmp #aGuideMenuInputRoutines.Description
        beq _OnDescription

        lda wGuideMenuTitleScrollPosition
        asl a
        clc
        adc wGuideMenuTitleScrollPosition
        asl a
        clc
        adc wGuideMenuDataPointer
        tay

        lda $0000,b,y
        beq _HasNoDescription
        bra _HasDescription
        
        _End
        jsr rsGuideMenuDisableDescriptionArrowSpriteModifications
        rts

        _HasNoDescription
        ldx aActiveSpriteSystem.wOffset,b
        stz aActiveSpriteSystem.aCodeOffset,b,x
        stz aActiveSpriteSystem.aFrameOffset,b,x
        bra _End

        ; If you are on a title and the option has a description, show a right facing arrow

        _HasDescription
        ldx aActiveSpriteSystem.wOffset,b
        lda #<>aGuideMenuDescriptionArrowRightSpriteData
        sta aActiveSpriteSystem.aCodeOffset,b,x

        lda #1
        sta aActiveSpriteSystem.aFrameTimer,b,x
        bra _End

        ; If you are on a description, show a left facing arrow

        _OnDescription
        ldx aActiveSpriteSystem.wOffset,b  
        lda #<>aGuideMenuDescriptionArrowLeftSpriteData
        sta aActiveSpriteSystem.aCodeOffset,b,x

        lda #1
        sta aActiveSpriteSystem.aFrameTimer,b,x
        bra _End

      aGuideMenuDescriptionArrowRightSpriteData ; 91/89BC

        -
        AS_Sprite 10, aGuideMenuDescriptionArrowRightSpriteDataFrame1
        AS_Sprite  3, aGuideMenuDescriptionArrowRightSpriteDataFrame2
        AS_Sprite  5, aGuideMenuDescriptionArrowRightSpriteDataFrame3
        AS_Sprite 10, aGuideMenuDescriptionArrowRightSpriteDataFrame4
        AS_Sprite  3, aGuideMenuDescriptionArrowRightSpriteDataFrame3
        AS_Sprite  5, aGuideMenuDescriptionArrowRightSpriteDataFrame2
        AS_Loop -


      aGuideMenuDescriptionArrowLeftSpriteData ; 91/89D7

        -
        AS_Sprite 10, aGuideMenuDescriptionArrowLeftSpriteDataFrame1
        AS_Sprite  3, aGuideMenuDescriptionArrowLeftSpriteDataFrame2
        AS_Sprite  5, aGuideMenuDescriptionArrowLeftSpriteDataFrame3
        AS_Sprite 10, aGuideMenuDescriptionArrowLeftSpriteDataFrame4
        AS_Sprite  3, aGuideMenuDescriptionArrowLeftSpriteDataFrame3
        AS_Sprite  5, aGuideMenuDescriptionArrowLeftSpriteDataFrame2
        AS_Loop -

      aGuideMenuDescriptionArrowRightSpriteDataFrame1 ; 91/89F2

        _Sprites := [[(   1,   -4), $0, SpriteSmall, C2I((13, 16)), 3, 4, false, false]]

        .structSpriteArray aGuideMenuDescriptionArrowRightSpriteDataFrame1._Sprites

      aGuideMenuDescriptionArrowRightSpriteDataFrame2 ; 91/89F9

        _Sprites := [[(   2,   -4), $0, SpriteSmall, C2I((13, 16)), 3, 4, false, false]]

        .structSpriteArray aGuideMenuDescriptionArrowRightSpriteDataFrame2._Sprites

      aGuideMenuDescriptionArrowRightSpriteDataFrame3 ; 91/8A00

        _Sprites := [[(   3,   -4), $0, SpriteSmall, C2I((13, 16)), 3, 4, false, false]]

        .structSpriteArray aGuideMenuDescriptionArrowRightSpriteDataFrame3._Sprites

      aGuideMenuDescriptionArrowRightSpriteDataFrame4 ; 91/8A07

        _Sprites := [[(   4,   -4), $0, SpriteSmall, C2I((13, 16)), 3, 4, false, false]]

        .structSpriteArray aGuideMenuDescriptionArrowRightSpriteDataFrame4._Sprites

      aGuideMenuDescriptionArrowLeftSpriteDataFrame1 ; 91/8A0E

        _Sprites := [[(   2,   -4), $0, SpriteSmall, C2I((13, 16)), 3, 4, true, false]]

        .structSpriteArray aGuideMenuDescriptionArrowLeftSpriteDataFrame1._Sprites

      aGuideMenuDescriptionArrowLeftSpriteDataFrame2 ; 91/8A15

        _Sprites := [[(   1,   -4), $0, SpriteSmall, C2I((13, 16)), 3, 4, true, false]]

        .structSpriteArray aGuideMenuDescriptionArrowLeftSpriteDataFrame2._Sprites

      aGuideMenuDescriptionArrowLeftSpriteDataFrame3 ; 91/8A1C

        _Sprites := [[(   0,   -4), $0, SpriteSmall, C2I((13, 16)), 3, 4, true, false]]

        .structSpriteArray aGuideMenuDescriptionArrowLeftSpriteDataFrame3._Sprites

      aGuideMenuDescriptionArrowLeftSpriteDataFrame4 ; 91/8A23

        _Sprites := [[(  -1,   -4), $0, SpriteSmall, C2I((13, 16)), 3, 4, true, false]]

        .structSpriteArray aGuideMenuDescriptionArrowLeftSpriteDataFrame4._Sprites

      rlGuideMenuPrepareDescriptionText ; 91/8A2A
    
        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        
        rep #$30
        lda wR17
        pha

        lda wR16
        pha

        lda wR15
        pha

        stz wR17
        
        lda aCurrentTilemapInfo.wBaseTile,b
        sta wR16
        phx

          ; wR17 is X/Y offset

          _Loop
          lda wR17
          clc
          adc #1,s
          tax
          jsr rsGuideMenuHandleDescriptionColors
          bcs _EndDescription

          jsl rlDrawMenuText
          jsr rsGuideMenuHandleDescriptionLineBreaks
          bra _Loop

        _EndDescription
        plx

        pla
        sta wR15

        pla
        sta wR16

        pla
        sta wR17

        plp
        plb
        rtl 

        .databank 0

      rsGuideMenuHandleDescriptionColors ; 91/8A62
    
        .al
        .autsiz
        .databank ?

        ; If the character is $1C01 or less, change the base tile index aka color and 
        ; get the text length for a potential append command.
        ; If entry is 0, end the description.
        ; Else, just draw the text

        lda wR16
        sta aCurrentTilemapInfo.wBaseTile,b

        lda [lR18]
        beq _EndDescription

        cmp #TM_Palette +1
        beq +
        bcs _DrawText

          ; Change the color

          +
          dec a
          ora wR16
          sta aCurrentTilemapInfo.wBaseTile,b
          inc lR18
          inc lR18
          jsl rlGetMenuTextLength
          sta wR15

        _DrawText
        clc
        rts 

        _EndDescription
        sec
        rts 

        .databank 0

      rsGuideMenuHandleDescriptionLineBreaks ; 91/8A86
    
        .al
        .autsiz
        .databank ?

        ; If $FFFF, append following text to line.
        ; Else, go to next line

        lda [lR18]
        cmp #$FFFF
        beq +

          lda wR17
          and #$FF00
          clc
          adc #pack([0,2])
          sta wR17
          rts

        +
        lda wR17
        clc
        adc wR15
        sta wR17

        inc lR18
        inc lR18
        rts 

        .databank 0

        .endwith ; GuideMenuConfig

    .endsection GuideMenuSection

    .section GuideMenuDataSection

      aGuideMenuData ; 91/8AA5

        .structGuideMenuDataEntry aGuideMenuDescriptionHowToOperate, aGuideMenuTitleHowToOperate, aGuideMenuPreviewHowToOperate
        .structGuideMenuDataEntry aGuideMenuDescriptionSaveAndLoad, aGuideMenuTitleSaveAndLoad, aGuideMenuPreviewSaveAndLoad
        .structGuideMenuDataEntry aGuideMenuDescriptionGameFlow, aGuideMenuTitleGameFlow, aGuideMenuPreviewGameFlow
        .structGuideMenuDataEntry aGuideMenuSubpageVictoryAndDefeat, aGuideMenuTitleVictoryAndDefeat, aGuideMenuPreviewVictoryAndDefeat
        .structGuideMenuDataEntry aGuideMenuDescriptionPreparationsMenu, aGuideMenuTitlePreparationsMenu, aGuideMenuPreviewPreparationsMenu
        .structGuideMenuDataEntry aGuideMenuSubpageUnitMenu, aGuideMenuTitleUnitMenu, aGuideMenuPreviewUnitMenu
        .structGuideMenuDataEntry aGuideMenuDescriptionMapMenu, aGuideMenuTitleMapMenu, aGuideMenuPreviewMapMenu
        .structGuideMenuDataEntry aGuideMenuDescriptionUnits, aGuideMenuTitleUnits, aGuideMenuPreviewUnits
        .structGuideMenuDataEntry aGuideMenuSubpageItems, aGuideMenuTitleItems, aGuideMenuPreviewItems
        .structGuideMenuDataEntry aGuideMenuDescriptionTerrain, aGuideMenuTitleTerrain, aGuideMenuPreviewTerrain
        .structGuideMenuDataEntry aGuideMenuDescriptionShops, aGuideMenuTitleShops, aGuideMenuPreviewShops
        .structGuideMenuDataEntry aGuideMenuDescriptionBeginnersCenter, aGuideMenuTitleBeginnersCenter, aGuideMenuPreviewBeginnersCenter
        .structGuideMenuDataEntry aGuideMenuSubpageAdvice, aGuideMenuTitleAdvice, aGuideMenuPreviewAdvice
        .word GuideMenuDataEnd

      aGuideMenuTitlePageStructure ; 91/8AF5

        .enc "GuideMenu"

        ; Unused.

        .text "ページ構成\n"

      aGuideMenuTitleHowToOperate ; 91/8B01

        .text "そうさほうほう\n"

      aGuideMenuTitleSaveAndLoad ; 91/8B11

        .text "セーブとロード\n"

      aGuideMenuTitleGameFlow ; 91/8B21

        .text "ゲームのながれ\n"

      aGuideMenuTitleVictoryAndDefeat ; 91/8B31

        .text "勝利と敗北\n"

      aGuideMenuTitlePreparationsMenu ; 91/8B3D

        .text "進撃メニュー\n"

      aGuideMenuTitleUnitMenu ; 91/8B4B

        .text "ユニットメニュー\n"

      aGuideMenuTitleMapMenu ; 91/8B5D

        .text "マップメニュー\n"

      aGuideMenuTitleUnits ; 91/8B6D

        .text "ユニット\n"

      aGuideMenuTitleItems ; 91/8B77

        .text "アイテム\n"

      aGuideMenuTitleTerrain ; 91/8B81

        .text "ちけい\n"

      aGuideMenuTitleShops ; 91/8B89

        .text "みせ\n"

      aGuideMenuTitleBeginnersCenter ; 91/8B8F

        .text "初心者の館\n"

      aGuideMenuTitleAdvice ; 91/8B9B

        .text "アドバイス\n"

      aGuideMenuPreviewPageStructure ; 91/8BA7

        ; Unused.
        ; Near identical copy to aGuideMenuPreviewHowToOperate, just with the
        ; "A or right key" on the same line.

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "{Green}チュートリアルモード\n{Append}のそうさほうほう\n"
        .text "　\n"
        .text "{Blue}　十字キー\n{Append}でカーソル移動。\n"
        .text "　\n"
        .text "{White}　みたいこうもくで、\n{Append}{Blue}Ａ\n{Append}{White}または\n{Append}{Blue}みぎキー\n{Append}で\n"
        .text "　ないようを表示。\n"
        .text "　\n"
        .text "　\n"
        .text "{White}　ここで\n{Append}{White}Ａ\n{Append}をおすと、ゲーム中の\n"
        .text "　キーそうさが表示されます。\n{End}"

      aGuideMenuUnknown918CAD ; 91/8CAD

        ; Titles and basic descriptions for the last 4 guide menu options?

        .word GuideMenuNoSubpage

        .text "地形\n"
        .text "　　地形の解説\n"
        .text "　\n"
        .text "店\n"
        .text "　　店の解説\n"
        .text "　\n"
        .text "初心者の館\n"
        .text "　　はじめてのかたは読んでください。\n"
        .text "　\n"
        .text "わんぽいんとあどばいす\n"
        .text "　　知っておけばちょっと便利です。\n{End}"

      aGuideMenuPreviewHowToOperate ; 91/8D55

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "{Green}チュートリアルモード\n{Append}のそうさほうほう\n"
        .text "　\n"
        .text "{Blue}　十字キー\n{Append}でカーソル移動。\n"
        .text "　\n"
        .text "{White}　みたいこうもくで、\n{Append}{Blue}Ａ\n{Append}{White}または\n{Append}{Blue}みぎキー\n{Append}で\n"
        .text "　ないようを表示。\n"
        .text "　\n"
        .text "　\n"
        .text "{White}　ここで\n{Append}{Blue}Ａ\n{Append}"
        .text "をおすと、ゲーム中の\n"
        .text "　キーそうさが表示されます。\n{End}"

      aGuideMenuDescriptionHowToOperate  ; 91/8E5B

        .word GuideMenuNoSubpage

        .text "{Blue}十字\n"
        .text "　　カーソル移動\n"
        .text "　\n"
        .text "{Blue}Ａ\n"
        .text "　　ユニットをつかんだり\n"
        .text "　　コマンドをえらんだりします。\n"
        .text "　\n"
        .text "{Blue}Ｂ\n"
        .text "　　キャンセルボタンです。\n"
        .text "　\n"
        .text "{Blue}Ｘ\n"
        .text "　　じょうほう表示ボタンです\n"
        .text "　\n"
        .text "{Blue}Ｙ\n"
        .text "　　おしっぱなしでバトルフィールドの\n"
        .text "　　カーソルをこうそく移動できます。\n"
        .text "　\n"
        .text "{Blue}とくしゅキーそうさ\n"
        .text "{Blue}ｌ＋Ｒ＋ＳＥｌＥＣＴ＋ＳＴＡＲＴ\n"
        .text "　　リセット\n"
        .text "ーーーーーーーー\n"
        .text "ｌ＋Ｙ＋Ｂ　ドーピング\n"
        .text "　\n"
        .text "ｌ＋ＳＥｌ　プレイヤーセレクト\n"
        .text "　\n"
        .text "Ｒ＋Ｙ＋Ｂおしながら　上上\n"
        .text "　　イベントチェック\n"
        .text "Ｙ＋ＳＥｌ　カーソル位置表示\n"
        .text "　\n"
        .text "Ｙ＋Ｂおしながら　上上\n"
        .text "　　オンバトテスト\n"
        .text "　\n{End}"

      aGuideMenuPreviewSaveAndLoad ; 91/9087

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "{White}　ゲームの\n{Append}{Blue}セーブ\n{Append}{White}、\n{Append}{Blue}ロード\n{Append}{White}は、\n{Append}{Green}章\n{Append}{White}と\n{Append}{Green}章\n{Append}の\n"
        .text "　くぎれごとにすることができます。\n"
        .text "　\n"
        .text "{White}　れいがいで、\n{Append}{Green}バトルフィールド\n{Append}でも\n"
        .text "{White}　\n{Append}{Blue}中断\n{Append}{White}することもできますが、\n{Append}{Blue}中断\n{Append}か\n"
        .text "{White}　らの\n{Append}{Blue}ロード\n{Append}{White}は\n{Append}{Red}１回\n{Append}しかできません。\n"
        .text "　\n"
        .text "　\n"
        .text "{Blue}　Ａ\n{Append}{White}をおすと、\n{Append}{Blue}セーブ\n{Append}{White}、\n{Append}{Blue}ロード\n{Append}がめんの\n"
        .text "　説明です。\n{End}"

      aGuideMenuDescriptionSaveAndLoad ; 91/9211

        .word GuideMenuNoSubpage

        .text "{Blue}新しく始める\n"
        .text "　　最初から始めます。\n"
        .text "　　いちばん最初にゲームを\n"
        .text "　　始めたときはこれしかでません。\n"
        .text "　\n"
        .text "{Blue}中断から始める\n"
        .text "{White}　　前回\n{Append}{White}中断\n{Append}したところから始めます。\n"
        .text "{White}　　\n{Append}{Blue}中断\n{Append}{White}からの\n{Append}{Blue}ロード\n{Append}{White}は\n{Append}{Red}１回\n{Append}のみです。\n"
        .text "　\n"
        .text "{Blue}記録から始める\n"
        .text "{White}　　前回\n{Append}{White}記録\n{Append}したところから始めます。\n"
        .text "{White}　　\n{Append}{Blue}中断から始める\n{Append}とはちがい、\n"
        .text "　　なんかいでもせんたくできます。\n"
        .text "　\n"
        .text "{Blue}記録を写す\n"
        .text "{White}　　\n{Append}{White}せんたく\n{Append}{White}した\n{Append}{Blue}記録\n{Append}{White}を\n{Append}{White}コピー\n{Append}します。\n"
        .text "{White}　　\n{Append}{Blue}記録\n{Append}がいっぱいのときは\n"
        .text "　　このコマンドは表示されません。\n"
        .text "　\n"
        .text "{Blue}記録を消す\n"
        .text "{White}　　\n{Append}{White}せんたくした\n{Append}{Blue}記録\n{Append}を消します。\n"
        .text "{White}　　消した\n{Append}{Blue}記録\n{Append}は、にどとふっかつ\n"
        .text "　　しませんのでちゅういしてください。\n"
        .text "　\n{End}"

      aGuideMenuPreviewGameFlow ; 91/94F1
        
        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　\n"
        .text "{White}　ゲームは、\n{Append}{Green}章\n{Append}ごとにくぎることが\n"
        .text "　できます。\n"
        .text "　\n"
        .text "{White}　ここでは、\n{Append}{Green}章\n{Append}１つ１つの流れを\n"
        .text "　説明しています。\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuDescriptionGameFlow ; 91/9587

        .word GuideMenuNoSubpage

        .text "{Green}章の始まり\n"
        .text "{Red}　↓\n"
        .text "{Green}全体マップ\n"
        .text "　　全体マップが表示され\n"
        .text "　　進撃ルート、ストーリーなどが\n"
        .text "　　流れます。\n"
        .text "{Red}　↓\n"
        .text "{Green}進撃メニュー\n"
        .text "　　アイテム整理、出撃ユニット選択\n"
        .text "　　などをします。\n"
        .text "　　記録はここでもできます。\n"
        .text "　　７マップまではありません。\n"
        .text "{Red}　↓\n"
        .text "{Green}バトルフィールド\n"
        .text "　　ゲームのメインです。\n"
        .text "　　各マップの勝利条件をみたせば\n"
        .text "　　マップクリアです。\n"
        .text "{Red}　↓\n"
        .text "{Green}セーブ\n"
        .text "　　ゲームデータの記録をします。\n"
        .text "　　さいこう３つまで記録できます。\n"
        .text "{Red}　↓\n"
        .text "{Green}章の始まり\n{Append}へ\n"
        .text "　\n{End}"

      aGuideMenuPreviewVictoryAndDefeat ; 91/9773

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "{Blue}　章\n{Append}{White}ごとの\n{Append}{Blue}勝利条件\n{Append}{White}、\n{Append}{Blue}敗北条件\n{Append}が\n"
        .text "　説明されています。\n"
        .text "　\n"
        .text "　\n"
        .text "{Blue}　Ａ\n{Append}をおすとそれぞれの説明になります\n"
        .text "{White}　が、その\n{Append}{Blue}章\n{Append}{White}の\n{Append}{Blue}勝利条件\n{Append}{White}、\n{Append}{Blue}敗北条件\n{Append}は、\n"
        .text "{Blue}　バトルフィールド\n{Append}{White}の\n{Append}{Blue}マップメニュー\n{Append}で\n"
        .text "{White}　「\n{Append}{Blue}状況\n{Append}{White}」\n{Append}をみてかくにんしてください。\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuSubpageVictoryAndDefeat ; 91/98C9

        .structGuideMenuDataEntry aGuideMenuDescriptionVictoryConditions, aGuideMenuTitleVictoryConditions, aGuideMenuPreviewVictoryConditions
        .structGuideMenuDataEntry 0, aGuideMenuTitleDefeatConditions, aGuideMenuPreviewDefeatConditions
        .word GuideMenuDataEnd

      aGuideMenuTitleVictoryConditions ; 91/98D7

        .text "勝利条件\n"

      aGuideMenuTitleDefeatConditions ; 91/98E1

        .text "敗北条件\n"

      aGuideMenuPreviewVictoryConditions ; 91/98EB

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "{Blue}勝利条件\n"
        .text "　\n"
        .text "　\n"
        .text "　　大きくわけて\n"
        .text "　\n"
        .text "{Blue}　　　　制圧　離脱　持続\n"
        .text "　\n"
        .text "　　の３つがあります。\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewDefeatConditions ; 91/995F

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "{Blue}敗北条件\n"
        .text "　\n"
        .text "　\n"
        .text "　　敗北条件は、主人公のリーフがし\n"
        .text "　　ぬこと、また章によっては、拠点\n"
        .text "　　を制圧されることで敗北します。\n"
        .text "　　\n"
        .text "　\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuDescriptionDefeatConditions ; 91/99FB

        ; Unused.

        .word GuideMenuNoSubpage

        .text "勝利条件、敗北条件ともに、詳しくは章\n"
        .text "ごとにマップメニューの　状況　を見て\n"
        .text "ください。\n"
        .text "　\n{End}"

      aGuideMenuDescriptionVictoryConditions ; 91/9A5D

        .word GuideMenuNoSubpage

        .text "{Blue}　制圧\n"
        .text "　　リーフが、バトルフィールドに一つ\n"
        .text "　　だけある制圧ポイントに、到達する\n"
        .text "　　ことが条件のマップです。\n"
        .text "　\n"
        .text "{Blue}　離脱\n"
        .text "{White}　　リーフが\n{Append}{Blue}離脱ポイント\n{Append}に到着すること\n"
        .text "{White}　　が、\n{Append}{Blue}勝利条件\n{Append}{White}の\n{Append}{Blue}章\n{Append}です。\n"
        .text "　　ただ、リーフよりさきに自軍ユニット\n"
        .text "{White}　　をすべて\n{Append}{Blue}離脱\n{Append}{White}させておかないと、\n{Append}{Blue}離脱\n"
        .text "{Blue}　　させてないユニットは、捕虜になって\n"
        .text "{Blue}　　しまう\n{Append}ので注意してください。\n"
        .text "　\n"
        .text "{Blue}　持続\n"
        .text "　　設定されたターンだけ、リーフが生き\n"
        .text "　　ていることが条件の章です。\n"
        .text "　\n{End}"

      aGuideMenuPreviewPreparationsMenu ; 91/9C5D

        .word GuideMenuNoSubpage

        .text "{White}　この\n{Append}{Blue}章\n{Append}{White}の\n{Append}{Blue}バトルフィールド\n{Append}の\n"
        .text "　じゅんびをします。\n"
        .text "　ここでは、いかのコマンドが使え\n"
        .text "　ます。\n"
        .text "　\n"
        .text "{Blue}　　　　マップ\n"
        .text "{Blue}　　　　アイテム\n"
        .text "{Blue}　　　　進撃\n"
        .text "{Blue}　　　　記録\n"
        .text "　\n"
        .text "{Blue}　Ａ\n{Append}をおすとそれぞれの説明になります。\n{End}"

      aGuideMenuDescriptionPreparationsMenu ; 91/9D57

        .word GuideMenuNoSubpage

        .text "{Blue}マップ\n"
        .text "{Blue}　　バトルフィールド\n{Append}を見ます。\n"
        .text "{Blue}　　さくてきのバトルフィールドでは、\n"
        .text "{Blue}　　見ることができません。\n"
        .text "　\n"
        .text "{Blue}アイテム\n"
        .text "　　アイテムを交換したり、輸送隊に\n"
        .text "　　預けたりします。\n"
        .text "{Blue}　　アイテムの使用は出来ません。\n"
        .text "　\n"
        .text "{Blue}進撃\n"
        .text "{White}　　その\n{Append}{Blue}バトルフィールド\n{Append}を始めます。\n"
        .text "　\n"
        .text "{Blue}記録\n"
        .text "　　現在の状況を記録します。\n"
        .text "　\n{End}"

      aGuideMenuPreviewUnitMenu ; 91/9EAD

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "{Blue}　バトルフィールド\n{Append}での、ユニットの\n"
        .text "　行動をきめる、さまざまなコマンド\n"
        .text "　の説明です。\n"
        .text "　\n"
        .text "　　　　共通コマンド\n"
        .text "　　　　地形コマンド\n"
        .text "　　　　兵種コマンド\n"
        .text "　\n"
        .text "　の３タイプにわけて説明しています。\n"
        .text "　\n{End}"

      aGuideMenuSubpageUnitMenu ; 91/9F89

        .structGuideMenuDataEntry aGuideMenuSubpageRegularCommands, aGuideMenuTitleRegularCommands, aGuideMenuPreviewRegularCommands
        .structGuideMenuDataEntry aGuideMenuSubpageTerrainCommands, aGuideMenuTitleTerrainCommands, aGuideMenuPreviewTerrainCommands
        .structGuideMenuDataEntry aGuideMenuSubpageClassCommands, aGuideMenuTitleClassCommands, aGuideMenuPreviewClassCommands
        .word GuideMenuDataEnd

      aGuideMenuTitleRegularCommands ; 91/9F9D

        .text "共通コマンド\n"

      aGuideMenuTitleTerrainCommands ; 91/9FAB

        .text "地形コマンド\n"

      aGuideMenuTitleClassCommands ; 91/9FB9

        .text "兵種コマンド\n"

      aGuideMenuSubpageRegularCommands ; 91/9FC7

        .structGuideMenuDataEntry aGuideMenuDescriptionAttack, aGuideMenuTitleAttack, aGuideMenuPreviewAttack
        .structGuideMenuDataEntry aGuideMenuDescriptionCapture, aGuideMenuTitleCapture, aGuideMenuPreviewCapture
        .structGuideMenuDataEntry 0, aGuideMenuTitleWait, aGuideMenuPreviewWait
        .structGuideMenuDataEntry 0, aGuideMenuTitleItem, aGuideMenuPreviewItem
        .structGuideMenuDataEntry 0, aGuideMenuTitleTransfer, aGuideMenuPreviewTransfer
        .structGuideMenuDataEntry 0, aGuideMenuTitleTrade, aGuideMenuPreviewTrade
        .structGuideMenuDataEntry 0, aGuideMenuTitleAnimation, aGuideMenuPreviewAnimation
        .structGuideMenuDataEntry 0, aGuideMenuTitleTalk, aGuideMenuPreviewTalk
        .structGuideMenuDataEntry 0, aGuideMenuTitleVisit, aGuideMenuPreviewVisit
        .structGuideMenuDataEntry 0, aGuideMenuTitleRelease, aGuideMenuPreviewRelease
        .structGuideMenuDataEntry 0, aGuideMenuTitleRescue, aGuideMenuPreviewRescue
        .word GuideMenuDataEnd

      aGuideMenuTitleAttack ; 91/A00B

        .text "攻撃\n"

      aGuideMenuTitleCapture ; 91/A011

        .text "捕える\n"

      aGuideMenuTitleWait ; 91/A019

        .text "待機\n"

      aGuideMenuTitleItem ; 91/A01F

        .text "持ち物\n"

      aGuideMenuTitleTransfer ; 91/A027

        .text "人交換\n"

      aGuideMenuTitleTrade ; 91/A02F

        .text "物交換\n"

      aGuideMenuTitleAnimation ; 91/A037

        .text "アニメ\n"

      aGuideMenuTitleTalk ; 91/A03F

        .text "話す\n"

      aGuideMenuTitleVisit ; 91/A045

        .text "訪ねる\n"

      aGuideMenuTitleRelease ; 91/A04D

        .text "かいほう\n"

      aGuideMenuTitleRescue ; 91/A057

        .text "かつぐ\n"

      aGuideMenuSubpageTerrainCommands ; 91/A05F

        .structGuideMenuDataEntry 0, aGuideMenuTitleArmory, aGuideMenuPreviewArmory
        .structGuideMenuDataEntry 0, aGuideMenuTitleVendor, aGuideMenuPreviewVendor
        .structGuideMenuDataEntry 0, aGuideMenuTitleArena, aGuideMenuPreviewArena
        .structGuideMenuDataEntry 0, aGuideMenuTitleSupply, aGuideMenuPreviewSupply
        .structGuideMenuDataEntry 0, aGuideMenuTitleSecretShop, aGuideMenuPreviewSecretShop
        .structGuideMenuDataEntry 0, aGuideMenuTitleEscape, aGuideMenuPreviewEscape
        .structGuideMenuDataEntry 0, aGuideMenuTitleConvoy, aGuideMenuPreviewConvoy
        .structGuideMenuDataEntry 0, aGuideMenuTitleSeize, aGuideMenuPreviewSeize
        .structGuideMenuDataEntry 0, aGuideMenuTitleDoor, aGuideMenuPreviewDoor
        .structGuideMenuDataEntry 0, aGuideMenuTitleBridge, aGuideMenuPreviewBridge
        .structGuideMenuDataEntry 0, aGuideMenuTitleChest, aGuideMenuPreviewChest
        .word GuideMenuDataEnd

      aGuideMenuTitleArmory ; 91/A0A3

        .text "武器屋\n"

      aGuideMenuTitleVendor ; 91/A0AB

        .text "道具屋\n"

      aGuideMenuTitleArena ; 91/A0B3

        .text "闘技場\n"

      aGuideMenuTitleSupply ; 91/A0BB

        .text "預かり所\n"

      aGuideMenuTitleSecretShop ; 91/A0C5

        .text "秘密の店\n"

      aGuideMenuTitleEscape ; 91/A0CF

        .text "離脱\n"

      aGuideMenuTitleConvoy ; 91/A0D5

        .text "輸送隊\n"

      aGuideMenuTitleSeize ; 91/A0DD

        .text "制圧\n"

      aGuideMenuTitleDoor ; 91/A0E3

        .text "扉\n"

      aGuideMenuTitleBridge ; 91/A0E7

        .text "はね橋\n"

      aGuideMenuTitleChest ; 91/A0EF

        .text "宝箱\n"

      aGuideMenuSubpageClassCommands ; 91/A0F5

        .structGuideMenuDataEntry 0, aGuideMenuTitleStaff, aGuideMenuPreviewStaff
        .structGuideMenuDataEntry 0, aGuideMenuTitleDance, aGuideMenuPreviewDance
        .word GuideMenuDataEnd

      aGuideMenuTitleStaff ; 91/A103

        .text "杖\n"

      aGuideMenuTitleDance ; 91/A107

        .text "踊り\n"

      aGuideMenuPreviewRegularCommands ; 91/A10D

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　共通コマンド\n"
        .text "　\n"
        .text "　\n"
        .text "　条件さえあえば、どのユニットでも\n"
        .text "　行うことのできるコマンドです。\n"
        .text "　\n{End}"

      aGuideMenuPreviewTerrainCommands ; 91/A179

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　地形コマンド\n"
        .text "　\n"
        .text "　\n"
        .text "　特定の地形でせんたくできる\n"
        .text "　コマンドです。\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewClassCommands ; 91/A1D3

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　兵種コマンド\n"
        .text "　\n"
        .text "　\n"
        .text "　特定の兵種がつかえる\n"
        .text "　コマンドです。\n"
        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewAttack ; 91/A233

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　敵ユニットに攻撃をしかけます。\n"
        .text "　\n"
        .text "　ほぼ全てのユニットが使えるコマンド\n"
        .text "　のため、「共通コマンド」にぶんるい\n"
        .text "　しましたが、いちぶの杖しか使えない\n"
        .text "　ユニットには、使うことはできません。\n"
        .text "　\n"
        .text "　また、武器をもっていないときも\n"
        .text "　攻撃はできません。\n{End}"

      aGuideMenuDescriptionAttack ; 91/A339

        .word GuideMenuNoSubpage

        .text "　攻撃のしゅるいは、武器によっていかの\n"
        .text "　４つにぶんるいできます。\n"
        .text "　\n"
        .text "　直接攻撃\n"
        .text "　　りんせつしたユニットに攻撃します。\n"
        .text "　　剣、槍、斧の武器を装備できるユニ\n"
        .text "　　ットが行えます。\n"
        .text "　\n"
        .text "　間接攻撃\n"
        .text "　　はなれたユニットに攻撃します。\n"
        .text "　　弓といちぶの剣、槍、斧を装備でき\n"
        .text "　　るユニットが行えます。\n"
        .text "　\n"
        .text "　遠距離攻撃\n"
        .text "　　遠くのユニットに攻撃します。\n"
        .text "　　シューターがする攻撃です。\n"
        .text "　\n"
        .text "　魔法\n"
        .text "　　ほとんどすべての魔法は直接攻撃と\n"
        .text "　　間接攻撃、またいちぶの魔法は遠距\n"
        .text "　　離攻撃をすることができます。\n"
        .text "　\n"
        .text "　武器についてくわしくは、\n"
        .text "「アイテム」の「武器」をみてください。\n{End}"

      aGuideMenuPreviewCapture ; 91/A583

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　\n"
        .text "　敵ユニットを捕えるために攻撃を\n"
        .text "　しかけます。\n"
        .text "　\n"
        .text "　\n"
        .text "　この攻撃で、てきユニットにとどめを\n"
        .text "　さしたときのみ、てきをほりょにする\n"
        .text "　ことができます。\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuDescriptionCapture ; 91/A633

        .word GuideMenuNoSubpage

        .text "　捕えるためには、攻撃するための条件の\n"
        .text "　ほか、いかの条件もひつようです。\n"
        .text "　\n"
        .text "　\n"
        .text "　ちょくせつ攻撃である\n"
        .text "　　　つまり、弓しか使えないユニット\n"
        .text "　　　は、捕えることができません。\n"
        .text "　\n"
        .text "　馬系ユニットではない\n"
        .text "　　　馬系ユニットとは、馬、ペガサス、\n"
        .text "　　　ドラゴンにのっているユニットの\n"
        .text "　　　ことです。\n"
        .text "　\n"
        .text "　体格がそのてきユニットより大きい\n"
        .text "　　　ユニットの体格をみたいときは、\n"
        .text "　　　ユニットにカーソルをあわせ、\n"
        .text "　　　Ｘボタンをおしてみてください。\n"
        .text "　\n"
        .text "　\n"
        .text "　イベントなどでじゅうようなユニットは、\n"
        .text "　この条件にあっていても、捕えることが\n"
        .text "　できないユニットもいます。\n"
        .text "　\n{End}"

      aGuideMenuPreviewWait ; 91/A87F

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　\n"
        .text "　つかんだユニットの行動を終了します。\n"
        .text "　次の自軍の行動まで、そのユニットは\n"
        .text "　動かすことができなくなります。\n"
        .text "　\n"
        .text "　待機したあとでも、Ｘボタンでの\n"
        .text "　情報の表示はできます。\n"
        .text "　\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewItem ; 91/A949

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　つかんだユニットのアイテムを見ます。\n"
        .text "　また、以下の行動を選択できます。\n"
        .text "　\n"
        .text "　\n"
        .text "　装備　えらんだアイテムを装備\n"
        .text "　　　　　します。\n"
        .text "　つかう　持ち物を使います。\n"
        .text "　\n"
        .text "　すてる　特定のアイテムは捨てられ\n"
        .text "　　　　　ません。\n{End}"

      aGuideMenuPreviewTransfer ; 91/AA35

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　同行しているユニットをうけわたす、\n"
        .text "　もしくはひきとることができます。\n"
        .text "　\n"
        .text "　みかたユニットが、となりあっている\n"
        .text "　ときに、使えるコマンドです。\n"
        .text "　\n"
        .text "　ただし、体格、ユニットの状態に\n"
        .text "　よっては使えません。\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewTrade ; 91/AB19

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　アイテムを交換します。\n"
        .text "　アイテムをもらったり、わたしたりも\n"
        .text "　できます。\n"
        .text "　\n"
        .text "　みかたユニットがとなりあっているとき、\n"
        .text "　またはユニットを同行しているときに\n"
        .text "　つかえるコマンドです。\n"
        .text "　\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewAnimation ; 91/ABEB

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　\n"
        .text "　オンマップバトルとリアルバトルの\n"
        .text "　きりかえをします。\n"
        .text "　\n"
        .text "　　設定　画面で　こべつ　をせんたく\n"
        .text "　してるときにえらべます。\n"
        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewTalk ; 91/AC89

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　\n"
        .text "　特定のユニットどうしで、かいわする\n"
        .text "　コマンドです。\n"
        .text "　\n"
        .text "　\n"
        .text "　　てきのユニットが、なかまになる\n"
        .text "　こともあります。\n"
        .text "　\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewVisit ; 91/AD1B

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　　民家に訪れます。\n"
        .text "　\n"
        .text "　\n"
        .text "　アイテムやじょうほうがもらえるほか、\n"
        .text "　特定の民家では、ユニットがなかまに\n"
        .text "　なってくれることもあります。\n"
        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewRelease ; 91/ADC1

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　「捕える」で捕えたユニットをにがし\n"
        .text "　ます。\n"
        .text "　\n"
        .text "　\n"
        .text "　にがしたユニットのアイテムは\n"
        .text "　なくなってしまうので、交換で\n"
        .text "　アイテムをとりわすれないよう\n"
        .text "　ちゅういしてください。\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewRescue ; 91/AE85

        .word GuideMenuNoSubpage

        .text "　みかたユニットをかつぎます。\n"
        .text "　いかの条件のユニットのとなりにいる\n"
        .text "　ときに、使えます。\n"
        .text "　\n"
        .text "みかたのユニット\n"
        .text "体格が行動しているユニットよりちいさい\n"
        .text "　\n"
        .text "　れいがいで、馬系ユニットは、徒歩\n"
        .text "ユニットすべてをかつげます。\n"
        .text "　また、状態がバサークのユニットは\n"
        .text "かつぐことはできません。\n{End}"

      aGuideMenuPreviewArmory ; 91/AFA9

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　武器屋にはいります。\n"
        .text "　\n"
        .text "　剣や槍などの武器を売っています。\n"
        .text "　\n"
        .text "　\n"
        .text "　また、もう必要のないアイテムを\n"
        .text "　うることもできます。\n"
        .text "　\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewVendor ; 91/B041

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　\n"
        .text "　道具屋にはいります。\n"
        .text "　\n"
        .text "　きずぐすりや、かぎなどの、さまざまな\n"
        .text "　やくにたつ道具がうられています。\n"
        .text "　\n"
        .text "　また、もう必要のないアイテムを\n"
        .text "　うることもできます。\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewArena ; 91/B0FD

        .word GuideMenuNoSubpage

        .text "　闘技場にはいります。\n"
        .text "　\n"
        .text "　闘技場では、お金をかけて戦います。\n"
        .text "　勝てば、かけ金のばいのお金がもら\n"
        .text "　えるほか、けいけんちももらえますが、\n"
        .text "　負けてしまうと死んでしまいますので\n"
        .text "　ちゅういしてください。\n"
        .text "　\n"
        .text "　また、勝ち負けに関係なく疲労は\n"
        .text "　たまります。\n"
        .text "　\n{End}"

      aGuideMenuPreviewSupply ; 91/B20B

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　預かり所にはいります。\n"
        .text "　\n"
        .text "　はいったユニットのアイテムを預けら\n"
        .text "　れるほか、預かり所のアイテムをうけ\n"
        .text "　とることもできます。\n"
        .text "　\n"
        .text "　預かり所に預けられるアイテムの\n"
        .text "　かずは、最大で１２８個です。\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewSecretShop ; 91/B2E5

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　\n"
        .text "{Blue}　秘密の店\n{Append}にはいります。\n"
        .text "　\n"
        .text "{White}　ただ、\n{Append}{Blue}秘密の店\n{Append}にはいるためには\n"
        .text "{Blue}　メンバーカード\n{Append}がひつようなほか、\n"
        .text "{Blue}　バトルフィールド\n{Append}中にかくされて\n"
        .text "　います。\n"
        .text "　がんばってさがしてください。\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewEscape ; 91/B3CB

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　\n"
        .text "　　そのバトルフィールドを離脱します。\n"
        .text "　\n"
        .text "　　ただ、リーフよりさきに自軍ユニット\n"
        .text "{White}　　をすべて\n{Append}{Blue}離脱\n{Append}{White}させておかないと、\n{Append}{Blue}離脱\n"
        .text "{Blue}　　させてないユニットは、捕虜になって\n"
        .text "{Blue}　　しまう\n{Append}ので注意してください。\n"
        .text "　\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewConvoy ; 91/B4C7

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　\n"
        .text "　輸送隊と物の交換をします。\n"
        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "　たぶんなくなる。\n"
        .text "　\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewSeize ; 91/B523

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　もくてきが「制圧」になっている\n"
        .text "　章のみで使えるコマンドです。\n"
        .text "　このコマンドを使うことで\n"
        .text "　その章はクリアです。\n"
        .text "　以下の地形にリーフが移動すると\n"
        .text "　使えます。\n"
        .text "　\n"
        .text "{Blue}　ぎょくざ\n"
        .text "{Blue}　しろ\n"
        .text "　\n{End}"

      aGuideMenuPreviewDoor ; 91/B5F3

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "{Blue}　とうぞく\n{Append}{White}が\n{Append}{Blue}地形\n{Append}{White}の\n{Append}{Blue}扉\n{Append}のとなりに\n"
        .text "　移動すると、使えるコマンドです。\n"
        .text "　\n"
        .text "{Blue}　とうぞくのかぎ\n{Append}を１つ使って\n"
        .text "{Blue}　扉\n{Append}をあけます。\n"
        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewBridge ; 91/B6B3

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "{Blue}　とうぞく\n{Append}{White}が\n{Append}{Blue}地形\n{Append}{White}の\n{Append}{Blue}はね橋\n{Append}のとなりに\n"
        .text "　移動すると、使えるコマンドです。\n"
        .text "　\n"
        .text "{Blue}　とうぞくのかぎ\n{Append}を１つ使って\n"
        .text "{Blue}　はね橋\n{Append}をおろします。\n"
        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewChest ; 91/B77D

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "{Blue}　とうぞく\n{Append}{White}が\n{Append}{Blue}地形\n{Append}{White}の\n{Append}{Blue}宝箱\n{Append}上に移動すると、\n"
        .text "　つかえるコマンドです。\n"
        .text "　\n"
        .text "{Blue}　とうぞくのかぎ\n{Append}を１つ使って\n"
        .text "{Blue}　宝箱\n{Append}をあけます。\n"
        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewStaff ; 91/B83D

        .word GuideMenuNoSubpage

        .text "　杖を使います。\n"
        .text "　\n"
        .text "　\n"
        .text "　つえのしゅるいによって、\n"
        .text "　\n"
        .text "　　　ＨＰ、状態のかいふく\n"
        .text "　　　移動\n"
        .text "　　　こうげきほじょ\n"
        .text "　\n"
        .text "　などを行います。また、杖はしっぱい\n"
        .text "　することもあります。\n{End}"

      aGuideMenuPreviewDance ; 91/B8FD

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　踊りを踊ります。\n"
        .text "　踊りこのみのコマンドです。\n"
        .text "　\n"
        .text "　\n"
        .text "　この行動によって、となりあうユニット\n"
        .text "　すべてが再行動できます。\n"
        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewMapMenu ; 91/B995

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "マップメニュー\n"
        .text "　\n"
        .text "　\n"
        .text "{Blue}　　バトルフィールド\n{Append}での、\n"
        .text "　マップメニューコマンドの\n"
        .text "　説明がかかれています。\n"
        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "\n{End}"

      aGuideMenuDescriptionMapMenu ; 91/BA21

        .word GuideMenuNoSubpage

        .text "{Blue}部隊\n"
        .text "　　自軍のユニット表です。\n"
        .text "　\n"
        .text "{Blue}状況\n"
        .text "　　章のもくてき、ターン数などを\n"
        .text "　　表示します。\n"
        .text "　\n"
        .text "{Blue}設定\n"
        .text "　　戦闘アニメなど、さまざまな設定\n"
        .text "　\n"
        .text "セーブ　いずれなくなる。\n"
        .text "　\n"
        .text "ロード　これも。\n"
        .text "　\n"
        .text "輸送隊\n"
        .text "　　うえにおなじ。\n"
        .text "　\n"
        .text "{Blue}中断\n"
        .text "　　現在の状況を記録します。\n"
        .text "　　ただし、１度しかロードできません。\n"
        .text "　\n"
        .text "{Blue}終了\n"
        .text "　　自軍の行動を終了して、敵に行動\n"
        .text "　　権を渡す。\n{End}"

      aGuideMenuPreviewUnits ; 91/BBA1

        .word GuideMenuNoSubpage

        .text "ユニットについて\n"
        .text "　\n"
        .text "　\n"
        .text "　　ユニットの説明をしています。\n"
        .text "　\n"
        .text "　兵種\n"
        .text "　パラメータ\n"
        .text "　クラスチェンジ\n"
        .text "　状態\n"
        .text "　再行動\n"
        .text "　\n{End}"

      aGuideMenuDescriptionUnits ; 91/BC25

        .word GuideMenuNoSubpage

        .text "　\n{End}"

      aGuideMenuPreviewItems ; 91/BC2F

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "アイテム\n"
        .text "　\n"
        .text "　\n"
        .text "　　さまざまなアイテムについての\n"
        .text "　　説明をするつもりです。\n"
        .text "　\n"
        .text "　\n"
        .text "　ただ、オンラインヘルプでこれが、\n"
        .text "　いるのだろーか？\n"
        .text "　\n{End}"

      aGuideMenuSubpageItems ; 91/BCCD

        .structGuideMenuDataEntry 0, aGuideMenuTitleWeapons, aGuideMenuPreviewWeapons
        .structGuideMenuDataEntry 0, aGuideMenuTitleUsableItems, aGuideMenuPreviewUsableItems
        .word GuideMenuDataEnd

      aGuideMenuTitleWeapons ; 91/BCDB

        .text "ぶき\n"

      aGuideMenuTitleUsableItems ; 91/BCE1

        .text "どうぐ\n"

      aGuideMenuPreviewWeapons ; 91/BCE9

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "　種類\n"
        .text "　武器レベル\n"
        .text "　得意武器属性\n"
        .text "　特効\n"
        .text "　\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewUsableItems ; 91/BD39

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　アイテムは使用回数を回復できません。\n"
        .text "　\n"
        .text "　\n"
        .text "　回復系\n"
        .text "　パラメータＵＰ系\n"
        .text "　鍵系\n"
        .text "　その他\n"
        .text "　\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuPreviewTerrain ; 91/BDAF

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　ちけい\n"
        .text "　\n"
        .text "　\n"
        .text "　　地形の説明をするよてい。\n"
        .text "　\n"
        .text "　\n"
        .text "　これはたぶんつかうとおもうが、\n"
        .text "　どれだけくわしくするかがもんだい。\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuDescriptionTerrain ; 91/BE41

        .word GuideMenuNoSubpage

        .text "ちけいのせつめい。\n"
        .text "　だよ。\n"
        .text "　\n{End}"

      aGuideMenuPreviewShops ; 91/BE69

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　みせ\n"
        .text "　\n"
        .text "{Blue}　　　　武器屋\n"
        .text "{Blue}　　　　道具屋\n"
        .text "{Blue}　　　　預かり所\n"
        .text "{Blue}　　　　闘技場\n"
        .text "{Blue}　　　　秘密の店\n"
        .text "　\n"
        .text "　　の説明をしています。\n"
        .text "　\n{End}"

      aGuideMenuDescriptionShops ; 91/BEFF

        .word GuideMenuNoSubpage

        .text "{Blue}武器屋\n"
        .text "　　武器を売っている店です。\n"
        .text "　\n"
        .text "{Blue}道具屋\n"
        .text "　　道具を売っている店です。\n"
        .text "　\n"
        .text "{Blue}預かり所\n"
        .text "　　持ち物を預かってもらえます。\n"
        .text "　\n"
        .text "{Blue}闘技場\n"
        .text "　　お金をかけて、戦います。\n"
        .text "　　闘技場で勝つと、かけ金のばいの\n"
        .text "　　お金がもらえます。\n"
        .text "　\n"
        .text "{Blue}秘密の店\n"
        .text "　　ほかのみせではかえない、きちょうな\n"
        .text "　　武器やアイテムを売っています。\n"
        .text "　　ただし、メンバーカードがないと\n"
        .text "　　入れません。\n"
        .text "　\n{End}"

      aGuideMenuPreviewBeginnersCenter ; 91/C089

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　しょしんしゃのやかた\n"
        .text "　\n"
        .text "　\n"
        .text "　　しょしんしゃようの説明。\n"
        .text "　　なまえかえるかのうせい、大。\n"
        .text "　\n"
        .text "　\n"
        .text "　のこってるかどうかも、あやしい。\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuDescriptionBeginnersCenter ; 91/C127

        .word GuideMenuNoSubpage

        .text "　初心者用説明ぶん。\n{End}"

      aGuideMenuPreviewAdvice ; 91/C143

        .word GuideMenuNoSubpage

        .text "　\n"
        .text "　わんぽいんとあどばいす\n"
        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "　　しっておいたら、ちょっとべんりな\n"
        .text "　ことをかいています。\n"
        .text "　\n"
        .text "　\n"
        .text "　\n"
        .text "　\n{End}"

      aGuideMenuSubpageAdvice ; 91/C1C1

        .structGuideMenuDataEntry aGuideMenuDescriptionAdvice1, aGuideMenuTitleAdvice1, 0 
        .structGuideMenuDataEntry aGuideMenuDescriptionAdvice2, aGuideMenuTitleAdvice2, 0 
        .structGuideMenuDataEntry aGuideMenuDescriptionAdvice3, aGuideMenuTitleAdvice3, 0 
        .word GuideMenuDataEnd

      aGuideMenuTitleAdvice1 ; 91/C1D5

        .text "アドバイス１\n"

      aGuideMenuTitleAdvice2 ; 91/C1E3

        .text "アドバイス２\n"

      aGuideMenuTitleAdvice3 ; 91/C1F1

        .text "アドバイス３\n"

      aGuideMenuDescriptionAdvice1 ; 91/C1FF

        .word GuideMenuNoSubpage

        .text "{Blue}捕える\n"
        .text "　\n"
        .text "　\n"
        .text "　こんかいの最大のポイントは、\n"
        .text "「捕える」です。\n"
        .text "　\n"
        .text "　リーフ軍は貧乏ですので、まめに捕えて\n"
        .text "アイテムを奪わないと、きずぐすりひとつ\n"
        .text "かうのにもこまります。\n"
        .text "　\n"
        .text "　また、捕えることによって発生する\n"
        .text "イベントもあります。\n{End}"

      aGuideMenuDescriptionAdvice2 ; 91/C2F3

        .word GuideMenuNoSubpage

        .text "{White}　「\n{Append}{Blue}盗む\n"
        .text "{White}」\n{Append}の活用\n"
        .text "　\n"
        .text "　\n"
        .text "　「盗む」という行動は、体格がアイテム\n"
        .text "の重さより大きくないといけないので、体\n"
        .text "格の小さい盗賊にはあまり役に立たないと\n"
        .text "思うかもしれません。\n"
        .text "　しかし、杖、道具には重さがないので、\n"
        .text "体格に関係なく盗めます。\n"
        .text "　\n"
        .text "　「捕える」ことのできない馬系ユニット\n"
        .text "などからもアイテムをとることができると\n"
        .text "いうことも、たいせつなことです。\n"
        .text "　\n{End}"

      aGuideMenuDescriptionAdvice3 ; 91/C46D

        .word GuideMenuNoSubpage

        .text "　馬系ユニットは最後に行動？\n"
        .text "　\n"
        .text "　\n"
        .text "　馬系ユニットは、他の徒歩ユニットを\n"
        .text "すべてかつぐことができます。\n"
        .text "　\n"
        .text "　もちろん、行動終了になったユニット\n"
        .text "もかつげますので、もう一度攻撃をうけ\n"
        .text "たらしぬ、といったユニットを、まもる\n"
        .text "ことができます。\n"
        .text "　\n"
        .text "　再行動もできるユニットなので、もし\n"
        .text "ものために、さいごに行動するとよいで\n"
        .text "しょう。\n"
        .text "　\n{End}"

      aGuideMenuSubpageCommands ; 91/C5C3

        .structGuideMenuDataEntry aGuideMenuDescriptionCommand1, aGuideMenuTitleCommand1, 0 
        .structGuideMenuDataEntry aGuideMenuDescriptionCommand2, aGuideMenuTitleCommand2, 0 
        .structGuideMenuDataEntry aGuideMenuDescriptionCommand3, aGuideMenuTitleCommand3, 0 
        .structGuideMenuDataEntry aGuideMenuDescriptionCommand4, aGuideMenuTitleCommand4, 0 
        .structGuideMenuDataEntry aGuideMenuDescriptionCommand5, aGuideMenuTitleCommand5, 0 
        .structGuideMenuDataEntry aGuideMenuDescriptionCommand6, aGuideMenuTitleCommand6, 0 
        .structGuideMenuDataEntry aGuideMenuDescriptionCommand7, aGuideMenuTitleCommand7, 0 
        .word GuideMenuDataEnd

      aGuideMenuTitleCommand1 ; 91/C5EF

        .text "コマンド１\n"

      aGuideMenuTitleCommand2 ; 91/C5FB

        .text "コマンド２\n"

      aGuideMenuTitleCommand3 ; 91/C607

        .text "コマンド３\n"

      aGuideMenuTitleCommand4 ; 91/C613

        .text "コマンド４\n"

      aGuideMenuTitleCommand5 ; 91/C61F

        .text "コマンド５\n"

      aGuideMenuTitleCommand6 ; 91/C62B

        .text "コマンド６\n"

      aGuideMenuTitleCommand7 ; 91/C637

        .text "コマンド７\n"

      aUnknown91C643 ; 91/C643

        .word GuideMenuNoSubpage

        .text "ＦＥ５そうさせつめい１\n"
        .text "ＦＥ５そうさせつめい２\n"
        .text "ＦＥ５そうさせつめい３\n"
        .text "ＦＥ５そうさせつめい４\n"
        .text "ＦＥ５そうさせつめい５\n"
        .text "ＦＥ５そうさせつめい６\n"
        .text "ＦＥ５そうさせつめい７\n"
        .text "ＦＥ５そうさせつめい８\n"
        .text "ＦＥ５そうさせつめい９\n"
        .text "ＦＥ５そうさせつめい１０\n"
        .text "ＦＥ５そうさせつめい１１\n"
        .text "ＦＥ５そうさせつめい１２\n"
        .text "ＦＥ５そうさせつめい１３\n"
        .text "ＦＥ５そうさせつめい１４\n"
        .text "ＦＥ５そうさせつめい１５\n"
        .text "ＦＥ５そうさせつめい１６\n"
        .text "ＦＥ５そうさせつめい１７\n"
        .text "ＦＥ５そうさせつめい１８\n"
        .text "ＦＥ５そうさせつめい１９\n"
        .text "ＦＥ５そうさせつめい２０\n"
        .text "ＦＥ５そうさせつめい２１\n"
        .text "ＦＥ５そうさせつめい２２\n"
        .text "ＦＥ５そうさせつめい２３\n"
        .text "ＦＥ５そうさせつめい２４\n{End}"

      aUnknown91C8A7 ; 91/C8A7

        .word GuideMenuNoSubpage

        .text "ＦＥ５そうさせつめい２\n{End}"

      aUnknown91C8C5 ; 91/C8C5

        .word GuideMenuNoSubpage

        .text "ＦＥ５そうさせつめい３\n{End}"

      aGuideMenuDescriptionNewDescription ; 91/C8E3

        .word GuideMenuNoSubpage

        .text "ＦＥ５しんこうせつめい\n{End}"

      aGuideMenuDescriptionCommand1 ; 91/C901

        .word GuideMenuNoSubpage

        .text "ＦＥ５コマンドせつめい１\n{End}"

      aGuideMenuDescriptionCommand2 ; 91/C921

        .word GuideMenuNoSubpage

        .text "ＦＥ５コマンドせつめい２\n{End}"

      aGuideMenuDescriptionCommand3 ; 91/C941

        .word GuideMenuNoSubpage

        .text "ＦＥ５コマンドせつめい３\n{End}"

      aGuideMenuDescriptionCommand4 ; 91/C961

        .word GuideMenuNoSubpage

        .text "ＦＥ５コマンドせつめい４\n{End}"

      aGuideMenuDescriptionCommand5 ; 91/C981

        .word GuideMenuNoSubpage

        .text "ＦＥ５コマンドせつめい５\n{End}"

      aGuideMenuDescriptionCommand6 ; 91/C9A1

        .word GuideMenuNoSubpage

        .text "ＦＥ５コマンドせつめい６\n{End}"

      aGuideMenuDescriptionCommand7 ; 91/C9C1

        .word GuideMenuNoSubpage

        .text "ＦＥ５コマンドせつめい７\n{End}"

        ; 91/C9E1

    .endsection GuideMenuDataSection

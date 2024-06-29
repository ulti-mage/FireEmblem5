
    .weak

      rlEnableVBlank                              :?= address($8082DA)
      rlDisableVBlank                             :?= address($8082E8)
      rlPlaySoundEffect                           :?= address($808C87)
      rlFadeInByTimer                             :?= address($80AB89)
      rlFadeOutByTimer                            :?= address($80ABC7)     
      rlDMAByStruct                               :?= address($80AE2E)
      rlDMAByPointer                              :?= address($80AEF9)
      rlAppendDecompList                          :?= address($80B00A)
      rlBlockCopy                                 :?= address($80B340)
      rlFillTilemapByWord                         :?= address($80E89F)
      rlActiveSpriteEngineClearAllSprites         :?= address($818219)
      rlProcEngineCreateProc                      :?= address($829BF1)
      rlProcEngineFindProc                        :?= address($829CEC)
      rlProcEngineFreeProc                        :?= address($829D11)
      procFadeOut1                                :?= address($82A137)
      procSetMainGameLoop                         :?= address($82A1BB)
      rlHDMAEngineCreateEntry                     :?= address($82A3ED)
      rlHDMAEngineFreeEntryByOffset               :?= address($82A582)
      rlHDMAEngineFindEntry                       :?= address($82A586)
      rlEnableBG1Sync                             :?= address($81B1FA)
      rlEnableBG3Sync                             :?= address($81B212)
      rlCheckIfSaveSlotValid                      :?= address($81C7A8)
      rlGetDemoEvents                             :?= address($9AE134)
      rlProcPaletteChange                         :?= address($8EEC3A)
      procMapBattlePaletteChange                  :?= address($8EEC55)
      rlSetCurrentMenuColor                       :?= address($859532)
      rlClearBGOFS                                :?= address($9A958A)
      rlLoadDefaultOptionWindowColors             :?= address($8594CE)
      rlFreeSaveSlotByIndex                       :?= address($81C8D0)
      rlSaveToSRAMSlot                            :?= address($81C568)
      rlFadeOutBackgroundMusic                    :?= address($9A833C)
      rlLoadSaveSlot                              :?= address($81C670)
      rlGetWorldMapEventPointer                   :?= address($8CCA65)
      rlFreezeRightFacingCursor                   :?= address($8EB0C1)
      rlActiveSpriteEngineFindEntry               :?= address($818187)
      rlActiveSpriteEngineClearSpriteByIndex      :?= address($818226)
      rlC2IConverter                              :?= address($95812F)
      rlCheckIfSaveSlotFilled                     :?= address($81C7E2)

      rlSetLayerPositionsAndSizesAlt              :?= address($80C356)
      ; This is like rlSetLayerPositionsAndSizes, but doesn't check for INIDISP
      ; and only writes the the buffers and not the actual registers.


      aBlackPalette                               :?= address($90B2F3)
      aWhitePalette                               :?= address($90B4F3)

      g4bppSystemIcons                            :?= address($F1F080)

      g2bppMenuTiles                              :?= address($F3CC80)
      
      g4bppMenuTileSetting1Graphics               :?= address($F48000)
      g4bppMenuTileSetting2Graphics               :?= address($F48800)
      g4bppMenuTileSetting3Graphics               :?= address($F49000)
      g4bppMenuTileSetting4Graphics               :?= address($F49800)
      g4bppMenuTileSetting5Graphics               :?= address($F4A000)
      g4bppUnknownMenuTileSettingGraphics         :?= address($F4A800)
      g4bppDarkMenuBackgroundTiles                :?= address($F4B000)


      aMenuTileSetting1Palette                    :?= address($F4FE00)
      aMenuTileSetting2Palette                    :?= address($F4FE20)
      aMenuTileSetting3Palette                    :?= address($F4FE40)
      aMenuTileSetting4Palette                    :?= address($F4FE60)
      aMenuTileSetting5Palette                    :?= address($F4FE80)
      aUnknownMenuTileSettingPalette              :?= address($F4FEA0)
      aDarkMenuBackgroundPalette                  :?= address($F4FEC0)

    .endweak

    .virtual $00158A

      wParagonModeCheckIndex   .word ?          ; $00158A
      wParagonModeUnlockedFlag .word ?          ; $00158C

    .endvirtual

    .virtual $7EA939

      aTitleMenu .block

        wSelectedOption .word ?                 ; $7EA939 
        aOptionsList .fill size(long) * 10      ; $7EA93B 
        wOptionsListIndex .word ?               ; $7EA959
        wXCoordinate .word ?                    ; $7EA95B
        wYOffset .word ?                        ; $7EA95D
        .union
          wCurrentOptionIndex .word ?           ; $7EA95F
          wYCoordinate .word ?
        .endunion
      .bend

      wTitleSaveSlotTileSetting .word ?         ; $7EA961
      aTitleValidSaveSlots .fill size(byte) * 3 ; $7EA963
      aSaveMenuActionIndex .word ?              ; $7EA966
        ; 0 = load save
        ; 1 = save game
        ; 2 = copy save
        ; 3 = delete save
        ; 4 = new save
      aSaveBoxHDMALineData1 .fill 224           ; $7EA968
      aSaveBoxHDMALineData2 .fill 224           ; $7EAA48
      wSaveBoxHDMAVOFS .word ?                  ; $7EAB28
      wSaveBoxHDMAScanlineOffset .word ?        ; $7EAB2A
      wSaveBoxHDMAControlCode .word ?           ; $7EAB2C
        ; 0 = Halt
        ; 1 = Fold
        ; 2 = Unfold
      wTitleParagonEnableFlag .word ?           ; $7EAB2E

    .endvirtual

    .virtual $7EAF63

      wSaveSlotChapter .word ?                  ; $7EAF63
      wSaveSlotTurn .word ?                     ; $7EAF65

    .endvirtual

    .virtual $7EAF6F

      wSaveSlotTileSetting .word ?              ; $7EAF6F

    .endvirtual



    ; Helpers:

    procSaveOption .namespace

      SelectedSaveIndex       := aProcSystem.aBody0
      SelectedSaveIndexBuffer := aProcSystem.aBody1
      CursorProcOffset        := aProcSystem.aBody2
      CursorProcOffsetBuffer  := aProcSystem.aBody3
      ; The buffers are used for the original save when using copy.
      ConfirmMenuOption       := aProcSystem.aBody4

    .endnamespace


    structPaletteChangeData .struct CurrentPalettePointer, DestinationPalettePointer, LastColorOffset, MaxPaletteChangeCounter, MaxAdjustmentsCounter, GradualStepFlag
      .if (\GradualStepFlag === ?)
        CurrentPaletteOffset     .word ?
        DestinationPaletteOffset .word ?
        DestinationPaletteBank   .byte ?
        LastColorOffset          .byte ?
        MaxPaletteChangeCounter  .byte ?
        MaxAdjustmentsCounter    .word ?
        GradualStepFlag          .byte ?
      .else
        CurrentPaletteOffset     .word (\CurrentPalettePointer-aBGPaletteBuffer)/2          ; 0
        DestinationPaletteOffset .word (<>\DestinationPalettePointer)                       ; 2
        DestinationPaletteBank   .byte `\DestinationPalettePointer                          ; 4
        LastColorOffset          .byte ((<>\LastColorOffset)-(<>\CurrentPalettePointer))/2  ; 5
        MaxPaletteChangeCounter  .byte \MaxPaletteChangeCounter                             ; 6
        MaxAdjustmentsCounter    .word \MaxAdjustmentsCounter                               ; 7
        GradualStepFlag          .byte int(\GradualStepFlag)<<7                             ; 9
      .endif
    .endstruct

    PaletteFadeToBlack := 0
    PaletteFadeToWhite := $FFFF


    macroFindAndFreeProc .segment Proc
      phx
      lda #(`\Proc)<<8
      sta lR44+1
      lda #<>\Proc
      sta lR44
      jsl rlProcEngineFindProc
      bcc +
      
      stz aProcSystem.aHeaderSleepTimer,b,x
      jsl rlProcEngineFreeProc
      
      clc
      bra ++

      +
      sec
      
      +
      plx
    .endsegment










    TitleScreenConfig .namespace

      ; VRAM positions

        OAMBase = $0000
        BG1Base = $4000
        BG2Base = BG1Base
        BG3Base = $A000

        BG4Base = BG3Base
        ; This is set, but never used since the screen isn't using Mode0.

        OAMTilesPosition := OAMBase
        OAMAllocate .function Size
          Return := TitleScreenConfig.OAMTilesPosition
          TitleScreenConfig.OAMTilesPosition += Size
        .endfunction Return

        BG12TilesPosition := BG1Base
        BG12Allocate .function Size
          Return := TitleScreenConfig.BG12TilesPosition
          TitleScreenConfig.BG12TilesPosition += Size
        .endfunction Return

        BG3TilesPosition := BG3Base
        BG3Allocate .function Size
          Return := TitleScreenConfig.BG3TilesPosition
          TitleScreenConfig.BG3TilesPosition += Size
        .endfunction Return


        FireEmblemBannerGraphicPosition = OAMAllocate(16 * 16 * size(Tile4bpp))   ; $0000 - $2000
        SystemIconTilesPosition = OAMAllocate(16 * 2 * size(Tile4bpp))            ; $2000 - $2400

        _ := OAMAllocate($3000 - OAMTilesPosition)
        ThirteenYearsLaterGraphicPosition = OAMAllocate(16 * 4 * size(Tile4bpp))  ; $3000 - $3800


        FireEmblemGraphicPosition = BG12Allocate(16 * 16 * size(Tile4bpp))        ; $4000 - $6000

        FireEmblemCrestGraphicPosition = BG12Allocate(16 * 32 * size(Tile4bpp))   ; $6000 - $A000


        BG3TilemapPosition = BG3Allocate(32 * 32 * size(word))                    ; $A000 - $A800


        _ := BG3Allocate($B800 - BG3TilesPosition)
        MenuTextTilesPosition = BG3Allocate(16 * 40 * size(Tile2bpp))             ; $B800 - $E000
        ; Last 2 rows are overwritten by the flame graphic

        _ := BG12Allocate($E000 - BG12TilesPosition)
        BG1TilemapPosition = BG12Allocate(64 * 32 * size(word))                   ; $E000 - $F000
        BG2TilemapPosition = BG12Allocate(64 * 32 * size(word))                   ; $F000 - to end of VRAM


        BG12CrestGraphicBaseTile = VRAMToTile(FireEmblemCrestGraphicPosition, BG1Base, size(Tile4bpp))
        BG12BlankTile = TilemapEntry(BG12CrestGraphicBaseTile + C2I((15,31)), 0, false, false, false)

        BG3MenuTilesBaseTile = VRAMToTile(MenuTextTilesPosition, BG3Base, size(Tile2bpp))
        BG3BlankTile = TilemapEntry(BG3MenuTilesBaseTile + C2I((15,5)), 0, false, false, false)


        ; Pixel coordinates
        FireEmblemBanner    = (128, 159)
        NintendoCopyright   = (128, 204)
        ThirteenYearsLater  = (128, 100)

    .endnamespace ; TitleScreenConfig


    TitleMenuConfig .namespace 

      ; VRAM positions

        OAMBase = $0000
        BG1Base = $4000
        BG2Base = BG1Base
        BG3Base = $A000

        OAMTilesPosition := OAMBase
        OAMAllocate .function Size
          Return := TitleMenuConfig.OAMTilesPosition
          TitleMenuConfig.OAMTilesPosition += Size
        .endfunction Return

        BG12TilesPosition := BG1Base
        BG12Allocate .function Size
          Return := TitleMenuConfig.BG12TilesPosition
          TitleMenuConfig.BG12TilesPosition += Size
        .endfunction Return

        BG3TilesPosition := BG3Base
        BG3Allocate .function Size
          Return := TitleMenuConfig.BG3TilesPosition
          TitleMenuConfig.BG3TilesPosition += Size
        .endfunction Return


        _ := OAMAllocate($2000 - OAMTilesPosition)
        SystemIconTilesPosition = OAMAllocate(16 * 2 * size(Tile4bpp))                    ; $2000 - $2400

        DarkMenuBackgroundTilesPosition = BG12Allocate(16 * 4 * size(Tile4bpp))           ; $4000 - $4800
        SaveBackgroundGraphicPosition = BG12Allocate(3 * (16 * 4 * size(Tile4bpp)))       ; $4800 - $6000
        FireEmblemCrestGraphicPosition = BG12Allocate(16 * 32 * size(Tile4bpp))           ; $6000 - $A000

        BG3TilemapPage0Position = BG3Allocate(32 * 32 * size(word))                       ; $A000 - $A800
        BG3TilemapPage1Position = BG3Allocate(32 * 32 * size(word))                       ; $A800 - $B000


        _ := BG3Allocate($B180 - BG3TilesPosition)
        TitleMenuOptionTextPosition = BG3Allocate(TitleMenuMaxOptionsCount * (12 * 2 * size(Tile2bpp))) ; $B180 - $BB40

        _ := BG3Allocate($BC00 - BG3TilesPosition)
        SaveHeaderTilesPosition = BG3Allocate(12 * 2 * size(Tile2bpp))                    ; $BC00 - $BD80

        _ := BG3Allocate($BF00 - BG3TilesPosition)
        SaveSlotTextTilesPosition = BG3Allocate(3 * (SaveSlotTextSize[0] * SaveSlotTextSize[1] * size(Tile2bpp)))    ; $BF00 - $C800
        SaveConfirmTextTilesPosition = BG3Allocate(SaveConfirmTextSize[0] * SaveConfirmTextSize[1] * size(Tile2bpp)) ; $C800 - $C960

        MenuTextTilesPosition = $B800                                                     ; $B800 - $E000
        ; This just keeps getting overwritten by all kinds of stuff so the alloc doesn't quite work
        ; Would be: BG3Allocate(16 * 40 * size(Tile2bpp))

        _ := BG12Allocate($E000 - BG12TilesPosition)
        BG1TilemapPage0Position = BG12Allocate(32 * 32 * size(word))                      ; $E000 - $E800
        BG1TilemapPage1Position = BG12Allocate(32 * 32 * size(word))                      ; $E800 - $F000
        BG2TilemapPosition = BG12Allocate(64 * 32 * size(word))                           ; $F000 - to end of VRAM


        BG12CrestGraphicBaseTile = VRAMToTile(FireEmblemCrestGraphicPosition, BG1Base, size(Tile4bpp))
        DarkMenuBackgroundTilesBaseTile = VRAMToTile(DarkMenuBackgroundTilesPosition, BG1Base, size(Tile4bpp))

        BG12BlankTile = TilemapEntry(BG12CrestGraphicBaseTile + C2I((15,31)), 0, false, false, false)
        BG12BlankTileAlt = TilemapEntry(DarkMenuBackgroundTilesBaseTile + C2I((15,7)), 0, false, false, false)

        BG3MenuTilesBaseTile = VRAMToTile(MenuTextTilesPosition, BG3Base, size(Tile2bpp))
        BG3BlankTile = TilemapEntry(BG3MenuTilesBaseTile + C2I((15,5)), 0, false, false, false)

        IntroTimelineTilesBaseTile = VRAMToTile(BG3TilemapPage0Position, BG3Base, size(Tile2bpp))
        IntroTimelineBlankTile = TilemapEntry(IntroTimelineTilesBaseTile + C2I((0, 8)), 0, false, false, false)
        IntroTimelineTextBaseTile = $A810


        TitleMenuMaxOptionsCount = 7
        MaxSaveSlotIndex = 2

        TitleMenuPosition   = (9, 12)
        ; The Y position is irrelevant since its recalculated anyway

        TitleMenuOptionSize = (14, 4)

        SaveHeaderPosition  = (9, 3)
        SaveHeaderSize      = (14, 4)

        SaveHeaderTextPosition = (255, 4)
        SaveHeaderTextSize = (12, 2)

        SaveSlotPosition    = (3, 9)
        SaveSlotSize        = (26, 4)

        SaveSlotTextPosition  = (4, 10)
        SaveSlotTextSize      = (24, 2)

        SaveSlotCursorPixelPosition = (8, 80)

        SaveConfirmPosition = (8, 22)
        SaveConfirmSize     = (16, 4)

        SaveConfirmTextPosition = (11, 23)
        SaveConfirmTextSize = (14, 2)

        IntroTimelineInitialTileOffset = (3, 28)

    .endnamespace ; TitleMenuConfig


    .section TitleMenu1Section

      .with TitleMenuConfig


      procTitle .structProcInfo "xx", None, None, aProcTitleCode ; 94/ADE9

      procTitleMenuNewSave .structProcInfo "ft", rlProcTitleMenuNewSaveInit, None, aProcCodeHandleChosenTitleOption ; 94/ADF1

      procTitleMenuLoadSave .structProcInfo "ft", rlProcLoadSaveInit, None, aProcCodeHandleChosenTitleOption ; 94/ADF9

      procTitleMenuCopySave .structProcInfo "ft", rlProcCopySaveInit, None, aProcCodeHandleChosenTitleOption ; 94/AE01

      procTitleMenuDeleteSave .structProcInfo "ft", rlProcDeleteSaveInit, None, aProcCodeHandleChosenTitleOption ; 94/AE09

      procMapLoadSave .structProcInfo "ll", rlProcLoadSaveInit, None, aProcMapLoadSaveCode ; 94/AE11

      procMapSaveGame .structProcInfo "sv", rlProcSaveGameInit, None, aProcMapSaveGameCode ; 94/AE19

      procMapCopySave .structProcInfo "lc", rlProcCopySaveInit, None, aProcMapCopySaveCode ; 94/AE21

      procMapDeleteSave .structProcInfo "ld", rlProcDeleteSaveInit, None, aProcMapDeleteSaveCode ; 94/AE29

      rlProcTitleMenuNewSaveInit ; 94/AE31

        .al
        .autsiz
        .databank ?

        lda #4
        sta aSaveMenuActionIndex
        rtl

        .databank 0

      rlProcLoadSaveInit ; 94/AE39

        .al
        .autsiz
        .databank ?

        lda #0
        sta aSaveMenuActionIndex
        rtl

        .databank 0

      rlProcSaveGameInit ; 94/AE41

        .al
        .autsiz
        .databank ?

        lda #1
        sta aSaveMenuActionIndex
        rtl

        .databank 0

      rlProcCopySaveInit ; 94/AE49

        .al
        .autsiz
        .databank ?

        lda #2
        sta aSaveMenuActionIndex
        rtl

        .databank 0

      rlProcDeleteSaveInit ; 94/AE51

        .al
        .autsiz
        .databank ?

        lda #3
        sta aSaveMenuActionIndex
        rtl

        .databank 0

      rlSelectFirstValidSaveSlot ; 94/AE59

        .al
        .autsiz
        .databank ?

        stz procSaveOption.SelectedSaveIndex,b,x

        jsr rsGetFirstValidSaveSlot

        lda #-1
        sta procSaveOption.SelectedSaveIndexBuffer,b,x
        rtl

        .databank 0

      rlSelectPreviousSaveSlot ; 94/AE66

        .al
        .autsiz
        .databank ?

        ; This is used by the copy option to get the first selected
        ; save back.

        lda procSaveOption.SelectedSaveIndexBuffer,b,x
        bmi +

          lda procSaveOption.SelectedSaveIndexBuffer,b,x
          sta procSaveOption.SelectedSaveIndex,b,x

          jsr rsGetFirstValidSaveSlot

        +
        rtl

        .databank 0

      rlSelectLastUsedSaveSlot ; 94/AE75

        .al
        .autsiz
        .databank ?

        ; This is used to pick the file you used when you last played.

        lda aSRAM.aSaveDataHeader.LastFile
        and #$00FF
        cmp #MaxSaveSlotIndex + 1
        bcc +

          lda #0
          sta aSRAM.aSaveDataHeader.LastFile

        +
        sta procSaveOption.SelectedSaveIndex,b,x
        jsr rsGetFirstValidSaveSlot
        rtl

        .databank 0

        .endwith ; TitleMenuConfig

    .endsection TitleMenu1Section

    .section TitleScreen1Section

      .with TitleScreenConfig


      aProcTitleCode ; 94/AE8F

        PROC_SONG_FADE_OUT 0

        PROC_CALL_ARGS rlTitleSetFadeTimer, size(+)
        + .block
          .byte 1
        .bend

        -
        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_FALSE -, rlTitleWaitForFadeOut

        PROC_CALL rlTitleScreenSetHardwareRegisters

        PROC_CREATE_PROC procCreateTitleScreen
        PROC_HALT_WHILE procCreateTitleScreen

        PROC_CALL rlDrawTitleScreenBanner
        PROC_CALL rlDrawNintendoCopyright
        PROC_CALL rlLoadTitleScreenPalettes

        ; Skip the title screen and go straight to the menu if you are holding Start
        PROC_JUMP_IF_BUTTON _SkipTitle, JOY_Start

          PROC_PLAY_SONG $0023
          PROC_HALT_UNTIL_SONG_PLAYING

          PROC_YIELD 1

          PROC_CALL rlCreateTitleFlameWaveHDMA

          PROC_CREATE_PROC procTitleFlameScroll

          PROC_CALL_ARGS rlTitleSetFadeTimer, size(+)
          + .block
            .byte 4
          .bend

          -
          PROC_YIELD 1
          PROC_JUMP_IF_ROUTINE_FALSE -, rlTitleWaitForFadeIn

          PROC_CALL rlSetTitleIdleLongTimer

          PROC_JUMP +

            _ShortTimer
            PROC_CALL rlSetTitleIdleShortTimer

          +
          PROC_SET_ONCYCLE rlProcCycleRunDemoEvents
          PROC_YIELD 1
          PROC_SET_ONCYCLE None

          PROC_BL aProcCodeClearTitleScreen

          _End
          PROC_CALL rlCreateTitleMenuProc
          PROC_END

        _SkipTitle
        PROC_CALL rlTitleSkipped

        PROC_CALL_ARGS rlTitleSetFadeTimer, size(+)
        + .block
          .byte 1
        .bend

        -
        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_FALSE -, rlTitleWaitForFadeIn

        PROC_JUMP _End

      rlTitleSkipped ; 94/AF25

        .al
        .autsiz
        .databank ?

        jsl rlClearTitleScreenSprites

        ; Stop BG music
        jsl $9A8380

        sep #$20
        lda #T_Setting(false, true, false, false, false)
        sta bBufferTM
        rep #$20
        rtl

        .databank 0

      rlCreateTitleMenuProc ; 94/AF36

        .al
        .autsiz
        .databank ?

        jsl rlClearTitleFlameWaveHDMA
        jsl rlClearBGOFS

        macroFindAndFreeProc procTitleFlameScroll

        lda #(`procTitleMenu)<<8
        sta lR44+1
        lda #<>procTitleMenu
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        .endwith ; TitleScreenConfig

    .endsection TitleScreen1Section

    .section TitleMenu2Section

      .with TitleMenuConfig


      aProcCodeHandleChosenTitleOption ; 94/AF6A

        PROC_CALL rlDrawSaveMenuHeader
        PROC_HALT_WHILE procDialogue94CCDF

        PROC_CALL rlUpdateVRAMBG3Page1

        PROC_YIELD 1

        PROC_CREATE_PROC procTitleScrollRight
        PROC_HALT_WHILE procTitleScrollRight

        PROC_SET_ONCYCLE rlProcCycleGetSelectedOptionProcCode
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_END

      rlDrawSaveMenuHeader ; 94/AF91

        .al
        .autsiz
        .databank ?

        ; Clears the top center text

        lda #(`aDecompressionBuffer + (32 * 32 * size(word)))<<8
        sta lR18+1
        lda #<>aDecompressionBuffer + (32 * 32 * size(word))
        sta lR18
        lda #(`aBG3TilemapBuffer.Page1 + (32 * 4 * size(word)))<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer.Page1 + (32 * 4 * size(word))
        sta lR19
        lda #(32 * SaveHeaderTextSize[1] * size(word))
        sta lR20
        jsl rlBlockCopy

        lda aSaveMenuActionIndex
        asl a
        clc
        adc aSaveMenuActionIndex
        tax
        lda aSaveFileHeaderTextPointers,x
        sta lR18
        lda aSaveFileHeaderTextPointers+1,x
        sta lR18+1

        lda #SaveHeaderTilesPosition - BG3Base >> 1
        sta wR0

        lda #2
        sta wR1

        ldx #pack([SaveHeaderTextPosition[0], SaveHeaderTextPosition[1] + 32])
        
        lda #0
        sta wR2

        lda #0
        sta wR3

        jsl rlDrawDialogueText
        rtl

        .databank 0

      aSaveFileHeaderTextPointers ; 94/AFE1

        .long $908033 ; load save
        .long $90803F ; save game
        .long $908053 ; copy save
        .long $90805D ; delete save
        .long $908026 ; new save

      rlProcCycleGetSelectedOptionProcCode ; 94/AFF0

        .al
        .autsiz
        .databank ?

        lda #1
        sta aProcSystem.aHeaderSleepTimer,b,x

        lda aSaveMenuActionIndex
        asl a
        tax
        lda aTitleSelectedOptionProcCode,x
        ldx aProcSystem.wOffset,b
        sta aProcSystem.aHeaderCodeOffset,b,x
        rtl

        .databank 0

      aTitleSelectedOptionProcCode ; 94/B007

        .word <>aProcCodeTitleMenuLoadSave
        .word <>aProcCodeTitleMenuSaveGame
        .word <>aProcCodeTitleMenuCopySave
        .word <>aProcCodeTitleMenuDeleteSave
        .word <>aProcCodeTitleMenuNewSave

      aProcCodeTitleMenuNewSave ; 94/B011

        PROC_CALL rlSelectFirstValidSaveSlot
        PROC_CALL rlCreateSaveSlotCursor
        
        PROC_SET_ONCYCLE rlProcCycleSaveInputHandler
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_PLAY_SFX $0016

        PROC_CALL rlSetUpNewSaveFile

        PROC_BL aProcCodeUpdateSaveSlot

        PROC_CALL rlNewSaveWrapUp
        PROC_END

      aProcMapLoadSaveCode ; 94/B039

        PROC_SONG_FADE_OUT 0

        PROC_CALL_ARGS rlTitleSetFadeTimer, size(+)
        + .block
          .byte 1
        .bend

        -
        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_FALSE -, rlTitleWaitForFadeOut

        PROC_SET_ONCYCLE rlProcCycleBuildMapSaveMenu
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_SET_ONCYCLE rlProcCycleHandleMapSavePaletteText1
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_CALL rlDrawSaveMenuHeader

        PROC_HALT_WHILE procDialogue94CCDF

        PROC_CALL rlUpdateVRAMBG3Page1
        PROC_YIELD 1

        PROC_CALL_ARGS rlTitleSetFadeTimer, size(+)
        + .block
          .byte 1
        .bend

        -
        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_FALSE -, rlTitleWaitForFadeIn

      aProcCodeTitleMenuLoadSave ; 94/B082

        PROC_CALL rlSelectLastUsedSaveSlot

        -
        PROC_CALL rlCreateSaveSlotCursor

        -
        PROC_SET_ONCYCLE rlProcCycleSaveInputHandler
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_JUMP_IF_ROUTINE_TRUE +, rlCheckIfSelectedSaveSlotValid

          PROC_PLAY_SFX $0022
          PROC_JUMP -

        +
        PROC_PLAY_SFX $000D

        PROC_JUMP_IF_ROUTINE_FALSE +, rlSaveMenuTryLoadChapter

          PROC_JUMP --

        +
        PROC_END

      aProcMapSaveGameCode ; 94/B0B6

        PROC_JUMP_IF_ROUTINE_TRUE +, rlSaveGameCheckIfOnPrepScreen

          PROC_SONG_FADE_OUT 0

        +
        PROC_CALL_ARGS rlTitleSetFadeTimer, size(+)
        + .block
          .byte 1
        .bend

        -
        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_FALSE -, rlTitleWaitForFadeOut

        PROC_SET_ONCYCLE rlProcCycleBuildMapSaveMenu
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_YIELD 1

        PROC_SET_ONCYCLE rlProcCycleHandleMapSavePaletteText1
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_CALL rlDrawSaveMenuHeader
        PROC_HALT_WHILE procDialogue94CCDF

        PROC_CALL rlUpdateVRAMBG3Page1
        PROC_YIELD 1

        PROC_CALL_ARGS rlTitleSetFadeTimer, size(+)
        + .block
          .byte 1
        .bend

        -
        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_FALSE -, rlTitleWaitForFadeIn

      aProcCodeTitleMenuSaveGame ; 94/B108

        PROC_CALL rlSelectLastUsedSaveSlot

        _Cancel
        PROC_CALL rlCreateSaveSlotCursor

        PROC_SET_ONCYCLE rlProcCycleSaveInputHandler
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_PLAY_SFX $000D

        PROC_CALL rlCreateSaveConfirmMenuCursor

        PROC_BL aProcCodeCreateSaveConfirmMenuBox

        PROC_SET_ONCYCLE rlProcCycleSaveConfirmMenuInputHandler
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_BL aProcCodeClearSaveConfirmMenuBox

        PROC_SET_ONCYCLE rlProcCycleHandleSaveConfirmMenuCancel
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_PLAY_SFX $0016

        PROC_CALL rlOverwriteSelectedSaveSlot

        PROC_BL aProcCodeUpdateSaveSlot

        PROC_CALL rlSaveMenuRunCallback

        PROC_END

      aProcMapDeleteSaveCode ; 94/B155

        PROC_CALL_ARGS rlTitleSetFadeTimer, size(+)
        + .block
          .byte 1
        .bend

        -
        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_FALSE -, rlTitleWaitForFadeOut

        PROC_SET_ONCYCLE rlProcCycleBuildMapSaveMenu
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_YIELD 1

        PROC_SET_ONCYCLE rlProcCycleHandleMapSavePaletteText1
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_CALL rlDrawSaveMenuHeader
        PROC_HALT_WHILE procDialogue94CCDF

        PROC_CALL rlUpdateVRAMBG3Page1

        PROC_YIELD 1

        PROC_CALL_ARGS rlTitleSetFadeTimer, size(+)
        + .block
          .byte 1
        .bend

        -
        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_FALSE -, rlTitleWaitForFadeIn

      aProcCodeTitleMenuDeleteSave ; 94/B19C

        PROC_CALL rlSelectFirstValidSaveSlot

        _Cancel
        PROC_CALL rlCreateSaveSlotCursor

        -
        PROC_SET_ONCYCLE rlProcCycleSaveInputHandler
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_JUMP_IF_ROUTINE_TRUE +, rlCheckIfSelectedSaveSlotValid

          PROC_PLAY_SFX $0022
          PROC_JUMP -

        +
        PROC_PLAY_SFX $000D

        PROC_CALL rlCreateSaveConfirmMenuCursor

        PROC_BL aProcCodeCreateSaveConfirmMenuBox

        PROC_SET_ONCYCLE rlProcCycleSaveConfirmMenuInputHandler
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_BL aProcCodeClearSaveConfirmMenuBox

        PROC_SET_ONCYCLE rlProcCycleHandleSaveConfirmMenuCancel
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_PLAY_SFX $000D

        PROC_CALL rlSaveMenuDeleteSaveSlot

        PROC_BL aProcCodeUpdateSaveSlot

        PROC_SET_ONCYCLE rlProcCycleExitDeleteSaveOnNoSavesFilled
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_JUMP _Cancel

      aProcMapCopySaveCode ; 94/B1FF

        PROC_CALL_ARGS rlTitleSetFadeTimer, size(+)
        + .block
          .byte 1
        .bend

        -
        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_FALSE -, rlTitleWaitForFadeOut

        PROC_SET_ONCYCLE rlProcCycleBuildMapSaveMenu
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_YIELD 1

        PROC_SET_ONCYCLE rlProcCycleHandleMapSavePaletteText1
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_CALL rlDrawSaveMenuHeader
        PROC_HALT_WHILE procDialogue94CCDF

        PROC_CALL rlUpdateVRAMBG3Page1

        PROC_YIELD 1

        PROC_CALL_ARGS rlTitleSetFadeTimer, size(+)
        + .block
          .byte 1
        .bend

        -
        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_FALSE -, rlTitleWaitForFadeIn

      aProcCodeTitleMenuCopySave ; 94/B246

        PROC_CALL rlSelectFirstValidSaveSlot

        _Cancel
        PROC_CALL rlSelectPreviousSaveSlot
        PROC_CALL rlCreateSaveSlotCursor

        PROC_SET_ONCYCLE rlProcCycleSaveInputHandler
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_PLAY_SFX $000D

        PROC_CALL rlCreateSecondSaveSlotCursor

        PROC_SET_ONCYCLE rlProcCycleCopyInputHandler
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_PLAY_SFX $000D

        PROC_CALL rlCreateSaveConfirmMenuCursor

        PROC_BL aProcCodeCreateSaveConfirmMenuBox

        PROC_SET_ONCYCLE rlProcCycleSaveConfirmMenuInputHandler
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_BL aProcCodeClearSaveConfirmMenuBox

        PROC_SET_ONCYCLE rlProcCycleHandleSaveConfirmMenuCancel
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_PLAY_SFX $000D

        PROC_CALL rlSaveMenuCopySaveSlot

        PROC_BL aProcCodeUpdateSaveSlot

        PROC_SET_ONCYCLE rlProcCycleExitCopySaveOnAllSavesFilled
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_JUMP _Cancel

        PROC_END

      aProcCodeUpdateSaveSlot ; 94/B2B4

        PROC_CALL rlEvaluateSaveSlots
        PROC_CALL rlCreateSaveBoxFoldingHDMA
        PROC_CALL rlSetSaveBoxHDMAFold

        -
        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_FALSE -, rlCheckIfSaveBoxFoldingHDMAHalt

        PROC_CALL rlUpdateFoldedSaveSlotBGGraphics

        PROC_HALT_WHILE procDialogue94CCDF

        PROC_CALL rlUpdateVRAMBG3Page1
        PROC_CALL rlSetSaveBoxHDMAUnfold

        -
        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_FALSE -, rlCheckIfSaveBoxFoldingHDMAHalt

        PROC_YIELD 8

        PROC_CALL rlClearSaveBoxFoldingHDMA

        PROC_YIELD 1

        PROC_RETURN

      rlSaveGameCheckIfOnPrepScreen ; 94/B2F4

        .al
        .autsiz
        .databank ?

        lda wPrepScreenFlag,b
        beq +

          sec
          rtl

        +
        clc
        rtl

        .databank 0

      rlSetUpNewSaveFile ; 94/B2FD

        .al
        .autsiz
        .databank ?

        lda procSaveOption.SelectedSaveIndex,b,x
        sta $7E4FB8

        jsl rlSetNewGameOptions

        lda wTitleParagonEnableFlag
        sta wParagonModeEnable,b

        jsl rlOverwriteSelectedSaveSlot
        rtl

        .databank 0

      rlNewSaveWrapUp ; 94/B314

        .al
        .autsiz
        .databank ?

        lda #<>$80BF58
        sta aProcSystem.wInput0,b

        lda #(`procFadeWithCallback)<<8
        sta lR44+1
        lda #<>procFadeWithCallback
        sta lR44
        jsl rlProcEngineCreateProc

        jsl rlLoadDefaultOptionWindowColors
        jsl rlSetCurrentMenuColor

        macroFindAndFreeProc procRightFacingCursor

        rtl

        .databank 0

      rlSaveMenuCopySaveSlot ; 94/B34E

        .al
        .autsiz
        .databank ?

        lda procSaveOption.SelectedSaveIndexBuffer,b,x
        sta wR0
        lda procSaveOption.SelectedSaveIndex,b,x
        sta wR1

        lda wR0
        jsr rsSaveMenuGetSRAMSaveSlotPointer
        sta lR18

        sep #$20
        lda #`aSRAM
        sta lR18+2
        rep #$20

        lda wR1
        jsr rsSaveMenuGetSRAMSaveSlotPointer
        sta lR19

        sep #$20
        lda #`aSRAM
        sta lR19+2
        rep #$20

        lda #size(structSaveDataEntry)
        sta lR20
        jsl rlBlockCopy

        macroFindAndFreeProc procRightFacingCursor
        macroFindAndFreeProc procRightFacingCursor

        rtl

        .databank 0

      rlProcCycleExitCopySaveOnAllSavesFilled ; 94/B3BA

        .al
        .autsiz
        .databank ?

        lda #1
        sta aProcSystem.aHeaderSleepTimer,b,x

        jsr rsGetFilledSaveSlotCount

        lda wR0
        cmp #3
        bne +

          jsl rlSaveMenuHandleBPress

        +
        rtl

        .databank 0

      rlProcCycleExitDeleteSaveOnNoSavesFilled ; 94/B3CF

        .al
        .autsiz
        .databank ?

        lda #1
        sta aProcSystem.aHeaderSleepTimer,b,x

        jsr rsGetFilledSaveSlotCount
        bcs +

          jsl rlSaveMenuHandleBPress

        +
        rtl

        .databank 0

      rlCheckIfSelectedSaveSlotValid ; 94/B3DF

        .al
        .autsiz
        .databank ?

        lda procSaveOption.SelectedSaveIndex,b,x
        jsl rlCheckIfSaveSlotValid
        rtl

        .databank 0

      rlSaveMenuDeleteSaveSlot ; 94/B3E7

        .al
        .autsiz
        .databank ?

        lda #1
        sta aProcSystem.aHeaderSleepTimer,b,x

        lda procSaveOption.SelectedSaveIndex,b,x
        sta aTitleMenu.wCurrentOptionIndex

        jsl rlCheckIfSaveSlotValid
        bcc +

          lda aTitleMenu.wCurrentOptionIndex
          jsl rlFreeSaveSlotByIndex

        +
        rtl

        .databank 0

      rlUpdateFoldedSaveSlotBGGraphics ; 94/B403

        .al
        .autsiz
        .databank ?

        lda procSaveOption.SelectedSaveIndex,b,x
        sta aTitleMenu.wCurrentOptionIndex
        jsr rsUpdateFoldedSaveSlotBGGraphicsEffect
        rtl

        .databank 0

        .endwith ; TitleMenuConfig

    .endsection TitleMenu2Section

    .section TitleScreen2Section

      .with TitleScreenConfig


      rlSetTitleIdleShortTimer ; 94/B40E

        .al
        .autsiz
        .databank ?

        lda #785
        sta aProcSystem.aBody0,b,x
        rtl

        .databank 0

      rlSetTitleIdleLongTimer ; 94/B415

        .al
        .autsiz
        .databank ?

        lda #810
        sta aProcSystem.aBody0,b,x
        rtl

        .databank 0

      rlProcCycleRunDemoEvents ; 94/B41C

        .al
        .autsiz
        .databank ?

        ; If timer hits 0, play demo events

        dec aProcSystem.aBody0,b,x
        bne +

          stz aProcSystem.aHeaderSleepTimer,b,x
          jsl rlProcEngineFreeProc
          jsl rlGetDemoEvents
          rtl

        +
        stz aProcSystem.aHeaderSleepTimer,b,x

        ; While the timer is counting down, hit start to fall through and get to the title menu

        lda wJoy1New
        bit #JOY_Start
        beq +

          lda #1
          sta aProcSystem.aHeaderSleepTimer,b,x

          lda #$0015
          jsl rlPlaySoundEffect
        
        +
        rtl

        .databank 0

      aProcCodeClearTitleScreen ; 94/B445

        PROC_CALL rlClearTitleScreenSprites

        ; Makes the 'Fire Emblem' graphic fade out

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block 
          .structPaletteChangeData aBGPaletteBuffer.aPalette2, PaletteFadeToBlack, aBGPaletteBuffer.aPalette4, None, 256, false
        .bend

        PROC_YIELD 40

        PROC_RETURN

      rlClearTitleScreenSprites ; 94/B45E

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #CGWSEL_Setting(false, true, CGWSEL_MathAlways, CGWSEL_BlackNever)
        sta bBufferCGWSEL

        lda #CGADSUB_Setting(CGADSUB_Add, false, true, false, false, false, false, false)
        sta bBufferCGADSUB

        lda #T_Setting(true, true, false, false, true)
        sta bBufferTM

        lda #T_Setting(false, true, false, false, false)
        sta bBufferTS
        rep #$20

        jsl rlActiveSpriteEngineClearAllSprites
        rtl

        .databank 0

        .endwith ; TitleScreenConfig

    .endsection TitleScreen2Section

    .section TitleMenu3Section

      .with TitleMenuConfig


      rlUnknown94B477 ; 94/B477

        .al
        .autsiz
        .databank ?

        ; Handles setup and creation of a procMapLoadSave

        jsl $80C11F
        rtl

        .databank 0

      rsCheckIfLeavingTitleMenu ; 94/B47C

        .al
        .autsiz
        .databank ?

        ; Check how we entered the save menu in the first place
        ; If we are on the MapSaveGame proc, it had to have been the map.
        ; Then check for the procs available on the title menu.
        ; Any others don't return to the title menu

        lda #(`procMapSaveGame)<<8
        sta lR44+1
        lda #<>procMapSaveGame
        sta lR44
        jsl rlProcEngineFindProc
        bcs _SEC

          lda #(`procTitleMenuNewSave)<<8
          sta lR44+1
          lda #<>procTitleMenuNewSave
          sta lR44
          jsl rlProcEngineFindProc
          bcs _CLC

          lda #(`procTitleMenuLoadSave)<<8
          sta lR44+1
          lda #<>procTitleMenuLoadSave
          sta lR44
          jsl rlProcEngineFindProc
          bcs _CLC

          lda #(`procTitleMenuCopySave)<<8
          sta lR44+1
          lda #<>procTitleMenuCopySave
          sta lR44
          jsl rlProcEngineFindProc
          bcs _CLC

          lda #(`procTitleMenuDeleteSave)<<8
          sta lR44+1
          lda #<>procTitleMenuDeleteSave
          sta lR44
          jsl rlProcEngineFindProc
          bcs _CLC

        _SEC
        sec
        rts
        
        _CLC
        clc
        rts

        .databank 0

      rlSaveMenuTryLoadChapter ; 94/B4D0

        .al
        .autsiz
        .databank ?

        lda procSaveOption.SelectedSaveIndex,b,x
        jsl rlCheckIfSaveSlotValid
        bcc _Invalid

        lda #5
        sta wUnknown000E23,b

        lda wSaveSlotTurn
        bne +

        jsl rlSaveMenuLoadChapter
        bra ++

        ; Save has a turn, should never happen.
        +
        jsl rlSaveMenuLoadChapterWithTurn

        +
        clc
        rtl

        ; By default, you shouldn't get here since you can't load empty saves and the checksum should be correct.

        _Invalid
        jsr rsCheckIfLeavingTitleMenu
        bcs +

          ; If you get here, it does start a new save but doesn't update the graphics and 
          ; softlocks you at the same time. After a soft reset, it does show a correct new save.
          jsl rlSetUpNewSaveFile

          lda #$000D
          jsl rlPlaySound
          clc
          rtl

        ; If you get here, you are booted back to the 'Select a save slot' part, while duplicating the cursor.
        +
        lda #$0022
        jsl rlPlaySound
        sec
        rtl

        .databank 0

      rsClearCurrentSaveMagicNumber ; 94/B50C

        .al
        .autsiz
        .databank ?

        lda aTitleMenu.wCurrentOptionIndex
        jsr rsSaveMenuGetSRAMSaveSlotPointer
        tax
        lda #0
        sta aSRAM,x
        rts

        .databank 0

      rsSaveMenuGetSRAMSaveSlotPointer ; 94/B51C

        .al
        .autsiz
        .databank ?

        asl a
        tax
        lda aSaveMenuSRAMSaveSlotPointers,x
        rts

        .databank 0

      aSaveMenuSRAMSaveSlotPointers ; 94/B523

        .word <>aSRAM.aSaveSlot1.MagicNumber
        .word <>aSRAM.aSaveSlot2.MagicNumber
        .word <>aSRAM.aSaveSlot3.MagicNumber
        .word <>aSRAM.aSaveSlotSuspend.MagicNumber
        .word <>$707FE8
        .word <>$707FE8

      rsGetTitleMenuOptionTextVRAMPosition ; 94/B52F

        .al
        .autsiz
        .databank ?

        phx
        lda aTitleMenu.wCurrentOptionIndex
        asl a
        tax
        lda aTitleMenuOptionTextVRAMPositions,x
        sta wR0
        plx
        rts

        .databank 0

      aTitleMenuOptionTextVRAMPositions ; 94/B53E

        .word TitleMenuOptionTextPosition - BG3Base >> 1
        .word TitleMenuOptionTextPosition + 1 * (12 * 2 * size(Tile2bpp)) - BG3Base >> 1
        .word TitleMenuOptionTextPosition + 2 * (12 * 2 * size(Tile2bpp)) - BG3Base >> 1
        .word TitleMenuOptionTextPosition + 3 * (12 * 2 * size(Tile2bpp)) - BG3Base >> 1
        .word TitleMenuOptionTextPosition + 4 * (12 * 2 * size(Tile2bpp)) - BG3Base >> 1
        .word TitleMenuOptionTextPosition + 5 * (12 * 2 * size(Tile2bpp)) - BG3Base >> 1
        .word TitleMenuOptionTextPosition + 6 * (12 * 2 * size(Tile2bpp)) - BG3Base >> 1

      rsGetTitleMenuSaveTextVRAMPosition ; 94/B54C

        .al
        .autsiz
        .databank ?

        phx
        lda aTitleMenu.wCurrentOptionIndex
        asl a
        tax
        lda aTitleMenuSaveTextVRAMPosition,x
        sta wR0
        plx
        rts

        .databank 0

      aTitleMenuSaveTextVRAMPosition ; 94/B55B

        .word SaveSlotTextTilesPosition - BG3Base >> 1
        .word SaveSlotTextTilesPosition + 1 * (SaveSlotTextSize[0] * SaveSlotTextSize[1] * size(Tile2bpp)) - BG3Base >> 1
        .word SaveSlotTextTilesPosition + 2 * (SaveSlotTextSize[0] * SaveSlotTextSize[1] * size(Tile2bpp)) - BG3Base >> 1

        .word SaveConfirmTextTilesPosition - BG3Base >> 1

      rlOverwriteSelectedSaveSlot ; 94/B563

        .al
        .autsiz
        .databank ?

        ldx aProcSystem.wOffset,b
        lda procSaveOption.SelectedSaveIndex,b,x

        pha
        jsl rlFreeSaveSlotByIndex
        pla

        jsl rlSaveToSRAMSlot
        rtl

        .databank 0

      rlSaveMenuHandleBPress ; 94/B574

        .al
        .autsiz
        .databank ?

        ; Pressed B on the save slot menu

        jsr rsCheckIfLeavingTitleMenu
        bcs _Leaving

        lda #(`procSwapSaveToTitleMenu)<<8
        sta lR44+1
        lda #<>procSwapSaveToTitleMenu
        sta lR44
        jsl rlProcEngineCreateProc

        macroFindAndFreeProc procRightFacingCursor

        bra +
        
        _Leaving
        jsl rlSaveMenuRunNonTitleMenuCallback

        +
        ldx aProcSystem.wOffset,b
        stz aProcSystem.aHeaderSleepTimer,b,x
        jsl rlProcEngineFreeProc
        rtl

        .databank 0

      rlStartParagonSaveFile ; 94/B5B5

        .al
        .autsiz
        .databank ?

        lda #1
        sta wTitleParagonEnableFlag
        bra +

      rlStartNewSaveFile ; 94/B5BE

        .al
        .autsiz
        .databank ?

        lda #0
        sta wTitleParagonEnableFlag
        
        +
        lda #$000D
        jsl rlPlaySound

        lda #(`procTitleMenuNewSave)<<8
        sta lR44+1
        lda #<>procTitleMenuNewSave
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      rlLoadSaveFile ; 94/B5DB

        .al
        .autsiz
        .databank ?

        lda #$000D
        jsl rlPlaySound

        lda #(`procTitleMenuLoadSave)<<8
        sta lR44+1
        lda #<>procTitleMenuLoadSave
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      rlCopySaveFile ; 94/B5F1

        .al
        .autsiz
        .databank ?

        lda #$000D
        jsl rlPlaySound

        lda #(`procTitleMenuCopySave)<<8
        sta lR44+1
        lda #<>procTitleMenuCopySave
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      rlDeleteSaveFile ; 94/B607

        .al
        .autsiz
        .databank ?

        lda #$000D
        jsl rlPlaySound

        lda #(`procTitleMenuDeleteSave)<<8
        sta lR44+1
        lda #<>procTitleMenuDeleteSave
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      rlUnknown94B61D ; 94/B61D

        .al
        .autsiz
        .databank ?

        lda #<>$809D0F
        sta wMainLoopPointer
        rtl

        .databank 0

      rlSaveMenuRunCallback ; 94/B623

        .al
        .autsiz
        .databank ?

        jsl rlSetCurrentMenuColor

        lda lUnknown7EA4EC+1
        sta lR18+1
        lda lUnknown7EA4EC
        sta lR18
        phk
        pea #<>(+)-1

        jml [lR18]
        
        +
        rtl

        .databank 0

      rlSaveMenuRunNonTitleMenuCallback ; 94/B63B

        .al
        .autsiz
        .databank ?

        ; In order to run this callback, we had to have entered
        ; the save menu from somewhere thats not the title menu.

        lda #(`procMapSaveGame)<<8
        sta lR44+1
        lda #<>procMapSaveGame
        sta lR44
        jsl rlProcEngineFindProc
        bcs +

          jsl rlSaveMenuRunCallback
          rtl

        +
        lda #(`procDelayedSaveMenuRunCallback)<<8
        sta lR44+1
        lda #<>procDelayedSaveMenuRunCallback
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      procDelayedSaveMenuRunCallback .structProcInfo "xx", None, None, aProcDelayedSaveMenuRunCallbackCode ; 94/B65F

      aProcDelayedSaveMenuRunCallbackCode ; 94/B667

        PROC_YIELD 20

        PROC_CALL rlSaveMenuRunCallback

        PROC_END

      rlSaveMenuLoadChapterWithTurn ; 94/B670

        .al
        .autsiz
        .databank ?

        lda #0
        jsl rlFadeOutBackgroundMusic

        ldx aProcSystem.wOffset,b
        lda procSaveOption.SelectedSaveIndex,b,x
        jsl rlLoadSaveSlot
        jsl rlSaveMenuRunCallback
        rtl

        .databank 0

      rlSaveMenuLoadChapter ; 94/B686

        .al
        .autsiz
        .databank ?

        lda #0
        jsl rlFadeOutBackgroundMusic

        ldx aProcSystem.wOffset,b
        lda procSaveOption.SelectedSaveIndex,b,x
        jsl rlLoadSaveSlot
        jsl rlGetWorldMapEventPointer

        lda lR18
        beq +

          lda #<>$80BF58
          sta aProcSystem.wInput0,b

          lda #(`procFadeWithCallback)<<8
          sta lR44+1
          lda #<>procFadeWithCallback
          sta lR44
          jsl rlProcEngineCreateProc
          bra ++
        
        +
        jsl $888356

        +
        rtl

        .databank 0

      rlResumeSaveFile ; 94/B6BA

        .al
        .autsiz
        .databank ?

        lda #0
        jsl rlFadeOutBackgroundMusic

        lda #$000D
        jsl rlPlaySound

        lda #5
        sta wUnknown000E23,b
        lda #3
        jsl rlLoadSaveSlot
        jsl rlSaveMenuRunCallback
        rtl

        .databank 0

      rlUnknown94B6DA ; 94/B6DA

        .al
        .autsiz
        .databank ?

        jsl rlSaveMenuRunCallback
        rtl

        .databank 0

      procIntroTimelineSkipCheck .structProcInfo "xx", rlProcIntroTimelineSkipCheckInit, rlProcIntroTimelineSkipCheckCycle, None ; 94/B6DF

      rlProcIntroTimelineSkipCheckInit ; 94/B6E7

        .al
        .autsiz
        .databank ?

        stz wJoy1New

      rlProcIntroTimelineSkipCheckCycle ; 94/B6E9

        .al
        .autsiz
        .databank ?

        lda wJoy1New
        bit #JOY_Start
        beq +

          jsl rlIntroTimelineWrapUp

        +
        rtl

        .databank 0

      procIntroTimeline .block 
        .structProcInfo "hs", rlProcIntroTimelineInit, None, aProcIntroTimelineCode ; 94/B6F5

        PixelOffset = aProcSystem.aBody0
        TileOffset  = aProcSystem.aBody1
      .bend

      rlProcIntroTimelineInit ; 94/B6FD

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #T_Setting(false, true, false, false, false)
        sta bBufferTM

        lda #T_Setting(false, false, false, false, false)
        sta bBufferTS

        lda #T_Setting(false, false, false, false, false)
        sta bBufferTMW

        lda #T_Setting(false, false, false, false, false)
        sta bBufferTSW

        lda #WOBJSEL_Setting(false, false, false, false, false, false, false, false)
        sta bBufferWOBJSEL

        lda #CGWSEL_Setting(false, false, CGWSEL_MathAlways, CGWSEL_BlackNever)
        sta bBufferCGWSEL

        lda #CGADSUB_Setting(CGADSUB_Add, false, false, false, false, false, false, false)
        sta bBufferCGADSUB
        rep #$20

        stz wBufferBG1VOFS
        stz wBufferBG2VOFS
        stz wBufferBG3VOFS
        stz wBufferBG1HOFS
        stz wBufferBG2HOFS
        stz wBufferBG3HOFS

        lda #<>aBG3TilemapBuffer
        sta wR0
        lda #BG3BlankTile
        jsl rlFillTilemapByWord

        lda #<>aBG3TilemapBuffer.Page1
        sta wR0
        lda #BG3BlankTile
        jsl rlFillTilemapByWord

        jsl rlEnableBG3Sync

        lda #(`procIntroTimelineSkipCheck)<<8
        sta lR44+1
        lda #<>procIntroTimelineSkipCheck
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      aProcIntroTimelineCode ; 94/B754

        PROC_CALL rlIntroTimelinePrepareTilemap
        PROC_HALT_WHILE_DECOMPRESSING

        PROC_SET_ONCYCLE rlProcCycleIntroTimelineDisplay
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_CALL rlIntroTimelineWrapUp
        PROC_END

      rlIntroTimelinePrepareTilemap ; 94/B76C

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #T_Setting(false, true, true, false, false)
        sta bBufferTM
        rep #$20

        lda #(`acIntroTimelineTilemap)<<8
        sta lR18+1
        lda #<>acIntroTimelineTilemap
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        lda #BG3Base >> 1
        sta wR0
        lda #IntroTimelineBlankTile
        ldx #0
        jsl rlClearVRAMTilemapEntry
        rtl

        .databank 0

      rlIntroTimelineWrapUp ; 94/B79C

        .al
        .autsiz
        .databank ?

        lda #0
        jsl rlFadeOutBackgroundMusic

        lda #<>$80BF58
        sta aProcSystem.wInput0,b

        lda #(`procFadeWithCallback)<<8
        sta lR44+1
        lda #<>procFadeWithCallback
        sta lR44
        jsl rlProcEngineCreateProc

        macroFindAndFreeProc procIntroTimelineSkipCheck
        macroFindAndFreeProc procIntroTimeline
        macroFindAndFreeProc procDialogue94CCDF

        rtl

        .databank 0

      rlProcCycleIntroTimelineDisplay ; 94/B80F

        .al
        .autsiz
        .databank ?

        inc procIntroTimeline.TileOffset,b,x

        lda #<>(+)
        sta aProcSystem.aHeaderOnCycle,b,x

        +
        stz aProcSystem.aHeaderSleepTimer,b,x

        lda procIntroTimeline.PixelOffset,b,x
        inc procIntroTimeline.PixelOffset,b,x
        lsr a
        sta wBufferBG2VOFS
        sta wBufferBG3VOFS
        lsr a
        lsr a
        lsr a
        lsr a
        cmp procIntroTimeline.TileOffset,b,x
        beq +

          sta procIntroTimeline.TileOffset,b,x
          sta wR0

          jsr rsIntroTimelineHandleTextTilemap
          jsr rsIntroTimelineHandleTextGraphics
          bcc +

            ldx aProcSystem.wOffset,b
            lda #1
            sta aProcSystem.aHeaderSleepTimer,b,x

        +
        rtl

        .databank 0

      rlUnknown94B846 ; 94/B846

        .al
        .autsiz
        .databank ?

        jsr rsIntroTimelineClearTilemapForNewEntry
        rtl

        .databank 0

      rsIntroTimelineClearTilemapForNewEntry ; 94/B84A

        .al
        .autsiz
        .databank ?

        ; Makes sure that whereever we are writing the newest text to,
        ; the entry that used to be there gets cleared first

        lda wR0
        clc
        adc #IntroTimelineInitialTileOffset[1] / 2

        -
        sec
        sbc #32 / 2
        bpl -

        clc
        adc #32 / 2
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc #<>aBG3TilemapBuffer
        sta wR1

        ldy #(16 * 4 * size(word)) -2

        phb
        php
        sep #$20
        lda #`aBG3TilemapBuffer
        pha
        rep #$20
        plb

        lda #IntroTimelineBlankTile
        
        -
        sta (wR1),y
        dec y
        dec y
        bpl -

        plp
        plb
        rts

        .databank 0

      rsIntroTimelineHandleTextGraphics ; 94/B880

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wR0 = current tile offset

        ; Output:
        ; sec if done

        jsr rsIntroTimelineClearTilemapForNewEntry

        lda wR0
        asl a
        clc
        adc wR0
        tax
        lda aIntroTimelineTextPointers,x
        bne +

          ; If we found an empty entry, just update the tilemap

          jsl rlDMAByStruct
            .structDMAToVRAM aBG3TilemapBuffer, (32 * 32 * size(word)), VMAIN_Setting(true), BG3TilemapPage0Position

          bra _CLC

        +
        cmp #$FFFF
        beq _SEC

        sta lR18
        lda aIntroTimelineTextPointers+1,x
        sta lR18+1

        lda wR0
        clc
        adc #IntroTimelineInitialTileOffset[1] / 2
        
        -
        sec
        sbc #32 / 2
        bpl -

        clc
        adc #32 / 2
        asl a
        pha

        tax
        lda aIntroTimelineTextVRAMPositions,x
        sta wR0

        pla
        xba
        sep #$20
        lda #IntroTimelineInitialTileOffset[0]
        rep #$20

        tax
        lda #1
        sta wR1

        lda #2
        sta wR2

        lda #0
        sta wR3

        jsl rlDrawDialogueText
        
        _CLC
        clc
        rts
        
        _SEC
        sec
        rts

        .databank 0

      aIntroTimelineTextVRAMPositions ; 94/B8E5

        .word IntroTimelineTextBaseTile - BG3Base >> 1
        .word IntroTimelineTextBaseTile - BG3Base +  1 * (26 * 2 * size(Tile2bpp)) >> 1
        .word IntroTimelineTextBaseTile - BG3Base +  2 * (26 * 2 * size(Tile2bpp)) >> 1
        .word IntroTimelineTextBaseTile - BG3Base +  3 * (26 * 2 * size(Tile2bpp)) >> 1
        .word IntroTimelineTextBaseTile - BG3Base +  4 * (26 * 2 * size(Tile2bpp)) >> 1
        .word IntroTimelineTextBaseTile - BG3Base +  5 * (26 * 2 * size(Tile2bpp)) >> 1
        .word IntroTimelineTextBaseTile - BG3Base +  6 * (26 * 2 * size(Tile2bpp)) >> 1
        .word IntroTimelineTextBaseTile - BG3Base +  7 * (26 * 2 * size(Tile2bpp)) >> 1
        .word IntroTimelineTextBaseTile - BG3Base +  8 * (26 * 2 * size(Tile2bpp)) >> 1
        .word IntroTimelineTextBaseTile - BG3Base +  9 * (26 * 2 * size(Tile2bpp)) >> 1
        .word IntroTimelineTextBaseTile - BG3Base + 10 * (26 * 2 * size(Tile2bpp)) >> 1
        .word IntroTimelineTextBaseTile - BG3Base + 11 * (26 * 2 * size(Tile2bpp)) >> 1
        .word IntroTimelineTextBaseTile - BG3Base + 12 * (26 * 2 * size(Tile2bpp)) >> 1
        .word IntroTimelineTextBaseTile - BG3Base + 13 * (26 * 2 * size(Tile2bpp)) >> 1
        .word IntroTimelineTextBaseTile - BG3Base + 14 * (26 * 2 * size(Tile2bpp)) >> 1
        .word IntroTimelineTextBaseTile - BG3Base + 15 * (26 * 2 * size(Tile2bpp)) >> 1
        .word IntroTimelineTextBaseTile - BG3Base + 16 * (26 * 2 * size(Tile2bpp)) >> 1
 
      aIntroTimelineTextPointers ; 94/B907

        .long $908485
        .long $908497
        .long 0
        .long $9084AE
        .long $9084C7
        .long $9084DB
        .long 0
        .long $9084F0
        .long $90850A
        .long 0
        .long $90851C
        .long 0
        .long $908530
        .long $908545
        .long 0
        .long $908558
        .long 0
        .long $90856B
        .long $90857F
        .long $908598
        .long 0
        .long $9085B1
        .long 0
        .long $9085C2
        .long $9085D6
        .long 0
        .long $9085E9
        .long $9085FB
        .long $90860E
        .long $90861E
        .long $908631
        .long $908647
        .long 0
        .long $90865F
        .long $90867C
        .long 0
        .long $908695
        .long $9086AD
        .long $9086C9
        .long 0
        .long $9086E5
        .long $9086FE
        .long 0
        .long $90871D
        .long $90873A
        .long 0
        .long $90874E
        .long $FFFFFF

      rsIntroTimelineHandleTextTilemap ; 94/B997

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wR0 = current tile offset 

        lda wR0
        pha

        lda wR0

        ; This keeps track of if we have looped the screen

        -
        sec
        sbc #32 / 2
        bpl -

        clc
        adc #32 / 2
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc #<>aDecompressionBuffer
        sta lR18

        sep #$20
        lda #`aDecompressionBuffer
        sta lR18+2
        rep #$20

        lda wR0
        clc
        adc #IntroTimelineInitialTileOffset[1] / 2

        -
        sec
        sbc #32 / 2
        bpl -

        clc
        adc #32 / 2
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc #BG2TilemapPosition >> 1
        sta wR1
        lda #(16 * 4 * size(word))
        sta wR0
        jsl rlDMAByPointer

        pla
        sta wR0

        rts

        .databank 0

      rlCreateSaveConfirmMenuCursor ; 94/B9E4

        .al
        .autsiz
        .databank ?

        ldx aProcSystem.wOffset,b
        lda procSaveOption.SelectedSaveIndex,b,x
        jsr rsGetSaveFileMenuCursorCoords

        lda procSaveOption.CursorProcOffset,b,x
        tax

        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody1,b,x
        jsl rlFreezeRightFacingCursor

        lda aSaveMenuActionIndex
        cmp #2
        bne +

          ; Selected the copy option
          ldx aProcSystem.wOffset,b
          lda procSaveOption.SelectedSaveIndexBuffer,b,x
          jsr rsGetSaveFileMenuCursorCoords

          lda procSaveOption.CursorProcOffsetBuffer,b,x
          tax

          lda aProcSystem.wInput0,b
          sta aProcSystem.aBody0,b,x
          lda aProcSystem.wInput1,b
          sta aProcSystem.aBody1,b,x
          jsl rlFreezeRightFacingCursor

        +
        ldx aProcSystem.wOffset,b
        stz procSaveOption.ConfirmMenuOption,b,x
        lda procSaveOption.ConfirmMenuOption,b,x
        jsr rsGetSaveConfirmMenuCursorCoords

        lda #(`procRightFacingCursor)<<8
        sta lR44+1
        lda #<>procRightFacingCursor
        sta lR44
        jsl rlProcEngineCreateProc

        ldx aProcSystem.wOffset,b
        sta procSaveOption.CursorProcOffset,b,x
        rtl

        .databank 0

      rlProcCycleSaveConfirmMenuInputHandler ; 94/BA48

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aHeaderSleepTimer,b,x

        jsr rsSaveConfirmMenuHandleLeftRightInputs

        lda wJoy1New
        bit #JOY_A
        bne _APressed

        bit #JOY_B
        bne +

          jmp _End
        
        +
        lda #1
        sta procSaveOption.ConfirmMenuOption,b,x
        bra _Cancel
        
        _APressed
        lda procSaveOption.ConfirmMenuOption,b,x
        bne _Cancel

          ; Confirm
          macroFindAndFreeProc procRightFacingCursor
          macroFindAndFreeProc procRightFacingCursor
          macroFindAndFreeProc procRightFacingCursor

          ldx aProcSystem.wOffset,b
          lda #1
          sta aProcSystem.aHeaderSleepTimer,b,x
          rtl

        _Cancel
        macroFindAndFreeProc procRightFacingCursor
        macroFindAndFreeProc procRightFacingCursor
        macroFindAndFreeProc procRightFacingCursor

        ldx aProcSystem.wOffset,b
        lda #1
        sta aProcSystem.aHeaderSleepTimer,b,x

        lda #$0021
        jsl rlPlaySoundEffect

        _End
        rtl

        .databank 0

      rsSaveConfirmMenuHandleLeftRightInputs ; 94/BB33

        .al
        .autsiz
        .databank ?

        phx
        lda wJoy1New
        bit #(JOY_Right | JOY_Left)
        beq +

          lda #$000A
          jsl rlPlaySound

          lda #1
          sec
          sbc procSaveOption.ConfirmMenuOption,b,x
          sta procSaveOption.ConfirmMenuOption,b,x

        +
        lda procSaveOption.ConfirmMenuOption,b,x
        jsr rsGetSaveConfirmMenuCursorCoords

        lda procSaveOption.CursorProcOffset,b,x
        tax

        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody1,b,x

        plx
        rts

        .databank 0

      rlProcCycleHandleSaveConfirmMenuCancel ; 94/BB64

        .al
        .autsiz
        .databank ?

        lda #1
        sta aProcSystem.aHeaderSleepTimer,b,x

        lda procSaveOption.ConfirmMenuOption,b,x
        beq +

          ; Chose "No" on the confirm menu

          phx
          lda aSaveMenuActionIndex
          asl a
          tax
          lda aSaveConfirmBoxCancelProcCodes,x
          plx
          sta aProcSystem.aHeaderCodeOffset,b,x

        +
        rtl

        .databank 0

      aSaveConfirmBoxCancelProcCodes ; 94/BB7F

        .word 0
        .word <>aProcCodeTitleMenuSaveGame._Cancel
        .word <>aProcCodeTitleMenuCopySave._Cancel
        .word <>aProcCodeTitleMenuDeleteSave._Cancel
        .word 0

      rsGetSaveConfirmMenuCursorCoords ; 94/BB89

        .al
        .autsiz
        .databank ?

        phx
        asl a
        tax
        lda aSaveConfirmMenuCursorCoords,x
        and #$00FF
        sta aProcSystem.wInput0,b
        lda aSaveConfirmMenuCursorCoords+1,x
        and #$00FF
        sta aProcSystem.wInput1,b
        plx
        rts

        .databank 0

      aSaveConfirmMenuCursorCoords ; 94/BBA2

        .word  70 | (183 << 8)
        .word 126 | (183 << 8)

      rlCreateSaveSlotCursor ; 94/BBA6

        .al
        .autsiz
        .databank ?

        jsr rsGetFirstValidSaveSlot

        ldx aProcSystem.wOffset,b
        lda procSaveOption.SelectedSaveIndex,b,x
        jsr rsGetSaveFileMenuCursorCoords

        lda #(`procRightFacingCursor)<<8
        sta lR44+1
        lda #<>procRightFacingCursor
        sta lR44
        jsl rlProcEngineCreateProc

        ldx aProcSystem.wOffset,b
        sta procSaveOption.CursorProcOffset,b,x
        rtl

        .databank 0

      rlProcCycleSaveInputHandler ; 94/BBC7

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aHeaderSleepTimer,b,x

        ; If A pressed: fall through and continue with proc code.

        lda wJoy1New
        bit #JOY_A
        beq +

          lda #1
          sta aProcSystem.aHeaderSleepTimer,b,x
          rtl

        +
        bit #JOY_B
        beq +

          lda #$0021
          jsl rlPlaySound
          jsl rlSaveMenuHandleBPress
          rtl

        +
        jsr rsSaveMenuHandleUpDownInputs
        jsr rsSaveMenuParagonInputCheck
        rtl

        .databank 0

      rsSaveMenuParagonInputCheck ; 94/BBF0

        .al
        .autsiz
        .databank ?

        ; Skip this if you already did the input sequence.

        phx
        phy
        lda wParagonModeUnlockedFlag,b
        bne _End

        ; You have to have "New Save" selected

        lda aSaveMenuActionIndex
        cmp #4
        bne _End

        lda wJoy1New
        beq _End

        lda wParagonModeCheckIndex,b
        inc wParagonModeCheckIndex,b
        asl a
        tax
        lda aParagonModeInputCheck,x
        cmp wJoy1New
        beq +

        stz wParagonModeCheckIndex,b
        bra _End
        
        +
        inc x
        inc x
        lda aParagonModeInputCheck,x
        cmp #-1
        bne _End

        lda #$0081
        jsl rlPlaySound

        sep #$20
        lda #1
        sta wParagonModeUnlockedFlag,b
        rep #$20
        
        _End
        ply
        plx
        rts

        .databank 0

      aParagonModeInputCheck ; 94/BC37

        .word JOY_Right
        .word JOY_Left
        .word JOY_Right
        .word JOY_Left
        .word JOY_Right
        .word JOY_Left
        .word JOY_Right
        .word JOY_Right

        .sint -1

      rlClearParagonModeCheck ; 94/BC49

        .al
        .autsiz
        .databank ?

        stz wParagonModeUnlockedFlag,b

      rlClearParagonModeCheckIndex ; 94/BC4C

        .al
        .autsiz
        .databank ?

        stz wParagonModeCheckIndex,b
        rtl

        .databank 0

      rsCopyMenuHandleUpDownInputs ; 94/BC50

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aTitleMenu
        pha
        rep #$20
        plb

        .databank `aTitleMenu

        lda procSaveOption.SelectedSaveIndex,b,x
        pha

        lda wJoy1New
        bit #JOY_Down
        bne _DownPressed

        bit #JOY_Up
        bne _UpPressed
        bra +
        
          _DownPressed
          lda #1
          sta wR0
          jsr rsSelectFirstFreeSaveSlot
          bra +
          
          _UpPressed
          lda #-1
          sta wR0
          jsr rsSelectFirstFreeSaveSlot
          bra +

        +
        lda procSaveOption.SelectedSaveIndex,b,x
        cmp procSaveOption.SelectedSaveIndexBuffer,b,x
        beq _DownPressed

        ldx aProcSystem.wOffset,b
        lda procSaveOption.SelectedSaveIndex,b,x
        jsr rsGetSaveFileMenuCursorCoords

        lda procSaveOption.CursorProcOffset,b,x
        tax

        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody1,b,x

        pla
        ldx aProcSystem.wOffset,b
        cmp procSaveOption.SelectedSaveIndex,b,x
        beq +

          lda #9
          jsl rlPlaySound

        +
        plp
        plb
        rts

        .databank 0

      rsSelectedSaveSlotIndexBoundsCheck ; 94/BCB4

        .al
        .autsiz
        .databank ?

        ; Based on the index in aProcSystem.aBody0,
        ; keeps the value between 0 and 2.

        lda aProcSystem.aBody0,b,x
        bpl +

          lda #MaxSaveSlotIndex
          sta aProcSystem.aBody0,b,x
          bra ++

        +
        cmp #MaxSaveSlotIndex +1
        bcc +

          lda #0
          sta aProcSystem.aBody0,b,x

        +
        rts

        .databank 0

      rsGetFirstValidSaveSlot ; 94/BCCD

        .al
        .autsiz
        .databank ?

        ; First routine is partially irrelevant. Only used to set the selected 
        ; save slot to the last entry, so the next routine can increment it
        ; and start at save slot 0.

        ; Sets procSaveOption.SelectedSaveIndex to the selected option

        lda #-1
        jsr rsGetFirstValidSaveSlotEffect

        lda #1
        jsr rsGetFirstValidSaveSlotEffect

        rts

        .databank 0

      rsGetFirstValidSaveSlotEffect ; 94/BCDA

        .al
        .autsiz
        .databank ?

        sta wR0

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        phx
        lda aSaveMenuActionIndex
        asl a
        tax
        jsr (aSelectSaveSlotRoutines,x)
        plx
        plp
        plb
        rts

        .databank 0

      aSelectSaveSlotRoutines ; 94/BCF4

        .word <>rsSelectFirstFilledSaveSlot ; load save
        .word <>rsSelectFirstSaveSlot       ; save game
        .word <>rsSelectFirstFilledSaveSlot ; copy save
        .word <>rsSelectFirstFilledSaveSlot ; delete save
        .word <>rsSelectFirstFreeSaveSlot   ; new save

      rsSelectFirstSaveSlot ; 94/BCFE

        .al
        .autsiz
        .databank ?

        ldx aProcSystem.wOffset,b
        lda procSaveOption.SelectedSaveIndex,b,x
        clc
        adc wR0
        sta procSaveOption.SelectedSaveIndex,b,x
        jsr rsSelectedSaveSlotIndexBoundsCheck
        rts

        .databank 0

      rsSelectFirstFreeSaveSlot ; 94/BD0E

        .al
        .autsiz
        .databank `aTitleValidSaveSlots

        ldx aProcSystem.wOffset,b

        -
        lda procSaveOption.SelectedSaveIndex,b,x
        clc
        adc wR0
        sta procSaveOption.SelectedSaveIndex,b,x
        jsr rsSelectedSaveSlotIndexBoundsCheck

        lda procSaveOption.SelectedSaveIndex,b,x
        tay
        lda aTitleValidSaveSlots,y
        and #$00FF
        bne -

        rts

        .databank 0

      rsSelectFirstFilledSaveSlot ; 94/BD2A

        .al
        .autsiz
        .databank `aTitleValidSaveSlots

        ldx aProcSystem.wOffset,b
        
        -
        lda procSaveOption.SelectedSaveIndex,b,x
        clc
        adc wR0
        sta procSaveOption.SelectedSaveIndex,b,x
        jsr rsSelectedSaveSlotIndexBoundsCheck

        lda procSaveOption.SelectedSaveIndex,b,x
        tay
        lda aTitleValidSaveSlots,y
        and #$00FF
        beq -

        rts

        .databank 0

      rsSaveMenuHandleUpDownInputs ; 94/BD46

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aTitleMenu
        pha
        rep #$20
        plb

        lda procSaveOption.SelectedSaveIndex,b,x
        pha

        lda wJoy1New
        bit #JOY_Down
        bne _DownPressed

        bit #JOY_Up
        bne _UpPressed
        bra +
        
        _DownPressed
        lda #1
        jsr rsGetFirstValidSaveSlotEffect
        bra +
        
        _UpPressed
        lda #-1
        jsr rsGetFirstValidSaveSlotEffect
        bra +

        +
        ldx aProcSystem.wOffset,b
        lda procSaveOption.SelectedSaveIndex,b,x
        jsr rsGetSaveFileMenuCursorCoords
        
        lda procSaveOption.CursorProcOffset,b,x
        tax

        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x

        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody1,b,x

        pla
        ldx aProcSystem.wOffset,b
        cmp procSaveOption.SelectedSaveIndex,b,x
        beq +

          lda #9
          jsl rlPlaySound

        +
        plp
        plb
        rts

        .databank 0

      rlCreateSecondSaveSlotCursor ; 94/BD9E

        .al
        .autsiz
        .databank ?

        lda procSaveOption.SelectedSaveIndex,b,x
        sta procSaveOption.SelectedSaveIndexBuffer,b,x

        lda procSaveOption.CursorProcOffset,b,x
        sta procSaveOption.CursorProcOffsetBuffer,b,x
        tax

        lda aProcSystem.aBody0,b,x
        sta aProcSystem.aBody0,b,x
        jsl rlFreezeRightFacingCursor

        ldx aProcSystem.wOffset,b
        lda procSaveOption.SelectedSaveIndex,b,x
        jsr rsGetSaveFileMenuCursorCoords

        lda #(`procRightFacingCursor)<<8
        sta lR44+1
        lda #<>procRightFacingCursor
        sta lR44
        jsl rlProcEngineCreateProc

        ldx aProcSystem.wOffset,b
        sta procSaveOption.CursorProcOffset,b,x
        rtl

        .databank 0

      rlProcCycleCopyInputHandler ; 94/BDD3

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aHeaderSleepTimer,b,x

        lda wJoy1New
        bit #JOY_A
        beq +

          lda #1
          sta aProcSystem.aHeaderSleepTimer,b,x
          rtl

        +
        bit #JOY_B
        beq _BE3A

          macroFindAndFreeProc procRightFacingCursor
          macroFindAndFreeProc procRightFacingCursor

          ldx aProcSystem.wOffset,b
          lda #1
          sta aProcSystem.aHeaderSleepTimer,b,x

          lda #<>aProcCodeTitleMenuCopySave._Cancel
          sta aProcSystem.aHeaderCodeOffset,b,x

          lda #$0021
          jsl rlPlaySound
          rtl

        _BE3A
        jsr rsCopyMenuHandleUpDownInputs
        rtl

        .databank 0

      rsGetSaveFileMenuCursorCoords ; 94/BE3E

        .al
        .autsiz
        .databank ?

        phx
        asl a
        tax 
        lda aSaveFileMenuCursorCoords,x
        and #$00FF
        sta aProcSystem.wInput0,b

        lda aSaveFileMenuCursorCoords+1,x
        and #$00FF
        sta aProcSystem.wInput1,b
        plx
        rts

        .databank 0

      aSaveFileMenuCursorCoords ; 94/BE57

        .word pack([SaveSlotCursorPixelPosition[0], SaveSlotCursorPixelPosition[1]])
        .word pack([SaveSlotCursorPixelPosition[0], SaveSlotCursorPixelPosition[1] + 1 * SaveSlotSize[1] * 8])
        .word pack([SaveSlotCursorPixelPosition[0], SaveSlotCursorPixelPosition[1] + 2 * SaveSlotSize[1] * 8])
        .word pack([SaveSlotCursorPixelPosition[0], SaveSlotCursorPixelPosition[1] + 3 * SaveSlotSize[1] * 8])

      .endwith ; TitleMenuConfig

    .endsection TitleMenu3Section

    .section TitleScreen3Section

      .with TitleScreenConfig


      procTitleFromIntoScenes .structProcInfo "xx", rlProcTitleFromIntoScenesInit, None, aProcTitleFromIntoScenesCode ; 94/BE5F

      rlProcTitleFromIntoScenesInit ; 94/BE67

        .al
        .autsiz
        .databank ?

        lda #40
        sta wBufferBG1VOFS
        lda #-16
        sta wBufferBG2VOFS
        rtl

        .databank 0

      aProcTitleFromIntoScenesCode ; 94/BE72

        PROC_YIELD 2

        PROC_CALL rlTitleScreenFromIntroScenesSetHardwareRegisters

        PROC_PLAY_SONG $0022
        PROC_HALT_UNTIL_SONG_PLAYING

        PROC_YIELD 1

        PROC_CREATE_PROC procCreateTitleScreen
        PROC_HALT_WHILE procCreateTitleScreen

        PROC_CREATE_PROC procTitleFromIntoScenesSkipCheck

        PROC_YIELD 30

        PROC_CALL rlCreateThirteenYearsLaterSprite

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
          .structPaletteChangeData aOAMPaletteBuffer.aPalette3, aThirteenYearsLaterPalette, aOAMPaletteBuffer.aPalette4, None, 32, false
        .bend

        PROC_HALT_WHILE procMapBattlePaletteChange

        PROC_YIELD 140

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
          .structPaletteChangeData aBGPaletteBuffer.aPalette0, aWhitePalette, aBGPaletteBuffer.aPalette0 + 2, None, 64, false
        .bend

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
          .structPaletteChangeData aOAMPaletteBuffer.aPalette3, aWhitePalette, aOAMPaletteBuffer.aPalette4, None, 64, false
        .bend

        PROC_HALT_WHILE procMapBattlePaletteChange

        PROC_CALL rlTitleScreenSetHardwareRegisters
        PROC_CALL rlClearThirteenYearsLaterSprite

        PROC_YIELD 77

        PROC_YIELD 1

        PROC_CALL rlCreateTitleFlameWaveHDMA

        PROC_CREATE_PROC procTitleFlameScroll

        PROC_CREATE_PROC procScrollDownFireEmblemGraphic

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
          .structPaletteChangeData aBGPaletteBuffer.aPalette0, aTitleFlamePalette, aBGPaletteBuffer.aPalette0+8, None, 32, false
        .bend

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
          .structPaletteChangeData aBGPaletteBuffer.aPalette2, PaletteFadeToBlack, aBGPaletteBuffer.aPalette4, None, 128, false
        .bend

        PROC_YIELD 96

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
          .structPaletteChangeData aBGPaletteBuffer.aPalette2, aFireEmblemPalette, aBGPaletteBuffer.aPalette4, None, 128, false
        .bend

        PROC_CREATE_PROC procScrollUpFireEmblemCrestGraphic

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
          .structPaletteChangeData aBGPaletteBuffer.aPalette5, aFireEmblemCrestPalette, aOAMPaletteBuffer.aPalette0, None, 128, false
        .bend

        PROC_YIELD 50

        PROC_CALL rlDrawTitleScreenBanner
        PROC_CALL rlDrawNintendoCopyright

        PROC_YIELD 16

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
          .structPaletteChangeData aBGPaletteBuffer.aPalette5, aFireEmblemCrestFadingPalette, aOAMPaletteBuffer.aPalette0, None, 2048, false
        .bend

        PROC_HALT_WHILE procMapBattlePaletteChange

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
          .structPaletteChangeData aBGPaletteBuffer.aPalette5, aFireEmblemCrestPalette, aOAMPaletteBuffer.aPalette0, None, 32, false
        .bend

        PROC_FREE_PROC procTitleFromIntoScenesSkipCheck

        PROC_YIELD 1

        PROC_JUMP aProcTitleCode._ShortTimer

      procTitleFromIntoScenesSkipCheck .structProcInfo "xx", None, rlProcTitleFromIntoScenesSkipCheckCycle, None ; 94/BF75

      rlProcTitleFromIntoScenesSkipCheckCycle ; 94/BF7D

        .al
        .autsiz
        .databank ?

        lda wJoy1New
        bit #JOY_Start
        beq _End

          macroFindAndFreeProc procTitleFromIntoScenes
          jsl $80C0BD

        _End
        rtl

        .databank 0

      rlCreateThirteenYearsLaterSprite ; 94/BFA6

        .al
        .autsiz
        .databank ?

        lda #(`asThirteenYearsLater)<<8
        sta lR44+1
        lda #<>asThirteenYearsLater
        sta lR44
        ldx #ThirteenYearsLater[0]
        ldy #ThirteenYearsLater[1]
        jsl $81822E

        lda #(`aBlackPalette)<<8
        sta lR18+1
        lda #<>aBlackPalette
        sta lR18
        lda #(`aOAMPaletteBuffer.aPalette3)<<8
        sta lR19+1
        lda #<>aOAMPaletteBuffer.aPalette3
        sta lR19
        lda #size(Palette)
        sta lR20
        jsl rlBlockCopy
        rtl

        .databank 0

      rlClearThirteenYearsLaterSprite ; 94/BFD8

        .al
        .autsiz
        .databank ?

        lda #(`asThirteenYearsLater)<<8
        sta lR44+1
        lda #<>asThirteenYearsLater
        sta lR44
        jsl rlActiveSpriteEngineFindEntry
        bcc +

          jsl rlActiveSpriteEngineClearSpriteByIndex

        +
        rtl

        .databank 0

      asThirteenYearsLater ; 94/BFED

        .word 0
        .word 0
        .word <>asThirteenYearsLaterCode

      asThirteenYearsLaterCode ; 94/BFF3

        -
        AS_Sprite 1, asThirteenYearsLaterFrame1
        AS_Loop -

      asThirteenYearsLaterFrame1 ; 94/BFFA

        _Sprites := [[(  72,    0), $00, SpriteSmall, C2I((15, 27)), 3, 3, false, false]]
        _Sprites..= [[(  64,    0), $00, SpriteSmall, C2I((14, 27)), 3, 3, false, false]]
        _Sprites..= [[(  56,    0), $00, SpriteSmall, C2I((13, 27)), 3, 3, false, false]]
        _Sprites..= [[(  48,    0), $00, SpriteSmall, C2I((12, 27)), 3, 3, false, false]]
        _Sprites..= [[(  64,   -8), $00, SpriteSmall, C2I((11, 24)), 3, 3, false, false]]
        _Sprites..= [[(  56,   -8), $00, SpriteSmall, C2I((11, 27)), 3, 3, false, false]]
        _Sprites..= [[(  48,   -8), $00, SpriteSmall, C2I((10, 27)), 3, 3, false, false]]
        _Sprites..= [[(  40,    0), $00, SpriteSmall, C2I((15, 26)), 3, 3, false, false]]
        _Sprites..= [[(  32,    0), $00, SpriteSmall, C2I((14, 26)), 3, 3, false, false]]
        _Sprites..= [[(  24,    0), $00, SpriteSmall, C2I((13, 26)), 3, 3, false, false]]
        _Sprites..= [[(  16,    0), $00, SpriteSmall, C2I((12, 26)), 3, 3, false, false]]
        _Sprites..= [[(  32,  -16), $21, SpriteLarge, C2I((14, 24)), 3, 3, false, false]]
        _Sprites..= [[(  16,  -16), $21, SpriteLarge, C2I((12, 24)), 3, 3, false, false]]
        _Sprites..= [[(   8,    0), $00, SpriteSmall, C2I((11, 26)), 3, 3, false, false]]
        _Sprites..= [[(   0,    0), $00, SpriteSmall, C2I((10, 26)), 3, 3, false, false]]
        _Sprites..= [[(   8,   -8), $00, SpriteSmall, C2I((11, 25)), 3, 3, false, false]]
        _Sprites..= [[(   0,   -8), $00, SpriteSmall, C2I((10, 25)), 3, 3, false, false]]
        _Sprites..= [[( -80,    0), $21, SpriteLarge, C2I((0, 26)), 3, 3, false, false]]
        _Sprites..= [[( -16,    0), $21, SpriteLarge, C2I((8, 26)), 3, 3, false, false]]
        _Sprites..= [[( -32,    0), $21, SpriteLarge, C2I((6, 26)), 3, 3, false, false]]
        _Sprites..= [[( -48,    0), $21, SpriteLarge, C2I((4, 26)), 3, 3, false, false]]
        _Sprites..= [[( -64,    0), $21, SpriteLarge, C2I((2, 26)), 3, 3, false, false]]
        _Sprites..= [[( -16,  -16), $21, SpriteLarge, C2I((8, 24)), 3, 3, false, false]]
        _Sprites..= [[( -32,  -16), $21, SpriteLarge, C2I((6, 24)), 3, 3, false, false]]
        _Sprites..= [[( -48,  -16), $21, SpriteLarge, C2I((4, 24)), 3, 3, false, false]]
        _Sprites..= [[( -64,  -16), $21, SpriteLarge, C2I((2, 24)), 3, 3, false, false]]
        _Sprites..= [[( -80,  -16), $21, SpriteLarge, C2I((0, 24)), 3, 3, false, false]]

        .structSpriteArray asThirteenYearsLaterFrame1._Sprites

      rlDrawTitleScreenBanner ; 94/C083

        .al
        .autsiz
        .databank ?

        lda #(`asTitleScreenBanner)<<8
        sta lR44+1
        lda #<>asTitleScreenBanner
        sta lR44
        ldx #FireEmblemBanner[0]
        ldy #FireEmblemBanner[1]
        jsl $81822E
        rtl

        .databank 0

      rlDrawNintendoCopyright ; 94/C098

        .al
        .autsiz
        .databank ?

        ; Also includes the "push start" graphic

        lda #(`asNintendoCopyright)<<8
        sta lR44+1
        lda #<>asNintendoCopyright
        sta lR44
        ldx #NintendoCopyright[0] + 256
        ldy #NintendoCopyright[1]
        jsl $81822E
        rtl

        .databank 0

      procTitleFlameScroll .structProcInfo "xx", None, rlProcTitleFlameScrollCycle, None ; 94/C0AD

      rlProcTitleFlameScrollCycle ; 94/C0B5

        .al
        .autsiz
        .databank ?

        inc aProcSystem.aBody0,b,x

        lda aProcSystem.aBody0,b,x
        bit #1
        beq +

          inc wBufferBG3VOFS
          dec wBufferBG3HOFS
        
        +
        rtl

        .databank 0

      procScrollDownFireEmblemGraphic .structProcInfo "xx", None, rlProcScrollDownFireEmblemGraphicCycle, None ; 94/C0C5

      rlProcScrollDownFireEmblemGraphicCycle ; 94/C0CD

        .al
        .autsiz
        .databank ?

        inc aProcSystem.aBody0,b,x
        lda aProcSystem.aBody0,b,x
        cmp #160
        beq +
        bcs _Finished
        
        +
        bit #$0003
        bne _End

        dec wBufferBG1VOFS
        bra _End
        
        _Finished
        stz aProcSystem.aHeaderSleepTimer,b,x
        jsl rlProcEngineFreeProc
        
        _End
        rtl

        .databank 0

      procScrollUpFireEmblemCrestGraphic .structProcInfo "xx", None, rlProcScrollUpFireEmblemCrestGraphicCycle, None ; 94/C0EB

      rlProcScrollUpFireEmblemCrestGraphicCycle ; 94/C0F3

        .al
        .autsiz
        .databank ?

        inc aProcSystem.aBody0,b,x
        lda aProcSystem.aBody0,b,x
        cmp #64
        beq +
        bcs _Finished
        
        +
        bit #$0003
        bne _End

        inc wBufferBG2VOFS
        bra _End
        
        _Finished
        stz aProcSystem.aHeaderSleepTimer,b,x
        jsl rlProcEngineFreeProc
        
        _End
        rtl

        .databank 0

      procCreateTitleScreen .structProcInfo "xx", rlProcCreateTitleScreenInit, None, aProcCreateTitleScreenCode ; 94/C111

      rlProcCreateTitleScreenInit ; 94/C119

        .al
        .autsiz
        .databank ?

        lda #(`$80A01A)<<8
        sta lUnknown7EA4EC+1
        lda #<>$80A01A
        sta lUnknown7EA4EC

        sep #$20
        lda bBufferINIDISP
        pha

        lda #INIDISP_Setting(true, 0)
        sta bBufferINIDISP
        rep #$20

        lda #BG1Base >> 1
        sta wR1
        lda #BG2Base >> 1
        sta wR2
        lda #BG3Base >> 1
        sta wR3
        lda #BG4Base >> 1
        sta wR4
        lda #OAMBase >> 1
        sta wR5

        lda #BG1TilemapPosition >> 1
        sta wR6
        lda #BG2TilemapPosition >> 1
        sta wR7
        lda #BG3TilemapPosition >> 1
        sta wR8
        jsl rlSetLayerPositionsAndSizesAlt

        sep #$20
        pla
        sta bBufferINIDISP

        sep #$20
        lda bBufferBG1SC
        and #~BGSC_Size
        ora #BGSC_Setting(0, BGSC_64x32)
        sta bBufferBG1SC

        lda bBufferBG2SC
        and #~BGSC_Size
        ora #BGSC_Setting(0, BGSC_64x32)
        sta bBufferBG2SC

        lda bBufferBG3SC
        and #~BGSC_Size
        ora #BGSC_Setting(0, BGSC_32x32)
        sta bBufferBG3SC

        lda #BGMODE_Setting(BG_Mode1, false, false, false, false, true)
        sta bBufferBGMODE

        lda bBufferOBSEL
        and #~OBSEL_Size
        sta bBufferOBSEL
        rep #$20

        rtl

        .databank 0

      rlTitleScreenSetHardwareRegisters ; 94/C18A

        .al
        .autsiz
        .databank ?

        ; Main Screen = BG1, BG2, OBJ
        ; Sub Screen  = BG3
        ; CGW = handle all colors of main + sub
        ; CGA = full addition on just BG1

        sep #$20
        lda #T_Setting(true, true, false, false, true)
        sta bBufferTM
        lda #T_Setting(false, false, true, false, false)
        sta bBufferTS
        lda #CGWSEL_Setting(false, true, CGWSEL_MathAlways, CGWSEL_BlackNever)
        sta bBufferCGWSEL
        lda #CGADSUB_Setting(CGADSUB_Add, false, true, false, false, false, false, false)
        sta bBufferCGADSUB
        rep #$20
        rtl

        .databank 0

      rlTitleScreenFromIntroScenesSetHardwareRegisters ; 94/C19F

        .al
        .autsiz
        .databank ?

        ; Main Screen = OBJ
        ; Sub Screen = none
        ; CGW = handle all colors of main
        ; CGA = color math on no layers

        sep #$20
        lda #T_Setting(false, false, false, false, true)
        sta bBufferTM
        lda #T_Setting(false, false, false, false, false)
        sta bBufferTS
        lda #CGWSEL_Setting(false, false, CGWSEL_MathAlways, CGWSEL_BlackNever)
        sta bBufferCGWSEL
        lda #CGADSUB_Setting(CGADSUB_Add, false, false, false, false, false, false, false)
        sta bBufferCGADSUB
        rep #$20
        rtl

        .databank 0

      aProcCreateTitleScreenCode ; 94/C1B4

        PROC_CALL rlTitleDMAMenuTextPart1
        PROC_YIELD 1

        PROC_CALL rlTitleDMAMenuTextPart2
        PROC_YIELD 1

        PROC_CALL rlTitleDMAMenuTextPart3
        PROC_YIELD 1


        PROC_CALL rlTitleDecompressFireEmblemGraphic
        PROC_YIELD 1

        PROC_HALT_WHILE_DECOMPRESSING

        PROC_CALL rlTitleDMAFireEmblemGraphicPart1
        PROC_YIELD 1

        PROC_CALL rlTitleDMAFireEmblemGraphicPart2
        PROC_YIELD 1


        PROC_CALL rlTitleDecompressFireEmblemTilemap
        PROC_YIELD 1

        PROC_HALT_WHILE_DECOMPRESSING

        PROC_CALL rlTitleDMAFireEmblemTilemap
        PROC_YIELD 1


        PROC_CALL rlTitleDecompressFireEmblemCrestGraphic
        PROC_YIELD 1

        PROC_HALT_WHILE_DECOMPRESSING

        PROC_CALL rlTitleDMAFireEmblemCrestGraphicPart1
        PROC_YIELD 1

        PROC_CALL rlTitleDMAFireEmblemCrestGraphicPart2
        PROC_YIELD 1

        PROC_CALL rlTitleDMAFireEmblemCrestGraphicPart3
        PROC_YIELD 1

        PROC_CALL rlTitleDMAFireEmblemCrestGraphicPart4
        PROC_YIELD 1


        PROC_CALL rlTitleDecompressFireEmblemCrestTilemap
        PROC_YIELD 1

        PROC_HALT_WHILE_DECOMPRESSING

        PROC_CALL rlTitleDMAFireEmblemCrestTilemap
        PROC_YIELD 1


        PROC_CALL rlTitleDecompressFireEmblemFlameData
        PROC_YIELD 1

        PROC_HALT_WHILE_DECOMPRESSING

        PROC_CALL rlTitleDMAFireEmblemFlameData
        PROC_YIELD 1


        PROC_CALL rlTitleDecompressFireEmblemBannerGraphic
        PROC_YIELD 1

        PROC_HALT_WHILE_DECOMPRESSING

        PROC_CALL rlTitleDMAFireEmblemBannerGraphicPart1
        PROC_YIELD 1

        PROC_CALL rlTitleDMAFireEmblemBannerGraphicPart2
        PROC_YIELD 1


        PROC_CALL rlDecompressThirteenYearsLaterGraphic
        PROC_YIELD 1

        PROC_CALL rlDMAThirteenYearsLaterGraphic
        PROC_YIELD 1

        PROC_CALL rlTitleScreenClearBlankTiles
        PROC_YIELD 1

        PROC_END

      rlTitleDMAMenuTextPart1 ; 94/C263

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct
          .structDMAToVRAM g2bppMenuTiles, (16 * 16 * size(Tile2bpp)), VMAIN_Setting(true), MenuTextTilesPosition

        rtl

        .databank 0

      rlTitleDMAMenuTextPart2 ; 94/C271

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct
          .structDMAToVRAM g2bppMenuTiles+(16 * 16 * size(Tile2bpp)) , (16 * 16 * size(Tile2bpp)), VMAIN_Setting(true), MenuTextTilesPosition + (16 * 16 * size(Tile2bpp))

        rtl

        .databank 0

      rlTitleDMAMenuTextPart3 ; 94/C27F

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct
          .structDMAToVRAM g2bppMenuTiles+(16 * 32 * size(Tile2bpp)), (16 * 8 * size(Tile2bpp)), VMAIN_Setting(true), MenuTextTilesPosition + (16 * 32 * size(Tile2bpp))

        jsl rlDMAByStruct
          .structDMAToVRAM g4bppSystemIcons, (16 * 2 * size(Tile4bpp)), VMAIN_Setting(true), SystemIconTilesPosition

        rtl

        .databank 0

      rlTitleDecompressFireEmblemGraphic ; 94/C29A

        .al
        .autsiz
        .databank ?

        lda #(`g4bppcTitleFireEmblem)<<8
        sta lR18+1
        lda #<>g4bppcTitleFireEmblem
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        rtl

        .databank 0

      rlTitleDMAFireEmblemGraphicPart1 ; 94/C2B3

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct
          .structDMAToVRAM aDecompressionBuffer, (16 * 8 * size(Tile4bpp)), VMAIN_Setting(true), FireEmblemGraphicPosition

        rtl

        .databank 0

      rlTitleDMAFireEmblemGraphicPart2 ; 94/C2C1

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct
          .structDMAToVRAM aDecompressionBuffer + (16 * 8 * size(Tile4bpp)), (16 * 8 * size(Tile4bpp)), VMAIN_Setting(true), FireEmblemGraphicPosition + (16 * 8 * size(Tile4bpp))

        rtl

        .databank 0

      rlTitleDecompressFireEmblemTilemap ; 94/C2CF

        .al
        .autsiz
        .databank ?

        lda #(`acTitleFireEmblemTilemap)<<8
        sta lR18+1
        lda #<>acTitleFireEmblemTilemap
        sta lR18
        lda #(`aBG1TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG1TilemapBuffer
        sta lR19
        jsl rlAppendDecompList
        rtl

        .databank 0

      rlTitleDMAFireEmblemTilemap ; 94/C2E8

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct
          .structDMAToVRAM aBG1TilemapBuffer, (32 * 32 * size(word)), VMAIN_Setting(true), BG1TilemapPosition

        rtl

        .databank 0

      rlTitleDecompressFireEmblemCrestGraphic ; 94/C2F6

        .al
        .autsiz
        .databank ?

        lda #(`g4bppcTitleFireEmblemCrest)<<8
        sta lR18+1
        lda #<>g4bppcTitleFireEmblemCrest
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        rtl

        .databank 0

      rlTitleDMAFireEmblemCrestGraphicPart1 ; 94/C30F

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct
          .structDMAToVRAM aDecompressionBuffer, (16 * 8 * size(Tile4bpp)), VMAIN_Setting(true), FireEmblemCrestGraphicPosition

        rtl

        .databank 0

      rlTitleDMAFireEmblemCrestGraphicPart2 ; 94/C31D

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct
          .structDMAToVRAM aDecompressionBuffer + (16 * 8 * size(Tile4bpp)), (16 * 8 * size(Tile4bpp)), VMAIN_Setting(true), FireEmblemCrestGraphicPosition + (16 * 8 * size(Tile4bpp))

        rtl

        .databank 0

      rlTitleDMAFireEmblemCrestGraphicPart3 ; 94/C32B

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct
          .structDMAToVRAM aDecompressionBuffer + (16 * 16 * size(Tile4bpp)), (16 * 8 * size(Tile4bpp)), VMAIN_Setting(true), FireEmblemCrestGraphicPosition + (16 * 16 * size(Tile4bpp))

        rtl

        .databank 0

      rlTitleDMAFireEmblemCrestGraphicPart4 ; 94/C339

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct
          .structDMAToVRAM aDecompressionBuffer + (16 * 24 * size(Tile4bpp)), (16 * 8 * size(Tile4bpp)), VMAIN_Setting(true), FireEmblemCrestGraphicPosition + (16 * 24 * size(Tile4bpp))

        rtl

        .databank 0

      rlTitleDecompressFireEmblemCrestTilemap ; 94/C347

        .al
        .autsiz
        .databank ?

        lda #(`acTitleFireEmblemCrestTilemap)<<8
        sta lR18+1
        lda #<>acTitleFireEmblemCrestTilemap
        sta lR18
        lda #(`aBG2TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG2TilemapBuffer
        sta lR19
        jsl rlAppendDecompList
        rtl

        .databank 0

      rlTitleDMAFireEmblemCrestTilemap ; 94/C360

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct
          .structDMAToVRAM aBG2TilemapBuffer, (32 * 32 * size(word)), VMAIN_Setting(true), BG2TilemapPosition

        rtl

        .databank 0

      rlTitleDecompressFireEmblemFlameData ; 94/C36E

        .al
        .autsiz
        .databank ?

        lda #(`g4bppcTitleFlame)<<8
        sta lR18+1
        lda #<>g4bppcTitleFlame
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        lda #(`acTitleFlameTilemap)<<8
        sta lR18+1
        lda #<>acTitleFlameTilemap
        sta lR18
        lda #(`aBG3TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer
        sta lR19
        jsl rlAppendDecompList
        rtl

        .databank 0

      rlTitleDMAFireEmblemFlameData ; 94/C39F

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct
          .structDMAToVRAM aDecompressionBuffer, (16 * 2 * size(Tile2bpp)), VMAIN_Setting(true), MenuTextTilesPosition + (16 * 38 * size(Tile2bpp))

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer, (32 * 32 * size(word)), VMAIN_Setting(true), BG3TilemapPosition

        lda #(`aBlackPalette)<<8
        sta lR18+1
        lda #<>aBlackPalette
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette0)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette0
        sta lR19
        lda #size(Color) * 4
        sta lR20
        jsl rlBlockCopy
        rtl

        .databank 0

      rlTitleDecompressFireEmblemBannerGraphic ; 94/C3D7

        .al
        .autsiz
        .databank ?

        lda #(`g4bppcTitleFireEmblemBanner)<<8
        sta lR18+1
        lda #<>g4bppcTitleFireEmblemBanner
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        rtl

        .databank 0

      rlTitleDMAFireEmblemBannerGraphicPart1 ; 94/C3F0

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct
          .structDMAToVRAM aDecompressionBuffer, (16 * 8 * size(Tile4bpp)), VMAIN_Setting(true), FireEmblemBannerGraphicPosition

        rtl

        .databank 0

      rlTitleDMAFireEmblemBannerGraphicPart2 ; 94/C3FE

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct
          .structDMAToVRAM aDecompressionBuffer + (16 * 8 * size(Tile4bpp)), (16 * 8 * size(Tile4bpp)), VMAIN_Setting(true), FireEmblemBannerGraphicPosition + (16 * 8 * size(Tile4bpp))

        lda #(`aFireEmblemBannerPalette)<<8
        sta lR18+1
        lda #<>aFireEmblemBannerPalette
        sta lR18
        lda #(`aOAMPaletteBuffer.aPalette0)<<8
        sta lR19+1
        lda #<>aOAMPaletteBuffer.aPalette0
        sta lR19
        lda #size(Palette) * 3
        sta lR20
        jsl rlBlockCopy
        rtl

        .databank 0

      rlDecompressThirteenYearsLaterGraphic ; 94/C429

        .al
        .autsiz
        .databank ?

        lda #(`g4bppThirteenYearsLaterGraphic)<<8
        sta lR18+1
        lda #<>g4bppThirteenYearsLaterGraphic
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        rtl

        .databank 0

      rlDMAThirteenYearsLaterGraphic ; 94/C442

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct
          .structDMAToVRAM aDecompressionBuffer, (16 * 4 * size(Tile4bpp)) , VMAIN_Setting(true), ThirteenYearsLaterGraphicPosition

        lda #(`$90B4F3)<<8
        sta lR18+1
        lda #<>$90B4F3
        sta lR18
        lda #(`$000360)<<8
        sta lR19+1
        lda #<>$000360
        sta lR19
        lda #$0020
        sta lR20
        jsl rlBlockCopy
        rtl

        .databank 0

      rlTitleScreenClearBlankTiles ; 94/C46D

        .al
        .autsiz
        .databank ?

        lda #BG3Base >> 1
        sta wR0
        lda #BG3BlankTile
        ldx #0
        jsl rlClearVRAMTilemapEntry

        lda #BG1Base >> 1
        sta wR0
        lda #BG12BlankTile
        ldx #1
        jsl rlClearVRAMTilemapEntry
        rtl

        .databank 0

      rlLoadTitleScreenPalettes ; 94/C48C

        .al
        .autsiz
        .databank ?

        ; Clears BG_PAL0 and OAM_PAL0-6

        jsl $809C9B

        lda #(`aFireEmblemPalette)<<8
        sta lR18+1
        lda #<>aFireEmblemPalette
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette2)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette2
        sta lR19
        lda #size(Palette) *2
        sta lR20
        jsl rlBlockCopy

        lda #(`aTitleFlamePalette)<<8
        sta lR18+1
        lda #<>aTitleFlamePalette
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette0)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette0
        sta lR19
        lda #size(Palette)
        sta lR20
        jsl rlBlockCopy

        lda #(`aFireEmblemCrestPalette)<<8
        sta lR18+1
        lda #<>aFireEmblemCrestPalette
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette5)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette5
        sta lR19
        lda #size(Palette) *3
        sta lR20
        jsl rlBlockCopy

        lda #(`aFireEmblemBannerPalette)<<8
        sta lR18+1
        lda #<>aFireEmblemBannerPalette
        sta lR18
        lda #(`aOAMPaletteBuffer.aPalette0)<<8
        sta lR19+1
        lda #<>aOAMPaletteBuffer.aPalette0
        sta lR19
        lda #size(Palette) *3
        sta lR20
        jsl rlBlockCopy

        stz aBGPaletteBuffer.aPalette0,b

        rtl

        .databank 0

      rlUnknownCreateTitleScreen ; 94/C508

        .al
        .autsiz
        .databank ?

        ; This fails to grab the Nintendo copyright and 
        ; the left half of the 'push start' graphic

        jsl rlDisableVBlank

        sep #$20
        lda #INIDISP_Setting(true, 0)
        sta bBufferINIDISP
        rep #$20

        sep #$20
        lda #INIDISP_Setting(true, 0)
        sta INIDISP,b
        rep #$20

        lda #(`$80A01A)<<8
        sta lUnknown7EA4EC+1
        lda #<>$80A01A
        sta lUnknown7EA4EC

        sep #$20
        lda #T_Setting(true, true, true, false, true)
        sta bBufferTM
        rep #$20

        lda #<>aBG1TilemapBuffer
        sta wR0
        lda #BG12BlankTile
        jsl rlFillTilemapByWord

        lda #<>aBG2TilemapBuffer
        sta wR0
        lda #BG12BlankTile
        jsl rlFillTilemapByWord

        lda #<>aBG3TilemapBuffer
        sta wR0
        lda #BG3BlankTile
        jsl rlFillTilemapByWord

        jsl rlDMAByStruct
          .structDMAToVRAM aBG1TilemapBuffer, (32 * 32 * size(word)), VMAIN_Setting(true), BG1TilemapPosition

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer, (32 * 32 * size(word)), VMAIN_Setting(true), BG3TilemapPosition

        jsl rlDMAByStruct
          .structDMAToVRAM g2bppMenuTiles, (16 * 40 * size(Tile2bpp)), VMAIN_Setting(true), MenuTextTilesPosition

        jsl rlDMAByStruct
          .structDMAToVRAM g4bppSystemIcons, (16 * 2 * size(Tile4bpp)), VMAIN_Setting(true), SystemIconTilesPosition

        lda #(`g4bppcTitleFireEmblem)<<8
        sta lR18+1
        lda #<>g4bppcTitleFireEmblem
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aDecompressionBuffer, (16 * 16 * size(Tile4bpp)), VMAIN_Setting(true), FireEmblemGraphicPosition

        lda #(`acTitleFireEmblemTilemap)<<8
        sta lR18+1
        lda #<>acTitleFireEmblemTilemap
        sta lR18
        lda #(`aBG1TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG1TilemapBuffer
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aBG1TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), BG1TilemapPosition

        lda #(`g4bppcTitleFireEmblemCrest)<<8
        sta lR18+1
        lda #<>g4bppcTitleFireEmblemCrest
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aDecompressionBuffer, (16 * 32 * size(Tile4bpp)), VMAIN_Setting(true), FireEmblemCrestGraphicPosition

        lda #(`acTitleFireEmblemCrestTilemap)<<8
        sta lR18+1
        lda #<>acTitleFireEmblemCrestTilemap
        sta lR18
        lda #(`aBG2TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG2TilemapBuffer
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aBG2TilemapBuffer, (32 * 32 * size(word)), VMAIN_Setting(true), BG2TilemapPosition

        lda #(`g4bppcTitleFireEmblemBanner)<<8
        sta lR18+1
        lda #<>g4bppcTitleFireEmblemBanner
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aDecompressionBuffer, (16 * 12 * size(Tile4bpp)), VMAIN_Setting(true), FireEmblemBannerGraphicPosition

        lda #BG3Base >> 1
        sta wR0
        lda #BG3BlankTile
        ldx #0
        jsl rlClearVRAMTilemapEntry

        lda #BG1Base >> 1
        sta wR0
        lda #BG12BlankTile
        ldx #1
        jsl rlClearVRAMTilemapEntry

        stz aBGPaletteBuffer.aPalette0,b

        jsl rlDrawTitleScreenBanner
        jsl rlDrawNintendoCopyright

        sep #$20
        lda #INIDISP_Setting(false, 0)
        sta bBufferINIDISP
        rep #$20

        sep #$20
        lda #INIDISP_Setting(false, 0)
        sta INIDISP,b
        rep #$20

        jsl rlEnableVBlank
        rtl

        .databank 0

      asNintendoCopyright ; 94/C683
      
        .word 0
        .word <>asNintendoCopyrightCycle
        .word <>asNintendoCopyrightCode

      asNintendoCopyrightCycle ; 94/C689

        .al
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aXCoordinate,b,x
        sec
        sbc #16
        sta aActiveSpriteSystem.aXCoordinate,b,x

        inc aActiveSpriteSystem.aUnknown000944,b,x
        lda aActiveSpriteSystem.aUnknown000944,b,x
        cmp #16
        bne +

          ; This writes a value instead of a routine pointer to the cycle routine
          ; and only manages to not crash because the active sprite system can't
          ; run code from RAM.

          lda $C6A4,b
          sta aActiveSpriteSystem.aOnCycle,b,x

        +
        rtl

        .databank 0

      asTitleScreenBanner ; 94/C6A5

        .word 0
        .word 0
        .word <>asTitleScreenBannerCode

      asTitleScreenBannerCode ; 94/C6AB

        AS_Sprite 1, asTitleScreenBannerFrame1
        AS_Sprite 1, asTitleScreenBannerFrame2
        AS_Sprite 1, asTitleScreenBannerFrame3
        AS_Sprite 1, asTitleScreenBannerFrame4
        AS_Sprite 1, asTitleScreenBannerFrame5
        AS_Sprite 1, asTitleScreenBannerFrame6
        AS_Sprite 2, asTitleScreenBannerFrame7
        AS_Sprite 4, asTitleScreenBannerFrame8

        -
        AS_Sprite 1, asTitleScreenBannerFrame9
        AS_Loop -

      asNintendoCopyrightCode ; 94/C6D2

        -
        AS_Sprite 1, asNintendoCopyrightFrame1
        AS_Loop -

      asTitleScreenBannerFrame1 .block ; 94/C6D9

        _Sprites := [[(  -8,   27), $21, SpriteLarge, $006A, 2, 1, false, false]]
        _Sprites..= [[(  -8,   11), $21, SpriteLarge, $004A, 2, 1, false, false]]
        _Sprites..= [[(  -8,   -5), $21, SpriteLarge, $002A, 2, 1, false, false]]

        .structSpriteArray asTitleScreenBannerFrame1._Sprites

        .bend

      asTitleScreenBannerFrame2 .block ; 94/C6EA

        _Sprites := [[(   8,   25), $21, SpriteLarge, $006C, 2, 1, false, false]]
        _Sprites..= [[(  -8,   25), $21, SpriteLarge, $006A, 2, 1, false, false]]
        _Sprites..= [[( -24,   25), $21, SpriteLarge, $0068, 2, 1, false, false]]
        _Sprites..= [[(   8,    9), $21, SpriteLarge, $004C, 2, 1, false, false]]
        _Sprites..= [[(  -8,    9), $21, SpriteLarge, $004A, 2, 1, false, false]]
        _Sprites..= [[( -24,    9), $21, SpriteLarge, $0048, 2, 1, false, false]]
        _Sprites..= [[(   8,   -7), $21, SpriteLarge, $002C, 2, 1, false, false]]
        _Sprites..= [[(  -8,   -7), $21, SpriteLarge, $002A, 2, 1, false, false]]
        _Sprites..= [[( -24,   -7), $21, SpriteLarge, $0028, 2, 1, false, false]]

        .structSpriteArray asTitleScreenBannerFrame2._Sprites

        .bend

      asTitleScreenBannerFrame3 .block ; 94/C719

        _Sprites := [[(  24,   23), $21, SpriteLarge, $006E, 2, 1, false, false]]
        _Sprites..= [[(   8,   23), $21, SpriteLarge, $006C, 2, 1, false, false]]
        _Sprites..= [[(  -8,   23), $21, SpriteLarge, $006A, 2, 1, false, false]]
        _Sprites..= [[( -24,   23), $21, SpriteLarge, $0068, 2, 1, false, false]]
        _Sprites..= [[( -40,   23), $21, SpriteLarge, $0066, 2, 1, false, false]]
        _Sprites..= [[(  24,    7), $21, SpriteLarge, $004E, 2, 1, false, false]]
        _Sprites..= [[(   8,    7), $21, SpriteLarge, $004C, 2, 1, false, false]]
        _Sprites..= [[(  -8,    7), $21, SpriteLarge, $004A, 2, 1, false, false]]
        _Sprites..= [[( -24,    7), $21, SpriteLarge, $0048, 2, 1, false, false]]
        _Sprites..= [[( -40,    7), $21, SpriteLarge, $0046, 2, 1, false, false]]
        _Sprites..= [[(  24,   -9), $21, SpriteLarge, $002E, 2, 1, false, false]]
        _Sprites..= [[(   8,   -9), $21, SpriteLarge, $002C, 2, 1, false, false]]
        _Sprites..= [[(  -8,   -9), $21, SpriteLarge, $002A, 2, 1, false, false]]
        _Sprites..= [[( -24,   -9), $21, SpriteLarge, $0028, 2, 1, false, false]]
        _Sprites..= [[( -40,   -9), $21, SpriteLarge, $0026, 2, 1, false, false]]

        .structSpriteArray asTitleScreenBannerFrame3._Sprites

        .bend

      asTitleScreenBannerFrame4 .block ; 94/C766

        _Sprites := [[(  40,   21), $21, SpriteLarge, $00A8, 2, 1, false, false]]
        _Sprites..= [[(  40,    5), $21, SpriteLarge, $0088, 2, 1, false, false]]
        _Sprites..= [[(  40,  -11), $21, SpriteLarge, $00A0, 2, 1, false, false]]
        _Sprites..= [[(  24,   21), $21, SpriteLarge, $006E, 2, 1, false, false]]
        _Sprites..= [[(   8,   21), $21, SpriteLarge, $006C, 2, 1, false, false]]
        _Sprites..= [[(  -8,   21), $21, SpriteLarge, $006A, 2, 1, false, false]]
        _Sprites..= [[( -24,   21), $21, SpriteLarge, $0068, 2, 1, false, false]]
        _Sprites..= [[( -40,   21), $21, SpriteLarge, $0066, 2, 1, false, false]]
        _Sprites..= [[( -56,   21), $21, SpriteLarge, $0064, 2, 1, false, false]]
        _Sprites..= [[(  24,    5), $21, SpriteLarge, $004E, 2, 1, false, false]]
        _Sprites..= [[(   8,    5), $21, SpriteLarge, $004C, 2, 1, false, false]]
        _Sprites..= [[(  -8,    5), $21, SpriteLarge, $004A, 2, 1, false, false]]
        _Sprites..= [[( -24,    5), $21, SpriteLarge, $0048, 2, 1, false, false]]
        _Sprites..= [[( -40,    5), $21, SpriteLarge, $0046, 2, 1, false, false]]
        _Sprites..= [[( -56,    5), $21, SpriteLarge, $0044, 2, 1, false, false]]
        _Sprites..= [[(  24,  -11), $21, SpriteLarge, $002E, 2, 1, false, false]]
        _Sprites..= [[(   8,  -11), $21, SpriteLarge, $002C, 2, 1, false, false]]
        _Sprites..= [[(  -8,  -11), $21, SpriteLarge, $002A, 2, 1, false, false]]
        _Sprites..= [[( -24,  -11), $21, SpriteLarge, $0028, 2, 1, false, false]]
        _Sprites..= [[( -40,  -11), $21, SpriteLarge, $0026, 2, 1, false, false]]
        _Sprites..= [[( -56,  -11), $21, SpriteLarge, $0024, 2, 1, false, false]]

        .structSpriteArray asTitleScreenBannerFrame4._Sprites

        .bend

      asTitleScreenBannerFrame5 .block ; 94/C7D1

        _Sprites := [[(  64,  -20),  $0, SpriteSmall, $0093, 2, 1, false, false]]
        _Sprites..= [[( -72,  -20),  $0, SpriteSmall, $0012, 2, 1, false, false]]
        _Sprites..= [[(  56,   20), $21, SpriteLarge, $00AA, 2, 1, false, false]]
        _Sprites..= [[(  40,   20), $21, SpriteLarge, $00A8, 2, 1, false, false]]
        _Sprites..= [[(  56,    4), $21, SpriteLarge, $008A, 2, 1, false, false]]
        _Sprites..= [[(  40,    4), $21, SpriteLarge, $0088, 2, 1, false, false]]
        _Sprites..= [[(  56,  -12), $21, SpriteLarge, $00A2, 2, 1, false, false]]
        _Sprites..= [[(  40,  -12), $21, SpriteLarge, $00A0, 2, 1, false, false]]
        _Sprites..= [[(  24,   20), $21, SpriteLarge, $006E, 2, 1, false, false]]
        _Sprites..= [[(   8,   20), $21, SpriteLarge, $006C, 2, 1, false, false]]
        _Sprites..= [[(  -8,   20), $21, SpriteLarge, $006A, 2, 1, false, false]]
        _Sprites..= [[( -24,   20), $21, SpriteLarge, $0068, 2, 1, false, false]]
        _Sprites..= [[( -40,   20), $21, SpriteLarge, $0066, 2, 1, false, false]]
        _Sprites..= [[( -56,   20), $21, SpriteLarge, $0064, 2, 1, false, false]]
        _Sprites..= [[( -72,   20), $21, SpriteLarge, $0062, 2, 1, false, false]]
        _Sprites..= [[(  24,    4), $21, SpriteLarge, $004E, 2, 1, false, false]]
        _Sprites..= [[(   8,    4), $21, SpriteLarge, $004C, 2, 1, false, false]]
        _Sprites..= [[(  -8,    4), $21, SpriteLarge, $004A, 2, 1, false, false]]
        _Sprites..= [[( -24,    4), $21, SpriteLarge, $0048, 2, 1, false, false]]
        _Sprites..= [[( -40,    4), $21, SpriteLarge, $0046, 2, 1, false, false]]
        _Sprites..= [[( -56,    4), $21, SpriteLarge, $0044, 2, 1, false, false]]
        _Sprites..= [[( -72,    4), $21, SpriteLarge, $0042, 2, 1, false, false]]
        _Sprites..= [[(  24,  -12), $21, SpriteLarge, $002E, 2, 1, false, false]]
        _Sprites..= [[(   8,  -12), $21, SpriteLarge, $002C, 2, 1, false, false]]
        _Sprites..= [[(  -8,  -12), $21, SpriteLarge, $002A, 2, 1, false, false]]
        _Sprites..= [[( -24,  -12), $21, SpriteLarge, $0028, 2, 1, false, false]]
        _Sprites..= [[( -40,  -12), $21, SpriteLarge, $0026, 2, 1, false, false]]
        _Sprites..= [[( -56,  -12), $21, SpriteLarge, $0024, 2, 1, false, false]]
        _Sprites..= [[( -72,  -12), $21, SpriteLarge, $0022, 2, 1, false, false]]

        .structSpriteArray asTitleScreenBannerFrame5._Sprites

        .bend

      asTitleScreenBannerFrame6 .block ; 94/C864

        _Sprites := [[( -72,  -21),  $0, SpriteSmall, $0012, 2, 1, false, false]]
        _Sprites..= [[(  64,  -21),  $0, SpriteSmall, $0093, 2, 1, false, false]]
        _Sprites..= [[(  88,  -13),  $0, SpriteSmall, $00A6, 2, 1, false, false]]
        _Sprites..= [[(  56,   19), $21, SpriteLarge, $00AA, 2, 1, false, false]]
        _Sprites..= [[(  40,   19), $21, SpriteLarge, $00A8, 2, 1, false, false]]
        _Sprites..= [[(  72,    3), $21, SpriteLarge, $008C, 2, 1, false, false]]
        _Sprites..= [[(  56,    3), $21, SpriteLarge, $008A, 2, 1, false, false]]
        _Sprites..= [[(  40,    3), $21, SpriteLarge, $0088, 2, 1, false, false]]
        _Sprites..= [[(  72,  -13), $21, SpriteLarge, $00A4, 2, 1, false, false]]
        _Sprites..= [[(  72,  -29), $21, SpriteLarge, $0084, 2, 1, false, false]]
        _Sprites..= [[(  56,  -13), $21, SpriteLarge, $00A2, 2, 1, false, false]]
        _Sprites..= [[(  40,  -13), $21, SpriteLarge, $00A0, 2, 1, false, false]]
        _Sprites..= [[(  24,   19), $21, SpriteLarge, $006E, 2, 1, false, false]]
        _Sprites..= [[(   8,   19), $21, SpriteLarge, $006C, 2, 1, false, false]]
        _Sprites..= [[(  -8,   19), $21, SpriteLarge, $006A, 2, 1, false, false]]
        _Sprites..= [[( -24,   19), $21, SpriteLarge, $0068, 2, 1, false, false]]
        _Sprites..= [[( -40,   19), $21, SpriteLarge, $0066, 2, 1, false, false]]
        _Sprites..= [[( -56,   19), $21, SpriteLarge, $0064, 2, 1, false, false]]
        _Sprites..= [[( -72,   19), $21, SpriteLarge, $0062, 2, 1, false, false]]
        _Sprites..= [[(  24,    3), $21, SpriteLarge, $004E, 2, 1, false, false]]
        _Sprites..= [[(   8,    3), $21, SpriteLarge, $004C, 2, 1, false, false]]
        _Sprites..= [[(  -8,    3), $21, SpriteLarge, $004A, 2, 1, false, false]]
        _Sprites..= [[( -24,    3), $21, SpriteLarge, $0048, 2, 1, false, false]]
        _Sprites..= [[( -40,    3), $21, SpriteLarge, $0046, 2, 1, false, false]]
        _Sprites..= [[( -56,    3), $21, SpriteLarge, $0044, 2, 1, false, false]]
        _Sprites..= [[( -72,    3), $21, SpriteLarge, $0042, 2, 1, false, false]]
        _Sprites..= [[( -88,    3), $21, SpriteLarge, $0040, 2, 1, false, false]]
        _Sprites..= [[(  24,  -13), $21, SpriteLarge, $002E, 2, 1, false, false]]
        _Sprites..= [[(   8,  -13), $21, SpriteLarge, $002C, 2, 1, false, false]]
        _Sprites..= [[(  -8,  -13), $21, SpriteLarge, $002A, 2, 1, false, false]]
        _Sprites..= [[( -24,  -13), $21, SpriteLarge, $0028, 2, 1, false, false]]
        _Sprites..= [[( -40,  -13), $21, SpriteLarge, $0026, 2, 1, false, false]]
        _Sprites..= [[( -56,  -13), $21, SpriteLarge, $0024, 2, 1, false, false]]
        _Sprites..= [[( -72,  -13), $21, SpriteLarge, $0022, 2, 1, false, false]]
        _Sprites..= [[( -88,  -13), $21, SpriteLarge, $0020, 2, 1, false, false]]
        _Sprites..= [[( -88,  -29), $21, SpriteLarge, $0000, 2, 1, false, false]]

        .structSpriteArray asTitleScreenBannerFrame6._Sprites

        .bend

      asTitleScreenBannerFrame7 .block ; 94/C91A

        _Sprites := [[(  88,  -14),  $0, SpriteSmall, $00A6, 2, 1, false, false]]
        _Sprites..= [[(  64,  -22),  $0, SpriteSmall, $0093, 2, 1, false, false]]
        _Sprites..= [[( -72,  -22),  $0, SpriteSmall, $0012, 2, 1, false, false]]
        _Sprites..= [[(  56,   18), $21, SpriteLarge, $00AA, 2, 1, false, false]]
        _Sprites..= [[(  40,   18), $21, SpriteLarge, $00A8, 2, 1, false, false]]
        _Sprites..= [[(  72,    2), $21, SpriteLarge, $008C, 2, 1, false, false]]
        _Sprites..= [[(  56,    2), $21, SpriteLarge, $008A, 2, 1, false, false]]
        _Sprites..= [[(  40,    2), $21, SpriteLarge, $0088, 2, 1, false, false]]
        _Sprites..= [[(  72,  -14), $21, SpriteLarge, $00A4, 2, 1, false, false]]
        _Sprites..= [[(  72,  -30), $21, SpriteLarge, $0084, 2, 1, false, false]]
        _Sprites..= [[(  56,  -14), $21, SpriteLarge, $00A2, 2, 1, false, false]]
        _Sprites..= [[(  40,  -14), $21, SpriteLarge, $00A0, 2, 1, false, false]]
        _Sprites..= [[(  24,   18), $21, SpriteLarge, $006E, 2, 1, false, false]]
        _Sprites..= [[(   8,   18), $21, SpriteLarge, $006C, 2, 1, false, false]]
        _Sprites..= [[(  -8,   18), $21, SpriteLarge, $006A, 2, 1, false, false]]
        _Sprites..= [[( -24,   18), $21, SpriteLarge, $0068, 2, 1, false, false]]
        _Sprites..= [[( -40,   18), $21, SpriteLarge, $0066, 2, 1, false, false]]
        _Sprites..= [[( -56,   18), $21, SpriteLarge, $0064, 2, 1, false, false]]
        _Sprites..= [[( -72,   18), $21, SpriteLarge, $0062, 2, 1, false, false]]
        _Sprites..= [[(  24,    2), $21, SpriteLarge, $004E, 2, 1, false, false]]
        _Sprites..= [[(   8,    2), $21, SpriteLarge, $004C, 2, 1, false, false]]
        _Sprites..= [[(  -8,    2), $21, SpriteLarge, $004A, 2, 1, false, false]]
        _Sprites..= [[( -24,    2), $21, SpriteLarge, $0048, 2, 1, false, false]]
        _Sprites..= [[( -40,    2), $21, SpriteLarge, $0046, 2, 1, false, false]]
        _Sprites..= [[( -56,    2), $21, SpriteLarge, $0044, 2, 1, false, false]]
        _Sprites..= [[( -72,    2), $21, SpriteLarge, $0042, 2, 1, false, false]]
        _Sprites..= [[( -88,    2), $21, SpriteLarge, $0040, 2, 1, false, false]]
        _Sprites..= [[(  24,  -14), $21, SpriteLarge, $002E, 2, 1, false, false]]
        _Sprites..= [[(   8,  -14), $21, SpriteLarge, $002C, 2, 1, false, false]]
        _Sprites..= [[(  -8,  -14), $21, SpriteLarge, $002A, 2, 1, false, false]]
        _Sprites..= [[( -24,  -14), $21, SpriteLarge, $0028, 2, 1, false, false]]
        _Sprites..= [[( -40,  -14), $21, SpriteLarge, $0026, 2, 1, false, false]]
        _Sprites..= [[( -56,  -14), $21, SpriteLarge, $0024, 2, 1, false, false]]
        _Sprites..= [[( -72,  -14), $21, SpriteLarge, $0022, 2, 1, false, false]]
        _Sprites..= [[( -88,  -14), $21, SpriteLarge, $0020, 2, 1, false, false]]
        _Sprites..= [[( -88,  -30), $21, SpriteLarge, $0000, 2, 1, false, false]]

        .structSpriteArray asTitleScreenBannerFrame7._Sprites

        .bend

      asTitleScreenBannerFrame8 .block ; 94/C9D0

        _Sprites := [[( -72,  -23),  $0, SpriteSmall, $0012, 2, 1, false, false]]
        _Sprites..= [[(  64,  -23),  $0, SpriteSmall, $0093, 2, 1, false, false]]
        _Sprites..= [[(  88,  -15),  $0, SpriteSmall, $00A6, 2, 1, false, false]]
        _Sprites..= [[(  56,   17), $21, SpriteLarge, $00AA, 2, 1, false, false]]
        _Sprites..= [[(  40,   17), $21, SpriteLarge, $00A8, 2, 1, false, false]]
        _Sprites..= [[(  72,    1), $21, SpriteLarge, $008C, 2, 1, false, false]]
        _Sprites..= [[(  56,    1), $21, SpriteLarge, $008A, 2, 1, false, false]]
        _Sprites..= [[(  40,    1), $21, SpriteLarge, $0088, 2, 1, false, false]]
        _Sprites..= [[(  72,  -15), $21, SpriteLarge, $00A4, 2, 1, false, false]]
        _Sprites..= [[(  72,  -31), $21, SpriteLarge, $0084, 2, 1, false, false]]
        _Sprites..= [[(  56,  -15), $21, SpriteLarge, $00A2, 2, 1, false, false]]
        _Sprites..= [[(  40,  -15), $21, SpriteLarge, $00A0, 2, 1, false, false]]
        _Sprites..= [[(  24,   17), $21, SpriteLarge, $006E, 2, 1, false, false]]
        _Sprites..= [[(   8,   17), $21, SpriteLarge, $006C, 2, 1, false, false]]
        _Sprites..= [[(  -8,   17), $21, SpriteLarge, $006A, 2, 1, false, false]]
        _Sprites..= [[( -24,   17), $21, SpriteLarge, $0068, 2, 1, false, false]]
        _Sprites..= [[( -40,   17), $21, SpriteLarge, $0066, 2, 1, false, false]]
        _Sprites..= [[( -56,   17), $21, SpriteLarge, $0064, 2, 1, false, false]]
        _Sprites..= [[( -72,   17), $21, SpriteLarge, $0062, 2, 1, false, false]]
        _Sprites..= [[(  24,    1), $21, SpriteLarge, $004E, 2, 1, false, false]]
        _Sprites..= [[(   8,    1), $21, SpriteLarge, $004C, 2, 1, false, false]]
        _Sprites..= [[(  -8,    1), $21, SpriteLarge, $004A, 2, 1, false, false]]
        _Sprites..= [[( -24,    1), $21, SpriteLarge, $0048, 2, 1, false, false]]
        _Sprites..= [[( -40,    1), $21, SpriteLarge, $0046, 2, 1, false, false]]
        _Sprites..= [[( -56,    1), $21, SpriteLarge, $0044, 2, 1, false, false]]
        _Sprites..= [[( -72,    1), $21, SpriteLarge, $0042, 2, 1, false, false]]
        _Sprites..= [[( -88,    1), $21, SpriteLarge, $0040, 2, 1, false, false]]
        _Sprites..= [[(  24,  -15), $21, SpriteLarge, $002E, 2, 1, false, false]]
        _Sprites..= [[(   8,  -15), $21, SpriteLarge, $002C, 2, 1, false, false]]
        _Sprites..= [[(  -8,  -15), $21, SpriteLarge, $002A, 2, 1, false, false]]
        _Sprites..= [[( -24,  -15), $21, SpriteLarge, $0028, 2, 1, false, false]]
        _Sprites..= [[( -40,  -15), $21, SpriteLarge, $0026, 2, 1, false, false]]
        _Sprites..= [[( -56,  -15), $21, SpriteLarge, $0024, 2, 1, false, false]]
        _Sprites..= [[( -72,  -15), $21, SpriteLarge, $0022, 2, 1, false, false]]
        _Sprites..= [[( -88,  -15), $21, SpriteLarge, $0020, 2, 1, false, false]]
        _Sprites..= [[( -88,  -31), $21, SpriteLarge, $0000, 2, 1, false, false]]

        .structSpriteArray asTitleScreenBannerFrame8._Sprites

        .bend

      asTitleScreenBannerFrame9 .block ; 94/CA86

        _Sprites := [[( 102,  -61), $21, SpriteLarge, $000E, 3, 1, false, false]]
        _Sprites..= [[(  88,  -16),  $0, SpriteSmall, $00A6, 2, 1, false, false]]
        _Sprites..= [[(  64,  -24),  $0, SpriteSmall, $0093, 2, 1, false, false]]
        _Sprites..= [[( -72,  -24),  $0, SpriteSmall, $0012, 2, 1, false, false]]
        _Sprites..= [[(  56,   16), $21, SpriteLarge, $00AA, 2, 1, false, false]]
        _Sprites..= [[(  40,   16), $21, SpriteLarge, $00A8, 2, 1, false, false]]
        _Sprites..= [[(  72,    0), $21, SpriteLarge, $008C, 2, 1, false, false]]
        _Sprites..= [[(  56,    0), $21, SpriteLarge, $008A, 2, 1, false, false]]
        _Sprites..= [[(  40,    0), $21, SpriteLarge, $0088, 2, 1, false, false]]
        _Sprites..= [[(  72,  -16), $21, SpriteLarge, $00A4, 2, 1, false, false]]
        _Sprites..= [[(  72,  -32), $21, SpriteLarge, $0084, 2, 1, false, false]]
        _Sprites..= [[(  56,  -16), $21, SpriteLarge, $00A2, 2, 1, false, false]]
        _Sprites..= [[(  40,  -16), $21, SpriteLarge, $00A0, 2, 1, false, false]]
        _Sprites..= [[(  24,   16), $21, SpriteLarge, $006E, 2, 1, false, false]]
        _Sprites..= [[(   8,   16), $21, SpriteLarge, $006C, 2, 1, false, false]]
        _Sprites..= [[(  -8,   16), $21, SpriteLarge, $006A, 2, 1, false, false]]
        _Sprites..= [[( -24,   16), $21, SpriteLarge, $0068, 2, 1, false, false]]
        _Sprites..= [[( -40,   16), $21, SpriteLarge, $0066, 2, 1, false, false]]
        _Sprites..= [[( -56,   16), $21, SpriteLarge, $0064, 2, 1, false, false]]
        _Sprites..= [[( -72,   16), $21, SpriteLarge, $0062, 2, 1, false, false]]
        _Sprites..= [[(  24,    0), $21, SpriteLarge, $004E, 2, 1, false, false]]
        _Sprites..= [[(   8,    0), $21, SpriteLarge, $004C, 2, 1, false, false]]
        _Sprites..= [[(  -8,    0), $21, SpriteLarge, $004A, 2, 1, false, false]]
        _Sprites..= [[( -24,    0), $21, SpriteLarge, $0048, 2, 1, false, false]]
        _Sprites..= [[( -40,    0), $21, SpriteLarge, $0046, 2, 1, false, false]]
        _Sprites..= [[( -56,    0), $21, SpriteLarge, $0044, 2, 1, false, false]]
        _Sprites..= [[( -72,    0), $21, SpriteLarge, $0042, 2, 1, false, false]]
        _Sprites..= [[( -88,    0), $21, SpriteLarge, $0040, 2, 1, false, false]]
        _Sprites..= [[(  24,  -16), $21, SpriteLarge, $002E, 2, 1, false, false]]
        _Sprites..= [[(   8,  -16), $21, SpriteLarge, $002C, 2, 1, false, false]]
        _Sprites..= [[(  -8,  -16), $21, SpriteLarge, $002A, 2, 1, false, false]]
        _Sprites..= [[( -24,  -16), $21, SpriteLarge, $0028, 2, 1, false, false]]
        _Sprites..= [[( -40,  -16), $21, SpriteLarge, $0026, 2, 1, false, false]]
        _Sprites..= [[( -56,  -16), $21, SpriteLarge, $0024, 2, 1, false, false]]
        _Sprites..= [[( -72,  -16), $21, SpriteLarge, $0022, 2, 1, false, false]]
        _Sprites..= [[( -88,  -16), $21, SpriteLarge, $0020, 2, 1, false, false]]
        _Sprites..= [[( -88,  -32), $21, SpriteLarge, $0000, 2, 1, false, false]]

        .structSpriteArray asTitleScreenBannerFrame9._Sprites

        .bend

      asNintendoCopyrightFrame1 .block ; 94/CB41

        _Sprites := [[(  24,  -16), $21, SpriteLarge, $00CC, 2, 2, true, false]]
        _Sprites..= [[(   8,  -16), $21, SpriteLarge, $00AE, 2, 2, false, false]]
        _Sprites..= [[(  -8,  -16), $21, SpriteLarge, $008E, 2, 2, false, false]]
        _Sprites..= [[( -24,  -16), $21, SpriteLarge, $00CE, 2, 2, false, false]]
        _Sprites..= [[( -40,  -16), $21, SpriteLarge, $00CC, 2, 2, false, false]]
        _Sprites..= [[(  92,    0), $21, SpriteLarge, $00EE, 2, 0, false, false]]
        _Sprites..= [[(  76,    0), $21, SpriteLarge, $00EC, 2, 0, false, false]]
        _Sprites..= [[(  60,    0), $21, SpriteLarge, $00EA, 2, 0, false, false]]
        _Sprites..= [[(  44,    0), $21, SpriteLarge, $00E8, 2, 0, false, false]]
        _Sprites..= [[(  28,    0), $21, SpriteLarge, $00E6, 2, 0, false, false]]
        _Sprites..= [[(  12,    0), $21, SpriteLarge, $00E4, 2, 0, false, false]]
        _Sprites..= [[(  -4,    0), $21, SpriteLarge, $00E2, 2, 0, false, false]]
        _Sprites..= [[( -20,    0), $21, SpriteLarge, $00E0, 2, 0, false, false]]
        _Sprites..= [[( -36,    0), $21, SpriteLarge, $00CA, 2, 0, false, false]]
        _Sprites..= [[( -52,    0), $21, SpriteLarge, $00C8, 2, 0, false, false]]
        _Sprites..= [[( -68,    0), $21, SpriteLarge, $00C6, 2, 0, false, false]]
        _Sprites..= [[( -84,    0), $21, SpriteLarge, $00C4, 2, 0, false, false]]
        _Sprites..= [[(-100,    0), $21, SpriteLarge, $00C2, 2, 0, false, false]]
        _Sprites..= [[(-116,    0), $21, SpriteLarge, $00C0, 2, 0, false, false]]

        .structSpriteArray asNintendoCopyrightFrame1._Sprites

        .bend

      .endwith ; TitleScreenConfig

    .endsection TitleScreen3Section

    .section TitleMenu4Section

      .with TitleMenuConfig


      rlUnknown94CBA2 ; 94/CBA2

        .al
        .autsiz
        .databank ?

        ; Zane's "rlDrawShopDialogueText"
        ; Pls fix

        php
        rep #$30
        lda lR18
        sta aProcSystem.wInput0,b
        lda lR18+2
        and #$00FF
        sta aProcSystem.wInput1,b

        lda #(`procDialogue94CBC2)<<8
        sta lR44+1
        lda #<>procDialogue94CBC2
        sta lR44
        jsl rlProcEngineCreateProc
        plp
        rtl

        .databank 0

      procDialogue94CBC2 .structProcInfo "lm", rlProcDialogue94CBC2Init, None, aProcDialogue94CBC2Code ; 94/CBC2

      rlProcDialogue94CBC2Init ; 94/CBCA

        .al
        .autsiz
        .databank ?

        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody1,b,x
        rtl

        .databank 0

      aProcDialogue94CBC2Code ; 94/CBD7

        -
        PROC_CALL rlUnknown94CBE9
        PROC_YIELD 1

        PROC_HALT_WHILE procDialogue94CCDF

        PROC_YIELD 1

        PROC_JUMP -

      rlUnknown94CBE9 ; 94/CBE9

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda aProcSystem.aBody1,b,x
        pha
        rep #$20
        plb

        ldy aProcSystem.aBody0,b,x
        lda $0000,b,y
        bne +

        stz aProcSystem.aHeaderSleepTimer,b,x
        jsl rlProcEngineFreeProc
        bra ++
        
        +
        lda aProcSystem.aBody0,b,x
        clc
        adc #$000B
        sta aProcSystem.aBody0,b,x

        lda $0000,b,y
        sta lR18
        lda $0001,b,y
        sta lR18+1
        lda $0005,b,y
        sta wR0
        lda $0007,b,y
        and #$00FF
        sta wR1
        lda $0008,b,y
        and #$00FF
        sta wR2
        lda $0009,b,y
        sta wR3
        ldx $0003,b,y
        jsl rlUnknown94CC3D

        +
        plp
        plb
        rtl

        .databank 0

      rlUnknown94CC3D ; 94/CC3D

        .al
        .autsiz
        .databank ?

        jsr rsUnknown94CCA8

        lda wR2
        bne +

          ldy wR1
          cpy #0
          beq +

            lda #$000A

        +
        sta aProcSystem.wInput0,b
        lda wR1
        sta aProcSystem.wInput1,b
        lda wR3
        sta aProcSystem.wInput2,b

        lda bBufferBG34NBA
        and #$000F
        xba
        asl a
        asl a
        asl a
        asl a
        clc
        adc wR0
        sta wDialogueVRAMGraphicsStartOffset
        lda #BG3TilemapPage0Position >> 1
        sta $7E45B8
        lda #1
        jsl $958162

        lda #0
        sta wDialogueCurrentTilemapIndex
        lda #0
        sta wDialogueNextTilemapIndex
        txa

        jsl $95812F
        clc
        adc #<>aBG3TilemapBuffer
        sta lDialogueTilemapBufferPointer
        jsl rlUnknown94DD59

        lda #(`procDialogue94CCDF)<<8
        sta lR44+1
        lda #<>procDialogue94CCDF
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      rsUnknown94CCA8 ; 94/CCA8

        .al
        .autsiz
        .databank ?

        txa
        and #$00FF
        cmp #$00FF
        bne +

          lda wR0
          pha
          lda wR1
          pha
          lda wR2
          pha
          lda lR18
          pha
          lda lR18+1
          pha

          txa
          and #$FF00
          pha
          jsl $8ABB6B 
          plx
          stx wR0
          ora wR0
          tax

          pla
          sta lR18+1
          pla
          sta lR18
          pla
          sta wR2
          pla
          sta wR1
          pla
          sta wR0

        +
        rts

        .databank 0

      procDialogue94CCDF .structProcInfo "lm", rlProcDialogue94CCDFInit, rlProcDialogue94CCDFCycle, None ; 94/CCDF

      rlProcDialogue94CCDFInit ; 94/CCE7

        .al
        .autsiz
        .databank ?

        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody0,b,x
        cmp #0
        beq +

          lda wDialogueEngineStatus,b
          ora #$0200
          sta wDialogueEngineStatus,b

          lda #$FFFF
          sta $17ED,b
          lda #$FFFF
          sta $17EF,b
          lda aProcSystem.wInput0,b
          sta $17F7,b
          rtl

        +
        lda wDialogueEngineStatus,b
        eor aProcSystem.wInput2,b
        sta wDialogueEngineStatus,b

        lda aProcSystem.wInput0,b
        beq +

          sta $17ED,b
        
        +
        phx
        phy
        lda #(`$94EA21)<<8
        sta lR44+1
        lda #<>$94EA21
        sta lR44
        jsl rlProcEngineFindProc

        ply
        plx
        lda #0
        bcs +

          lda #1

        +
        sta $001800
        rtl

        .databank 0

      rlProcDialogue94CCDFCycle ; 94/CD3E

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody0,b,x
        asl a
        tax
        jsr (aUnknown94CD47,x)
        rtl

        .databank 0

      aUnknown94CD47 ; 94/CD47

        .word <>rsUnknown94CD92
        .word <>rsUnknown94CD4D
        .word <>rsUnknown94CD78

      rsUnknown94CD4D ; 94/CD4D

        .al
        .autsiz
        .databank ?

        lda wBGUpdateFlags
        ora bDMAArrayFlag,b
        bne +

          jsl $9583FD
          bcs +

            ldx aProcSystem.wOffset,b
            stz aProcSystem.aHeaderSleepTimer,b,x
            jsl rlProcEngineFreeProc
            jsl rlEnableBG3Sync
            jsl rlDMAByStruct
              .structDMAToVRAM aBG3TilemapBuffer + (32 * 28 * size(word)), $0100, VMAIN_Setting(true), BG3TilemapPage0Position + (32 * 28 * size(word))

        +
        rts

        .databank 0

      rsUnknown94CD78 ; 94/CD78

        .al
        .autsiz
        .databank ?

        lda wBGUpdateFlags
        ora bDMAArrayFlag,b
        bne +

          jsl $9583FD
          bcs +

            ldx aProcSystem.wOffset,b
            stz aProcSystem.aHeaderSleepTimer,b,x
            jsl rlProcEngineFreeProc

        +
        rts

        .databank 0

      rsUnknown94CD92 ; 94/CD92

        .al
        .autsiz
        .databank ?

        lda wBGUpdateFlags
        ora bDMAArrayFlag,b
        bne +

          jsl $958233

          lda wDialogueEngineStatus,b
          bne +

            ldx aProcSystem.wOffset,b
            stz aProcSystem.aHeaderSleepTimer,b,x
            jsl rlProcEngineFreeProc

        +
        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer + (32 * 28 * size(word)), $0100, VMAIN_Setting(true), BG3TilemapPage0Position + (32 * 28 * size(word))

        jsl rlEnableBG3Sync
        rts

        .databank 0

      rlProcCycleBuildTitleSaveMenuSlots1 ; 94/CDC0

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aHeaderSleepTimer,b,x

        lda #<>rlProcCycleBuildTitleSaveMenuSlots2
        sta aProcSystem.aHeaderOnCycle,b,x

        jsr rsTitleSaveMenuSetHardwareRegisters

        jsl rlEvaluateSaveSlots

        lda #<>aBG1TilemapBuffer.Page1
        sta wR0
        lda #BG12BlankTileAlt
        jsl rlFillTilemapByWord

        lda #<>aBG3TilemapBuffer.Page1
        sta wR0
        lda #BG3BlankTile
        jsl rlFillTilemapByWord

        lda #(`acSaveMenuBackgroundTilemap)<<8
        sta lR18+1
        lda #<>acSaveMenuBackgroundTilemap
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        lda #(`acSaveMenuBorderTilemap)<<8
        sta lR18+1
        lda #<>acSaveMenuBorderTilemap
        sta lR18
        lda #(`aDecompressionBuffer + (32 * 28 * size(word)))<<8
        sta lR19+1
        lda #<>aDecompressionBuffer + (32 * 28 * size(word))
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM g4bppDarkMenuBackgroundTiles, (16 * 4 * size(Tile4bpp)), VMAIN_Setting(true), DarkMenuBackgroundTilesPosition

        rtl

        .databank 0

      rlProcCycleBuildTitleSaveMenuSlots2 ; 94/CE26

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aHeaderSleepTimer,b,x

        lda bDecompressionArrayFlag,b
        beq +

          jmp rlProcCycleBuildTitleSaveMenuSlots3._End

        +
        lda #<>rlProcCycleBuildTitleSaveMenuSlots3
        sta aProcSystem.aHeaderOnCycle,b,x

        ; Clears BG_PAL0 and OAM_PAL0-6

        jsl $809C9B

        lda #(`aDarkMenuBackgroundPalette)<<8
        sta lR18+1
        lda #<>aDarkMenuBackgroundPalette
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette1)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette1
        sta lR19
        lda #size(Palette)
        sta lR20
        jsl rlBlockCopy

        ; The block copies handle everything until the start of the confirm box

        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        lda #(`aBG1TilemapBuffer.Page1)<<8
        sta lR19+1
        lda #<>aBG1TilemapBuffer.Page1
        sta lR19
        lda #(32 * (SaveConfirmPosition[1] - 1) * size(word))
        sta lR20
        jsl rlBlockCopy

        lda #(`aDecompressionBuffer + (32 * 28 * size(word)))<<8
        sta lR18+1
        lda #<>aDecompressionBuffer + (32 * 28 * size(word))
        sta lR18
        lda #(`aBG3TilemapBuffer.Page1)<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer.Page1
        sta lR19
        lda #(32 * (SaveConfirmPosition[1] - 1) * size(word))
        sta lR20
        jsl rlBlockCopy

        jsl rlDMAByStruct
          .structDMAToVRAM aBG1TilemapBuffer.Page1, (32 * 28 * size(word)), VMAIN_Setting(true), BG1TilemapPage1Position

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer.Page1, (32 * 28 * size(word)), VMAIN_Setting(true), BG3TilemapPage1Position

        rtl

        .databank 0

      rlProcCycleBuildTitleSaveMenuSlots3 ; 94/CEAD

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aHeaderSleepTimer,b,x

        lda #MaxSaveSlotIndex
        sta procTitleMenu.CurrentOptionIndex,b,x 

        lda #<>(+)
        sta aProcSystem.aHeaderOnCycle,b,x

        +
        stz aProcSystem.aHeaderSleepTimer,b,x

        lda procTitleMenu.CurrentOptionIndex,b,x
        sta aTitleMenu.wCurrentOptionIndex

        jsr rlGetSaveSlotTileSettingIndex
        jsr rlGetSaveSlotGraphicsData

        ldx aProcSystem.wOffset,b
        dec procTitleMenu.CurrentOptionIndex,b,x
        bpl _End

          lda #1
          sta aProcSystem.aHeaderSleepTimer,b,x

        _End
        rtl

        .databank 0

      rlProcCycleHandleTitleSavePaletteText1 ; 94/CEDB

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aHeaderSleepTimer,b,x

        lda #MaxSaveSlotIndex
        sta procTitleMenu.CurrentOptionIndex,b,x 

        lda #<>rlProcCycleHandleTitleSavePaletteText2
        sta aProcSystem.aHeaderOnCycle,b,x

      rlProcCycleHandleTitleSavePaletteText2 ; 94/CEEA

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aHeaderSleepTimer,b,x

        lda procTitleMenu.CurrentOptionIndex,b,x
        sta aTitleMenu.wCurrentOptionIndex

        jsr rlGetSaveSlotTileSettingIndex
        jsr rsSaveSlotDrawText

        ldx aProcSystem.wOffset,b
        lda #<>(+)
        sta aProcSystem.aHeaderOnCycle,b,x

        +
        stz aProcSystem.aHeaderSleepTimer,b,x

        lda #(`procDialogue94CCDF)<<8
        sta lR44+1
        lda #<>procDialogue94CCDF
        sta lR44
        jsl rlProcEngineFindProc
        bcs _End

          ldx aProcSystem.wOffset,b
          lda #<>rlProcCycleHandleTitleSavePaletteText2
          sta aProcSystem.aHeaderOnCycle,b,x

          dec procTitleMenu.CurrentOptionIndex,b,x

          lda procTitleMenu.CurrentOptionIndex,b,x
          bpl rlProcCycleHandleTitleSavePaletteText2

            ; Done drawing all save slot texts

            jsl rlUpdateVRAMBG3Page1

            ldx aProcSystem.wOffset,b

            lda #1
            sta aProcSystem.aHeaderSleepTimer,b,x

            jsl rlInitiateWindowColorHDMAs

            ldx #MaxSaveSlotIndex

            -
            txa
            sta aTitleMenu.wCurrentOptionIndex

              jsr rsTitleApplySaveHDMAColors
              dec x
              bpl -

            jsl rlEnableWindowColorHDMA

        _End
        rtl

        .databank 0

      rlUnknown94CF4B ; 94/CF4B

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #T_Setting(true, true, true, false, true)
        sta bBufferTM
        stz bBufferTS
        rep #$20
        rtl

        .databank 0

      rlProcCycleBuildMapSaveMenu ; 94/CF56

        .al
        .autsiz
        .databank ?

        jsr rsMapSaveMenuSetHardwareRegisters
        jsl rlEvaluateSaveSlots

        jsl rlDMAByStruct
          .structDMAToVRAM g2bppMenuTiles, (16 * 40 * size(Tile2bpp)), VMAIN_Setting(true), MenuTextTilesPosition

        jsl rlDMAByStruct
          .structDMAToVRAM g4bppSystemIcons, (16 * 2 * size(Tile4bpp)), VMAIN_Setting(true), SystemIconTilesPosition

        lda #<>aBG1TilemapBuffer
        sta wR0
        lda #BG12BlankTile
        jsl rlFillTilemapByWord

        lda #<>aBG2TilemapBuffer
        sta wR0
        lda #BG12BlankTile
        jsl rlFillTilemapByWord

        lda #<>aBG3TilemapBuffer
        sta wR0
        lda #BG3BlankTile
        jsl rlFillTilemapByWord

        lda #<>aBG1TilemapBuffer.Page1
        sta wR0
        lda #BG12BlankTileAlt
        jsl rlFillTilemapByWord

        lda #<>aBG3TilemapBuffer.Page1
        sta wR0
        lda #BG3BlankTile
        jsl rlFillTilemapByWord

        lda #(`g4bppcTitleFireEmblemCrest)<<8
        sta lR18+1
        lda #<>g4bppcTitleFireEmblemCrest
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aDecompressionBuffer, (16 * 32 * size(Tile4bpp)), VMAIN_Setting(true), FireEmblemCrestGraphicPosition

        lda #(`acTitleFireEmblemCrestTilemap)<<8
        sta lR18+1
        lda #<>acTitleFireEmblemCrestTilemap
        sta lR18
        lda #(`aBG2TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG2TilemapBuffer
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aBG2TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), BG2TilemapPosition

        jsl rlDMAByStruct
          .structDMAToVRAM g4bppDarkMenuBackgroundTiles, (16 * 4 * size(Tile4bpp)), VMAIN_Setting(true), DarkMenuBackgroundTilesPosition

        lda #(`acSaveMenuBackgroundTilemap)<<8
        sta lR18+1
        lda #<>acSaveMenuBackgroundTilemap
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        lda #(`aBG1TilemapBuffer.Page1)<<8
        sta lR19+1
        lda #<>aBG1TilemapBuffer.Page1
        sta lR19
        lda #(32 * (SaveConfirmPosition[1] - 1) * size(word))
        sta lR20
        jsl rlBlockCopy

        jsl rlDMAByStruct
          .structDMAToVRAM aBG1TilemapBuffer.Page1, (32 * 28 * size(word)), VMAIN_Setting(true), BG1TilemapPage1Position

        lda #(`acSaveMenuBorderTilemap)<<8
        sta lR18+1
        lda #<>acSaveMenuBorderTilemap
        sta lR18
        lda #(`aDecompressionBuffer + (32 * 28 * size(word)))<<8
        sta lR19+1
        lda #<>aDecompressionBuffer + (32 * 28 * size(word))
        sta lR19
        jsl rlAppendDecompList

        lda #(`aDecompressionBuffer + (32 * 28 * size(word)))<<8
        sta lR18+1
        lda #<>aDecompressionBuffer + (32 * 28 * size(word))
        sta lR18
        lda #(`aBG3TilemapBuffer.Page1)<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer.Page1
        sta lR19
        lda #(32 * (SaveConfirmPosition[1] - 1) * size(word))
        sta lR20
        jsl rlBlockCopy

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer.Page1, (32 * 28 * size(word)), VMAIN_Setting(true), BG3TilemapPage1Position

        lda #BG3Base >> 1
        sta wR0
        lda #BG3BlankTile
        ldx #0
        jsl rlClearVRAMTilemapEntry

        lda #BG1Base >> 1
        sta wR0
        lda #BG12BlankTileAlt
        ldx #1
        jsl rlClearVRAMTilemapEntry

        ; Clears BG_PAL0 and OAM_PAL0-6

        jsl $809C9B

        lda #(`aDarkMenuBackgroundPalette)<<8
        sta lR18+1
        lda #<>aDarkMenuBackgroundPalette
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette1)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette1
        sta lR19
        lda #size(Palette)
        sta lR20
        jsl rlBlockCopy

        lda #(`aFireEmblemCrestPalette)<<8
        sta lR18+1
        lda #<>aFireEmblemCrestPalette
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette5)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette5
        sta lR19
        lda #size(Palette) * 3
        sta lR20
        jsl rlBlockCopy
        rtl

        .databank 0

      rlProcCycleHandleMapSavePaletteText1 ; 94/D0EB

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aHeaderSleepTimer,b,x
        jsl rlInitiateWindowColorHDMAs

        ldx #MaxSaveSlotIndex

          -
          phx
          txa
          sta aTitleMenu.wCurrentOptionIndex
          jsr rlGetSaveSlotTileSettingIndex
          jsr rlGetSaveSlotGraphicsData
          plx

          jsr rsTitleApplySaveHDMAColors
          dec x
          bpl -

        jsl rlEnableWindowColorHDMA

        ldx aProcSystem.wOffset,b
        lda #<>rlProcCycleHandleMapSavePaletteText2
        sta aProcSystem.aHeaderOnCycle,b,x

        stz aProcSystem.aBody4,b,x
        rtl

        .databank 0

      rlProcCycleHandleMapSavePaletteText2 ; 94/D119

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aHeaderSleepTimer,b,x

        lda aProcSystem.aBody4,b,x
        cmp #MaxSaveSlotIndex +1
        bne +

          lda #1
          sta aProcSystem.aHeaderSleepTimer,b,x
          jsl rlUpdateVRAMBG3Page1
          rtl

        +
        sta aTitleMenu.wCurrentOptionIndex
        jsr rlGetSaveSlotTileSettingIndex
        jsr rsSaveSlotDrawText

        ldx aProcSystem.wOffset,b
        inc aProcSystem.aBody4,b,x

        lda #<>rlProcCycleHandleMapSavePaletteText3
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlProcCycleHandleMapSavePaletteText3 ; 94/D146

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aHeaderSleepTimer,b,x

        lda #(`procDialogue94CCDF)<<8
        sta lR44+1
        lda #<>procDialogue94CCDF
        sta lR44
        jsl rlProcEngineFindProc
        bcs +

          ldx aProcSystem.wOffset,b
          lda #<>rlProcCycleHandleMapSavePaletteText2
          sta aProcSystem.aHeaderOnCycle,b,x

        +
        rtl

        .databank 0

      rsUpdateFoldedSaveSlotBGGraphicsEffect ; 94/D163

        .al
        .autsiz
        .databank ?

        lda aTitleMenu.wCurrentOptionIndex
        asl a
        tax
        lda aFoldedSaveVRAMPosition,x
        sta wR1
        lda aFoldedSaveBGPosition,x
        sta lR18

        sep #$20
        lda #`aBG3TilemapBuffer
        sta lR18+2
        rep #$20

        lda #(16 * 4 * size(word))
        sta wR0
        jsl rlDMAByPointer

        jsl rlInitiateWindowColorHDMAs

        jsr rlGetSaveSlotTileSettingIndex
        jsr rlUpdateSaveSlotTextGraphics
        jsr rsTitleApplySaveHDMAColors

        ldx #MaxSaveSlotIndex
        
          -
          txa
          sta aTitleMenu.wCurrentOptionIndex
          jsr rsTitleApplySaveHDMAColors
          dec x
          bpl -

        jsl rlEnableWindowColorHDMA
        rts

        .databank 0

      aFoldedSaveVRAMPosition ; 94/D1A6

        .word BG3TilemapPage0Position + (32 * SaveSlotPosition[1] * size(word)) >> 1
        .word BG3TilemapPage0Position + (32 * SaveSlotPosition[1] * size(word)) + 1 * (32 * SaveSlotSize[1] * size(word)) >> 1
        .word BG3TilemapPage0Position + (32 * SaveSlotPosition[1] * size(word)) + 2 * (32 * SaveSlotSize[1] * size(word)) >> 1
        .word BG3TilemapPage0Position + (32 * SaveSlotPosition[1] * size(word)) + 3 * (32 * SaveSlotSize[1] * size(word)) >> 1

      aFoldedSaveBGPosition ; 94/D1AE

        .word <>aBG3TilemapBuffer + (32 * SaveSlotPosition[1] * size(word))
        .word <>aBG3TilemapBuffer + (32 * SaveSlotPosition[1] * size(word)) + 1 * (32 * SaveSlotSize[1] * size(word))
        .word <>aBG3TilemapBuffer + (32 * SaveSlotPosition[1] * size(word)) + 2 * (32 * SaveSlotSize[1] * size(word))
        .word <>aBG3TilemapBuffer + (32 * SaveSlotPosition[1] * size(word)) + 3 * (32 * SaveSlotSize[1] * size(word))

      rsTitleApplySaveHDMAColors ; 94/D1B6

        .al
        .autsiz
        .databank ?

        phx
        phy
        lda aTitleMenu.wCurrentOptionIndex
        jsr rsTitleCheckIfSaveFilled
        bcs +

          jsr rsTitleLoadEmptySaveHDMAColors

        +
        lda aTitleMenu.wCurrentOptionIndex
        tax
        lda aTitleSaveHMDAColorYCoordinates,x
        and #$00FF 
        sta wR0

        lda #SaveSlotSize[1]
        sta wR1

        jsl rlSetWindowColorHDMAAreaByTiles
        ply
        plx
        rts

        .databank 0

      aTitleSaveHMDAColorYCoordinates ; 94/D1DE

        .byte SaveSlotPosition[1]
        .byte SaveSlotPosition[1] + 1 * SaveSlotSize[1]
        .byte SaveSlotPosition[1] + 2 * SaveSlotSize[1]
        .byte SaveSlotPosition[1] + 3 * SaveSlotSize[1]

      aTitleEmptySaveColors ; 94/D1E2

        _UpperRed
        .word 24

        _UpperGreen
        .word 24

        _UpperBlue
        .word 24

        _LowerRed
        .word 7

        _LowerGreen
        .word 0

        _LowerBlue
        .word 14

      rsTitleLoadEmptySaveHDMAColors ; 94/D1EE

        .al
        .autsiz
        .databank ?

        lda #0
        tax
        lda aTitleEmptySaveColors._UpperRed,x
        sta aCurrentWindowColors.wUpperRed
        lda aTitleEmptySaveColors._UpperGreen,x
        sta aCurrentWindowColors.wUpperGreen
        lda aTitleEmptySaveColors._UpperBlue,x
        sta aCurrentWindowColors.wUpperBlue
        lda aTitleEmptySaveColors._LowerRed,x
        sta aCurrentWindowColors.wLowerRed
        lda aTitleEmptySaveColors._LowerGreen,x
        sta aCurrentWindowColors.wLowerGreen
        lda aTitleEmptySaveColors._LowerBlue,x
        sta aCurrentWindowColors.wLowerBlue
        rts

        .databank 0

      rlGetSaveSlotTileSettingIndex ; 94/D223

        .al
        .autsiz
        .databank ?

        phx
        phy
        lda aTitleMenu.wCurrentOptionIndex
        jsr rsTitleCheckIfSaveFilled

        lda wSaveSlotTileSetting
        and #$00FF
        bcs +

          ; Empty save slots get tile setting 1
          lda #1

        +
        sta wTitleSaveSlotTileSetting
        ply
        plx
        rts

        .databank 0

      rlUpdateSaveSlotTextGraphics ; 94/D23F

        .al
        .autsiz
        .databank ?

        jsr rlGetSaveSlotGraphicsData
        jsr rsSaveSlotDrawText
        rts

        .databank 0

      rlGetSaveSlotGraphicsData ; 94/D246

        .al
        .autsiz
        .databank ?

        jsr rsGetSaveTileSettingGraphicsPointer
        jsr rsGetSaveTileSettingGraphicsDestination

        lda #(16 * 4 * size(Tile4bpp))
        sta wR0
        jsl rlDMAByPointer

        jsr rsGetSaveTileSettingPalettePointer
        jsr rsGetSaveTileSettingPaletteDestination

        lda #size(Palette)
        sta lR20
        jsl rlBlockCopy
        rts

        .databank 0

      rsTitleClearSaveSlotText ; 94/D265

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aTitleMenu
        pha
        rep #$20
        plb

        phx
        phy
        lda wR0
        pha

        jsr rsGetTitleSaveTextCoordinates
        jsl rlC2IConverter
        clc
        adc #<>aBG3TilemapBuffer
        sta wR0

        ldx #MaxSaveSlotIndex

        -
        ldy #(SaveSlotTextSize[0] * 2) - size(word)
        lda #BG3BlankTile

        -
        sta (wR0),y

        dec y
        dec y
        bpl -

        lda wR0
        clc
        adc #C2I((0,1), size(Tile4bpp)) * 2
        sta wR0

        dec x
        bne --

        pla
        sta wR0
        ply
        plx
        plp
        plb
        rts

        .databank 0

      rsSaveSlotDrawText ; 94/D2A3

        .al
        .autsiz
        .databank ?

        jsr rsTitleClearSaveSlotText

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer.Page1 + (32 * (SaveSlotSize[1] * 3 - 2) * size(word)), (32 * (SaveSlotSize[1] * 3 - 2) * size(word)), VMAIN_Setting(true), BG3TilemapPage1Position + (32 * (SaveSlotSize[1] * 3 - 2) * size(word))

        lda aTitleMenu.wCurrentOptionIndex
        jsr rsTitleCheckIfSaveFilled
        bcc +

          lda wSaveSlotChapter

          ; This saves to the dialogue number address, remnants
          ; of FE4s turn display after the chapter name.

          lda wSaveSlotTurn
          sta $7E4598

          jsr rsTitleGetSaveChapterName
          jsr rsGetTitleSaveTextCoordinates
          tax

          jsr rsGetTitleMenuSaveTextVRAMPosition

          lda #2
          sta wR1

          lda #0
          sta wR2

          lda #0
          sta wR3

          jsl rlDrawDialogueText
          rts

        ; "No data"
        +
        jsr rsGetTitleSaveTextCoordinates
        ora #$00FF
        tax

        jsr rsGetTitleMenuSaveTextVRAMPosition

        lda #(`$90808A)<<8
        sta lR18+1
        lda #<>$90808A
        sta lR18

        lda #2
        sta wR1

        lda #0
        sta wR2

        lda #0
        sta wR3

        jsl rlDrawDialogueText
        rts

        .databank 0

      rsGetTitleSaveTextCoordinates ; 94/D30E

        .al
        .autsiz
        .databank ?

        phx
        lda aTitleMenu.wCurrentOptionIndex
        asl a
        tax
        lda aTitleSaveTextCoordinates,x
        plx
        rts

        .databank 0

      aTitleSaveTextCoordinates ; 94/D31B

        .word pack([SaveSlotTextPosition[0], SaveSlotTextPosition[1] + 32])
        .word pack([SaveSlotTextPosition[0], SaveSlotTextPosition[1] + 1 * SaveSlotSize[1] + 32])
        .word pack([SaveSlotTextPosition[0], SaveSlotTextPosition[1] + 2 * SaveSlotSize[1] + 32])
        .word pack([SaveSlotTextPosition[0], SaveSlotTextPosition[1] + 3 * SaveSlotSize[1] + 32])

      rsTitleGetSaveChapterName ; 94/D323

        .al
        .autsiz
        .databank ?

        phx
        lda wSaveSlotChapter
        jsl rlGetChapterName
        bra rsUnusedTitleGetSaveChapterName._End

        .databank 0

      rsUnusedTitleGetSaveChapterName ; 94/D32E

        .al
        .autsiz
        .databank ?

        ; Unused. 
        ; Remnants of FE4 where the save slots also showed
        ; the turncount at the end in brackets.

        lda wSaveSlotChapter
        asl a
        clc
        adc wSaveSlotChapter
        tax
        lda aUnusedTitleSaveChapterNames,x
        sta lR18
        lda aUnusedTitleSaveChapterNames+1,x
        sta lR18+1

        _End
        plx
        rts

        .databank 0

      aUnusedTitleSaveChapterNames ; 94/D347

        .long $9080CB
        .long $9080EA
        .long $908107
        .long $90811F
        .long $90813D
        .long $90815A
        .long $908175
        .long $908192
        .long $9081AD
        .long $9081CB
        .long $9081E7
        .long $908201
        .long $90821F
        .long $908239
        .long $908254
        .long $90826A
        .long $908285
        .long $90829C
        .long $9082B4
        .long $9082CC
        .long $9082E6
        .long $9082FE
        .long $908317
        .long $908331
        .long $90834B
        .long $908365
        .long $90837D
        .long $908399
        .long $9083B3
        .long $9083CB
        .long $9083E5
        .long $90841A
        .long $908434
        .long $908451
        .long $908469

      rsGetSaveTileSettingPalettePointer ; 94/D3B0

        .al
        .autsiz
        .databank ?

        lda wTitleSaveSlotTileSetting
        asl a
        tax
        lda aSaveTileSettingPalettePointers,x
        sta lR18

        sep #$20
        lda #`aMenuTileSetting1Palette
        sta lR18+2
        rep #$20
        rts

        .databank 0

      aSaveTileSettingPalettePointers ; 94/D3C5

        .word <>aMenuTileSetting1Palette
        .word <>aMenuTileSetting2Palette
        .word <>aMenuTileSetting3Palette
        .word <>aMenuTileSetting4Palette
        .word <>aMenuTileSetting5Palette

      rsGetSaveTileSettingPaletteDestination ; 94/D3CF

        .al
        .autsiz
        .databank ?

        lda aTitleMenu.wCurrentOptionIndex
        asl a
        tax
        lda aSaveTileSettingPaletteDestinations,x
        sta lR19

        sep #$20
        lda #`aBGPaletteBuffer.aPalette2
        sta lR19+2
        rep #$20
        rts

        .databank 0

      aSaveTileSettingPaletteDestinations ; 94/D3E4

        .word <>aBGPaletteBuffer.aPalette2
        .word <>aBGPaletteBuffer.aPalette3
        .word <>aBGPaletteBuffer.aPalette4
        .word <>aBGPaletteBuffer.aPalette5

      rsGetSaveTileSettingGraphicsPointer ; 94/D3EC

        .al
        .autsiz
        .databank ?

        lda wTitleSaveSlotTileSetting
        asl a
        tax
        lda aSaveTileGraphicsPointers,x
        sta lR18

        sep #$20
        lda #`g4bppMenuTileSetting1Graphics
        sta lR18+2
        rep #$20
        rts

        .databank 0

      aSaveTileGraphicsPointers ; 94/D401

        .word <>g4bppMenuTileSetting1Graphics
        .word <>g4bppMenuTileSetting2Graphics
        .word <>g4bppMenuTileSetting3Graphics
        .word <>g4bppMenuTileSetting4Graphics
        .word <>g4bppMenuTileSetting5Graphics

        .word <>g4bppUnknownMenuTileSettingGraphics
        ; Last one might be some kind of really early tile setting graphic,
        ; it looks different but is formatted incorrectly.
        ; Its also not from FE4.

      rsGetSaveTileSettingGraphicsDestination ; 94/D40D

        .al
        .autsiz
        .databank ?

        lda aTitleMenu.wCurrentOptionIndex
        asl a
        tax
        lda aSaveTileSettingGraphicDestinations,x
        sta wR1
        rts

        .databank 0

      aSaveTileSettingGraphicDestinations ; 94/D41A

        .word SaveBackgroundGraphicPosition + 0 * (16 * 4 * size(Tile4bpp)) >> 1
        .word SaveBackgroundGraphicPosition + 1 * (16 * 4 * size(Tile4bpp)) >> 1
        .word SaveBackgroundGraphicPosition + 2 * (16 * 4 * size(Tile4bpp)) >> 1
        
        .word SaveBackgroundGraphicPosition + 3 * (16 * 4 * size(Tile4bpp)) >> 1

        ; The last one isn't allocated and would end up overwriting the crest graphic

      procSwapSaveToTitleMenu .structProcInfo "xx", rlProcSwapSaveToTitleMenuInit, None, aProcSwapSaveToTitleMenuCode ; 94/D422

      rlProcSwapSaveToTitleMenuInit ; 94/D42A

        .al
        .autsiz
        .databank ?

        jsl rlClearParagonModeCheckIndex

        ; Change hardware registers
        jsr rsReturnToTitleMenuSetHardwareRegisters

        jsr rsGetTitleMenuOptions
        rtl

        .databank 0

      aProcSwapSaveToTitleMenuCode ; 94/D435

        PROC_BL aProcCodeBuildTitleMenuOptions

        PROC_CREATE_PROC procTitleScrollLeft
        PROC_HALT_WHILE procTitleScrollLeft

        PROC_CALL rlTitleMenuEnableAllBGLayers

        PROC_BL aProcCodeTitleMenuOptionsSelector

        PROC_END

      procTitleMenu .block 
        .structProcInfo "lm", rlProcTitleMenuInit, None, aProcTitleMenuCode ; 94/D44E

        CurrentOptionIndex = aProcSystem.aBody0
        CursorProcOffset   = aProcSystem.aBody0
        ; The first one gets overwritten by the second one after its no longer needed

      .bend

      rlProcTitleMenuInit ; 94/D456

        .al
        .autsiz
        .databank ?

        jsl rlClearParagonModeCheck

        jsr rsTitleMenuSetHardwareRegisters

        jsr rsGetTitleMenuOptions
        rtl

        .databank 0

      aProcTitleMenuCode ; 94/D461

        PROC_BL aProcCodeBuildTitleMenuOptions

        PROC_SET_ONCYCLE rlProcCycleBuildTitleSaveMenuSlots1
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_SET_ONCYCLE rlProcCycleHandleTitleSavePaletteText1
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_CALL rlTitleMenuEnableAllBGLayers

        PROC_BL aProcCodeTitleMenuOptionsSelector

        PROC_END

      aProcCodeBuildTitleMenuOptions ; 94/D484

        PROC_SET_ONCYCLE rlProcCycleBuildTitleMenuOptionBoxes1
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_CALL rlClearTitleMenuOptionTextIndex

        -
        PROC_HALT_WHILE procDialogue94CCDF
        PROC_YIELD 1

        PROC_JUMP_IF_ROUTINE_TRUE -, rlDrawTitleMenuOptionsText

        PROC_YIELD 1

        PROC_CALL rlEnableBG3Sync
        PROC_CALL rlEnableBG1Sync

        PROC_RETURN

      aProcCodeTitleMenuOptionsSelector ; 94/D4AF

        PROC_CALL rlTitleMenuCreateOptionsCursor

        PROC_SET_ONCYCLE rlTitleMenuOptionInputHandler
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_FREE_PROC procRightFacingCursor

        PROC_CALL rlTitleMenuRunOptionRoutine

        PROC_RETURN

      rlTitleMenuRunOptionRoutine ; 94/D4CA

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aTitleMenu
        pha
        rep #$20
        plb

        .databank `aTitleMenu

        lda aTitleMenu.wSelectedOption
        asl a
        clc
        adc @l aTitleMenu.wSelectedOption
        tax
        lda aTitleMenu.aOptionsList,x
        sta lR18
        lda aTitleMenu.aOptionsList+1,x
        sta lR18+1

        ldy #0
        lda [lR18],y
        pha
        inc y
        lda [lR18],y
        sta lR18+1
        pla
        sta lR18
        jsl rlTitleRunOptionRoutineEffect

        plp
        plb
        rtl

        .databank 0

      rlTitleRunOptionRoutineEffect ; 94/D4FD

        .al
        .autsiz
        .databank ?

        jml [lR18]

        .databank 0

      rlTitleMenuCreateOptionsCursor ; 94/D500

        .al
        .autsiz
        .databank ?

        lda aTitleMenu.wXCoordinate
        asl a
        asl a
        asl a
        sec
        sbc #16
        sta aProcSystem.wInput0,b

        lda aTitleMenu.wYOffset
        asl a
        asl a
        asl a
        clc
        adc #8
        sta aProcSystem.wInput1,b

        lda aTitleMenu.wSelectedOption
        asl a
        asl a
        asl a
        asl a
        clc
        adc aProcSystem.wInput1,b
        sta aProcSystem.wInput1,b

        ; This writes over procTitleMenu.CurrentOptionIndex, but it's no longer needed

        lda #(`procRightFacingCursor)<<8
        sta lR44+1
        lda #<>procRightFacingCursor
        sta lR44
        jsl rlProcEngineCreateProc
        sta procTitleMenu.CursorProcOffset,b,x
        rtl

        .databank 0

      rlTitleMenuOptionInputHandler ; 94/D53D

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aTitleMenu
        pha
        rep #$20
        plb

        .databank `aTitleMenu

        stz aProcSystem.aHeaderSleepTimer,b,x

        ; If you hit A, fall through and continue with ProcCode

        lda wJoy1New
        bit #JOY_A
        beq +

          lda #1
          sta aProcSystem.aHeaderSleepTimer,b,x

          plp
          plb
          rtl

        +
        lda aTitleMenu.wSelectedOption
        pha

        jsr rsTitleMenuChangeSelectedOption

        pla
        cmp aTitleMenu.wSelectedOption
        beq +

          lda #9
          jsl rlPlaySoundEffect
        
        +
        plp
        plb
        rtl

        .databank 0

      rsTitleMenuChangeSelectedOption ; 94/D571

        .al
        .autsiz
        .databank ?

        phb 
        php
        sep #$20
        lda #`aTitleMenu
        pha
        rep #$20
        plb

        .databank `aTitleMenu

        lda wJoy1New
        bit #JOY_Down
        beq ++

          lda aTitleMenu.wSelectedOption
          inc a
          cmp aTitleMenu.wOptionsListIndex
          bcc +

            lda #-1
            sta aTitleMenu.wSelectedOption
          
          +
          inc aTitleMenu.wSelectedOption
          bra _End
        
        +
        bit #JOY_Up
        beq _End

          lda aTitleMenu.wSelectedOption
          bne +

            lda aTitleMenu.wOptionsListIndex
            sta aTitleMenu.wSelectedOption

          +
          dec aTitleMenu.wSelectedOption
        
        _End
        ldx aProcSystem.wOffset,b
        jsr rsTitleAdjustSelectedOptionCursor
        plp
        plb
        rts

        .databank 0

      rsTitleAdjustSelectedOptionCursor ; 94/D5B2

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aTitleMenu
        pha
        rep #$20
        plb

        .databank `aTitleMenu

        phx
        lda procTitleMenu.CursorProcOffset,b,x
        tax

        lda @l aTitleMenu.wXCoordinate
        asl a
        asl a
        asl a
        sec
        sbc #16
        sta aProcSystem.aBody0,b,x

        lda @l aTitleMenu.wYOffset
        asl a
        asl a
        asl a
        clc
        adc #8
        sta wR1

        lda @l aTitleMenu.wSelectedOption
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc wR1
        sta aProcSystem.aBody1,b,x

        plx
        plp
        plb
        rts

        .databank 0

      rlTitleMenuEnableAllBGLayers ; 94/D5EF

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #T_Setting(true, true, true, false, true)
        sta bBufferTM
        rep #$20
        rtl

        .databank 0

      rlProcCycleBuildTitleMenuOptionBoxes1 ; 94/D5F8

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aHeaderSleepTimer,b,x

        lda #<>rlProcCycleBuildTitleMenuOptionBoxes2
        sta aProcSystem.aHeaderOnCycle,b,x

        lda #<>aBG1TilemapBuffer
        sta wR0
        lda #BG12BlankTile
        jsl rlFillTilemapByWord

        lda #<>aBG3TilemapBuffer
        sta wR0
        lda #BG3BlankTile
        jsl rlFillTilemapByWord

        jsl rlDMAByStruct
          .structDMAToVRAM g4bppDarkMenuBackgroundTiles, (16 * 4 * size(Tile4bpp)), VMAIN_Setting(true), DarkMenuBackgroundTilesPosition

        ; Clears BG_PAL0 and OAM_PAL0-6

        jsl $809C9B

        lda #(`aDarkMenuBackgroundPalette)<<8
        sta lR18+1
        lda #<>aDarkMenuBackgroundPalette
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette1)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette1
        sta lR19
        lda #size(Palette)
        sta lR20
        jsl rlBlockCopy

        lda #(`acTitleMenuOptionBackgroundTilemap)<<8
        sta lR18+1
        lda #<>acTitleMenuOptionBackgroundTilemap
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        lda #(`acTitleMenuOptionBorderTilemap)<<8
        sta lR18+1
        lda #<>acTitleMenuOptionBorderTilemap
        sta lR18
        lda #(`aDecompressionBuffer + (32 * 4 * size(word)))<<8
        sta lR19+1
        lda #<>aDecompressionBuffer + (32 * 4 * size(word))
        sta lR19
        jsl rlAppendDecompList
        rtl

        .databank 0

      rlProcCycleBuildTitleMenuOptionBoxes2 ; 94/D678

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aHeaderSleepTimer,b,x

        lda bDecompressionArrayFlag,b
        bne +

          lda #1
          sta aProcSystem.aHeaderSleepTimer,b,x

          phb
          php
          sep #$20
          lda #`aTitleMenu
          pha
          rep #$20
          plb

          .databank `aTitleMenu

          jsr rsGetTitleMenuOptionsYOffset
          jsr rsBuildTitleMenuOptionBoxesBackground
          plp
          plb

        +
        rtl
  
        .databank 0

      rsGetTitleMenuOptionsYOffset ; 94/D699

        .al
        .autsiz
        .databank `aTitleMenu

        lda @l aTitleMenu.wOptionsListIndex
        asl a
        asl a
        eor #$FFFF
        inc a
        clc
        adc #TitleMenuMaxOptionsCount << 2
        lsr a
        sta @l aTitleMenu.wYOffset
        rts

        .databank 0

      rsBuildTitleMenuOptionBoxesBackground ; 94/D6AD

        .al
        .autsiz
        .databank `aTitleMenu

        ldx aTitleMenu.wOptionsListIndex
        beq _End

          dec x
          
          -
          phx
          txa
          asl a
          asl a
          clc
          adc @l aTitleMenu.wYOffset
          sta @l aTitleMenu.wYCoordinate

          lda #(`aDecompressionBuffer)<<8
          sta lR18+1
          lda #<>aDecompressionBuffer
          sta lR18

          lda #(`aBG1TilemapBuffer)<<8
          sta lR19+1
          lda #<>aBG1TilemapBuffer
          sta lR19

          lda @l aTitleMenu.wXCoordinate
          sta wR0
          lda @l aTitleMenu.wYCoordinate
          sta wR1
          lda #TitleMenuOptionSize[0]
          sta wR2
          lda #TitleMenuOptionSize[1]
          sta wR3
          jsl rlCopyPackedTilemapSlice

          lda #(`aDecompressionBuffer + (32 * 4 * size(word)))<<8
          sta lR18+1
          lda #<>aDecompressionBuffer + (32 * 4 * size(word))
          sta lR18

          lda #(`aBG3TilemapBuffer)<<8
          sta lR19+1
          lda #<>aBG3TilemapBuffer
          sta lR19

          lda @l aTitleMenu.wXCoordinate
          sta wR0
          lda @l aTitleMenu.wYCoordinate
          sta wR1
          lda #TitleMenuOptionSize[0]
          sta wR2
          lda #TitleMenuOptionSize[1]
          sta wR3
          jsl rlCopyPackedTilemapSlice

          plx
          dec x
          bpl -

        _End
        rts

        .databank 0

      rlClearTitleMenuOptionTextIndex ; 94/D721

        .al
        .autsiz
        .databank ?

        stz procTitleMenu.CurrentOptionIndex,b,x
        rtl

        .databank 0

      rlDrawTitleMenuOptionsText ; 94/D725

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aHeaderSleepTimer,b,x
        phb
        php

        sep #$20
        lda #`aTitleMenu
        pha
        rep #$20
        plb

        .databank `aTitleMenu

        ; Exit if you are done drawing all option texts

        lda procTitleMenu.CurrentOptionIndex,b,x
        cmp @l aTitleMenu.wOptionsListIndex
        beq _CLC

          lda procTitleMenu.CurrentOptionIndex,b,x
          sta @l aTitleMenu.wCurrentOptionIndex

          jsr rsGetTitleMenuOptionTextVRAMPosition

          lda procTitleMenu.CurrentOptionIndex,b,x
          asl a
          clc
          adc procTitleMenu.CurrentOptionIndex,b,x
          tax
          lda aTitleMenu.aOptionsList,x
          sta lR18
          lda aTitleMenu.aOptionsList+1,x
          sta lR18+1

          ldy #3
          lda [lR18],y
          pha
          inc y
          lda [lR18],y
          sta lR18+1
          pla
          sta lR18

          ldx aProcSystem.wOffset,b
          lda procTitleMenu.CurrentOptionIndex,b,x
          asl a
          asl a
          clc
          adc @l aTitleMenu.wYOffset
          inc a
          xba
          sep #$20
          lda aTitleMenu.wXCoordinate
          inc a
          inc a
          rep #$20
          ora #$00FF
          tax

          lda #1
          sta wR1
          lda #0
          sta wR2
          lda #0
          sta wR3
          jsl rlDrawDialogueText

          ldx aProcSystem.wOffset,b
          inc procTitleMenu.CurrentOptionIndex,b,x
          plp
          plb
          sec
          rtl

        _CLC
        lda #1
        sta aProcSystem.aHeaderSleepTimer,b,x
        plp
        plb
        clc
        rtl

        .databank 0

      rsGetTitleMenuOptions ; 94/D7A9

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aTitleMenu
        pha
        rep #$20
        plb

        .databank `aTitleMenu

        stz aTitleMenu.wSelectedOption

        lda #TitleMenuPosition[0]
        sta aTitleMenu.wXCoordinate
        lda #TitleMenuPosition[1]
        sta aTitleMenu.wYOffset

        stz aTitleMenu.wOptionsListIndex
        ldx #0

        jsr rsCheckSuspendSaveSlotFilled
        bcc +

          lda #(`aTitleMenuOptionResumeGame)<<8
          sta @l aTitleMenu.aOptionsList+1,x
          lda #<>aTitleMenuOptionResumeGame
          sta @l aTitleMenu.aOptionsList,x
          inc x
          inc x
          inc x
          inc aTitleMenu.wOptionsListIndex
        
        +
        jsr rsGetFilledSaveSlotCount
        bcc _AllSlotsEmpty

          lda #(`aTitleMenuOptionLoadGame)<<8
          sta @l aTitleMenu.aOptionsList+1,x
          lda #<>aTitleMenuOptionLoadGame
          sta @l aTitleMenu.aOptionsList,x
          inc x
          inc x
          inc x
          inc aTitleMenu.wOptionsListIndex

          ; Can't copy if all saves are filled

          lda wR0
          cmp #3
          beq +

            lda #(`aTitleMenuOptionCopyFile)<<8
            sta @l aTitleMenu.aOptionsList+1,x
            lda #<>aTitleMenuOptionCopyFile
            sta @l aTitleMenu.aOptionsList,x
            inc x
            inc x
            inc x
            inc aTitleMenu.wOptionsListIndex

          +
          lda #(`aTitleMenuOptionDeleteFile)<<8
          sta @l aTitleMenu.aOptionsList+1,x
          lda #<>aTitleMenuOptionDeleteFile
          sta @l aTitleMenu.aOptionsList,x
          inc x
          inc x
          inc x
          inc aTitleMenu.wOptionsListIndex

        _AllSlotsEmpty
        lda wR0
        cmp #3
        beq +

          lda #(`aTitleMenuOptionNewGame)<<8
          sta @l aTitleMenu.aOptionsList+1,x
          lda #<>aTitleMenuOptionNewGame
          sta @l aTitleMenu.aOptionsList,x
          inc x
          inc x
          inc x
          inc aTitleMenu.wOptionsListIndex

        +
        lda aSRAM.aSaveDataHeader.CompletionFlag
        and #$00FF
        beq +

          lda #(`aTitleMenuOptionSoundRoom)<<8
          sta @l aTitleMenu.aOptionsList+1,x
          lda #<>aTitleMenuOptionSoundRoom
          sta @l aTitleMenu.aOptionsList,x
          inc x
          inc x
          inc x
          inc aTitleMenu.wOptionsListIndex
        
        +
        lda wR0
        cmp #3
        beq +

          lda wParagonModeUnlockedFlag,b
          beq +

            lda #(`aTitleMenuOptionParagonMode)<<8
            sta @l aTitleMenu.aOptionsList+1,x
            lda #<>aTitleMenuOptionParagonMode
            sta @l aTitleMenu.aOptionsList,x
            inc x
            inc x
            inc x
            inc aTitleMenu.wOptionsListIndex
        
        +
        plp
        plb
        rts

        .databank 0

      rsCheckSuspendSaveSlotFilled ; 94/D884

        .al
        .autsiz
        .databank ?

        ; Output:
        ; sec = suspend slot is filled

        phx
        lda #3
        jsl rlCheckIfSaveSlotValid
        plx
        rts

        .databank 0

      rsGetFilledSaveSlotCount ; 94/D88E

        .al
        .autsiz
        .databank ?

        ; Output:
        ; clc = no filled save slots
        ; wR0 = number of filled save slots

        stz wR0
        phx

        ldx #2
        
        -
        txa
        phx

        ldx wR0
        phx

        jsl rlCheckIfSaveSlotValid

        plx
        stx wR0

        plx
        bcc +

          inc wR0
        
        +
        dec x
        bpl -

        plx
        lda wR0
        bne +

          clc
          rts

        +
        sec
        rts

        .databank 0

      rlEvaluateSaveSlots ; 94/D8B1

        .al
        .autsiz
        .databank ?

        phx
        ldx #MaxSaveSlotIndex
        
        -
        txa
        phx
        jsl rlCheckIfSaveSlotValid

        plx
        bcc +

          ; Slot is valid
          sep #$20
          lda #1
          sta aTitleValidSaveSlots,x
          rep #$20
          bra ++
        
        +
        sep #$20
        lda #0
        sta aTitleValidSaveSlots,x
        rep #$20

        +
        dec x
        bpl -

        plx
        rtl

        .databank 0

      aProcCodeCreateSaveConfirmMenuBox ; 94/D8D9

        PROC_CALL rlCreateSaveConfirmMenu
        PROC_HALT_WHILE procDialogue94CCDF

        PROC_CALL rlSaveConfirmMenuDMAToVRAM

        PROC_YIELD 1
        PROC_RETURN

      rlCreateSaveConfirmMenu ; 94/D8EC

        .al
        .autsiz
        .databank ?

        lda #(`aDecompressionBuffer + (32 * SaveConfirmPosition[1] * size(word)))<<8
        sta lR18+1
        lda #<>aDecompressionBuffer + (32 * SaveConfirmPosition[1] * size(word))
        sta lR18
        lda #(`aBG1TilemapBuffer.Page1 + (32 * SaveConfirmPosition[1] * size(word)))<<8
        sta lR19+1
        lda #<>aBG1TilemapBuffer.Page1 + (32 * SaveConfirmPosition[1] * size(word))
        sta lR19
        lda #(32 * SaveConfirmSize[1] * size(word))
        sta lR20
        jsl rlBlockCopy

        lda #(`aDecompressionBuffer + (32 * SaveConfirmPosition[1] * size(word)) + (32 * 28 * size(word)))<<8
        sta lR18+1
        lda #<>aDecompressionBuffer + (32 * SaveConfirmPosition[1] * size(word)) + (32 * 28 * size(word))
        sta lR18
        lda #(`aBG3TilemapBuffer.Page1 + (32 * SaveConfirmPosition[1] * size(word)))<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer.Page1 + (32 * SaveConfirmPosition[1] * size(word))
        sta lR19
        lda #(32 * SaveConfirmSize[1] * size(word))
        sta lR20
        jsl rlBlockCopy

        lda aSaveMenuActionIndex
        asl a
        clc
        adc aSaveMenuActionIndex
        tax
        lda aSaveConfirmBoxTextPointers,x
        sta lR18
        lda aSaveConfirmBoxTextPointers+1,x
        sta lR18+1

        lda aTitleMenu.wCurrentOptionIndex
        pha

        lda #3
        sta aTitleMenu.wCurrentOptionIndex
        jsr rsGetTitleMenuSaveTextVRAMPosition

        pla
        sta aTitleMenu.wCurrentOptionIndex

        lda #2
        sta wR1

        lda #0
        sta wR2

        lda #0
        sta wR3

        ldx #pack([SaveConfirmTextPosition[0], SaveConfirmTextPosition[1] + 32])
        jsl rlDrawDialogueText
        rtl

        .databank 0

      aSaveConfirmBoxTextPointers ; 94/D968

        .long 0
        .long $9080A0
        .long $9080AC
        .long $9080B8
        .long 0

      aProcCodeClearSaveConfirmMenuBox ; 94/D977

        PROC_CALL rlSaveMenuClearConfirmMenu
        PROC_YIELD 1
        PROC_RETURN

      rlSaveMenuClearConfirmMenu ; 94/D980

        .al
        .autsiz
        .databank ?

        lda #(`aBG1TilemapBuffer.Page1 + (32 * SaveConfirmPosition[1] * size(word)))<<8
        sta lR18+1
        lda #<>aBG1TilemapBuffer.Page1 + (32 * SaveConfirmPosition[1] * size(word))
        sta lR18
        lda #(32 * SaveConfirmSize[1] * size(word))
        sta lR19
        lda #BG12BlankTileAlt
        jsl rlBlockFillWord

        lda #(`aBG3TilemapBuffer.Page1 + (32 * SaveConfirmPosition[1] * size(word)))<<8
        sta lR18+1
        lda #<>aBG3TilemapBuffer.Page1 + (32 * SaveConfirmPosition[1] * size(word))
        sta lR18
        lda #(32 * SaveConfirmSize[1] * size(word))
        sta lR19
        lda #BG3BlankTile
        jsl rlBlockFillWord
        jsl rlSaveConfirmMenuDMAToVRAM
        rtl

        .databank 0

      rlSaveConfirmMenuDMAToVRAM ; 94/D9B1

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct
          .structDMAToVRAM aBG1TilemapBuffer.Page1 + (32 * SaveConfirmPosition[1] * size(word)), (32 * SaveConfirmSize[1] * size(word)), VMAIN_Setting(true), BG1TilemapPage1Position + (32 * SaveConfirmPosition[1] * size(word))

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer.Page1 + (32 * SaveConfirmPosition[1] * size(word)), (32 * SaveConfirmSize[1] * size(word)), VMAIN_Setting(true), BG3TilemapPage1Position + (32 * SaveConfirmPosition[1] * size(word))

        rtl

        .databank 0

      aTitleMenuOptionSoundRoom ; 94/D9CC

        .long $80C5BB
        .long $908081

      aTitleMenuOptionParagonMode ; 94/D9D2

        .long rlStartParagonSaveFile
        .long $908078

      aTitleMenuOptionGameOver ; 94/D9D8

        ; Unused

        .long $80C29D
        .long $908067

      aTitleMenuOptionEndingScreen ; 94/D9DE

        ; Unused

        .long $80C4AD
        .long $908070

      aTitleMenuOptionNewGame ; 94/D9E4

        .long rlStartNewSaveFile
        .long $908026

      aTitleMenuOptionLoadGame ; 94/D9EA

        .long rlLoadSaveFile
        .long $908033

      aTitleMenuOptionResumeGame ; 94/D9F0

        .long rlResumeSaveFile
        .long $908046

      aTitleMenuOptionCopyFile ; 94/D9F6

        .long rlCopySaveFile
        .long $908053

      aTitleMenuOptionDeleteFile ; 94/D9FC

        .long rlDeleteSaveFile
        .long $90805D

      rlUpdateVRAMBG3Page1 ; 94/DA02

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer.Page1, (32 * 28 * size(word)), VMAIN_Setting(true), BG3TilemapPage1Position

        rtl

        .databank 0

      rlTitleSetFadeTimer ; 94/DA10

        .al
        .autsiz
        .databank ?

        lda $0000,b,y
        and #$00FF
        sta aProcSystem.aHeaderUnknownTimer,b,x
        rtl

        .databank 0

      rlTitleWaitForFadeOut ; 94/DA1A

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlFadeOutByTimer
        rtl

        .databank 0

      rlTitleWaitForFadeIn ; 94/DA22

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlFadeInByTimer
        rtl

        .databank 0

      rlClearVRAMTilemapEntry ; 94/DA2A

        .al
        .autsiz
        .databank ?

        ; In:
        ; wR0 = VRAM address
        ; wR1 = TilemapEntry
        ; x: 1 = Tile4bpp, 0 = Tile2bpp

        dec x
        bmi +

          asl a
          asl a
          asl a
          asl a
          clc
          adc wR0
          sta wR1

          lda #size(Tile4bpp)
          sta wR0
          lda #(`aVRAMClearTile)<<8
          sta lR18+1
          lda #<>aVRAMClearTile
          sta lR18
          jsl rlDMAByPointer
          rtl

        +
        asl a
        asl a
        asl a
        clc
        adc wR0
        sta wR1

        lda #size(Tile2bpp)
        sta wR0
        lda #(`aVRAMClearTile)<<8
        sta lR18+1
        lda #<>aVRAMClearTile
        sta lR18
        jsl rlDMAByPointer
        rtl

        .databank 0

      aVRAMClearTile ; 94/DA66

        .rept 16
          .word 0
        .endrept

      rlCreateSaveBoxFoldingHDMA ; 94/DA86

        .al
        .autsiz
        .databank ?

        lda procSaveOption.SelectedSaveIndex,b,x
        sta wR0

        lda #(`aSaveBoxFoldingHDMAEntry)<<8
        sta lR44+1
        lda #<>aSaveBoxFoldingHDMAEntry
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rtl

        .databank 0

      rlSetSaveBoxHDMAFold ; 94/DA9A

        .al
        .autsiz
        .databank ?

        lda #1
        sta wSaveBoxHDMAControlCode
        rtl

        .databank 0

      rlSetSaveBoxHDMAUnfold ; 94/DAA2

        .al
        .autsiz
        .databank ?

        lda #2
        sta wSaveBoxHDMAControlCode
        rtl

        .databank 0

      rlClearSaveBoxFoldingHDMA ; 94/DAAA

        .al
        .autsiz
        .databank ?

        phx
        lda #(`aSaveBoxFoldingHDMAEntry)<<8
        sta lR44+1
        lda #<>aSaveBoxFoldingHDMAEntry
        sta lR44
        jsl rlHDMAEngineFindEntry
        bcc +

        jsl rlHDMAEngineFreeEntryByOffset
        clc
        bra ++
        
        +
        sec
        
        +
        plx
        rtl

        .databank 0

      rlCheckIfSaveBoxFoldingHDMAHalt ; 94/DAC5

        .al
        .autsiz
        .databank ?

        lda wSaveBoxHDMAControlCode
        beq +

          clc
          rtl

        +
        sec
        rtl

        .databank 0

      aSaveBoxFoldingHDMAEntry .structHDMAIndirectEntryInfo rlSaveBoxFoldingHDMAInit, rlSaveBoxFoldingHDMACycle, aSaveBoxFoldingHDMACode, aSaveBoxFoldingHDMATable1, TM, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode0), `aSaveBoxHDMALineData1 ; 94/DACF

      aSaveBoxFoldingHDMATable1 ; 94/DADB

        .byte NTRL_Setting(112, true)
        .word <>aSaveBoxHDMALineData1

        .byte NTRL_Setting(112, true)
        .word <>aSaveBoxHDMALineData1 + 112

        .byte 0

      aSaveBoxFoldingHDMATable2 ; 94/DAE2

        .byte NTRL_Setting(112, true)
        .word <>aSaveBoxHDMALineData2

        .byte NTRL_Setting(112, true)
        .word <>aSaveBoxHDMALineData2 + 112

        .byte 0

      aSaveBoxFoldingHDMACode ; 94/DAE9
        
        HDMA_HALT

      rlSaveBoxFoldingHDMAInit ; 94/DAEB
        
        .al
        .autsiz
        .databank ?

        ; Input:
        ; wR0 = save slot index

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        ldx #224 - size(word)
        lda #pack([T_Setting(true, true, true, false, true), T_Setting(true, true, true, false, true)])

        .databank $7E

        -
        sta aSaveBoxHDMALineData1,x
        sta aSaveBoxHDMALineData2,x
        dec x
        dec x
        bpl -

        lda wR0
        asl a
        asl a
        asl a
        asl a
        asl a

        clc
        adc #SaveSlotPosition[1] * 8
        sta @l wSaveBoxHDMAVOFS

        stz wSaveBoxHDMAScanlineOffset

        jsr rsSaveBoxFoldingEffect
        plp
        plb
        rtl
 
        .databank 0

      rlSaveBoxFoldingHDMACycle ; 94/DB1D
        
        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        .databank $7E

        lda @l wSaveBoxHDMAControlCode
        asl a
        tax
        jsr (_DB33,x)

        plp
        plb
        rtl

        _DB33
        .word <>rsSaveBoxFoldingHalt
        .word <>rsSaveBoxFold
        .word <>rsSaveBoxUnfold

        .databank 0

      rsSaveBoxFoldingHalt ; 94/DB39
        
        .al
        .autsiz
        .databank ?

        rts

        .databank 0

      rsSaveBoxFold ; 94/DB3A
        
        .al
        .autsiz
        .databank $7E

        ; Increase the scanline offset until its equal or more than half of a boxes height.

        lda @l wSaveBoxHDMAScanlineOffset
        inc a
        inc a
        cmp #SaveSlotSize[1] * 8 / 2
        beq +
        bcs ++

          +
          sta @l wSaveBoxHDMAScanlineOffset
          jsr rsSaveBoxFoldingEffect
          rts

        +
        stz wSaveBoxHDMAControlCode
        rts

        .databank 0

      rsSaveBoxUnfold ; 94/DB53
        
        .al
        .autsiz
        .databank $7E

        ; Decrease the scanline offset until its equal to the boxes original height.

        lda @l wSaveBoxHDMAScanlineOffset
        dec a
        dec a
        bmi +

          sta @l wSaveBoxHDMAScanlineOffset
          jsr rsSaveBoxFoldingEffect
          rts

        +
        stz wSaveBoxHDMAControlCode
        rts

        .databank 0

      rsSaveBoxFoldingEffect ; 94/DB67
        
        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        jsr rsSaveBoxFoldingSwapHDMATables
        jsr rsSaveBoxFoldingSwapHDMALineData

        clc
        adc wSaveBoxHDMAVOFS
        sta wR0

        ; Hide backgrounds 1 and 3 for the save slot

        ldy #SaveSlotSize[1] * 8 - 1
        lda #T_Setting(false, true, false, false, true)
        sep #$20

        -
        sta (wR0),y
        dec y
        bpl -

        rep #$20

        ; Move the Y offset down

        lda wR0
        clc
        adc wSaveBoxHDMAScanlineOffset
        sta wR0

        ; For reenabling the backgrounds 1 and 3, reduce the affected scanline count by
        ; the scanline offset *2, to account for both the top and bottom.

        lda #0
        sep #$20
        lda wSaveBoxHDMAScanlineOffset
        asl a
        eor #$FF
        inc a
        clc
        adc #SaveSlotSize[1] * 8 - 1
        bmi _End

        tay
        lda #T_Setting(true, true, true, false, true)
        
        -
        sta (wR0),y
        dec y
        bpl -

        _End
        rep #$20
        plp
        plb
        rts

        .databank 0

      rsSaveBoxFoldingSwapHDMATables ; 94/DBB5
        
        .al
        .autsiz
        .databank ?

        ldx aHDMASystem.wOffset,b
        lda aHDMASystem.aOffset,b,x
        cmp #<>aSaveBoxHDMALineData1
        beq +

          lda #<>aSaveBoxFoldingHDMATable1
          sta aHDMASystem.aOffset,b,x
          rts

        +
        lda #<>aSaveBoxFoldingHDMATable2
        sta aHDMASystem.aOffset,b,x
        rts

        .databank 0

      rsSaveBoxFoldingSwapHDMALineData ; 94/DBCE
        
        .al
        .autsiz
        .databank ?

        ldx aHDMASystem.wOffset,b
        lda aHDMASystem.aOffset,b,x
        cmp #<>aSaveBoxFoldingHDMATable1
        beq +

          lda #<>aSaveBoxHDMALineData2
          rts

        +
        lda #<>aSaveBoxHDMALineData1
        rts

        .databank 0

      procTitleScrollRight .structProcInfo "xx", rlProcTitleScrollRightInit, rlProcTitleScrollRightCycle, None ; 94/DBE1

      rlProcTitleScrollRightInit ; 94/DBE9

        .al
        .autsiz
        .databank ?

        lda #0
        sta wBufferBG1HOFS
        lda #0
        sta wBufferBG3HOFS
        rtl

        .databank 0

      rlProcTitleScrollRightCycle ; 94/DBF4

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody0,b,x
        inc aProcSystem.aBody0,b,x
        asl a
        tax
        lda aTitleScrollRightOffsets,x
        bmi +

          sta wBufferBG1HOFS
          sta wBufferBG3HOFS
          sep #$20
          eor #$FF
          inc a
          sta bBufferWH0
          rep #$20
          rtl

        +
        ldx aProcSystem.wOffset,b
        stz aProcSystem.aHeaderSleepTimer,b,x
        jsl rlProcEngineFreeProc
        rtl

        .databank 0

      aTitleScrollRightOffsets ; 94/DC1B

        .word $0020
        .word $0040
        .word $0060
        .word $0080
        .word $00C0
        .word $00E0
        .word $00F0
        .word $00F8
        .word $00FC
        .word $00FE
        .word $00FF
        .word $0100

        .word $FFFF

      procTitleScrollLeft .structProcInfo "xx", rlProcTitleScrollLeftInit, rlProcTitleScrollLeftCycle, None ; 94/DC35

      rlProcTitleScrollLeftInit ; 94/DC3D

        .al
        .autsiz
        .databank ?

        lda #256
        sta wBufferBG1HOFS
        lda #256
        sta wBufferBG3HOFS
        rtl

        .databank 0

      rlProcTitleScrollLeftCycle ; 94/DC48

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody0,b,x
        inc aProcSystem.aBody0,b,x
        asl a
        tax
        lda aTitleScrollLeftOffsets,x
        bmi ++

          sta wBufferBG1HOFS
          sta wBufferBG3HOFS

          sep #$20
          eor #$FF
          inc a
          bne +

            lda #$FF

          +
          sta bBufferWH0
          rep #$20
          rtl

        +
        ldx aProcSystem.wOffset,b
        stz aProcSystem.aHeaderSleepTimer,b,x
        jsl rlProcEngineFreeProc
        rtl

        .databank 0

      aTitleScrollLeftOffsets ; 94/DC73

        .word $00E0
        .word $00C0
        .word $00A0
        .word $0080
        .word $0060
        .word $0040
        .word $0020
        .word $0010
        .word $0008
        .word $0004
        .word $0002
        .word $0001
        .word $0000

        .word $FFFF

      rsTitleMenuSetHardwareRegisters ; 94/DC8F

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #T_Setting(false, true, false, false, false)
        sta bBufferTM

        lda #T_Setting(false, false, false, false, false)
        sta bBufferTS

        lda #T_Setting(false, false, false, false, false)
        sta bBufferTMW

        lda #T_Setting(false, false, false, false, false)
        sta bBufferTSW

        lda #CGWSEL_Setting(false, false, CGWSEL_MathInside, CGWSEL_BlackNever)
        sta bBufferCGWSEL

        lda #CGADSUB_Setting(CGADSUB_Subtract, false, true, false, false, false, false, false)
        sta bBufferCGADSUB

        lda #255
        sta bBufferWH0

        lda #255
        sta bBufferWH1

        lda #W12SEL_Setting(false, false, false, false, false, false, false, false)
        sta bBufferW12SEL

        lda #W12SEL_Setting(false, false, false, false, false, false, false, false)
        sta bBufferW34SEL

        lda #WOBJSEL_Setting(false, false, false, false, true, false, false, false)
        sta bBufferWOBJSEL
        rep #$20

        lda #0
        sta wBufferBG1HOFS

        lda #0
        sta wBufferBG3HOFS

        rts

        .databank 0

      rsReturnToTitleMenuSetHardwareRegisters ; 94/DCCA

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #T_Setting(true, true, true, false, true)
        sta bBufferTM

        lda #T_Setting(false, false, false, false, false)
        sta bBufferTS

        lda #T_Setting(false, false, false, false, false)
        sta bBufferTMW

        lda #T_Setting(false, false, false, false, false)
        sta bBufferTSW

        lda #CGWSEL_Setting(false, false, CGWSEL_MathInside, CGWSEL_BlackNever)
        sta bBufferCGWSEL

        lda #CGADSUB_Setting(CGADSUB_Subtract, false, true, false, false, false, false, false)
        sta bBufferCGADSUB

        lda #0
        sta bBufferWH0

        lda #255
        sta bBufferWH1

        lda #0
        sta bBufferW12SEL

        lda #0
        sta bBufferW34SEL

        lda #WOBJSEL_Setting(false, false, false, false, true, false, false, false)
        sta bBufferWOBJSEL
        rep #$20

        lda #256
        sta wBufferBG1HOFS
        lda #256
        sta wBufferBG3HOFS
        rts

        .databank 0

      rsTitleSaveMenuSetHardwareRegisters ; 94/DD05

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #T_Setting(false, true, false, false, false)
        sta bBufferTM

        lda #T_Setting(false, false, false, false, false)
        sta bBufferTS

        lda #CGWSEL_Setting(false, false, CGWSEL_MathAlways, CGWSEL_BlackNever)
        sta bBufferCGWSEL

        lda #CGADSUB_Setting(CGADSUB_Subtract, false, true, false, false, false, false, false)
        sta bBufferCGADSUB

        lda bBufferBG1SC
        and #~BGSC_Size
        ora #BGSC_Setting(0, BGSC_64x32)
        sta bBufferBG1SC

        lda bBufferBG3SC
        and #~BGSC_Size
        ora #BGSC_Setting(0, BGSC_64x32)
        sta bBufferBG3SC

        rep #$20
        rts

        .databank 0

      rsMapSaveMenuSetHardwareRegisters ; 94/DD2A

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #T_Setting(true, true, true, false, true)
        sta bBufferTM

        lda #T_Setting(false, false, false, false, false)
        sta bBufferTS

        lda #CGWSEL_Setting(false, false, CGWSEL_MathAlways, CGWSEL_BlackNever)
        sta bBufferCGWSEL

        lda #CGADSUB_Setting(CGADSUB_Subtract, false, true, false, false, false, false, false)
        sta bBufferCGADSUB

        lda bBufferBG1SC
        and #~BGSC_Size
        ora #BGSC_64x32
        sta bBufferBG1SC

        lda bBufferBG3SC
        and #~BGSC_Size
        ora #BGSC_64x32
        sta bBufferBG3SC
        rep #$20

        lda #256
        sta wBufferBG1HOFS
        lda #256
        sta wBufferBG3HOFS
        rts

        .databank 0

      rlUnknown94DD59 ; 94/DD59

        .al
        .autsiz
        .databank ?

        lda $17E9,b
        ora #$0040
        sta $17E9,b
        rtl

        .databank 0

      rsTitleCheckIfSaveFilled ; 94/DD63

        .al
        .autsiz
        .databank ?

        tax
        lda aTitleValidSaveSlots,x
        and #$00FF
        beq +

          txa
          jsl rlCheckIfSaveSlotFilled
          rts

        +
        clc
        rts

        .databank 0

        ; 94/DD75

        .endwith ; TitleMenuConfig

    .endsection TitleMenu4Section



    .section TitleMenuTilemapDataSection

      startTilemaps
        acTitleMenuOptionBackgroundTilemap    .text ROM[$1C82C6:$1C831C]
        acTitleMenuOptionBorderTilemap        .text ROM[$1C831C:$1C834D]
      endTilemaps

      startGraphics
        g4bppcFinGraphic                      .text ROM[$1C834D:$1C8444]
      endGraphics

      startTilemaps
        acFinTilemap                          .text ROM[$1C8444:$1C84CD]
      endTilemaps

      startPalettes
        acFinPalette                          .text ROM[$1C84CD:$1C84D7]
      endPalettes

      startTilemaps
       acSaveMenuBackgroundTilemap            .text ROM[$1C84D7:$1C8627]
       acSaveMenuBorderTilemap                .text ROM[$1C8627:$1C86B9]
      endTilemaps

    .endsection TitleMenuTilemapDataSection




    .section NintendoLogoSection

      procNintendoLogo .structProcInfo "xx", None, None, aProcNintendoLogoCode ; B9/E2E3

      aProcNintendoLogoCode ; B9/E2EB

        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_TRUE _Skip, rlNintendoLogoSkipCheck
        
          PROC_CALL_ARGS rlTitleSetFadeTimer, size(_Args1)
          _Args1 .block
            .byte 1
          .bend

          -
          PROC_YIELD 1
          PROC_JUMP_IF_ROUTINE_FALSE -, rlTitleWaitForFadeOut

          PROC_CALL rlUnknownB9E331

          PROC_CALL_ARGS rlTitleSetFadeTimer, size(_Args2)
          _Args2 .block
            .byte 1
          .bend

          -
          PROC_YIELD 1
          PROC_JUMP_IF_ROUTINE_FALSE -, rlTitleWaitForFadeIn

          PROC_PLAY_SFX $0081

          PROC_YIELD 80

        _Skip
        PROC_CALL $80C3ED
        PROC_END

      rlNintendoLogoSkipCheck ; B9/E326

        .al
        .autsiz
        .databank ?

        lda wJoy1Input
        bit #JOY_Start
        beq +

          sec
          rtl
        
        +
        clc
        rtl

        .databank 0

      rlUnknownB9E331 ; B9/E331

        .al
        .autsiz
        .databank ?

        jsl rlDisableVBlank

        sep #$20
        lda #INIDISP_Setting(true, 0)
        sta bBufferINIDISP
        rep #$20

        sep #$20
        lda #INIDISP_Setting(true, 0)
        sta INIDISP,b
        rep #$20

        sep #$20
        lda #T_Setting(true, false, true, false, false)
        sta bBufferTM
        rep #$20

        jsr $B9E69E
        jsl $809C9B

        lda #(`g4bppcNintendoLogo)<<8
        sta lR18+1
        lda #<>g4bppcNintendoLogo
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aDecompressionBuffer, (16 * 4 * size(Tile4bpp)) + size(Tile4bpp), VMAIN_Setting(true), $A000

        lda #(`acNintendoLogoTilemap)<<8
        sta lR18+1
        lda #<>acNintendoLogoTilemap
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aDecompressionBuffer, $0700, VMAIN_Setting(true), $7000

        lda #(`acNintendoLogoPalette)<<8
        sta lR18+1
        lda #<>acNintendoLogoPalette
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette1)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette1
        sta lR19
        jsl rlAppendDecompList

        stz aBGPaletteBuffer.aPalette0,b

        lda #$C000 >> 1
        sta wR0
        lda #$02FF
        ldx #0
        jsl rlClearVRAMTilemapEntry

        sep #$20
        lda #INIDISP_Setting(false, 0)
        sta bBufferINIDISP
        rep #$20

        sep #$20
        lda #INIDISP_Setting(false, 0)
        sta INIDISP,b
        rep #$20

        jsl rlEnableVBlank
        rtl

        .databank 0

        ; B9/E3DF

    .endsection NintendoLogoSection





    .section TitleScreenFlameEffectSection

      rlCreateTitleFlameWaveHDMA ; B9/F818

        .al
        .autsiz
        .databank ?

        lda #(`aTitleFlameWaveHDMAEntry)<<8
        sta lR44+1
        lda #<>aTitleFlameWaveHDMAEntry
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rtl

        .databank 0

      rlClearTitleFlameWaveHDMA ; B9/F827

        .al
        .autsiz
        .databank ?

        phx
        lda #(`aTitleFlameWaveHDMAEntry)<<8
        sta lR44+1
        lda #<>aTitleFlameWaveHDMAEntry
        sta lR44
        jsl rlHDMAEngineFindEntry
        bcc +

          jsl rlHDMAEngineFreeEntryByOffset
          clc
          bra ++
          
          +
          sec
        
        +
        plx
        rtl

        .databank 0

      aTitleFlameWaveHDMAEntry .structHDMADirectEntryInfo rlTitleFlameWaveHDMAInit, rlTitleFlameWaveHDMAInit, aTitleFlameWaveHDMACode, aTitleFlameWaveHDMATable, BG3HOFS, DMAP_DMA_Setting(DMAP_CPUToIO, DMAP_Increment, DMAP_Mode2) ; B9/F842

      aTitleFlameWaveHDMACode ; B9/F84D

        HDMA_HALT

      rlTitleFlameWaveHDMAInit ; B9/F84F

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      aTitleFlameWaveHDMATable ; B9/F850

        _Table := [3, 5, 7, 8, 9, 9, 10, 10]

        .rept 8

          .byte NTRL_Setting(34, true)
          .word 0

          .for _Entry in _Table
            .word _Entry
          .endfor
          .for _Entry in _Table[::-1]
            .word _Entry
          .endfor

          .word 0

          .for _Entry in _Table
            .sint -_Entry
          .endfor
          .for _Entry in _Table[::-1]
            .sint -_Entry
          .endfor

        .endrept

        .byte 0

        ; B9/FA79

    .endsection TitleScreenFlameEffectSection



    .section TitlePalettesSection

      startPalettes
        aThirteenYearsLaterPalette            .text ROM[$1D03B8:$1D03D8]
        aFireEmblemPalette                    .text ROM[$1D03D8:$1D0418]
        aFireEmblemCrestPalette               .text ROM[$1D0418:$1D0478]
        aTitleFlamePalette                    .text ROM[$1D0478:$1D0498]
        aFireEmblemBannerPalette              .text ROM[$1D0498:$1D04F8]
        aFireEmblemCrestFadingPalette         .text ROM[$1D04F8:$1D0558]
      endPalettes

    .endsection TitlePalettesSection



    .section TitleGraphicDataSection

      startGraphics
        g4bppcTitleFireEmblem                 .text ROM[$1D0A21:$1D1D8C]
      endGraphics

      startTilemaps
        acTitleFireEmblemTilemap              .text ROM[$1D1D8C:$1D1EEE]
      endTilemaps

      startGraphics
        g4bppcTitleFireEmblemCrest            .text ROM[$1D1EEE:$1D3F04]
      endGraphics

      startTilemaps
        acTitleFireEmblemCrestTilemap         .text ROM[$1D3F04:$1D4218]
      endTilemaps

      startGraphics
        g4bppcTitleFlame                      .text ROM[$1D4218:$1D4261]
      endGraphics

      startTilemaps
        acTitleFlameTilemap                   .text ROM[$1D4261:$1D42CA]
      endTilemaps

      startGraphics
        g4bppcTitleFireEmblemBanner           .text ROM[$1D42CA:$1D512B]
      endGraphics

      startTilemaps
        acIntroTimelineTilemap                .text ROM[$1D512B:$1D52A3]
      endTilemaps

      startGraphics
        g4bppcNintendoLogo                    .text ROM[$1D52A3:$1D5871]
      endGraphics

      startTilemaps
        acNintendoLogoTilemap                 .text ROM[$1D5871:$1D591A]
      endTilemaps

      startPalettes
        acNintendoLogoPalette                 .text ROM[$1D591A:$1D593A]
      endPalettes
      
    .endsection TitleGraphicDataSection



    .section ThirteenYearsLaterGraphicSection

      startGraphics
        g4bppThirteenYearsLaterGraphic        .text ROM[$1E8D85:$1E9220]
      endGraphics

    .endsection ThirteenYearsLaterGraphicSection





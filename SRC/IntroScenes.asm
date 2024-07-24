
    .weak

      rlEnableVBlank                              :?= address($8082DA)
      rlDisableVBlank                             :?= address($8082E8)
      rlDMAByStruct                               :?= address($80AE2E)
      rlAppendDecompList                          :?= address($80B00A)
      rlBlockCopy                                 :?= address($80B340)
      rlFillTilemapByWord                         :?= address($80E89F)
      rlProcEngineCreateProc                      :?= address($829BF1)
      rlProcEngineFindProc                        :?= address($829CEC)
      rlProcEngineFreeProc                        :?= address($829D11)
      rlHDMAEngineCreateEntry                     :?= address($82A3ED)
      rlIRQEngineReset                            :?= address($82A6AE)
      rlProcPaletteChange                         :?= address($8EEC3A)
      procPaletteChange                           :?= address($8EEC55)
      rlBlockFillWord                             :?= address($80B36C)

      aBlackPalette                               :?= address($90B2F3)
      aWhitePalette                               :?= address($90B4F3)

      rlDMAByPointer                              :?= address($80AEF9)

      IRQ_HALT                                    :?= address($82A663)


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

      macroFindAndFreeHDMA .segment Proc
        phx
        lda #(`\Proc)<<8
        sta lR44+1
        lda #<>\Proc
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
      .endsegment

      macroScriptedBGPaletteChangeEntry .segment FrameCount, ColorOffset
        .rept \FrameCount
          .byte \ColorOffset
        .endrept
      .endsegment

      macroScriptedBGPaletteChangeLoop .segment
        .byte $FE
      .endsegment

    .endweak



    .virtual $7EA9B9

      wIntroSceneID     .word ?                                     ; $7EA9B9
        ; For unused code.
      wIntroSceneTextID .word ?                                     ; $7EA9BB
        ; For unused code.
      .word ?                                                       ; $7EA9BD
      wIntroSceneENTextFrameCounter .word ?                         ; $7EA9BF
        ; Counts up every frame.
      wIntroSceneENTextScrollDelay .word ?                          ; $7EA9C1
        ; Once the frame counter is equal to this, scroll the screen
        ; and reset the frame counter
      wIntroScene3FlameEffectHDMACounter        .word ?             ; $7EA9C3
      aIntroScene3FlameEffectHDMATableData      .fill 224 * 2       ; $7EA9C5

    .endvirtual

    .virtual $7F8654

      aIntroScenesBG2DecompressionBuffer        .fill $700          ; $7F8654
      aIntroScenesBG3DecompressionBuffer        .fill $A80          ; $7F8D54
      aIntroScenesGraphicsDecompressionBuffer   .fill $3F00         ; $7F97D4
      aIntroScenesGraphicsDecompreesionBuffer2  .fill ($800000 - *) ; $7FD6D4

    .endvirtual



    IntroScenesConfig .namespace

      ; VRAM positions

        OAMBase = $8000
        BG1Base = $7000
        BG2Base = $0000
        BG3Base = $C000

        OAMTilesPosition := OAMBase
        OAMAllocate .function Size
          Return := IntroScenesConfig.OAMTilesPosition
          IntroScenesConfig.OAMTilesPosition += Size
        .endfunction Return

        BG1TilesPosition := BG1Base
        BG1Allocate .function Size
          Return := IntroScenesConfig.BG1TilesPosition
          IntroScenesConfig.BG1TilesPosition += Size
        .endfunction Return

        BG2TilesPosition := BG2Base
        BG2Allocate .function Size
          Return := IntroScenesConfig.BG2TilesPosition
          IntroScenesConfig.BG2TilesPosition += Size
        .endfunction Return

        BG3TilesPosition := BG3Base
        BG3Allocate .function Size
          Return := IntroScenesConfig.BG3TilesPosition
          IntroScenesConfig.BG3TilesPosition += Size
        .endfunction Return


        SceneBGGraphicPosition = BG2Allocate(56 * 16 * size(Tile4bpp))  ; $0000 - $7000

        PictureTilemapPosition = BG1Allocate(32 * 32 * size(word))      ; $7000 - $7800

        _ := BG2Allocate($7800 - BG2TilesPosition)
        BG2TilemapPosition = BG2Allocate(32 * 32 * size(word))          ; $7800 - $8000

        PictureGraphic2Position = OAMAllocate(16 * 16 * size(Tile4bpp)) ; $8000 - $A000

        _ := BG1Allocate($A000 - BG1TilesPosition)
        PictureGraphic1Position = BG1Allocate(16 * 16 * size(Tile4bpp)) ; $A000 - $C000

        TextGraphicPosition = BG3Allocate(40 * 16 * size(Tile2bpp))     ; $C000 - $E800

        _ := BG3Allocate($EFC0 - BG3TilesPosition)
        BorderGraphicPosition = BG3Allocate(4  *  1 * size(Tile2bpp))   ; $EFC0 - $F000
        JPTextTilemapPosition = BG3Allocate(32 * 32 * size(word))       ; $F000 - $F800
        ENTextTilemapPosition = BG3Allocate(32 * 32 * size(word))       ; $F800 - end of VRAM


        JPTextPosition = (32, 25)
        PictureCoordinates = (8, 3)
        PictureSize = (16, 14)

    .endnamespace ; IntroScenesConfig



    .section IntroScenesSection

      .with IntroScenesConfig

      rlIntroScenesClearText ; B9/D5EE

        .al
        .autsiz
        .databank ?

        lda #<>aBG3TilemapBuffer
        sta wR0
        lda #$02FF
        jsl rlFillTilemapByWord

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), JPTextTilemapPosition

        jsl rlIntroScenesSetTextPalette
        rtl

        .databank 0

      rlUnknownB9D60C ; B9/D60C

        .al
        .autsiz
        .databank ?

        lda #(`aBG3TilemapBuffer + (32 * 18 * size(word)))<<8
        sta lR18+1
        lda #<>aBG3TilemapBuffer + (32 * 18 * size(word))
        sta lR18
        lda #(32 * 10 * size(word))
        sta lR19
        lda #$02FF
        jsl rlBlockFillWord

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), JPTextTilemapPosition

        jsl rlIntroScenesSetTextPalette
        rtl

        .databank 0

      procIntroScenes .structProcInfo "xx", None, None, aProcIntroScenesCode ; B9/D634

      aProcIntroScenesCode ; B9/D63C

        PROC_CALL_ARGS rlSetFadeTimer, size(+)
        + .block
          .byte 1
        .bend

        -
        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_FALSE -, rlWaitForFadeOut

        PROC_JUMP_IF_BUTTON _Skip, JOY_Start

          PROC_CREATE_PROC procIntroScenesSkipCheck

          PROC_YIELD 2

          PROC_PLAY_SONG $0021
          PROC_HALT_UNTIL_SONG_PLAYING

          PROC_CALL rlIntroScenesTextSetup
          PROC_YIELD 1

          PROC_CREATE_HDMA_ARRAY_ENTRY aIntroScenesJPBGClearHDMA

          PROC_CALL rlCreateIntroScenesEdgeFadingIRQs
          PROC_YIELD 1

          PROC_CALL rlPrepareIntroScene1

          PROC_CALL_ARGS rlSetFadeTimer, size(+)
          + .block
            .byte 8
          .bend

          -
          PROC_YIELD 1
          PROC_JUMP_IF_ROUTINE_FALSE -, rlWaitForFadeIn

          PROC_YIELD 1000

          PROC_CALL_ARGS rlSetFadeTimer, size(_Args3)
          _Args3 .block
            .byte 8
          .bend

          -
          PROC_YIELD 1
          PROC_JUMP_IF_ROUTINE_FALSE -, rlWaitForFadeOut

          PROC_CALL rlIntroScenesClearText
          PROC_YIELD 4

          PROC_CALL rlPrepareIntroScene2

          PROC_CALL_ARGS rlIntroScenesClearSpecifiedPalette, size(+)
          + .block
            .word aBGPaletteBuffer.aPalette2 - aBGPaletteBuffer
          .bend

          PROC_CALL_ARGS rlSetFadeTimer, size(+)
          + .block
            .byte 8
          .bend

          -
          PROC_YIELD 1
          PROC_JUMP_IF_ROUTINE_FALSE -, rlWaitForFadeIn

          PROC_YIELD 30

          PROC_BL aProcCodeIntroScene2DisplayPicture1
          PROC_BL aProcCodeIntroScene2DisplayPicture2

          PROC_BL aProcCodeStartIntroScene3
          PROC_BL aProcCodeIntroScene3DisplayPicture2
          PROC_BL aProcCodeIntroScene3DisplayPicture3

          PROC_YIELD 20

          PROC_CALL rlClearIntroSceneProcScriptedBGPaletteChange

          PROC_CALL_ARGS rlProcPaletteChange, size(+)
          + .block
           .structPaletteChangeData aBGPaletteBuffer.aPalette0, aWhitePalette, aBGPaletteBuffer.aPalette0 + size(Color), 0, 128, false
          .bend

          PROC_CALL_ARGS rlProcPaletteChange, size(+)
          + .block
           .structPaletteChangeData aBGPaletteBuffer.aPalette4, aWhitePalette, aOAMPaletteBuffer.aPalette0, 0, 128, false
          .bend

          PROC_HALT_WHILE procPaletteChange

          PROC_CALL rlClearIntroScenesHDMAs

          PROC_SONG_FADE_OUT 6

          PROC_CALL_ARGS rlProcPaletteChange, size(+)
          + .block
           .structPaletteChangeData aBGPaletteBuffer.aPalette4, aBlackPalette, aOAMPaletteBuffer.aPalette0, 0, 64, false
          .bend

          PROC_HALT_WHILE procPaletteChange

          PROC_CALL rlIntroScenesFinished
          PROC_END

        _Skip
        PROC_CALL rlIntroScenesSkipped
        PROC_END

      aProcCodeIntroScene2DisplayPicture1 ; B9/D72B

        PROC_CALL_ARGS rlCreateProcIntroScenePicture, size(+)
        + .block
          .long aIntroScene2Picture1Data
        .bend

        PROC_HALT_WHILE procIntroScenePicture

        PROC_CALL_ARGS rlIntroSceneHidePictureBackground, size(+)
        + .block
          .long aIntroScene2Picture1Data
        .bend

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aBGPaletteBuffer.aPalette0 + (size(Color) * 8), aIntroSceneBorderPalette, aBGPaletteBuffer.aPalette0 + (size(Color) * 12), 0, 64, false
        .bend

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aBGPaletteBuffer.aPalette2, aIntroScene2Picture1Palette, aBGPaletteBuffer.aPalette3, 0, 64, false
        .bend

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aBGPaletteBuffer.aPalette6, PaletteFadeToBlack, aBGPaletteBuffer.aPalette7, 0, 32, false
        .bend

        PROC_HALT_WHILE procPaletteChange

        PROC_YIELD 600

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aBGPaletteBuffer.aPalette0 + (size(Color) * 8), PaletteFadeToBlack, aBGPaletteBuffer.aPalette0 + (size(Color) * 12), 0, 64, false
        .bend

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aBGPaletteBuffer.aPalette2, PaletteFadeToBlack, aBGPaletteBuffer.aPalette3, 0, 64, false
        .bend

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aBGPaletteBuffer.aPalette6, aIntroScene2BackgroundPalette, aBGPaletteBuffer.aPalette7, 0, 32, false
        .bend

        PROC_HALT_WHILE procPaletteChange

        PROC_CALL rlIntroScene2RestoreBackground

        PROC_RETURN

      aProcCodeIntroScene2DisplayPicture2 ; B9/D7B5
        
        PROC_CALL_ARGS rlCreateProcIntroScenePicture, size(+)
        + .block
          .long aIntroScene2Picture2Data
        .bend

        PROC_HALT_WHILE procIntroScenePicture

        PROC_CALL_ARGS rlIntroSceneHidePictureBackground, size(+)
        + .block
          .long aIntroScene2Picture2Data
        .bend

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aBGPaletteBuffer.aPalette0 + (size(Color) * 8), aIntroSceneBorderPalette, aBGPaletteBuffer.aPalette0 + (size(Color) * 12), 0, 64, false
        .bend

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aBGPaletteBuffer.aPalette2, aIntroScene2Picture2Palette, aBGPaletteBuffer.aPalette3, 0, 64, false
        .bend

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aBGPaletteBuffer.aPalette6, PaletteFadeToBlack, aBGPaletteBuffer.aPalette7, 0, 32, false
        .bend

        PROC_HALT_WHILE procPaletteChange

        PROC_YIELD 820

        PROC_RETURN

      aProcCodeStartIntroScene3 ; B9/D805

        PROC_CALL_ARGS rlSetFadeTimer, size(+)
        + .block
          .byte 4
        .bend

        -
        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_FALSE -, rlWaitForFadeOut

        PROC_CALL_ARGS rlIntroScenesClearSpecifiedPalette, size(+)
        + .block
          .word aBGPaletteBuffer.aPalette2 - aBGPaletteBuffer
        .bend

        PROC_CALL rlPrepareIntroScene3

        PROC_CALL_ARGS rlSetFadeTimer, size(+)
        + .block
          .byte 1
        .bend

        -
        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_FALSE -, rlWaitForFadeIn

        PROC_CALL_ARGS rlCreateProcIntroScenePicture, size(+)
        + .block
          .long aIntroScene3Picture1Data
        .bend

        PROC_HALT_WHILE procIntroScenePicture

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aBGPaletteBuffer.aPalette0 + (size(Color) * 8), aIntroSceneBorderPalette, aBGPaletteBuffer.aPalette0 + (size(Color) * 12), 0, 64, false
        .bend

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aBGPaletteBuffer.aPalette2, aIntroScene3Picture1Palette, aBGPaletteBuffer.aPalette3, 0, 64, false
        .bend

        PROC_SET_ONCYCLE rlIntroScene3ScrollInPicture
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_YIELD 60

        PROC_CALL rlIntroScenesUpdateHardwareRegisters

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aBGPaletteBuffer.aPalette4, aIntroScene3BackgroundPalette, aBGPaletteBuffer.aPalette6, 0, 64, false
        .bend

        PROC_SET_ONCYCLE rlIntroScene3ScrollInBackground
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_HALT_WHILE procPaletteChange

        PROC_CALL rlIntroScene3BackgroundColorChange

        PROC_YIELD 700

        PROC_RETURN

      aProcCodeIntroScene3DisplayPicture2 ; B9/D899

        PROC_CALL rlIntroScene3Picture2UpdateHardwareRegisters

        PROC_CALL_ARGS rlIntroScenesClearSpecifiedPalette, size(+)
        + .block
          .word aOAMPaletteBuffer.aPalette7 - aBGPaletteBuffer
        .bend

        PROC_CALL_ARGS rlCreateProcIntroScenePicture, size(+)
        + .block
          .long aIntroScene3Picture2Data
        .bend

        PROC_HALT_WHILE procIntroScenePicture

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aOAMPaletteBuffer.aPalette7, aIntroScene3Picture2Palette, aOAMPaletteBuffer.aPalette7 + size(Palette), 0, 32, false
        .bend

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aBGPaletteBuffer.aPalette2, PaletteFadeToBlack, aBGPaletteBuffer.aPalette3, 0, 32, false
        .bend

        PROC_HALT_WHILE procPaletteChange

        PROC_CALL rlIntroScene3Picture2RevertHardwareRegisters

        PROC_YIELD 700

        PROC_RETURN

      rlIntroScene3Picture2UpdateHardwareRegisters ; B9/D8E2

        .al
        .autsiz
        .databank ?

        sep #$20
        lda bBufferOBSEL
        and #~OBSEL_Size
        ora #OBSEL_Setting(ObjSize8x8And64x64)
        sta bBufferOBSEL

        lda #T_Setting(true, true, false, false, false)
        sta bBufferTM

        lda #T_Setting(false, false, true, false, true)
        sta bBufferTS

        lda #CGADSUB_Setting(CGADSUB_Add, false, true, true, false, false, false, true)
        sta bBufferCGADSUB
        rep #$20
        rtl

        .databank 0

      rlIntroScene3Picture2RevertHardwareRegisters ; B9/D8FB

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #T_Setting(true, true, false, false, true)
        sta bBufferTM

        lda #T_Setting(false, false, true, false, false)
        sta bBufferTS

        lda #CGADSUB_Setting(CGADSUB_Add, false, false, true, false, false, false, true)
        sta bBufferCGADSUB

        rep #$20
        rtl

        .databank 0

      aProcCodeIntroScene3DisplayPicture3 ; B9/D90C

        PROC_CALL rlIntroScene3Picture3UpdateHardwareRegisters

        PROC_CALL_ARGS rlCreateProcIntroScenePicture, size(+)
        + .block
          .long aIntroScene3Picture3Data
        .bend

        PROC_HALT_WHILE procIntroScenePicture

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aBGPaletteBuffer.aPalette2, aIntroScene3Picture3Palette, aBGPaletteBuffer.aPalette3, 0, 32, false
        .bend

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aOAMPaletteBuffer.aPalette7, PaletteFadeToBlack, aOAMPaletteBuffer.aPalette7 + size(Palette), 0, 32, false
        .bend

        PROC_HALT_WHILE procPaletteChange

        PROC_CALL_ARGS rlIntroSceneHidePictureBackground, size(+)
        + .block
          .long aIntroScene3Picture3Data
        .bend

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aBGPaletteBuffer.aPalette6, PaletteFadeToBlack, aBGPaletteBuffer.aPalette7, 0, 1024, false
        .bend

        PROC_HALT_WHILE procPaletteChange

        PROC_YIELD 200

        PROC_CALL rlIntroScene3Picture3RevertHardwareRegisters

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aBGPaletteBuffer.aPalette6, aIntroScene3BackgroundPalette, aBGPaletteBuffer.aPalette7, 0, 64, false
        .bend

        PROC_YIELD 310

        PROC_RETURN

      rlIntroScene3Picture3UpdateHardwareRegisters ; B9/D97D

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #T_Setting(false, true, false, false, true)
        sta bBufferTM

        lda #T_Setting(true, false, true, false, false)
        sta bBufferTS

        lda #CGADSUB_Setting(CGADSUB_Add, false, false, true, false, false, true, true)
        sta bBufferCGADSUB
        rep #$20
        rtl

        .databank 0

      rlIntroScene3Picture3RevertHardwareRegisters ; B9/D98E

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #T_Setting(false, true, false, false, false)
        sta bBufferTM

        lda #T_Setting(true, false, true, false, false)
        sta bBufferTS

        lda #CGADSUB_Setting(CGADSUB_Add, false, false, true, false, false, false, true)
        sta bBufferCGADSUB

        rep #$20
        rtl 

        .databank 0

      rlUnknownB9D99F ; B9/D99F

        .al
        .autsiz
        .databank ?

        lda #$FFFF
        sta aBGPaletteBuffer.aPalette0,b

        sep #$20
        lda #T_Setting(false, false, false, false, false)
        sta bBufferTM

        lda #T_Setting(false, false, false, false, false)
        sta bBufferTS

        lda #CGWSEL_Setting(false, false, CGWSEL_MathAlways, CGWSEL_BlackNever)
        sta bBufferCGWSEL

        lda #CGADSUB_Setting(CGADSUB_Add, false, false, false, false, false, false, false)
        sta bBufferCGADSUB
        rep #$20

        lda #<>aBG2TilemapBuffer
        sta wR0
        lda #$02FF
        jsl rlFillTilemapByWord

        jsl rlDMAByStruct
          .structDMAToVRAM aBG2TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), BG2TilemapPosition

        rtl

        .databank 0

      aProcCodeUnknownB9D9D3 ; B9/D9D3

        PROC_CALL rlUnknownB9DA04

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aBGPaletteBuffer.aPalette1, PaletteFadeToBlack, aBGPaletteBuffer.aPalette2, 0, 64, false
        .bend

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
         .structPaletteChangeData aBGPaletteBuffer.aPalette2, aIntroScene3Picture2Palette, aBGPaletteBuffer.aPalette3, 0, 64, false
        .bend

        PROC_HALT_WHILE procPaletteChange

        PROC_CALL rlUnknownB9DA56

        PROC_RETURN

      rlUnknownB9DA04 ; B9/DA04

        .al
        .autsiz
        .databank ?

        lda #(`aUnknownPaletteB9DA36)<<8
        sta lR18+1
        lda #<>aUnknownPaletteB9DA36
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette2)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette2
        sta lR19
        lda #size(Palette)
        sta lR20
        jsl rlBlockCopy

        sep #$20
        lda #T_Setting(true, false, false, false, false)
        sta bBufferTM

        lda #T_Setting(false, true, false, false, false)
        sta bBufferTS

        lda #CGADSUB_Setting(CGADSUB_Add, false, true, false, false, false, false, false)
        sta bBufferCGADSUB
        
        lda #CGWSEL_Setting(false, true, CGWSEL_MathAlways, CGWSEL_BlackNever)
        sta bBufferCGWSEL

        rep #$20
        rtl

        .databank 0

      aUnknownPaletteB9DA36 ; B9/DA36

        .rept 16
          .word 0
        .endrept

      rlUnknownB9DA56 ; B9/DA56

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #T_Setting(false, true, false, false, false)
        sta bBufferTM

        lda #CGADSUB_Setting(CGADSUB_Add, false, false, false, false, false, false, false)
        sta bBufferCGADSUB

        lda #CGWSEL_Setting(false, false, CGWSEL_MathAlways, CGWSEL_BlackNever)
        sta bBufferCGWSEL
        rep #$20
        rtl

        .databank 0

      rlCreateProcIntroScenePicture ; B9/DA67

        .al
        .autsiz
        .databank ?

        lda $0000,b,y
        sta lR18
        lda $0001,b,y
        sta lR18+1
        lda #(`procIntroScenePicture)<<8
        sta lR44+1
        lda #<>procIntroScenePicture
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      rlUnknownB9DA80 ; B9/DA80

        .al
        .autsiz
        .databank ?

        lda $0000,b,y
        sta lR18
        lda $0001,b,y
        sta lR18+1

        lda #(`aBGPaletteBuffer.aPalette2)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette2
        sta lR19
        lda #size(Palette)
        sta lR20
        jsl rlBlockCopy

        lda #(`aOAMPaletteBuffer.aPalette7)<<8
        sta lR19+1
        lda #<>aOAMPaletteBuffer.aPalette7
        sta lR19
        jsl rlBlockCopy
        rtl

        .databank 0

      procIntroScenePicture .structProcInfo "xx", rlProcIntroScenePictureInit, None, aProcIntroScenePictureCode ; B9/DAAC

      rlProcIntroScenePictureInit ; B9/DAB4

        .al
        .autsiz
        .databank ?

        lda lR18
        sta aProcSystem.aBody0,b,x
        lda lR18+2
        and #$00FF
        sta aProcSystem.aBody1,b,x
        rtl

        .databank 0

      aProcIntroScenePictureCode ; B9/DAC2

        PROC_CALL rlDecompressIntroScenePictureGraphic

        PROC_HALT_WHILE_DECOMPRESSING

        PROC_SET_ONCYCLE rlProcCycleDMAIntroScenePicture1
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_JUMP_IF_ROUTINE_FALSE +, rlDecompressIntroScenePictureTilemap

          PROC_HALT_WHILE_DECOMPRESSING

          PROC_CALL rlDMAIntroScenePictureTilemap

          PROC_YIELD 1

          PROC_END

        +
        PROC_CALL rlDisplayIntroScenePictureAsSprite

        PROC_END

      rlDecompressIntroScenePictureGraphic ; B9/DAEC

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
        sta lR18
        lda $0001,b,y
        sta lR18+1
        lda #(`aIntroScenesGraphicsDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aIntroScenesGraphicsDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        plp
        plb
        rtl

        .databank 0

      rlProcCycleDMAIntroScenePicture1 ; B9/DB15

        .al
        .autsiz
        .databank ?

        ; DMAs the decomped graphic in 3 steps

        stz aProcSystem.aHeaderSleepTimer,b,x

        lda #<>rlProcCycleDMAIntroScenePicture2
        sta aProcSystem.aHeaderOnCycle,b,x

        phb
        php
        sep #$20
        lda aProcSystem.aBody1,b,x
        pha
        rep #$20
        plb

        ldy aProcSystem.aBody0,b,x
        lda $0003,b,y
        sta aProcSystem.aBody2,b,x

        lda #<>aIntroScenesGraphicsDecompressionBuffer
        sta aProcSystem.aBody3,b,x
        lda aProcSystem.aBody2,b,x
        sta wR1
        lda aProcSystem.aBody3,b,x
        sta lR18

        sep #$20
        lda #`aIntroScenesGraphicsDecompressionBuffer
        sta lR18+2
        rep #$20

        lda #(16 * 6 * size(Tile4bpp))
        sta wR0
        jsl rlDMAByPointer

        plp
        plb
        rtl

        .databank 0

      rlProcCycleDMAIntroScenePicture2 ; B9/DB56

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aHeaderSleepTimer,b,x

        lda #<>rlProcCycleDMAIntroScenePicture3
        sta aProcSystem.aHeaderOnCycle,b,x

        lda aProcSystem.aBody2,b,x
        clc
        adc #(16 * 6 * size(Tile4bpp)) >> 1
        sta aProcSystem.aBody2,b,x
        sta wR1

        lda aProcSystem.aBody3,b,x
        clc
        adc #(16 * 6 * size(Tile4bpp))
        sta aProcSystem.aBody3,b,x
        sta lR18

        sep #$20
        lda #`aIntroScenesGraphicsDecompressionBuffer
        sta lR18+2
        rep #$20

        lda #(16 * 6 * size(Tile4bpp))
        sta wR0
        jsl rlDMAByPointer
        rtl

        .databank 0

      rlProcCycleDMAIntroScenePicture3 ; B9/DB89

        .al
        .autsiz
        .databank ?

        lda #1
        sta aProcSystem.aHeaderSleepTimer,b,x

        lda aProcSystem.aBody2,b,x
        clc
        adc #(16 * 6 * size(Tile4bpp)) >> 1
        sta wR1

        lda aProcSystem.aBody3,b,x
        clc
        adc #(16 * 6 * size(Tile4bpp))
        sta lR18

        sep #$20
        lda #`aIntroScenesGraphicsDecompressionBuffer
        sta lR18+2
        rep #$20

        lda #(16 * 4 * size(Tile4bpp))
        sta wR0
        jsl rlDMAByPointer
        rtl

        .databank 0

      rlDecompressIntroScenePictureTilemap ; B9/DBB3

        .al
        .autsiz
        .databank ?

        ; Returns clc if the data entry doesn't have a tilemap pointer

        phb
        php
        sep #$20
        lda aProcSystem.aBody1,b,x
        pha
        rep #$20
        plb

        ldy aProcSystem.aBody0,b,x
        lda $0005,b,y
        beq +

          sta lR18
          lda $0006,b,y
          sta lR18+1
          lda #(`aIntroScenesGraphicsDecompressionBuffer)<<8
          sta lR19+1
          lda #<>aIntroScenesGraphicsDecompressionBuffer
          sta lR19
          jsl rlAppendDecompList

          plp
          plb
          sec
          rtl

        +
        plp
        plb
        clc
        rtl

        .databank 0

      rlDMAIntroScenePictureTilemap ; B9/DBE3

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

        lda #<>aBG1TilemapBuffer
        sta wR0
        lda #$00FF
        jsl rlFillTilemapByWord

        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody0,b,x
        pha

        clc
        adc #10
        sta lR18

        lda aProcSystem.aBody1,b,x
        sep #$20
        sta lR18+2
        rep #$20

        ; Copy tilemap rectangle
        jsl $8E8CE9

        ply
        lda $0008,b,y
        sta wR1
        lda $000D,b,y
        sta lR18
        lda $000E,b,y
        sta lR18+1
        lda #(32 * 28 * size(word))
        sta wR0
        jsl rlDMAByPointer

        plp
        plb
        rtl

        .databank 0

      rlIntroSceneHidePictureBackground ; B9/DC30

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda $0002,b,y
        pha
        rep #$20
        plb

        lda $0000,b,y
        tay

        lda $0010,b,y
        and #$00FF
        sta wR0
        lda $0011,b,y
        and #$00FF
        sta wR1
        lda $0012,b,y
        and #$00FF
        sta wR2
        lda $0013,b,y
        and #$00FF
        sta wR3

        ; This essentially turns the BG2 part, where the picture would be layered on top of it, 
        ; black by increasing the areas used palette by 2.

        lda #(`aBG2TilemapBuffer)<<8
        sta lR18+1
        lda #<>aBG2TilemapBuffer
        sta lR18
        lda #((2 << 10) & TM_Palette)
        sta lR19
        jsl rlModifyPackedTilemapSlice

        jsl rlDMAByStruct
          .structDMAToVRAM aBG2TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), BG2TilemapPosition

        lda #(`aBGPaletteBuffer.aPalette4)<<8
        sta lR18+1
        lda #<>aBGPaletteBuffer.aPalette4
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette6)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette6
        sta lR19
        lda #size(Palette) * 2
        sta lR20
        jsl rlBlockCopy

        plp
        plb
        rtl

        .databank 0

      rlIntroScene2RestoreBackground ; B9/DC9F

        .al
        .autsiz
        .databank ?

        lda #(`aIntroScenesBG2DecompressionBuffer)<<8
        sta lR18+1
        lda #<>aIntroScenesBG2DecompressionBuffer
        sta lR18
        lda #(`aBG2TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG2TilemapBuffer
        sta lR19
        lda #(32 * 28 * size(word))
        sta lR20
        jsl rlBlockCopy

        jsl rlDMAByStruct
          .structDMAToVRAM aBG2TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), BG2TilemapPosition

        rtl

        .databank 0

      rlDisplayIntroScenePictureAsSprite ; B9/DCCA

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

        lda aProcSystem.aBody0,b,x
        tay

        lda $0010,b,y
        and #$00FF
        asl a
        asl a
        asl a
        tax

        lda $0011,b,y
        and #$00FF
        asl a
        asl a
        asl a
        tay

        lda #(`asIntroScenePicture)<<8
        sta lR44+1
        lda #<>asIntroScenePicture
        sta lR44
        jsl $81822E

        plp
        plb
        rtl

        .databank 0

      aIntroScenesTextPaletteWhite ; B9/DCFE

        .word $35AD
        .word $5294
        .word $7FFF

      aIntroScenesTextPaletteGray ; B9/DD04

        .word $1084
        .word $2D6B
        .word $5EF7

      rlIntroScenesSetTextPalette ; B9/DD0A

        .al
        .autsiz
        .databank `aIntroScenesTextPaletteWhite

        lda aIntroScenesTextPaletteWhite
        sta aBGPaletteBuffer.aPalette0 + size(Color),b
        lda aIntroScenesTextPaletteWhite + size(Color)
        sta aBGPaletteBuffer.aPalette0 + (size(Color) * 2),b
        lda aIntroScenesTextPaletteWhite + (size(Color) * 2)
        sta aBGPaletteBuffer.aPalette0 + (size(Color) * 3),b

        stz aBGPaletteBuffer.aPalette0 + (size(Color) * 5),b
        stz aBGPaletteBuffer.aPalette0 + (size(Color) * 6),b
        stz aBGPaletteBuffer.aPalette0 + (size(Color) * 7),b
        rtl

        .databank 0

      procIntroScenesJPTextUnused .structProcInfo "xx", rlProcIntroScenesJPTextUnusedInit, None, aProcIntroScenesJPTextUnusedCode ; B9/DD26

        ; This is likely an early version of the intro scene text display,
        ; where it would have only been japanese text, scrolling upwards where the current
        ; english text is.

      rlProcIntroScenesJPTextUnusedInit ; B9/DD2E

        .al
        .autsiz
        .databank ?

        lda #0
        sta wIntroSceneTextID

        jsl rlIntroScenesSetTextPalette
        jsl rlIntroScenesClearTextPalette
        rtl

        .databank 0

      aProcIntroScenesJPTextUnusedCode ; B9/DD3E

        PROC_CALL rlUnknownB9EB79
        PROC_YIELD 1

        PROC_JUMP_IF_ROUTINE_TRUE _SceneDone, rlIntroSceneDisplayJPTextPart1

        PROC_CALL rlIntroSceneDisplayJPTextPart2

          PROC_CALL_ARGS rlProcPaletteChange, size(+)
          + .block
            .structPaletteChangeData aBGPaletteBuffer.aPalette0 + size(Color), aIntroScenesTextPaletteWhite, aBGPaletteBuffer.aPalette0 + (size(Color) * 4), 0, 128, false
          .bend

          PROC_CALL_ARGS rlProcPaletteChange, size(+)
          + .block
            .structPaletteChangeData aBGPaletteBuffer.aPalette0 + (size(Color) * 5), aIntroScenesTextPaletteGray, aBGPaletteBuffer.aPalette0 + (size(Color) * 8), 0, 128, false
          .bend

          PROC_HALT_WHILE procPaletteChange

          PROC_CALL rlIntroSceneDisplayJPTextPart3
          PROC_CALL rlIntroSceneDisplayJPTextPart4
          PROC_CALL rlIncreaseIntroSceneTextID
          PROC_CALL rlIntroScenesClearTextPalette

          PROC_YIELD 80

          PROC_JUMP aProcIntroScenesJPTextUnusedCode

        _SceneDone
        PROC_CALL rlIncreaseIntroSceneID
        PROC_CALL rlUnknownB9EB81
        PROC_END

      rlIntroSceneDisplayJPTextPart1 ; B9/DD9C

        .al
        .autsiz
        .databank ?

        ; Unused.

        lda #((0 << 10) & TM_Palette)
        sta lR21
        lda #<>aIntroScenesJPTextDataTable
        sta wR0

        lda wIntroSceneID
        sta wR1
        lda wIntroSceneTextID
        sta wR2

        stz wR3
        jsl rlIntroSceneDisplayJPText
        rtl

        .databank 0

      rlIntroSceneDisplayJPTextPart3 ; B9/DDB9

        .al
        .autsiz
        .databank ?

        ; Unused.

        lda #((1 << 10) & TM_Palette)
        sta lR21
        lda #<>aIntroScenesJPTextDataTable
        sta wR0

        lda wIntroSceneID
        sta wR1
        lda wIntroSceneTextID
        sta wR2

        stz wR3
        jsl rlIntroSceneDisplayJPText
        rtl

        .databank 0

      rlIntroSceneDisplayJPTextPart2 ; B9/DDD6

        .al
        .autsiz
        .databank ?

        ; Unused.

        lda #((3 << 10) & TM_Palette)
        sta lR21
        lda #<>aIntroScenesJPTextDataTable
        sta wR0

        lda wIntroSceneID
        sta wR1
        lda wIntroSceneTextID
        inc a
        sta wR2

        lda #(32 * 4 * size(word))
        sta wR3
        jsl rlIntroSceneDisplayJPText
        rtl

        .databank 0

      rlIntroSceneDisplayJPTextPart4 ; B9/DDF7

        .al
        .autsiz
        .databank ?

        ; Unused.

        lda #((4 << 10) & TM_Palette)
        sta lR21
        lda #<>aIntroScenesJPTextDataTable
        sta wR0

        lda wIntroSceneID
        sta wR1
        lda wIntroSceneTextID
        inc a
        sta wR2

        lda #(32 * 4 * size(word))
        sta wR3
        jsl rlIntroSceneDisplayJPText
        rtl

        .databank 0

      rlIntroSceneDisplayJPText ; B9/DE18

        .al
        .autsiz
        .databank ?

        ; Unused.

        ; wR0 = table pointer
        ; wR1 = scene ID
        ; wR2 = scene text ID
        ; wR3 = destination offset

        ; Returns sec if the destination offset is $FF

        phb
        php
        phk
        plb

        lda #(`aIntroScenesBG3DecompressionBuffer)<<8
        sta lR18+1
        lda #(`aBG3TilemapBuffer)<<8
        sta lR19+1

        lda wR1
        asl a
        tay

        lda (wR0),y
        tax

        ; Destination + wR2 * C2I((0, 2)) + wR3

        lda wR2
        xba
        lsr a
        lsr a
        clc
        adc $0000,b,x
        clc
        adc wR3
        sta lR19

        txa
        clc
        adc wR2
        tax

        lda $0002,b,x
        and #$00FF
        cmp #$00FF
        beq +

          ; Given value * (32 * 2 * size(word))

          xba
          lsr a
          clc
          adc #<>aIntroScenesBG3DecompressionBuffer
          sta lR18
          lda #(32 * 2 * size(word))
          sta lR20
          jsl rlCopyAndModifyTilemapSlice

          jsl rlDMAByStruct
            .structDMAToVRAM aBG3TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), JPTextTilemapPosition

          plp
          plb
          clc
          rtl

        +
        plp
        plb
        sec
        rtl

        .databank 0

      rlIntroScenesClearTextPalette ; B9/DE71

        .al
        .autsiz
        .databank ?

        stz aBGPaletteBuffer.aPalette0 + size(Color),b
        stz aBGPaletteBuffer.aPalette0 + (size(Color) *2),b
        stz aBGPaletteBuffer.aPalette0 + (size(Color) *3),b

        stz aBGPaletteBuffer.aPalette0 + (size(Color) *5),b
        stz aBGPaletteBuffer.aPalette0 + (size(Color) *6),b
        stz aBGPaletteBuffer.aPalette0 + (size(Color) *7),b
        rtl

        .databank 0

      rlIncreaseIntroSceneTextID ; B9/DE84

        .al
        .autsiz
        .databank ?

        ; Unused.

        lda wIntroSceneTextID
        inc a
        sta wIntroSceneTextID

        lda wIntroSceneTextID
        inc a
        sta wIntroSceneTextID
        rtl

        .databank 0

      rlIncreaseIntroSceneID ; B9/DE97

        .al
        .autsiz
        .databank ?

        ; Unused.

        lda wIntroSceneID
        inc a
        sta wIntroSceneID
        rtl

        .databank 0

      aIntroScenesJPTextDataTable ; B9/DEA1

        ; Unused.

        .word <>aIntroScenesJPTextData1
        .word <>aIntroScenesJPTextData2
        .word <>aIntroScenesJPTextData3
        .word <>aIntroScenesJPTextData4
        .word <>aIntroScenesJPTextData5
        .word <>aIntroScenesJPTextData6

      aIntroScenesJPTextData1 ; B9/DEAD

        .word <>aBG3TilemapBuffer + (32 * 18 * size(word))

        .byte 11
        .byte 0
        .byte 12
        .byte 1

        .word $FFFF

      aIntroScenesJPTextData2 ; B9/DEB5 

        .word <>aBG3TilemapBuffer + (32 * 18 * size(word))

        .byte 11
        .byte 2
        .byte 12
        .byte 3

        .word $FFFF
      
      aIntroScenesJPTextData3 ; B9/DEBD 

        .word <>aBG3TilemapBuffer + (32 * 18 * size(word))

        .byte 11
        .byte 4
        .byte 12
        .byte 5

        .word $FFFF

      aIntroScenesJPTextData4 ; B9/DEC5 

        .word <>aBG3TilemapBuffer + (32 * 18 * size(word))

        .byte 11
        .byte 6

        .word $FFFF
      
      aIntroScenesJPTextData5 ; B9/DECB 

        .word <>aBG3TilemapBuffer + (32 * 18 * size(word))

        .byte 11
        .byte 7
        .byte 12
        .byte 8

        .word $FFFF
      
      aIntroScenesJPTextData6 ; B9/DED3 

        .word <>aBG3TilemapBuffer + (32 * 18 * size(word))

        .byte 11
        .byte 9
        .byte 12
        .byte 10

        .word $FFFF

      rlIntroScenesTextSetup ; B9/DEDB

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
        lda #T_Setting(false, true, false, false, false)
        sta bBufferTM

        lda #T_Setting(true, false, true, false, false)
        sta bBufferTS

        lda #CGWSEL_Setting(false, true, CGWSEL_MathAlways, CGWSEL_BlackNever)
        sta bBufferCGWSEL

        lda #CGADSUB_Setting(CGADSUB_Add, false, false, true, false, false, false, true)
        sta bBufferCGADSUB
        rep #$20

        jsr rsClearIntroScenesVRAMTilemaps

        ; The graphics and tilemaps here are JP only and irrelevant,
        ; as they are overwritten by the JP/EN text graphics and tilemaps later.

        lda #(`g2bppcIntroNarrationJPUnused)<<8
        sta lR18+1
        lda #<>g2bppcIntroNarrationJPUnused
        sta lR18
        lda #(`aIntroScenesBG3DecompressionBuffer)<<8
        sta lR19+1
        lda #<>aIntroScenesBG3DecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aIntroScenesBG3DecompressionBuffer, (445 * 2 * size(Tile2bpp)), VMAIN_Setting(true), TextGraphicPosition

        lda #(`acIntroNarrationJPTilemapUnused)<<8
        sta lR18+1
        lda #<>acIntroNarrationJPTilemapUnused
        sta lR18
        lda #(`aIntroScenesBG3DecompressionBuffer)<<8
        sta lR19+1
        lda #<>aIntroScenesBG3DecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        lda #0
        sta wIntroSceneID

        ; Clears BG_PAL0 and OAM_PAL0-6

        jsl $809C9B

        jsl rlCreateIntroScenesENFadingHDMAs

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

      rlIntroScene1LoadText ; B9/DF69

        .al
        .autsiz
        .databank ?

        lda #(`acIntroNarration1ENTilemap)<<8
        sta lR18+1
        lda #<>acIntroNarration1ENTilemap
        sta lR18
        lda #(`aBG3TilemapBuffer.Page1)<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer.Page1
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer.Page1, (32 * 32 * size(word)), VMAIN_Setting(true), ENTextTilemapPosition

        lda #(`acIntroNarration1JPTilemap)<<8
        sta lR18+1
        lda #<>acIntroNarration1JPTilemap
        sta lR18
        lda #(`aIntroScenesBG3DecompressionBuffer)<<8
        sta lR19+1
        lda #<>aIntroScenesBG3DecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        lda #(`g2bppcIntroNarration1)<<8
        sta lR18+1
        lda #<>g2bppcIntroNarration1
        sta lR18
        lda #(`aIntroScenesGraphicsDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aIntroScenesGraphicsDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aIntroScenesGraphicsDecompressionBuffer, (40 * 16 * size(Tile2bpp)), VMAIN_Setting(true), TextGraphicPosition

        jsl rlCreateIntroScenesENTextScrollHDMA
        jsl rlCreateIntroScene1JPText
        rtl

        .databank 0

      rlIntroScene2LoadText ; B9/DFD4

        .al
        .autsiz
        .databank ?

        lda #(`acIntroNarration2ENTilemap)<<8
        sta lR18+1
        lda #<>acIntroNarration2ENTilemap
        sta lR18
        lda #(`aBG3TilemapBuffer.Page1)<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer.Page1
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer.Page1, (32 * 32 * size(word)), VMAIN_Setting(true), ENTextTilemapPosition

        jsl rlIntroScenesENTextScrollHDMAInit
        jsl rlCreateIntroScene2JPText
        rtl

        .databank 0

      rlIntroScene3LoadText ; B9/E002

        .al
        .autsiz
        .databank ?

        lda #(`acIntroNarration3ENTilemap)<<8
        sta lR18+1
        lda #<>acIntroNarration3ENTilemap
        sta lR18
        lda #(`aBG3TilemapBuffer.Page1)<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer.Page1
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer.Page1, (32 * 32 * size(word)), VMAIN_Setting(true), ENTextTilemapPosition

        lda #(`acIntroNarration2JPTilemap)<<8
        sta lR18+1
        lda #<>acIntroNarration2JPTilemap
        sta lR18
        lda #(`aIntroScenesBG3DecompressionBuffer)<<8
        sta lR19+1
        lda #<>aIntroScenesBG3DecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        lda #(`g2bppcIntroNarration2)<<8
        sta lR18+1
        lda #<>g2bppcIntroNarration2
        sta lR18
        lda #(`aIntroScenesGraphicsDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aIntroScenesGraphicsDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aIntroScenesGraphicsDecompressionBuffer, (40 * 16 * size(Tile2bpp)), VMAIN_Setting(true), TextGraphicPosition

        jsl rlIntroScenesENTextScrollHDMAInit

        lda #-200
        sta wIntroSceneENTextFrameCounter

        lda #12
        sta wIntroSceneENTextScrollDelay

        jsl rlCreateIntroScene3JPText
        rtl

        .databank 0

      rlCreateIntroScene1JPText ; B9/E07B

        .al
        .autsiz
        .databank ?

        lda #<>aIntroScene1JPTextData
        sta aProcSystem.wInput0,b

        lda #(`procIntroScenesJPText)<<8
        sta lR44+1
        lda #<>procIntroScenesJPText
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      rlCreateIntroScene2JPText ; B9/E090

        .al
        .autsiz
        .databank ?

        lda #<>aIntroScene2JPTextData
        sta aProcSystem.wInput0,b

        lda #(`procIntroScenesJPText)<<8
        sta lR44+1
        lda #<>procIntroScenesJPText
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      rlCreateIntroScene3JPText ; B9/E0A5

        .al
        .autsiz
        .databank ?

        lda #<>aIntroScene3JPTextData
        sta aProcSystem.wInput0,b

        lda #(`procIntroScenesJPText)<<8
        sta lR44+1
        lda #<>procIntroScenesJPText
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      procIntroScenesJPText .structProcInfo "xx", rlProcIntroScenesJPTextInit, None, aProcIntroScenesJPTextCode ; B9/E0BA

      rlProcIntroScenesJPTextInit ; B9/E0C2

        .al
        .autsiz
        .databank ?

        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x
        rtl

        .databank 0

      aProcIntroScenesJPTextCode ; B9/E0C9

        PROC_SET_ONCYCLE rlIntroScenesLoadJPTextDelay
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_CALL rlIntroSceneLoadJPTextTilemap

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
          .structPaletteChangeData aBGPaletteBuffer.aPalette0 + (size(Color) * 5), aIntroScenesTextPaletteGray, aBGPaletteBuffer.aPalette0 + (size(Color) * 8), 0, 64, false
        .bend

        PROC_HALT_WHILE procPaletteChange

        PROC_SET_ONCYCLE rlIntroScenesLoadJPTextDelay
        PROC_YIELD 1
        PROC_SET_ONCYCLE None

        PROC_CALL_ARGS rlProcPaletteChange, size(+)
        + .block
          .structPaletteChangeData aBGPaletteBuffer.aPalette0 + (size(Color) * 5), aBlackPalette, aBGPaletteBuffer.aPalette0 + (size(Color) * 8), 0, 64, false
        .bend

        PROC_HALT_WHILE procPaletteChange

        PROC_JUMP aProcIntroScenesJPTextCode

      rlIntroScenesLoadJPTextDelay ; B9/E110

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aHeaderSleepTimer,b,x

        phb
        php
        phk
        plb

        lda aProcSystem.aBody0,b,x
        tay
        lda $0000,b,y
        beq +

          sta aProcSystem.aBody1,b,x

          lda #<>rlIntroScenesWaitJPTextDelay
          sta aProcSystem.aHeaderOnCycle,b,x
          plp
          plb
          rtl

        +
        stz aProcSystem.aHeaderSleepTimer,b,x
        jsl rlProcEngineFreeProc
        plp
        plb
        rtl

        .databank 0

      rlIntroScenesWaitJPTextDelay ; B9/E136

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aHeaderSleepTimer,b,x

        dec aProcSystem.aBody1,b,x
        bne +

          lda #1
          sta aProcSystem.aHeaderSleepTimer,b,x

          inc aProcSystem.aBody0,b,x
          inc aProcSystem.aBody0,b,x

        +
        rtl

        .databank 0

      rlIntroSceneLoadJPTextTilemap ; B9/E14B

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        lda #(`aIntroScenesBG3DecompressionBuffer)<<8
        sta lR18+1
        lda #(`aBG3TilemapBuffer)<<8
        sta lR19+1

        lda aProcSystem.aBody0,b,x
        tay
        lda $0000,b,y
        sta lR18
        lda #<>aBG3TilemapBuffer + (JPTextPosition[0] * JPTextPosition[1] * size(word))
        sta lR19
        lda #(32 * 2 * size(word))
        sta lR20
        jsl rlBlockCopy

        ldx aProcSystem.wOffset,b
        inc aProcSystem.aBody0,b,x
        inc aProcSystem.aBody0,b,x

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), JPTextTilemapPosition

        plp
        plb
        rtl

        .databank 0

      aIntroScene1JPTextData ; B9/E189

        .word 300
        .word <>aIntroScenesBG3DecompressionBuffer
        .word 240

        .word 30
        .word <>aIntroScenesBG3DecompressionBuffer + (32 * 2 * size(word))
        .word 240

        .word 0

      aIntroScene2JPTextData ; B9/E197

        .word 200
        .word <>aIntroScenesBG3DecompressionBuffer + (2 *(32 * 2 * size(word)))
        .word 180

        .word 30
        .word <>aIntroScenesBG3DecompressionBuffer + (3 *(32 * 2 * size(word)))
        .word 180

        .word 30
        .word <>aIntroScenesBG3DecompressionBuffer + (4 *(32 * 2 * size(word)))
        .word 300

        .word 30
        .word <>aIntroScenesBG3DecompressionBuffer + (5 *(32 * 2 * size(word)))
        .word 270
        
        .word 0

      aIntroScene3JPTextData ; B9/E1B1

        .word 460
        .word <>aIntroScenesBG3DecompressionBuffer
        .word 240

        .word 90
        .word <>aIntroScenesBG3DecompressionBuffer + (32 * 2 * size(word))
        .word 200

        .word 30
        .word <>aIntroScenesBG3DecompressionBuffer + (2 *(32 * 2 * size(word)))
        .word 190

        .word 30
        .word <>aIntroScenesBG3DecompressionBuffer + (3 *(32 * 2 * size(word)))
        .word 240

        .word 30
        .word <>aIntroScenesBG3DecompressionBuffer + (4 *(32 * 2 * size(word)))
        .word 240

        .word 0

      rlIntroScene2LoadBorders ; B9/E1D1

        .al
        .autsiz
        .databank ?

        lda #(`g2bppcIntroScene2PictureBorders)<<8
        sta lR18+1
        lda #<>g2bppcIntroScene2PictureBorders
        sta lR18
        lda #(`aIntroScenesGraphicsDecompreesionBuffer2)<<8
        sta lR19+1
        lda #<>aIntroScenesGraphicsDecompreesionBuffer2
        sta lR19
        jsl rlAppendDecompList

        lda #(`acIntroScene2PictureBorderTilemap)<<8
        sta lR18+1
        lda #<>acIntroScene2PictureBorderTilemap
        sta lR18
        lda #(`aBG3TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aIntroScenesGraphicsDecompreesionBuffer2, (4 * 2 * size(Tile2bpp)), VMAIN_Setting(true), BorderGraphicPosition

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer, (32 * 32 * size(word)), VMAIN_Setting(true), JPTextTilemapPosition

        lda #(`aBlackPalette)<<8
        sta lR18+1
        lda #<>aBlackPalette
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette0 + (size(Color) * 8))<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette0 + (size(Color) * 8)
        sta lR19
        lda #size(Color) * 4
        sta lR20
        jsl rlBlockCopy
        rtl

        .databank 0

      rlIntroScenesSkipped ; B9/E239

        .al
        .autsiz
        .databank ?

        macroFindAndFreeProc procIntroScenesSkipCheck

        ; Create procTitle

        jsl $80C0BD
        rtl

        .databank 0

      rlIntroScenesFinished ; B9/E25B

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #T_Setting(false, false, false, false, false)
        sta bBufferTM
        rep #$20

        lda #(`aWhitePalette)<<8
        sta lR18+1
        lda #<>aWhitePalette
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette0)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette0
        sta lR19
        lda #size(Palette) * 16
        sta lR20
        jsl rlBlockCopy

        stz aBGPaletteBuffer.aPalette0,b

        ; Clear all sprites
        jsl $818219

        macroFindAndFreeProc procIntroScenesSkipCheck

        jsl $94C19F
        jsl $80C10B
        rtl

        .databank 0

      procIntroScenesSkipCheck .structProcInfo "xx", None, rlProcIntroScenesSkipCheckCycle, None ; B9/E2AD

      rlProcIntroScenesSkipCheckCycle ; B9/E2B5

        .al
        .autsiz
        .databank ?

        lda aSoundSystem.aUnknown0004BA,b
        bne _End

          lda wJoy1New
          bit #JOY_Start
          beq _End

            macroFindAndFreeProc procIntroScenes

            ; Create procTitle

            jsl $80C0BD

        _End
        rtl

        .databank 0

      .endwith ; IntroScenesConfig

    .endsection IntroScenesSection

    .section NintendoLogoSection

      procNintendoLogo .structProcInfo "xx", None, None, aProcNintendoLogoCode ; B9/E2E3

      aProcNintendoLogoCode ; B9/E2EB

        PROC_YIELD 1
        PROC_JUMP_IF_ROUTINE_TRUE _Skip, rlNintendoLogoSkipCheck
        
          PROC_CALL_ARGS rlSetFadeTimer, size(+)
          + .block
            .byte 1
          .bend

          -
          PROC_YIELD 1
          PROC_JUMP_IF_ROUTINE_FALSE -, rlWaitForFadeOut

          PROC_CALL rlLoadNintendoLogo

          PROC_CALL_ARGS rlSetFadeTimer, size(+)
          + .block
            .byte 1
          .bend

          -
          PROC_YIELD 1
          PROC_JUMP_IF_ROUTINE_FALSE -, rlWaitForFadeIn

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

      rlLoadNintendoLogo ; B9/E331

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

        jsr rsClearIntroScenesVRAMTilemaps

        ; Clears BG_PAL0 and OAM_PAL0-6

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
          .structDMAToVRAM aDecompressionBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), $7000

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

    .endsection NintendoLogoSection

    .section IntroScenes2Section

      .with IntroScenesConfig

      rlPrepareIntroScene1 ; B9/E3DF

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

        jsr rsClearIntroScenesVRAMTilemaps

        lda #(`g4bppcIntroScene1Background)<<8
        sta lR18+1
        lda #<>g4bppcIntroScene1Background
        sta lR18
        lda #(`aIntroScenesGraphicsDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aIntroScenesGraphicsDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aIntroScenesGraphicsDecompressionBuffer, (16 * 16 * size(Tile4bpp)), VMAIN_Setting(true), SceneBGGraphicPosition

        lda #(`acIntroScene1BackgroundTilemap)<<8
        sta lR18+1
        lda #<>acIntroScene1BackgroundTilemap
        sta lR18
        lda #(`aBG2TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG2TilemapBuffer
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aBG2TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), BG2TilemapPosition

        lda #(`aIntroScene1BackgroundPalette)<<8
        sta lR18+1
        lda #<>aIntroScene1BackgroundPalette
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette2)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette2
        sta lR19
        lda #size(Palette)
        sta lR20
        jsl rlBlockCopy

        jsl rlIntroScene1LoadText
        jsl rlIntroScenesSetTextPalette

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

      rlPrepareIntroScene2 ; B9/E47C

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

        jsr rsClearIntroScenesVRAMTilemaps

        lda #(`g4bppcIntroScene2Background)<<8
        sta lR18+1
        lda #<>g4bppcIntroScene2Background
        sta lR18
        lda #(`aIntroScenesGraphicsDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aIntroScenesGraphicsDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aIntroScenesGraphicsDecompressionBuffer, (56 * 16 * size(Tile4bpp)), VMAIN_Setting(true), SceneBGGraphicPosition

        lda #(`acIntroScene2BackgroundTilemap)<<8
        sta lR18+1
        lda #<>acIntroScene2BackgroundTilemap
        sta lR18
        lda #(`aIntroScenesBG2DecompressionBuffer)<<8
        sta lR19+1
        lda #<>aIntroScenesBG2DecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        lda #(`aIntroScenesBG2DecompressionBuffer)<<8
        sta lR18+1
        lda #<>aIntroScenesBG2DecompressionBuffer
        sta lR18
        lda #(`aBG2TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG2TilemapBuffer
        sta lR19
        lda #(32 * 28 * size(word))
        sta lR20
        jsl rlBlockCopy

        jsl rlDMAByStruct
          .structDMAToVRAM aBG2TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), BG2TilemapPosition

        lda #(`aIntroScene2BackgroundPalette)<<8
        sta lR18+1
        lda #<>aIntroScene2BackgroundPalette
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette4)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette4
        sta lR19
        lda #size(Palette)
        sta lR20
        jsl rlBlockCopy

        jsl rlIntroScene2LoadBorders
        jsl rlIntroScene2LoadText

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

      rlPrepareIntroScene3 ; B9/E536

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
        lda #T_Setting(true, true, false, false, false)
        sta bBufferTM

        lda #T_Setting(false, false, true, false, false)
        sta bBufferTS

        lda #CGWSEL_Setting(false, true, CGWSEL_MathAlways, CGWSEL_BlackNever)
        sta bBufferCGWSEL

        lda #CGADSUB_Setting(CGADSUB_Add, false, false, true, false, false, false, true)
        sta bBufferCGADSUB
        rep #$20

        lda #-16
        sta wBufferBG1HOFS
        lda #-16
        sta wBufferBG3HOFS
        lda #32
        sta wBufferBG2VOFS

        lda #<>aBG2TilemapBuffer.Page1
        sta wR0
        lda #$037F
        jsl rlFillTilemapByWord

        lda #(`g4bppcIntroScene3Background)<<8
        sta lR18+1
        lda #<>g4bppcIntroScene3Background
        sta lR18
        lda #(`aIntroScenesGraphicsDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aIntroScenesGraphicsDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        jsl rlDMAByStruct
          .structDMAToVRAM aIntroScenesGraphicsDecompressionBuffer, (56 * 16 * size(Tile4bpp)), VMAIN_Setting(true), SceneBGGraphicPosition

        lda #(`acIntroScene3BackgroundTilemap)<<8
        sta lR18+1
        lda #<>acIntroScene3BackgroundTilemap
        sta lR18
        lda #(`aIntroScenesBG2DecompressionBuffer)<<8
        sta lR19+1
        lda #<>aIntroScenesBG2DecompressionBuffer
        sta lR19
        jsl rlAppendDecompList

        lda #(`aIntroScenesBG2DecompressionBuffer)<<8
        sta lR18+1
        lda #<>aIntroScenesBG2DecompressionBuffer
        sta lR18
        lda #(`aBG2TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG2TilemapBuffer
        sta lR19
        lda #(32 * 32 * size(word))
        sta lR20
        jsl rlBlockCopy

        jsl rlDMAByStruct
          .structDMAToVRAM aBG2TilemapBuffer, (32 * 32 * size(word)), VMAIN_Setting(true), BG2TilemapPosition

        lda #(`aBlackPalette)<<8
        sta lR18+1
        lda #<>aBlackPalette
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette4)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette4
        sta lR19
        lda #size(Palette) * 2
        sta lR20
        jsl rlBlockCopy

        lda #(`aBlackPalette)<<8
        sta lR18+1
        lda #<>aBlackPalette
        sta lR18
        lda #(`aBGPaletteBuffer.aPalette0 + (size(Color) * 8))<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer.aPalette0 + (size(Color) * 8)
        sta lR19
        lda #size(Color) * 4
        sta lR20
        jsl rlBlockCopy
        
        jsl rlIntroScene3LoadText

        lda #(`aIntroScene3FlameEffectHDMA)<<8
        sta lR44+1
        lda #<>aIntroScene3FlameEffectHDMA
        sta lR44
        jsl rlHDMAEngineCreateEntry

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

      rlIntroScenesUpdateHardwareRegisters ; B9/E643

        .al
        .autsiz
        .databank ?

        ; Swaps BG1 from the sub to the main screen

        sep #$20
        lda #T_Setting(true, true, false, false, false)
        sta bBufferTM
        lda #T_Setting(false, false, true, false, false)
        sta bBufferTS
        lda #CGWSEL_Setting(false, true, CGWSEL_MathAlways, CGWSEL_BlackNever)
        sta bBufferCGWSEL
        lda #CGADSUB_Setting(CGADSUB_Add, false, false, true, false, false, false, true)
        sta bBufferCGADSUB
        rep #$20
        rtl

        .databank 0

      rlIntroScene3ScrollInBackground ; B9/E658

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aBody0,b,x

        lda #<>(+)
        sta aProcSystem.aHeaderOnCycle,b,x

        +
        stz aProcSystem.aHeaderSleepTimer,b,x

        inc aProcSystem.aBody0,b,x
        lda aProcSystem.aBody0,b,x
        bit #$0003
        bne +

          dec wBufferBG2VOFS
          bne +

            lda #1
            sta aProcSystem.aHeaderSleepTimer,b,x

        +
        rtl

        .databank 0

      rlIntroScene3ScrollInPicture ; B9/E67A

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aBody0,b,x

        lda #<>(+)
        sta aProcSystem.aHeaderOnCycle,b,x

        +
        stz aProcSystem.aHeaderSleepTimer,b,x

        inc aProcSystem.aBody0,b,x
        lda aProcSystem.aBody0,b,x
        bit #$0003
        bne +

          inc wBufferBG1HOFS
          inc wBufferBG3HOFS
          bne +

            lda #1
            sta aProcSystem.aHeaderSleepTimer,b,x

        +
        rtl

        .databank 0

      rsClearIntroScenesVRAMTilemaps ; B9/E69E

        .al
        .autsiz
        .databank ?

        lda #<>aBG1TilemapBuffer
        sta wR0
        lda #$00FF
        jsl rlFillTilemapByWord

        lda #<>aBG2TilemapBuffer
        sta wR0
        lda #$02FF
        jsl rlFillTilemapByWord

        lda #<>aBG3TilemapBuffer
        sta wR0
        lda #$02FF
        jsl rlFillTilemapByWord

        jsl rlDMAByStruct
          .structDMAToVRAM aBG1TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), PictureTilemapPosition

        jsl rlDMAByStruct
          .structDMAToVRAM aBG2TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), BG2TilemapPosition

        jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), JPTextTilemapPosition

        rts

        .databank 0

      rlIntroScenesClearSpecifiedPalette ; B9/E6EA

        .al
        .autsiz
        .databank ?

        ; Arguments:
        ; word: Palette offset - aBGPaletteBuffer

        sep #$20
        lda #`aBGPaletteBuffer
        sta lR19+2
        rep #$20

        lda $0000,b,y
        clc
        adc #<>aBGPaletteBuffer
        sta lR19
        lda #(`aIntroSceneBlackPalette)<<8
        sta lR18+1
        lda #<>aIntroSceneBlackPalette
        sta lR18
        lda #size(Palette)
        sta lR20
        jsl rlBlockCopy
        rtl

        .databank 0

      aIntroSceneBlackPalette ; B9/E70F

        .rept 16
          .word 0
        .endrept

      rlCopyAndModifyTilemapSlice ; B9/E72F

        .al
        .autsiz
        .databank ?

        ; lR18 = source
        ; lR19 = destination
        ; lR20 = size
        ; lR21 = tilemap value to add

        phb
        php
        phk
        plb
        phx
        phy

        ldy lR20
        beq ++

        ; Branch if it's an even size
        tya
        bit #$0001
        beq +

          dec y
          sep #$20
          lda [lR18],y
          clc
          adc lR21
          sta [lR19],y
          rep #$20
          bra +
          
            -
            lda [lR18],y
            clc
            adc lR21
            sta [lR19],y
            
            +
            dec y
            dec y
            bne -

          lda [lR18],y
          clc
          adc lR21
          sta [lR19],y

        +
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlModifyPackedTilemapSlice ; B9/E764

        .al
        .autsiz
        .databank ?

        ; wR0 = Y pos
        ; wR1 = X pos
        ; wR2 = width
        ; wR3 = height

        ; lR18 = tilemap buffer
        ; lR19 = tilemap value to add

        php
        rep #$30
        lda wR1
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc wR0
        asl a
        clc
        adc lR18
        sta lR18

        dec wR3
        bmi _End

        lda wR2
        asl a
        dec a
        dec a
        bmi _End

        sta wR2
        
        -
        ldy wR2

        -
        lda [lR18],y
        clc
        adc lR19
        sta [lR18],y
        dec y
        dec y
        bpl -

        lda lR18
        clc
        adc #C2I((0, 2), 32)
        sta lR18
        dec wR3
        bpl --
        
        _End
        plp
        rtl

        .databank 0

      aUnknownHDMAB9E79F .structHDMADirectEntryInfo rlUnknownHDMAB9E79FInit, rlUnknownHDMAB9E79FInit, aUnknownHDMAB9E79FCode, aUnknownHDMAB9E79FTable, BG3VOFS, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode2) ; B9/E79F 

      aUnknownHDMAB9E79FCode ; B9/E7AA

        HDMA_HALT

      rlUnknownHDMAB9E79FInit ; B9/E7AC

        .al
        .autsiz
        .databank ?

        rtl

        nop
        nop
        nop
        nop
        nop

        .databank 0

      aUnknownHDMAB9E79FTable ; B9/E7B2

        .byte NTRL_Setting(120)
        .word 0

        .byte NTRL_Setting(24)
        .word 0

        .byte NTRL_Setting(13)
        .word 0

        .byte NTRL_Setting(13)
        .word 3

        .byte NTRL_Setting(13)
        .word 6

        .byte NTRL_Setting(13)
        .word 9

        .byte NTRL_Setting(13)
        .word 12

        .byte NTRL_Setting(1)
        .sint -185

        .byte 0

      asIntroScenePicture ; B9/E7CB

        .word 0
        .word 0
        .word <>asIntroScenePictureCode

      asIntroScenePictureCode ; B9/E7D1

        -
        AS_Sprite 1, asIntroScenePictureFrame1
        AS_Loop -

      asIntroScenePictureFrame1 ; B9/E7D8

        _Sprites := [[(  64,   64), $21, SpriteLarge, C2I((8, 8)), 3, 7, false, false]]
        _Sprites..= [[(   0,   64), $21, SpriteLarge, C2I((0, 8)), 3, 7, false, false]]
        _Sprites..= [[(  64,    0), $21, SpriteLarge, C2I((8, 0)), 3, 7, false, false]]
        _Sprites..= [[(   0,    0), $21, SpriteLarge, C2I((0, 0)), 3, 7, false, false]]

        .structSpriteArray asIntroScenePictureFrame1._Sprites

      aIntroScene2Picture1Data ; B9/E7EE

        .long g4bppcIntroScene2Picture1
        .word PictureGraphic1Position >> 1
        .long acIntroScenePictureTilemap
        .word PictureTilemapPosition >> 1

        .long aIntroScenesGraphicsDecompressionBuffer
        .long aBG1TilemapBuffer
        .word pack([PictureCoordinates[0], PictureCoordinates[1]])
        .word pack([PictureSize[0], PictureSize[1]])

      aIntroScene2Picture2Data ; B9/E802

        .long g4bppcIntroScene2Picture2
        .word PictureGraphic1Position >> 1
        .long acIntroScenePictureTilemap
        .word PictureTilemapPosition >> 1

        .long aIntroScenesGraphicsDecompressionBuffer
        .long aBG1TilemapBuffer
        .word pack([PictureCoordinates[0], PictureCoordinates[1]])
        .word pack([PictureSize[0], PictureSize[1]])

      aIntroScene3Picture1Data ; B9/E816

        .long g4bppcIntroScene3Picture1
        .word PictureGraphic1Position >> 1
        .long acIntroScenePictureTilemap
        .word PictureTilemapPosition >> 1

        .long aIntroScenesGraphicsDecompressionBuffer
        .long aBG1TilemapBuffer
        .word pack([PictureCoordinates[0], PictureCoordinates[1]])
        .word pack([PictureSize[0], PictureSize[1]])

      aIntroScene3Picture2Data ; B9/E82A

        ; This is displayed as a sprite and I don't like it
        .long g4bppcIntroScene3Picture2
        .word PictureGraphic2Position >> 1
        .long 0
        .word 0

        .long aIntroScenesGraphicsDecompressionBuffer
        .long aBG1TilemapBuffer
        .word pack([PictureCoordinates[0], PictureCoordinates[1]])
        .word pack([PictureSize[0], PictureSize[1]])

      aIntroScene3Picture3Data ; B9/E83E

        .long g4bppcIntroScene3Picture3
        .word PictureGraphic1Position >> 1
        .long acIntroScenePictureTilemap
        .word PictureTilemapPosition >> 1

        .long aIntroScenesGraphicsDecompressionBuffer
        .long aBG1TilemapBuffer
        .word pack([PictureCoordinates[0], PictureCoordinates[1]])
        .word pack([PictureSize[0], PictureSize[1]])

      aUnknownHDMAB9E852 .structHDMADirectEntryInfo rlUnknownHDMAB9E852Init, rlUnknownHDMAB9E852Cycle, aUnknownHDMAB9E852Code, aUnknownHDMAB9E852Table, COLDATA, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode0) ; B9/E852

      aUnknownHDMAB9E852Table ; B9/E85D

        .byte NTRL_Setting(3),  COLDATA_Setting(13, true, false, false)
        .byte NTRL_Setting(2),  COLDATA_Setting(12, true, false, false)
        .byte NTRL_Setting(2),  COLDATA_Setting(11, true, false, false)
        .byte NTRL_Setting(2),  COLDATA_Setting(10, true, false, false)
        .byte NTRL_Setting(2),  COLDATA_Setting(8,  true, false, false)
        .byte NTRL_Setting(2),  COLDATA_Setting(7,  true, false, false)
        .byte NTRL_Setting(2),  COLDATA_Setting(6,  true, false, false)
        .byte NTRL_Setting(2),  COLDATA_Setting(5,  true, false, false)
        .byte NTRL_Setting(2),  COLDATA_Setting(4,  true, false, false)
        .byte NTRL_Setting(2),  COLDATA_Setting(3,  true, false, false)
        .byte NTRL_Setting(3),  COLDATA_Setting(2,  true, false, false)
        .byte NTRL_Setting(3),  COLDATA_Setting(1,  true, false, false)
        .byte NTRL_Setting(66), COLDATA_Setting(0,  true, false, false)
        .byte NTRL_Setting(9),  COLDATA_Setting(1,  true, false, false)
        .byte NTRL_Setting(8),  COLDATA_Setting(2,  true, false, false)
        .byte NTRL_Setting(10), COLDATA_Setting(3,  true, false, false)
        .byte NTRL_Setting(12), COLDATA_Setting(4,  true, false, false)
        .byte NTRL_Setting(12), COLDATA_Setting(5,  true, false, false)
        .byte NTRL_Setting(12), COLDATA_Setting(6,  true, false, false)
        .byte NTRL_Setting(13), COLDATA_Setting(7,  true, false, false)
        .byte NTRL_Setting(4),  COLDATA_Setting(8,  true, false, false)
        .byte NTRL_Setting(4),  COLDATA_Setting(9,  true, false, false)
        .byte NTRL_Setting(4),  COLDATA_Setting(10, true, false, false)
        .byte NTRL_Setting(4),  COLDATA_Setting(11, true, false, false)
        .byte NTRL_Setting(4),  COLDATA_Setting(12, true, false, false)
        .byte NTRL_Setting(4),  COLDATA_Setting(13, true, false, false)
        .byte NTRL_Setting(4),  COLDATA_Setting(14, true, false, false)
        .byte NTRL_Setting(4),  COLDATA_Setting(15, true, false, false)
        .byte NTRL_Setting(1),  COLDATA_Setting(16, true, false, false)

        .byte 0

      aUnknownHDMAB9E852Code ; B9/E898

        HDMA_HALT

      rlUnknownHDMAB9E852Init ; B9/E89A

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlUnknownHDMAB9E852Cycle ; B9/E89B

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlUnknownB9E89C ; B9/E89C

        .al
        .autsiz
        .databank ?

        macroFindAndFreeProc procScriptedBGPaletteChange
        macroFindAndFreeProc procScriptedBGPaletteChange
        macroFindAndFreeProc procScriptedBGPaletteChange
        rtl

        .databank 0

      rlUnknownB9E8F4 ; B9/E8F4

        .al
        .autsiz
        .databank ?

        lda #<>aUnknownB9E943
        sta aProcSystem.wInput0,b
        lda #`aUnknownB9E943
        sta aProcSystem.wInput1,b
        lda #(`procScriptedBGPaletteChange)<<8
        sta lR44+1
        lda #<>procScriptedBGPaletteChange
        sta lR44
        jsl rlProcEngineCreateProc

        lda #<>aUnknownB9E9A6
        sta aProcSystem.wInput0,b
        lda #`aUnknownB9E9A6
        sta aProcSystem.wInput1,b
        lda #(`procScriptedBGPaletteChange)<<8
        sta lR44+1
        lda #<>procScriptedBGPaletteChange
        sta lR44
        jsl rlProcEngineCreateProc

        lda #<>aUnknownB9E9F7
        sta aProcSystem.wInput0,b
        lda #`aUnknownB9E9F7
        sta aProcSystem.wInput1,b
        lda #(`procScriptedBGPaletteChange)<<8
        sta lR44+1
        lda #<>procScriptedBGPaletteChange
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      aUnknownB9E943 ; B9/E943

        .byte aBGPaletteBuffer.aPalette4 + (size(Color) * 15) - aBGPaletteBuffer >> 1
        .byte size(Color) >> 1
        .word <>aUnknownB9EA8BColorData

        macroScriptedBGPaletteChangeEntry 17, 0
        macroScriptedBGPaletteChangeEntry 7, 1
        macroScriptedBGPaletteChangeEntry 7, 2
        macroScriptedBGPaletteChangeEntry 7, 3
        macroScriptedBGPaletteChangeEntry 7, 4
        macroScriptedBGPaletteChangeEntry 7, 5
        macroScriptedBGPaletteChangeEntry 7, 6
        macroScriptedBGPaletteChangeEntry 7, 7
        macroScriptedBGPaletteChangeEntry 7, 8
        macroScriptedBGPaletteChangeEntry 7, 9
        macroScriptedBGPaletteChangeEntry 7, 10
        macroScriptedBGPaletteChangeEntry 7, 11
        macroScriptedBGPaletteChangeLoop

      aUnknownB9E9A6 ; B9/E9A6

        .byte aBGPaletteBuffer.aPalette4 + (size(Color) * 14) - aBGPaletteBuffer >> 1
        .byte size(Color) >> 1
        .word <>aUnknownB9EAABColorData

        macroScriptedBGPaletteChangeEntry 21, 0
        macroScriptedBGPaletteChangeEntry 5, 1
        macroScriptedBGPaletteChangeEntry 5, 2
        macroScriptedBGPaletteChangeEntry 5, 3
        macroScriptedBGPaletteChangeEntry 5, 4
        macroScriptedBGPaletteChangeEntry 5, 5
        macroScriptedBGPaletteChangeEntry 5, 6
        macroScriptedBGPaletteChangeEntry 5, 7
        macroScriptedBGPaletteChangeEntry 5, 8
        macroScriptedBGPaletteChangeEntry 5, 9
        macroScriptedBGPaletteChangeEntry 5, 10
        macroScriptedBGPaletteChangeEntry 5, 11
        macroScriptedBGPaletteChangeLoop

      aUnknownB9E9F7 ; B9/E9F7

        .byte aBGPaletteBuffer.aPalette4 + (size(Color) * 6) - aBGPaletteBuffer >> 1
        .byte size(Color) >> 1
        .word <>aUnknownB9EACBColorData

        macroScriptedBGPaletteChangeEntry 40, 0
        macroScriptedBGPaletteChangeEntry 7, 1
        macroScriptedBGPaletteChangeEntry 6, 2
        macroScriptedBGPaletteChangeEntry 5, 3
        macroScriptedBGPaletteChangeEntry 6, 4
        macroScriptedBGPaletteChangeEntry 7, 5
        macroScriptedBGPaletteChangeEntry 40, 6
        macroScriptedBGPaletteChangeEntry 8, 7
        macroScriptedBGPaletteChangeEntry 6, 8
        macroScriptedBGPaletteChangeEntry 5, 9
        macroScriptedBGPaletteChangeEntry 6, 10
        macroScriptedBGPaletteChangeEntry 7, 11
        macroScriptedBGPaletteChangeLoop

      aUnknownB9EA8BColorData ; B9/EA8B

        .word $4ABF
        .word $52DF
        .word $56FF
        .word $5F1F
        .word $675E
        .word $6B7E
        .word $739E
        .word $6B7E
        .word $675E
        .word $5F3E
        .word $56FF
        .word $52DF
        .word 0
        .word 0
        .word 0
        .word 0

      aUnknownB9EAABColorData ; B9/EAAB

        .word $1D5F
        .word $259F
        .word $29BF
        .word $31FF
        .word $3A1F
        .word $3E5F
        .word $467F
        .word $3E5F
        .word $3A1F
        .word $31FF
        .word $29BF
        .word $259F
        .word 0
        .word 0
        .word 0
        .word 0

      aUnknownB9EACBColorData ; B9/EACB

        .word $0828
        .word $0849
        .word $0869
        .word $0C69
        .word $0C6A
        .word $0C8A
        .word $0C6B
        .word $0C8A
        .word $0C6A
        .word $0C69
        .word $0869
        .word $0849
        .word 0
        .word 0
        .word 0
        .word 0

      aUnknownHDMAB9EAEB .structHDMADirectEntryInfo rlUnknownHDMAB9EAEBInit, rlUnknownHDMAB9EAEBCycle, aUnknownHDMAB9EAEBCode, $7EA937, BG3VOFS, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode2) ; B9/EAEB

        ; Dont fully understand what this HDMA is supposed to do besides 
        ; moving some BG3 scanlines 1 pixel up.

      aUnknownHDMAB9EAEBCode ; B9/EAF6

        HDMA_HALT

      rlUnknownHDMAB9EAEBInit ; B9/EAF8

        .al
        .autsiz
        .databank ?

        lda #0
        sta $7EA99D

        lda #0
        sta $7EA99B

        lda #1
        sta $7EA937

        lda #-1
        sta $7EA938

        lda #0
        sta $7EA93A

        rtl

        .databank 0

      rlUnknownHDMAB9EAEBCycle ; B9/EB1C

        .al
        .autsiz
        .databank ?

        lda $7EA99D
        beq ++

          lda $7EA99D
          inc a
          sta $7EA99D
          cmp #64
          bcc +

            lda #0
            sta $7EA99D

            lda $7EA99B
            clc
            adc #2
            sta $7EA99B

          +
          jsl rlUnknownB9EB89

        +
        rtl

        .databank 0

      rlUnknownB9EB48 ; B9/EB48

        .al
        .autsiz
        .databank ?

        lda $7EA99B
        asl a
        asl a
        asl a
        sta wR0

        lda $7EA99D
        lsr a
        lsr a
        lsr a
        sta wR1

        lda #(`$7EA937)<<8
        sta lR18+1
        lda #<>$7EA937
        sta lR18
        jsl rlUnknownB9EBAA
        rtl

        .databank 0

      rlUnknownB9EB69 ; B9/EB69

        .al
        .autsiz
        .databank ?

        lda #7
        sta $7EA99B
        rtl

        .databank 0

      rlUnknownB9EB71 ; B9/EB71

        .al
        .autsiz
        .databank ?

        lda #18
        sta $7EA99B
        rtl

        .databank 0

      rlUnknownB9EB79 ; B9/EB79

        .al
        .autsiz
        .databank ?

        lda #1
        sta $7EA99D
        rtl

        .databank 0

      rlUnknownB9EB81 ; B9/EB81

        .al
        .autsiz
        .databank ?

        lda #1
        sta $7EA99D
        rtl

        .databank 0

      rlUnknownB9EB89 ; B9/EB89

        .al
        .autsiz
        .databank ?

        lda $7EA99B
        asl a
        asl a
        asl a
        sta wR0

        lda $7EA99D
        lsr a
        lsr a
        lsr a
        sta wR1

        lda #(`$7EA937)<<8
        sta lR18+1
        lda #<>$7EA937
        sta lR18
        jsl rlUnknownB9EBAA
        rtl

        .databank 0

      rlUnknownB9EBAA ; B9/EBAA

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

        ldx lR18
        jsr rsUnknownB9EBBF
        jsr rsUnknownB9EBEE

        plp
        plb
        rtl

        .databank 0

      rsUnknownB9EBBF ; B9/EBBF

        .al
        .autsiz
        .databank ?

        lda wR0
        beq ++

          sec
          sbc #112
          beq +
          bcc +

            ; wR0 > $70
            sta wR0
            lda #NTRL_Setting(112)
            sta $0000,b,x
            lda #-1
            sta $0001,b,x
            inc x
            inc x
            inc x

          ; wR0 =< $70
          +
          lda wR0
          ora #NTRL_Setting(0, false)
          sta $0000,b,x
          lda #-1
          sta $0001,b,x
          inc x
          inc x
          inc x

        +
        rts

        .databank 0

      rsUnknownB9EBEE ; B9/EBEE

        .al
        .autsiz
        .databank ?

        lda #8
        sec
        sbc wR1
        beq +

          sta wR1
          ora #NTRL_Setting(0, true)
          sta $0000,b,x
          inc x

          lda #-1

            -
            sta $0000,b,x
            inc x
            inc x
            dec a
            dec wR1
            bne -

          sta $0001,b,x

          sep #$20
          lda #NTRL_Setting(16)
          sta $0000,b,x
          rep #$20

          lda #NTRL_Setting(1)
          sta $0003,b,x
          lda #-1
          sta $0004,b,x
          lda #0
          sta $0006,b,x
          rts

        +
        lda #NTRL_Setting(1)
        sta $0000,b,x
        lda #-1
        sta $0001,b,x
        lda #0
        sta $0003,b,x
        rts

        .databank 0

      rlClearIntroSceneProcScriptedBGPaletteChange ; B9/EC3E

        .al
        .autsiz
        .databank ?

        macroFindAndFreeProc procScriptedBGPaletteChange
        macroFindAndFreeProc procScriptedBGPaletteChange
        rtl

        .databank 0

      rlUnknownB9EC79 ; B9/EC79

        .al
        .autsiz
        .databank ?

        lda #<>aUnknownB9EC94
        sta aProcSystem.wInput0,b
        lda #`aUnknownB9EC94
        sta aProcSystem.wInput1,b
        lda #(`procScriptedBGPaletteChange)<<8
        sta lR44+1
        lda #<>procScriptedBGPaletteChange
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      aUnknownB9EC94 ; B9/EC94

        .byte aBGPaletteBuffer.aPalette2 + (size(Color) * 7) - aBGPaletteBuffer >> 1
        .byte size(Color) * 9 >> 1
        .word <>_ColorData

        macroScriptedBGPaletteChangeEntry 16, 0
        macroScriptedBGPaletteChangeEntry 11, 16
        macroScriptedBGPaletteChangeEntry 11, 32
        macroScriptedBGPaletteChangeEntry 11, 16
        macroScriptedBGPaletteChangeEntry 11, 32
        macroScriptedBGPaletteChangeEntry 14, 48
        macroScriptedBGPaletteChangeEntry 32, 64
        macroScriptedBGPaletteChangeEntry 11, 48
        macroScriptedBGPaletteChangeEntry 11, 32
        macroScriptedBGPaletteChangeEntry 11, 16
        macroScriptedBGPaletteChangeEntry 11, 32
        macroScriptedBGPaletteChangeEntry 14, 16
        macroScriptedBGPaletteChangeLoop

        _ColorData ; B9/ED3D
        ; Some kind of really bright skin-colored palette

        .word $429B
        .word $531F
        .word $5B7F
        .word $5B7F
        .word $639F
        .word $639F
        .word $639F
        .word $639F
        .word $639F
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0

        .word $3A5B
        .word $4ADF
        .word $533F
        .word $533F
        .word $5B5F
        .word $5B5F
        .word $5B5F
        .word $5B5F
        .word $5B5F
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0

        .word $323A
        .word $42BE
        .word $4B1E
        .word $4B1E
        .word $533E
        .word $533E
        .word $535E
        .word $533E
        .word $533E
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0

        .word $2E1A
        .word $3E9E
        .word $46FE
        .word $46FE
        .word $4F1E
        .word $4F1E
        .word $4F3E
        .word $4B1E
        .word $4F1D
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0

        .word $2DF9
        .word $3E7D
        .word $46DD
        .word $46DD
        .word $4EFD
        .word $4EFD
        .word $4F1D
        .word $4EFD
        .word $4EFD
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0

      rlIntroScene3BackgroundColorChange ; B9/EDDD

        .al
        .autsiz
        .databank ?

        lda #<>aIntroScene3BackgroundColorChangeData
        sta aProcSystem.wInput0,b
        lda #`aIntroScene3BackgroundColorChangeData
        sta aProcSystem.wInput1,b

        lda #(`procScriptedBGPaletteChange)<<8
        sta lR44+1
        lda #<>procScriptedBGPaletteChange
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      aIntroScene3BackgroundColorChangeData ; B9/EDF8

        .byte aBGPaletteBuffer.aPalette4 + (size(Color) * 11) - aBGPaletteBuffer >> 1
        .byte size(Color) * 5 >> 1
        .word <>_ColorData

        macroScriptedBGPaletteChangeEntry 16, 0
        macroScriptedBGPaletteChangeEntry 13, 5
        macroScriptedBGPaletteChangeEntry 14, 10
        macroScriptedBGPaletteChangeEntry 15, 16
        macroScriptedBGPaletteChangeEntry 14, 21
        macroScriptedBGPaletteChangeEntry 16, 16
        macroScriptedBGPaletteChangeEntry 10, 10
        macroScriptedBGPaletteChangeEntry 15, 5
        macroScriptedBGPaletteChangeLoop

        _ColorData    ; B9/EE6E
        .word $18F7
        .word $1069
        .word $3972
        .word $29BF
        .word $321F

        .word $18F6
        .word $1069
        .word $3972
        .word $2DDF
        .word $363F

        .word $14D5
        .word $1069
        .word $3972
        .word $31FF
        .word $3A5F

        .word 0

        .word $10B4
        .word $1069
        .word $3972
        .word $361F
        .word $3E7F

        .word $0C93
        .word $1069
        .word $3972
        .word $3A3F
        .word $429F
        .word 0 
        .word 0 
        .word 0 
        .word 0 
        .word 0 
        .word 0 

      aIntroScenesJPBGClearHDMA .structHDMADirectEntryInfo rlIntroScenesJPBGClearHDMAInit, rlIntroScenesJPBGClearHDMACycle, aIntroScenesJPBGClearHDMACode, aIntroScenesJPBGClearHDMATable, TMW, DMAP_HDMA_Setting(DMAP_CPUToIO, DMAP_Increment, DMAP_Mode0) ; B9/EEAE

        ; Disables BG2 at the tile height of the jp text

      aIntroScenesJPBGClearHDMATable ; B9/EEB9

        .byte NTRL_Setting(100)
        .byte T_Setting(false, false, false, false, false)

        .byte NTRL_Setting(101)
        .byte T_Setting(false, false, false, false, false)

        .byte NTRL_Setting(1)
        .byte T_Setting(false, true, false, false, false)

        .byte 0

      rlIntroScenesJPBGClearHDMAInit ; B9/EEC0

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #W12SEL_Setting(false, false, false, false, true, false, false, false)
        sta bBufferW12SEL
        rep #$20

      rlIntroScenesJPBGClearHDMACycle ; B9/EEC8

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      aIntroScenesJPBGClearHDMACode ; B9/EEC9

        HDMA_HALT

      rlCreateIntroScenesEdgeFadingIRQs ; B9/EECB

        .al
        .autsiz
        .databank ?

        ; These IRQs handle the fading from-, and to-black at the top
        ; and bottom of the intro scenes screen.
        ; They also read the screens INIDISP setting, and the brighter the screen is,
        ; the closer the fade effect moves towards the screen edge.

        jsl rlIRQEngineReset

        lda #(`aIntroScenesTopFadeIRQ)<<8
        sta lR44+1
        lda #<>aIntroScenesTopFadeIRQ
        sta lR44
        jsl $82A701

        lda #(`aIntroScenesBottomFadeIRQ)<<8
        sta lR44+1
        lda #<>aIntroScenesBottomFadeIRQ
        sta lR44
        jsl $82A701

        jsl $82A6C8
        rtl

        .databank 0

      rlClearIntroScenesEdgeFadingIRQs ; B9/EEF0

        .al
        .autsiz
        .databank ?

        jsl $82A6EA

        sep #$20
        lda bBufferNMITIMEN
        sta NMITIMEN,b
        rep #$20

        rtl

        .databank 0

      aIntroScenesTopFadeIRQ ; B9/EEFE

        .word 160
        .word 260

        .word <>rlIntroScenesTopFadeIRQCycle
        .word <>aIntroScenesTopFadeIRQCode

      aIntroScenesTopFadeIRQCode ; B9/EF06

        .word <>IRQ_HALT

      rlIntroScenesTopFadeIRQCycle ; B9/EF08

        .al
        .autsiz
        .databank ?

        ; Skip to the end if the screen is in forced black mode.

        sep #$20
        lda bBufferINIDISP
        bpl +

          jmp _End

        +

        ; Wait until HBlank happens

        -
        lda HVBJOY,b
        bit #HVBJOY_HBlank
        beq -

        lda aBGPaletteBuffer.aPalette0,b
        and #$1F
        clc
        adc #0
        clc
        adc bBufferINIDISP
        cmp #$1E
        bpl +

        sec
        sbc #INIDISP_Brightness
        bpl ++

        lda #INIDISP_Setting(false, 0)
        bra ++

        +
        lda #INIDISP_Setting(false, 15)

        +
        sta INIDISP,b

        _Values  := [0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 12, 14, 15]

        .for _Value in _Values

          ; Wait until HBlank for the previous part finishes

          -
          lda HVBJOY,b
          bit #HVBJOY_HBlank
          bne -

          ; ...and then wait until HBlank begins again to execute this part

          -
          lda HVBJOY,b
          bit #HVBJOY_HBlank
          beq -

          lda aBGPaletteBuffer.aPalette0,b
          and #$1F
          clc
          adc #_Value
          clc
          adc bBufferINIDISP
          cmp #$1E
          bpl +

          sec
          sbc #INIDISP_Brightness
          bpl ++

          lda #INIDISP_Setting(false, 0)
          bra ++

          +
          lda #INIDISP_Setting(false, 15)

          +
          sta INIDISP,b

        .endfor

        -
        lda HVBJOY,b
        bit #HVBJOY_HBlank
        beq -

        lda bBufferINIDISP
        sta INIDISP,b

        _End
        rep #$20
        rtl

        .databank 0

      aIntroScenesBottomFadeIRQ ; B9/F1F4

        .word 160
        .word 185

        .word <>rlIntroScenesBottomFadeIRQCycle
        .word <>aIntroScenesBottomFadeIRQCode

      aIntroScenesBottomFadeIRQCode ; B9/F1FC

        .word <>IRQ_HALT

      rlIntroScenesBottomFadeIRQCycle ; B9/F1FE

        .al
        .autsiz
        .databank ?

        sep #$20
        lda bBufferINIDISP
        bpl +

          jmp _End

        +
        -
        lda HVBJOY,b
        bit #HVBJOY_HBlank
        beq -

        lda bBufferINIDISP
        sta INIDISP,b

        _Values := [14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 15]

        .for _Value in _Values

          -
          lda HVBJOY,b
          bit #HVBJOY_HBlank
          bne -

          -
          lda HVBJOY,b
          bit #HVBJOY_HBlank
          beq -

          lda aBGPaletteBuffer.aPalette0,b
          and #$1F
          clc
          adc #_Value
          clc
          adc bBufferINIDISP
          cmp #$1E
          bpl +

          sec
          sbc #INIDISP_Brightness
          bpl ++

          lda #INIDISP_Setting(false, 0)
          bra ++
          
          +
          lda #INIDISP_Setting(false, 15)

          +
          sta INIDISP,b

        .endfor

        -
        lda HVBJOY,b
        bit #HVBJOY_HBlank
        beq -

        lda bBufferINIDISP
        sta INIDISP,b

        _End
        rep #$20
        rtl

        .databank 0

      rlCreateIntroScenesENFadingHDMAs ; B9/F4D2

        .al
        .autsiz
        .databank ?

        ; Makes the english text fade out near the middle of the screen
        ; and fade in at the bottom.

        lda #(`aIntroScenesENFadeHDMA1)<<8
        sta lR44+1
        lda #<>aIntroScenesENFadeHDMA1
        sta lR44
        jsl rlHDMAEngineCreateEntry

        lda #(`aIntroScenesENFadeHDMA2)<<8
        sta lR44+1
        lda #<>aIntroScenesENFadeHDMA2
        sta lR44
        jsl rlHDMAEngineCreateEntry

        lda #(`aIntroScenesENFadeHDMA3)<<8
        sta lR44+1
        lda #<>aIntroScenesENFadeHDMA3
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rtl

        .databank 0

      rlClearIntroScenesENFadingHDMAs ; B9/F4FD

        .al
        .autsiz
        .databank ?

        macroFindAndFreeHDMA aIntroScenesENFadeHDMA1
        macroFindAndFreeHDMA aIntroScenesENFadeHDMA2
        macroFindAndFreeHDMA aIntroScenesENFadeHDMA3
        rtl

        .databank 0

      aIntroScenesENFadeHDMA1 .structHDMADirectEntryInfo rlIntroScenesENFadeHDMA1Init, rlIntroScenesENFadeHDMA1Init, aIntroScenesENFadeHDMA1Code, aIntroScenesENFadeHDMA1Table, CGADD, DMAP_HDMA_Setting(DMAP_CPUToIO, DMAP_Increment, DMAP_Mode3); B9/F54C

      rlIntroScenesENFadeHDMA1Init ; B9/F557

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      aIntroScenesENFadeHDMA1Code ; B9/F558

        HDMA_HALT

      aIntroScenesENFadeHDMA2 .structHDMADirectEntryInfo rlIntroScenesENFadeHDMA2Init, rlIntroScenesENFadeHDMA2Init, aIntroScenesENFadeHDMA2Code, aIntroScenesENFadeHDMA2Table, CGADD, DMAP_HDMA_Setting(DMAP_CPUToIO, DMAP_Increment, DMAP_Mode3) ; B9/F55A

      rlIntroScenesENFadeHDMA2Init ; B9/F565

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      aIntroScenesENFadeHDMA2Code ; B9/F566

        HDMA_HALT

      aIntroScenesENFadeHDMA3 .structHDMADirectEntryInfo rlIntroScenesENFadeHDMA3Init, rlIntroScenesENFadeHDMA3Init, aIntroScenesENFadeHDMA3Code, aIntroScenesENFadeHDMA3Table, CGADD, DMAP_HDMA_Setting(DMAP_CPUToIO, DMAP_Increment, DMAP_Mode3) ; B9/F568

      rlIntroScenesENFadeHDMA3Init ; B9/F573

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      aIntroScenesENFadeHDMA3Code ; B9/F574

        HDMA_HALT

      aIntroScenesENFadeHDMA1Table ; B9/F576

        ; The high byte of the word is a dummy write to change CGADD to an odd address,
        ; while the lower byte is the color index. After that is a color word.

        ; Fades color ID 1 from black, to dark gray, to black

        .byte NTRL_Setting(100)
        .word pack([1, 1]), $0000 

        .byte NTRL_Setting(48)
        .word pack([1, 1]), $0000

        .byte NTRL_Setting(16, true)

        .word pack([1, 1]), $0000
        .word pack([1, 1]), $0000
        .word pack([1, 1]), $0000
        .word pack([1, 1]), $0421
        .word pack([1, 1]), $0421
        .word pack([1, 1]), $0421
        .word pack([1, 1]), $0842
        .word pack([1, 1]), $0842
        .word pack([1, 1]), $0842
        .word pack([1, 1]), $0C63
        .word pack([1, 1]), $0C63
        .word pack([1, 1]), $0C63
        .word pack([1, 1]), $1084
        .word pack([1, 1]), $1084
        .word pack([1, 1]), $1084
        .word pack([1, 1]), $14A5

        .byte NTRL_Setting(17)
        .word pack([1, 1]), $14A5

        .byte NTRL_Setting(17, true)

        .word pack([1, 1]), $14A5
        .word pack([1, 1]), $1084
        .word pack([1, 1]), $1084
        .word pack([1, 1]), $1084
        .word pack([1, 1]), $0C63
        .word pack([1, 1]), $0C63
        .word pack([1, 1]), $0C63
        .word pack([1, 1]), $0842
        .word pack([1, 1]), $0842
        .word pack([1, 1]), $0842
        .word pack([1, 1]), $0421
        .word pack([1, 1]), $0421
        .word pack([1, 1]), $0421
        .word pack([1, 1]), $0000
        .word pack([1, 1]), $0000
        .word pack([1, 1]), $0000
        .word pack([1, 1]), $0000

        .byte 0

      aIntroScenesENFadeHDMA2Table ; B9/F60C

        ; Fades color ID 2 from black, to gray, to black

        .byte NTRL_Setting(100)
        .word pack([2, 2]), $0000

        .byte NTRL_Setting(48)
        .word pack([2, 2]), $0000

        .byte NTRL_Setting(16, true)

        .word pack([2, 2]), $0421
        .word pack([2, 2]), $0842
        .word pack([2, 2]), $0C63
        .word pack([2, 2]), $1084
        .word pack([2, 2]), $14A5
        .word pack([2, 2]), $18C6
        .word pack([2, 2]), $1CE7
        .word pack([2, 2]), $2108
        .word pack([2, 2]), $2529
        .word pack([2, 2]), $294A
        .word pack([2, 2]), $2D6B
        .word pack([2, 2]), $318C
        .word pack([2, 2]), $35AD
        .word pack([2, 2]), $39CE
        .word pack([2, 2]), $3DEF
        .word pack([2, 2]), $4210

        .byte NTRL_Setting(17)
        .word pack([2, 2]), $4210

        .byte NTRL_Setting(17, true)

        .word pack([2, 2]), $4210
        .word pack([2, 2]), $3DEF
        .word pack([2, 2]), $39CE
        .word pack([2, 2]), $35AD
        .word pack([2, 2]), $318C
        .word pack([2, 2]), $2D6B
        .word pack([2, 2]), $294A
        .word pack([2, 2]), $2529
        .word pack([2, 2]), $2108
        .word pack([2, 2]), $1CE7
        .word pack([2, 2]), $18C6
        .word pack([2, 2]), $14A5
        .word pack([2, 2]), $1084
        .word pack([2, 2]), $0C63
        .word pack([2, 2]), $0842
        .word pack([2, 2]), $0421
        .word pack([2, 2]), $0000

        .byte 0

      aIntroScenesENFadeHDMA3Table ; B9/F6A2

        ; Fades color ID 3 from black, to white, to black

        .byte NTRL_Setting(100)
        .word pack([3, 3]), $0000

        .byte NTRL_Setting(48)
        .word pack([3, 3]), $0000

        .byte NTRL_Setting(16, true)

        .word pack([3, 3]), $0842
        .word pack([3, 3]), $1084
        .word pack([3, 3]), $18C6
        .word pack([3, 3]), $2108
        .word pack([3, 3]), $294A
        .word pack([3, 3]), $318C
        .word pack([3, 3]), $39CE
        .word pack([3, 3]), $4210
        .word pack([3, 3]), $4A52
        .word pack([3, 3]), $5294
        .word pack([3, 3]), $5AD6
        .word pack([3, 3]), $6318
        .word pack([3, 3]), $6B5A
        .word pack([3, 3]), $739C
        .word pack([3, 3]), $7BDE
        .word pack([3, 3]), $7FFF

        .byte NTRL_Setting(17)
        .word pack([3, 3]), $7FFF

        .byte NTRL_Setting(17, true)

        .word pack([3, 3]), $7FFF
        .word pack([3, 3]), $7BDE
        .word pack([3, 3]), $739C
        .word pack([3, 3]), $6B5A
        .word pack([3, 3]), $6318
        .word pack([3, 3]), $5AD6
        .word pack([3, 3]), $5294
        .word pack([3, 3]), $4A52
        .word pack([3, 3]), $4210
        .word pack([3, 3]), $39CE
        .word pack([3, 3]), $318C
        .word pack([3, 3]), $294A
        .word pack([3, 3]), $2108
        .word pack([3, 3]), $18C6
        .word pack([3, 3]), $1084
        .word pack([3, 3]), $0842
        .word pack([3, 3]), $0000

        .byte 0

      rlCreateIntroScenesENTextScrollHDMA ; B9/F738

        .al
        .autsiz
        .databank ?

        lda #(`aIntroScenesENTextScrollHDMA)<<8
        sta lR44+1
        lda #<>aIntroScenesENTextScrollHDMA
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rtl

        .databank 0

      rlClearIntroScenesENTextScrollHDMA ; B9/F747

        .al
        .autsiz
        .databank ?

        macroFindAndFreeHDMA aIntroScenesENTextScrollHDMA

        rtl

        .databank 0

      rlIntroScenesENTextScrollHDMAInit ; B9/F762

        .al
        .autsiz
        .databank ?

        lda #$FFFF
        sta wBufferBG3VOFS

        lda #0
        sta $165B,b
        lda #111
        sta $165D,b
        lda #0
        sta $1663,b
        lda #$FFFF
        sta $1665,b

        lda #0
        sta wIntroSceneENTextFrameCounter

        lda #10
        sta wIntroSceneENTextScrollDelay
        rtl

        .databank 0

      aIntroScenesENTextScrollHDMA .structHDMAIndirectEntryInfo rlIntroScenesENTextScrollHDMAInit, rlIntroScenesENTextScrollHDMACycle, aIntroScenesENTextScrollHDMACode, aIntroScenesENTextScrollHDMATable, BG3HOFS, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), 0 ; B9/F78E 

      aIntroScenesENTextScrollHDMACode ; B9/F79A
 
        HDMA_HALT

      rlIntroScenesENTextScrollHDMACycle ; B9/F79C

        .al
        .autsiz
        .databank ?

        lda wIntroSceneENTextFrameCounter
        inc a
        sta wIntroSceneENTextFrameCounter

        cmp wIntroSceneENTextScrollDelay
        bne +

          lda #0
          sta wIntroSceneENTextFrameCounter

          inc $165D,b

        +
        rtl

        .databank 0

      aIntroScenesENTextScrollHDMATable ; B9/F7B6

        .byte NTRL_Setting(100)
        .word $1673

        .byte NTRL_Setting(44)
        .word $1673

        .byte NTRL_Setting(58)
        .word $1677

        .byte NTRL_Setting(1)
        .word $1663

        .byte 0

      rlClearIntroScenesHDMAs ; B9/F7C3

        .al
        .autsiz
        .databank ?

        jsl rlClearIntroScenesENFadingHDMAs
        jsl rlClearIntroScenesENTextScrollHDMA
        jsl rlClearIntroScenesEdgeFadingIRQs

        macroFindAndFreeHDMA aIntroScene3FlameEffectHDMA
        macroFindAndFreeHDMA aIntroScenesJPBGClearHDMA

        sep #$20
        lda #T_Setting(false, true, false, false, false)
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

      .endwith ; IntroScenesConfig

    .endsection IntroScenes2Section

    .section IntroScene3FlameEffectSection

      aIntroScene3FlameEffectHDMA .structHDMAIndirectEntryInfo rlIntroScene3FlameEffectHDMAInit, rlIntroScene3FlameEffectHDMACycle, aIntroScene3FlameEffectHDMACode, aIntroScene3FlameEffectHDMATable, BG2VOFS, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode2), $7E ; B9/FA79 

      aIntroScene3FlameEffectHDMACode ; B9/FA85

        HDMA_HALT

      rlIntroScene3FlameEffectHDMAInit ; B9/FA87

        .al
        .autsiz
        .databank ?

        lda #0
        sta wIntroScene3FlameEffectHDMACounter

        jsl rlIntroScene3FlameEffectHDMACycle

        rtl

        .databank 0

      rlIntroScene3FlameEffectHDMACycle ; B9/FA93

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`wIntroScene3FlameEffectHDMACounter
        pha
        rep #$20
        plb

        .databank `wIntroScene3FlameEffectHDMACounter

        lda wIntroScene3FlameEffectHDMACounter
        inc a
        and #$00FF
        sta wIntroScene3FlameEffectHDMACounter
        lsr a
        lsr a
        asl a
        clc
        adc #<>aIntroScene3FlameEffectHDMAOffsets
        tax

        ldy #0
        
        -
        lda aIntroScene3FlameEffectHDMAOffsets & $FF0000,x
        clc
        adc wBufferBG2VOFS
        sta aIntroScene3FlameEffectHDMATableData,y
        sta aIntroScene3FlameEffectHDMATableData + $40,y
        sta aIntroScene3FlameEffectHDMATableData + $80,y
        sta aIntroScene3FlameEffectHDMATableData + $C0,y
        sta aIntroScene3FlameEffectHDMATableData + $100,y
        sta aIntroScene3FlameEffectHDMATableData + $140,y
        sta aIntroScene3FlameEffectHDMATableData + $180,y
        inc x
        inc x
        tya
        clc
        adc #size(word)
        tay
        cpy #$0040
        bne -

        plp
        plb
        rtl

        .databank 0

      aIntroScene3FlameEffectHDMATable ; B9/FADE

        .byte NTRL_Setting(112, true)
        .word <>aIntroScene3FlameEffectHDMATableData

        .byte NTRL_Setting(112, true)
        .word <>aIntroScene3FlameEffectHDMATableData + 224

        .byte 0

      aIntroScene3FlameEffectHDMAOffsets ; B9/FAE5
      
        _Values := [0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2]
        _Values..= [2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0]

        .rept 16
          .for _Value in _Values
            .word _Value
          .endfor
        .endrept

        .byte 0

      ; B9/FEE6

    .endsection IntroScene3FlameEffectSection


    .section IntroScenesPalettesSection
      
      aIntroScene2BackgroundPalette         .text ROM[$1D0250:$1D0270] ; BA/8250
      aUnknownBA8270Palette                 .text ROM[$1D0270:$1D0290] ; BA/8270
      aIntroScene3BackgroundPalette         .text ROM[$1D0290:$1D02D0] ; BA/8290
      aIntroScene2Picture1Palette           .text ROM[$1D02D0:$1D02F0] ; BA/82D0
      aIntroScene2Picture2Palette           .text ROM[$1D02F0:$1D0310] ; BA/82F0
      aIntroScene3Picture1Palette           .text ROM[$1D0310:$1D0330] ; BA/8310
      aIntroScene3Picture2Palette           .text ROM[$1D0330:$1D0350] ; BA/8330
      aIntroScene1BackgroundPalette         .text ROM[$1D0350:$1D0370] ; BA/8350
      aIntroScene3Picture3Palette           .text ROM[$1D0370:$1D0390] ; BA/8370
      aUnknownBA8370Palette                 .text ROM[$1D0390:$1D03B0] ; BA/8390
      aIntroSceneBorderPalette              .text ROM[$1D03B0:$1D03B8] ; BA/83B0

    .endsection IntroScenesPalettesSection


    .section IntroScenesGraphicData1Section

      ; Irrelevant, overwriten by jp/en g2bpp and tilemap
      g2bppcIntroNarrationJPUnused          .text ROM[$1D593B:$1D6E93] ; BA/D93B
      acIntroNarrationJPTilemapUnused       .text ROM[$1D6E93:$1D71A9] ; BA/EE93

      g4bppcIntroScene2Background           crossbankRaw ROM[$1D71A9:$1DCE10] ; BA/F1A9

    .endsection IntroScenesGraphicData1Section

    .section IntroScenesGraphicData2Section

      crossbankRawRemainder
      acIntroScene2BackgroundTilemap        .text ROM[$1DCE10:$1DD20B] ; BB/CE10
      g4bppcIntroScene3Background           crossbankRaw ROM[$1DD20B:$1E0A9F] ; BB/D20B

    .endsection IntroScenesGraphicData2Section

    .section IntroScenesGraphicData3Section

      crossbankRawRemainder
      acIntroScene3BackgroundTilemap        .text ROM[$1E0A9F:$1E0EAE] ; BB/8A9F
      g4bppcIntroScene1Background           .text ROM[$1E0EAE:$1E25EE] ; BC/8EAE
      acIntroScene1BackgroundTilemap        .text ROM[$1E25EE:$1E2760] ; BC/A5EE

      g4bppcIntroScene2Picture1             .text ROM[$1E2760:$1E3BEC] ; BC/A760
        ; Quan/Ethyln see wyverns
      g4bppcIntroScene2Picture2             .text ROM[$1E3BEC:$1E54B2] ; BC/BBEC
        ; Kalf dies
      g4bppcIntroScene3Picture1             .text ROM[$1E54B2:$1E67CE] ; BC/D4B2
        ; Finn/Leif look at burning castle
      g4bppcIntroScene3Picture2             .text ROM[$1E67CE:$1E79BF] ; BC/E7CE
        ; Finn holds Leif
      g4bppcIntroScene3Picture3             crossbankRaw ROM[$1E79BF:$1E8A17] ; BC/F9BF
        ; Finn holds Leif but close

    .endsection IntroScenesGraphicData3Section

    .section IntroScenesGraphicData4Section

      crossbankRawRemainder
      acIntroScenePictureTilemap            .text ROM[$1E8A17:$1E8B7C] ; BD/8A17
      acUnknownBD8B7CTilemap                .text ROM[$1E8B7C:$1E8CE1] ; BD/8B7C
      g2bppcIntroScene2PictureBorders       .text ROM[$1E8CE1:$1E8CFE] ; BD/8CE1
      acIntroScene2PictureBorderTilemap     .text ROM[$1E8CFE:$1E8D85] ; BD/8CFE

    .endsection IntroScenesGraphicData4Section


    .section IntroScenesGraphicData5Section

      g2bppcIntroNarration1                 .text ROM[$1F6B29:$1F7F3D] ; BE/EB29
      acIntroNarration1ENTilemap            crossbankRaw ROM[$1F7F3D:$1F803A] ; BE/FF3D

    .endsection IntroScenesGraphicData5Section

    .section IntroScenesGraphicData6Section

      crossbankRawRemainder
      acIntroNarration1JPTilemap            .text ROM[$1F803A:$1F8195] ; BF/803A
      acIntroNarration2ENTilemap            .text ROM[$1F8195:$1F833B] ; BF/8195
      acIntroNarration2JPTilemap            .text ROM[$1F833B:$1F8469] ; BF/833B
      acIntroNarration3ENTilemap            .text ROM[$1F8469:$1F846F] ; BF/8469

    .endsection IntroScenesGraphicData6Section


    .section IntroScenesGraphicData7Section

      g2bppcIntroNarration2                 .text ROM[$10C000:$10D0AA] ; A1/C000

    .endsection IntroScenesGraphicData7Section


    .section ProcScriptedPaletteChangeSection

      procScriptedBGPaletteChange .structProcInfo "BC", rlProcScriptedBGPaletteChangeInit, rlProcScriptedBGPaletteChangeCycle, None ; 94/9F97

      rlProcScriptedBGPaletteChangeInit ; 94/9F9F

        .al
        .autsiz
        .databank ?

        lda aProcSystem.wInput0,b
        sta lR18
        lda aProcSystem.wInput1,b
        sta lR18+2

        ldy #0

        lda [lR18],y
        and #$00FF
        asl a
        clc
        adc #$0100
        sta aProcSystem.aBody2,b,x
        inc y

        lda [lR18],y
        and #$00FF
        asl a
        sta aProcSystem.aBody3,b,x
        inc y

        lda [lR18],y
        sta aProcSystem.aBody0,b,x

        lda lR18
        clc
        adc #4
        sta aProcSystem.aBody4,b,x

        sep #$20
        lda lR18+2
        sta aProcSystem.aBody1,b,x
        rep #$20
        rtl

        .databank 0

      rlUnknown949FDC ; 94/9FDC

        .al
        .autsiz
        .databank ?

        lda #<>rlProcScriptedBGPaletteChangeCycle
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlProcScriptedBGPaletteChangeCycle ; 94/9FE3

        .al
        .autsiz
        .databank ?

        phb
        sep #$20
        lda aProcSystem.aBody1,b,x
        pha
        rep #$20
        plb

        lda aProcSystem.aBody0,b,x
        sta lR18
        lda aProcSystem.aBody4,b,x
        sta lR19
        lda aProcSystem.aBody2,b,x
        sta lR20
        lda aProcSystem.aBody3,b,x
        sta wR0

        -
        lda aProcSystem.aHeaderUnknownTimer,b,x
        clc
        adc lR19
        tay

        inc aProcSystem.aHeaderUnknownTimer,b,x
        lda $0000,b,y
        and #$00FF

        ldx aProcSystem.wOffset,b
        cmp #$00FF
        beq +

        cmp #$00FE
        beq ++

        jsr rsProcScriptedBGPaletteChangeApplyColor
        plb
        rtl
        
        +
        jsl rlProcEngineFreeProc
        plb
        rtl
        
        +
        stz aProcSystem.aHeaderUnknownTimer,b,x
        bra -

        .databank 0

      rsProcScriptedBGPaletteChangeApplyColor ; 94/A02E

        .al
        .autsiz
        .databank ?

        asl a
        clc
        adc lR18
        clc
        adc wR0
        dec a
        dec a
        tax

        ldy wR0
        dec y
        dec y
        
        -
        lda $0000,b,x
        sta (lR20),y
        dec x
        dec x
        dec y
        dec y
        bpl -

        rts

        .databank 0

        ; 94/A048

    .endsection ProcScriptedPaletteChangeSection

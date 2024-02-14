.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_MENU_COMMANDS :?= false
.if (!GUARD_FE5_MENU_COMMANDS)
  GUARD_FE5_MENU_COMMANDS := true

  ; Definitions

  .weak

    rlCreateMenu                                      :?= address($85898D)
    rlUpdateRescuedUnitCoordinates                    :?= address($839B37)
    rlCreatActionMenuHDMAs                            :?= address($8593AD)
    rlPlaySound                                       :?= address($808C87)
    rlCheckIfHighestPriorityMenu                      :?= address($858434)
    rlActionMenuInputHandler                          :?= address($858B43)
    rlTryGetBrokenItemID                              :?= address($83B0B7)
    rlFillInventoryHoles                              :?= address($83A49C)
    rlGetItemUseEffectPointer                         :?= address($87B143)
    rlDrawRightFacingStaticCursorHighPrio             :?= address($8590CF)
    rlUnknown85847C                                   :?= address($85847C)
    rlClearIconArray                                  :?= address($8A8060)
    rlUnknown80B99E                                   :?= address($80B99E)
    rlDrawTilemapPackedRect                           :?= address($84A3FF)
    rlGetMapTileIndexByCoords                         :?= address($838E76)
    rlCheckIfTileIsGateOrThroneByTileIndex            :?= address($83AF2B)
    rlFindObjectiveMarker                             :?= address($81C44C)
    rlRunRoutineForTilesIn1Range                      :?= address($839969)
    rlCheckAvailableTalks                             :?= address($8C9C59)
    rlRunRoutineForAllItemsInInventory                :?= address($83993C)
    rlCopyItemDataToBuffer                            :?= address($83B00D)
    rlCheckItemEquippable                             :?= address($83965E)
    rlFillMapByWord                                   :?= address($80E849)
    rlGetMapUnitsInRange                              :?= address($80E5CD)
    rlCopyCharacterDataToBufferByDeploymentNumber     :?= address($83901C)
    rlRunRoutineForAllPlayerVisibleUnitsInRange       :?= address($83991B)
    rlDrawBGPortraitByCharacter                       :?= address($8CC137)
    procItemSelectPortrait                            :?= address($8293B3)
    rlMapItemMenuDiscardYesAInput                     :?= address($8A877A)
    rlCheckIfAllegianceDoesNotMatchPhaseTarget        :?= address($83B34F)
    rlSetBattleForecastWindowShading                  :?= address($81BF0E)
    rlGetWindowSideByUnitXCoordinate                  :?= address($83CB09)
    rlGetBattleForecastBGTiles                        :?= address($81BF00)
    rlBuildBattleForecastWindow                       :?= address($81BF33)
    rlDMABurstWindowTiles                             :?= address($84A17D)
    rlActionStructCombatStructs                       :?= address($83CF2B)
    rlUnknownGetMapTileCoordsBySelectedUnit           :?= address($83A7FC)
    rlRunChapterLocationEvents                        :?= address($8C9CBD)
    rlCheckIfAllegianceDoesNotMatchPhase              :?= address($83B320)
    rlUpdateUnitMapsAndFog                            :?= address($81AC00)
    rlCopyCharacterDataFromBuffer                     :?= address($839041)
    rlCheckIfAllegianceMatchesPhase                   :?= address($83B30C)
    rlCopyExpandedCharacterDataBufferToBuffer         :?= address($83905C)
    rlCheckIfClassCanDismount                         :?= address($83A80F)
    aMountedClassTable                                :?= address($888000)
    aDismountedClassTable                             :?= address($88801C)
    rlCopyTerrainMovementCostBuffer                   :?= address($80E43B)
    rlGetMapCoordsByTileIndex                         :?= address($838E84)
    rlCopyClassDataToBuffer                           :?= address($8393E0)
    rlUpdateMountDismountSkills                       :?= address($83AC5B)
    rlCheckIfTargetableAllegiance                     :?= address($83B380)
    rlFillTilemapByWord                               :?= address($80E89F)
    rlEnableBG1Sync                                   :?= address($81B1FA)
    rlEnableBG3Sync                                   :?= address($81B212)
    rlGetEffectiveConstitution                        :?= address($83A855)
    rlCombineCharacterDataAndClassBases               :?= address($8390BE)
    rlGetEffectiveMove                                :?= address($8387D5)
    rlRegisterAllMapSpritesAndStatus                  :?= address($8885D1)
    rlGetEquippableItemInventoryOffset                :?= address($839705)
    aItemData                                         :?= address($B080AB)
    rlDrawSingleIcon                                  :?= address($8A8085)
    rlDrawPortraitSlot0Tilemap                        :?= address($8CC1BB)
    rlGetItemNamePointer                              :?= address($83931A)
    rlDrawMenuText                                    :?= address($87E728)
    rlDrawItemCurrentDurability                       :?= address($858921)
    rlGetEventCoordinatesByTileIndex                  :?= address($83A7EC)
    rlSetCursorToCoordinates                          :?= address($83C181)

    MenuOptionValid   = $0100
    MenuOptionInvalid = $0200
    MenuOptionHidden  = $0400


  .endweak





  .virtual $7E4F03

    lMenuStructPointer .long ?          ; $7E4F03
    wNextFreeMenuOptionsOffset .word ?  ; $7E4F06
      ; for aMenuOptions
    .word 0

    aMenuOptions .fill (17 *2)          ; $7E4F0A
      ; entries are white or gray as $01 or $02 | menu struct offset

    wMenuOptionsCount .word ?           ; $7E4F2C

  .endvirtual

  .virtual $7E4F30

    lMenuStructAvaliabilityCheck .long ?    ; $7E4F30
    lMenuStructTextRenderer .long ?         ; $7E4F33
    lMenuStructOnMoveRoutine .long ?        ; $7E4F36
    lMenuStructAPressRoutine .long ?        ; $7E4F39
    lMenuStructBPressRoutine .long ?        ; $7E4F3C
    lMenuStructXPressRoutine .long ?        ; $7E4F3F
    lMenuStructText .long ?                 ; $7E4F42
    .byte 0
    wSelectedMenuOptionYPosition .word ?    ; $7E4F46
    wSelectedMenuOptionOffset .word ?       ; $7E4F48

  .endvirtual

  .virtual $000E6B

    wDisplayRangeFlag               .word ?   ; $000E6B
    wForcedMapScrollFlag            .word ?   ; $000E6D

  .endvirtual


    .section ActionMenuCommandsSection

      aActionMenuData ; 87/8000

        .word <>aActionMenuSeizeOption
        .word <>aActionMenuRetreatOption
        .word <>aActionMenuArriveOption
        .word <>aActionMenuTalkOption
        .word <>aActionMenuAttackOption
        .word <>aActionMenuCaptureOption
        .word <>aActionMenuStealOption
        .word <>aActionMenuVisitOption
        .word <>aActionMenuArmoryOption
        .word <>aActionMenuVendorOption
        .word <>aActionMenuSecretShopOption
        .word <>aActionMenuArenaOption
        .word <>aActionMenuSupplyOption
        .word <>aActionMenuDoorOption
        .word <>aActionMenuDrawbridgeOption
        .word <>aActionMenuChestOption
        .word <>aActionMenuDanceOption
        .word <>aActionMenuWaitOption
        .word <>aActionMenuStaffOption
        .word <>aActionMenuItemsOption
        .word <>aActionMenuRescueOption
        .word <>aActionMenuDropOption
        .word <>aActionMenuReleaseOption
        .word <>aActionMenuGiveOption
        .word <>aActionMenuTakeOption
        .word <>aActionMenuTradeOption
        .word <>aActionMenuMountOption
        .word <>aActionMenuDismountOption
        .word <>aActionMenuAnimationOption
        .word 0

        .enc "SJIS"

      aActionMenuWaitOption ; 87/803C

        .long rlActionMenuWaitOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuWaitOptionAInput
        .long rlActionMenuBInput
        .long 0
        .text "　待機\n"

      aActionMenuAttackOption ; 87/8056

        .long rlActionMenuAttackOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuAttackOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　攻撃\n"

      aActionMenuCaptureOption ; 87/8070

        .long rlActionMenuCaptureOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuCaptureOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　捕える\n"

      aActionMenuStaffOption ; 87/808C

        .long rlActionMenuStaffOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuStaffOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　杖\n"

      aActionMenuTalkOption ; 87/80A4

        .long rlActionMenuTalkOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuTalkOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　話す\n"

      aActionMenuArmoryOption ; 87/80BE

        .long rlActionMenuArmoryOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuShopOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　武器屋\n"

      aActionMenuVendorOption ; 87/80DA

        .long rlActionMenuVendorOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuShopOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　道具屋\n"

      aActionMenuSecretShopOption ; 87/80F6

        .long rlActionMenuSecretShopOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuShopOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　秘密店\n"

      aActionMenuVisitOption ; 87/8112

        .long rlActionMenuVisitOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuVisitOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　訪ねる\n"

      aActionMenuSeizeOption ; 87/812E

        .long rlActionMenuSeizeOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuSeizeOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　制圧\n"

      aActionMenuRetreatOption ; 87/8148

        .long rlActionMenuRetreatOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuRetreatArriveOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　りだつ\n"

      aActionMenuArriveOption ; 87/8164

        .long rlActionMenuArriveOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuRetreatArriveOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　到達\n"

      aActionMenuTradeOption ; 87/817E

        .long rlActionMenuTradeOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuTradeOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　物交換\n"

      aActionMenuDoorOption ; 87/819A

        .long rlActionMenuDoorOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuDoorOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　扉\n"

      aActionMenuDrawbridgeOption ; 87/81B2

        .long rlActionMenuDrawbridgeOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuDrawbridgeOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　はね橋\n"

      aActionMenuItemsOption ; 87/81CE

        .long rlActionMenuItemsOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuItemsOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　持ち物\n"

      aActionMenuChestOption ; 87/81EA

        .long rlActionMenuChestOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuChestOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　宝箱\n"

      aActionMenuArenaOption ; 87/8204

        .long rlActionMenuArenaOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuArenaOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　闘技場\n"

      aActionMenuAnimationOption ; 87/8220

        .long rlActionMenuAnimationOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuAnimationOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　アニメ\n"

      aActionMenuDanceOption ; 87/823C

        .long rlActionMenuDanceOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuDanceOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　踊る\n"

      aActionMenuMountOption ; 87/8256

        .long rlActionMenuMountOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuMountOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　のる\n"

      aActionMenuDismountOption ; 87/8270

        .long rlActionMenuDismountOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuDismountOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　おりる\n"

      aActionMenuRescueOption ; 87/828C

        .long rlActionMenuRescueOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuRescueOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　かつぐ\n"

      aActionMenuDropOption ; 87/82A8

        .long rlActionMenuDropOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuDropOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　おろす\n"

      aActionMenuStealOption ; 87/82C4

        .long rlActionMenuStealOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuStealOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　ぬすむ\n"

      aActionMenuReleaseOption ; 87/82E0

        .long rlActionMenuReleaseOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuReleaseOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　解放\n"

      aActionMenuSupplyOption ; 87/82FA

        .long rlActionMenuSupplyOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuSupplyOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　預かり所\n"

      aActionMenuGiveOption ; 87/8318

        .long rlActionMenuGiveOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuGiveOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　人交換\n"

      aActionMenuTakeOption ; 87/8334

        .long rlActionMenuTakeOptionAvailabilityCheck
        .long 0
        .long 0
        .long rlActionMenuTakeOptionAInput
        .long rlActionMenuBInput
        .long 0

        .text "　人交換\n"

      procActionMenu .block ; 87/8350

        .dstruct structProcInfo, "AM", rlProcActionMenuInit, rlProcActionMenuCycle, None

      .bend

      rlProcActionMenuInit ; 87/8358

        .al
        .autsiz
        .databank `aActionStructUnit2

        php
        phb

        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        phx
        jsl rlActionMenuSupplyOptionAvailabilityCheck
        plx

        pha

        ; Pick window x coordinate based on unit position
        lda aSelectedCharacterBuffer.Coordinates,b
        sta aActionStructUnit2.Coordinates

        lda #25
        sta wR0
        lda #1
        sta wR1
        jsl rlPickMenuSideByUnitCoords

        ; X coord
        lda $C123,b
        sta wR0

        ; Y coord
        lda #6
        sta wR1

        ; Width | $80 no shading
        lda #6
        sta wR2

        lda #(`aActionMenuData)<<8
        sta lR18+1
        lda #<>aActionMenuData
        sta lR18

        ; Check if Supply command is visible, if yes increase
        ; the width of the window and move it a bit left if
        ; the window is displayed on the right map edge
        pla
        cmp #MenuOptionHidden
        beq +

          inc wR2

          lda wR0
          cmp #16
          bcc +

            dec wR0
        
        +
        jsl rlCreateMenu
        sta aProcSystem.aHeaderUnknownTimer,b,x

        jsr rsAdjustActionMenuYPosition

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuSetActiveMenu
        jsl rlMenuDrawAllMenusFromBuffers

        lda #4
        sta aProcSystem.aBody6,b,x

        jsl rlUpdateRescuedUnitCoordinates
        jsl rlCreatActionMenuHDMAs

        lda #12
        jsl rlPlaySound

        plb
        plp
        rtl

        .databank 0

      rsAdjustActionMenuYPosition ; 87/83D4

        .al
        .autsiz
        .databank $7E

        ; Moves the menu higher when more options are displayed

        sep #$20
        lda #28
        sec
        sbc aActiveMenuTemp.BG3Info.Size.H
        bpl +

          lda #0
        
        +
        lsr a
        cmp #6
        bcc +

          lda #6

        +
        sta aActiveMenuTemp.Position.Y

        lda aOptions.wAnimation
        cmp #2
        bne +

          ; Individual animation
          lda aActiveMenuTemp.BG3Info.Size.H
          cmp #20
          bcc +

            stz aActiveMenuTemp.Position.Y

        +
        rep #$30
        jsl rlMenuCopyActiveMenuCopyTempToCurrentSlot
        rts

        .databank 0

      rlProcActionMenuCycle ; 87/8402

        .al
        .autsiz
        .databank $7E

        php
        phb

        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlCheckIfHighestPriorityMenu
        bcc +

          jsr rsActionMenuWaitHotkey
          lda aProcSystem.aHeaderUnknownTimer,b,x
          jsl rlMenuCopyActiveMenuCopyCurrentSlotToTemp
          jsl rlActionMenuInputHandler

          lda aProcSystem.aBody6,b,x
          plb
          plp
          rtl

        +
        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuCopyActiveMenuCopyCurrentSlotToTemp

        lda aProcSystem.aBody7,b,x
        clc
        adc aActiveMenuTemp.Position.Y
        inc a
        asl a
        asl a
        asl a
        sta wR1

        lda aActiveMenuTemp.Position.X
        asl a
        asl a
        asl a
        sta wR0

        jsl rlDrawRightFacingStaticCursorHighPrio
        plb
        plp
        rtl

        .databank 0

      rsActionMenuWaitHotkey ; 87/844C

        .al
        .autsiz
        .databank $7E

        ; Change the currently selected action menu option to "Wait" when pressing R

        lda wJoy1New
        bit #JOY_R
        beq _End

        ldy #0

          -
          lda aMenuOptions,y
          beq _End

          and #$00FF
          cmp #$0022
          beq +

          inc y
          inc y
          bra -
        
        +
        tya
        sta aProcSystem.aBody7,b,x
        
        _End
        rts

        .databank 0

      rlActionMenuBInput ; 87/846C

        .al
        .autsiz
        .databank ?

        jsl rlProcEngineFreeProc
        jsl rlUnknown85847C

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlMenuDrawAllMenusFromBuffers
        lda #2
        rtl

        .databank 0

      rlMapItemMenuBInput ; 87/8483

        .al
        .autsiz
        .databank ?

        jsl rlProcEngineFreeProc

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlKillItemView

        phx
        lda #(`procActionMenu)<<8
        sta lR44+1
        lda #<>procActionMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        ; Not sure what the 2 is for.
        ; That routine discards A instantly.
        lda #2

        jsl rlClearIconArray
        rtl

        .databank 0

      rlRestartProcActionMenu ; 87/84AA

        .al
        .autsiz
        .databank ?

        lda wForcedMapScrollFlag,b
        bne +

          lda #<>rlRestartProcActionMenuEffect
          sta aProcSystem.aHeaderOnCycle,b,x

        +
        rtl

        .databank 0

      rlRestartProcActionMenuEffect ; 87/84B6

        .al
        .autsiz
        .databank ?

        jsl rlProcEngineFreeProc

        phx
        lda #(`procActionMenu)<<8
        sta lR44+1
        lda #<>procActionMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        rtl

        .databank 0

      rlActionMenuWaitOptionAInput ; 87/84CB

        .al
        .autsiz
        .databank ?

        ; some unit action bitfield, here set "wait used"
        lda $4F98,b
        ora #$0010
        sta $4F98,b

        lda aSelectedCharacterBuffer.UnitState,b
        ora #UnitStateMoved
        sta aSelectedCharacterBuffer.UnitState,b

      rlFreeProcActionMenu ; 87/84DD

        .al
        .autsiz
        .databank ?

        lda #$FFFF
        sta $7E4F96
        jsl rlProcEngineFreeProc
        jsl rlUnknown85847C

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlMenuDrawAllMenusFromBuffers
        rtl

        .databank 0

      rlActionMenuAttackOptionAInput ; 87/84F8

        .al
        .autsiz
        .databank ?

        jsl rlProcEngineFreeProc

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu

        phx
        lda #(`procMapWeaponSelectMenu)<<8
        sta lR44+1
        lda #<>procMapWeaponSelectMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        lda #3
        rtl

        .databank 0

      rlActionMenuCaptureOptionAInput ; 87/8517

        .al
        .autsiz
        .databank ?

        jsl rlProcEngineFreeProc

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu

        phx
        lda #(`procCaptureWeaponSelect)<<8
        sta lR44+1
        lda #<>procCaptureWeaponSelect
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        lda #3
        rtl

        .databank 0

      rlActionMenuShopOptionAInput ; 87/8536

        .al
        .autsiz
        .databank ?

        lda #13
        sta $0E25,b

        lda #(`procActionMenu)<<8
        sta lR44+1
        lda #<>procActionMenu
        sta lR44
        jsl rlProcEngineFindProc
        bcc +

          stz aProcSystem.aHeaderTypeOffset,b,x
        
        +
        jsl rlUnknown80B99E
        lda #3
        rtl

        .databank 0

      rlActionMenuTalkOptionAvailabilityCheck ; 87/8557

        .al
        .autsiz
        .databank ?

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne _HideOption

        jsl rlGetSelectedUnitsTalkOptions

        ; This ram address is a counter for how many talks are available
        lda $A7AD,b
        beq _HideOption

        lda #MenuOptionValid
        rtl
        
        _HideOption
        lda #MenuOptionHidden
        rtl

        .databank 0

      rlActionMenuSeizeOptionAvailabilityCheck ; 87/8570

        .al
        .autsiz
        .databank $7E

        ; You cant seize if the chapter has a retreat arrow.
        ; Prevents seizing in ch19 and, since ch14 has an invisible
        ; one, also prevents it there.

        lda #0
        cmp wObjectiveMarkerColorIndex
        bne _HideOption

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne _HideOption

        lda aSelectedCharacterBuffer.Character,b
        cmp #Leif
        bne _HideOption

        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0

        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1

        jsl rlGetMapTileIndexByCoords
        tax
        lda aVisibilityMap,x
        and #$00FF
        beq _HideOption

        jsl rlCheckIfTileIsGateOrThroneByTileIndex
        bcs +

        _HideOption
        lda #MenuOptionHidden
        rtl
        
        +
        lda #MenuOptionValid
        rtl

        .databank 0

      rlActionMenuRetreatOptionAvailabilityCheck ; 87/85B3

        .al
        .autsiz
        .databank $7E

        ; You can only retreat on red objective markers

        lda #1
        cmp wObjectiveMarkerColorIndex
        bne _HideOption

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne _HideOption

        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0

        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1

        jsl rlGetMapTileIndexByCoords
        jsl rlFindObjectiveMarker
        bcs +
        
        _HideOption
        lda #MenuOptionHidden
        rtl
        
        +
        lda #MenuOptionValid
        rtl

        .databank 0

      rlActionMenuArriveOptionAvailabilityCheck ; 87/85E5

        .al
        .autsiz
        .databank $7E

        ; You can only arrive on blue objective markers

        lda #2
        cmp wObjectiveMarkerColorIndex
        bne _HideOption

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne _HideOption

        lda #Leif
        cmp aSelectedCharacterBuffer.Character,b
        bne _HideOption

        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0

        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1

        jsl rlGetMapTileIndexByCoords
        jsl rlFindObjectiveMarker
        bcs +
        
        _HideOption
        lda #MenuOptionHidden
        rtl
        
        +
        lda #MenuOptionValid
        rtl

        .databank 0

      rlActionMenuVisitOptionAvailabilityCheck ; 87/861F

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne _HideOption

        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0

        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1

        jsl rlGetMapTileIndexByCoords
        tax
        lda aVisibilityMap,x
        and #$00FF
        beq _HideOption

        lda aTerrainMap,x
        and #$00FF
        cmp #TerrainHouse
        beq +

        cmp #TerrainChurch
        beq +
        
        _HideOption
        lda #MenuOptionHidden
        rtl
        
        +
        lda #MenuOptionValid
        rtl

        .databank 0

      rlGetSelectedUnitsTalkOptions ; 87/865C

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

        phx
        stz $A7AD,b

        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0

        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1

        jsl rlGetMapTileIndexByCoords
        tax
        lda #<>rlGetSelectedUnitsTalkOptionsEffect
        sta lR25
        lda #>`rlGetSelectedUnitsTalkOptionsEffect
        sta lR25+1
        jsl rlRunRoutineForTilesIn1Range
        plx
        plb
        plp
        rtl

        .databank 0

      rlGetSelectedUnitsTalkOptionsEffect ; 87/8691

        .al
        .autsiz
        .databank $7E

        lda aPlayerVisibleUnitMap,x
        and #$00FF
        beq _End

        sta wR0

        lda #<>aTemporaryActionStruct
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber

        lda aTemporaryActionStruct.Status,b
        and #$00FF
        cmp #0
        beq +

        cmp #StatusPoison
        beq +
        bra _End
        
        +
        lda aSelectedCharacterBuffer.Character,b
        sta wR0

        lda aTemporaryActionStruct.Character,b
        sta wR1

        jsl rlCheckAvailableTalks
        bcc _End

        ldx $A7AD,b
        lda aTemporaryActionStruct.DeploymentNumber,b
        and #$00FF
        sta $A7AF,b,x
        inc x
        inc x
        stx $A7AD,b

        _End
        rtl

        .databank 0

      rlActionMenuAttackOptionAvailabilityCheck ; 87/86D8

        .al
        .autsiz
        .databank ?

        lda #MenuOptionHidden
        sta $4F42,b

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne +

          lda #<>rlActionMenuGetAttackTargetsInItemRange
          sta lR25
          lda #>`rlActionMenuGetAttackTargetsInItemRange
          sta lR25+1
          lda #<>aSelectedCharacterBuffer.Items
          jsl rlRunRoutineForAllItemsInInventory

        +
        lda $4F42,b
        rtl

        .databank 0

      rlActionMenuGetAttackTargetsInItemRange ; 87/86FB

        .al
        .autsiz
        .databank ?

        ldx lR25
        phx
        ldx lR25+1
        phx

        jsl rlCopyItemDataToBuffer

        lda aItemDataBuffer.Traits,b
        bit #TraitWeapon
        beq _End

          lda #aSelectedCharacterBuffer.Character
          sta wR1
          jsl rlCheckItemEquippable
          bcc _End

            jsl rlActionMenuGetAttackTargetsInRange

            lda $A7AD,b
            beq _End

              lda #MenuOptionValid
              sta $4F42,b
              stz $A7AD,b
        
        _End
        pla
        sta lR25+1
        pla
        sta lR25
        rtl

        .databank 0

      rlActionMenuGetAttackTargetsInRange ; 87/8731

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

        lda #(`aRangeMap)<<8
        sta lR18+1
        lda #<>aRangeMap
        sta lR18
        lda #0
        jsl rlFillMapByWord

        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0

        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1

        lda #<>aRangeMap
        sta wR3
        lda aItemDataBuffer.Range,b
        jsl rlGetMapUnitsInRange

        stz $A7AD,b

        lda #<>rlActionMenuGetAttackTargetsInRangeEffect
        sta lR25
        lda #>`rlActionMenuGetAttackTargetsInRangeEffect
        sta lR25+1
        jsl rlRunRoutineForAllPlayerVisibleUnitsInRange

        plb
        plp
        rtl

        .databank 0

      rlActionMenuGetAttackTargetsInRangeEffect ; 87/877C

        .al
        .autsiz
        .databank $7E

        lda aPlayerVisibleUnitMap,y
        beq +

          jsl rlCheckIfAllegianceDoesNotMatchPhaseTarget
          bcc +

            lda aPlayerVisibleUnitMap,y
            ldx $A7AD,b
            sta $A7AF,b,x
            inc x
            inc x
            stx $A7AD,b

        +
        rtl

        .databank 0

      procMapWeaponSelectMenu .block ; 87/8796

        .dstruct structProcInfo, "WS", rlProcMapWeaponSelectMenuInit, rlProcMapWeaponSelectMenuCycle1, None

      .bend

      aMapWeaponSelectMenu ; 87/879E

        .word <>aMapWeaponSelectMenuOption
        .word <>aMapWeaponSelectMenuOption
        .word <>aMapWeaponSelectMenuOption
        .word <>aMapWeaponSelectMenuOption
        .word <>aMapWeaponSelectMenuOption
        .word <>aMapWeaponSelectMenuOption
        .word <>aMapWeaponSelectMenuOption
        .word 0

      aMapWeaponSelectMenuOption ; 87/87AE

        .long rlMapWeaponSelectMenuOptionDisplayCheck
        .long rlMapWeaponSelectMenuDrawItemDataByOffset
        .long rlGetItemDelayed
        .long rlMapWeaponSelectMenuAInput
        .long rlMapItemMenuBInput
        .long 0
        .enc "SJIS"
        .text "　\n"

      rlMapWeaponSelectMenuOptionDisplayCheck ; 87/87C4

        .al
        .autsiz
        .databank ?

        lda #MenuOptionHidden
        sta $4F42,b

        lda wSelectedMenuOptionOffset
        tax
        lda aSelectedCharacterBuffer.Items,b,x
        jsl rlActionMenuGetAttackTargetsInItemRange

        lda $4F42,b
        rtl

        .databank 0

      rlMapWeaponSelectMenuDrawItemDataByOffset ; 87/87DA

        .al
        .autsiz
        .databank $7E

        ldy wSelectedMenuOptionOffset
        lda aSelectedCharacterBuffer.Items,b,y
        jsl rlCopyItemDataToBuffer

        lda #MenuOptionValid
        jsl rlMapMenuDrawItemData
        rtl

        .databank 0

      rlProcMapWeaponSelectMenuInit ; 87/87EC

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        stz aProcSystem.aBody7,b,x
        stz wCapturingFlag

        phx
        lda aSelectedCharacterBuffer.Character,b
        sta wR0
        lda #0
        jsl rlDrawBGPortraitByCharacter
        jsl rlClearIconArray
        plx

        ; X
        lda #3
        sta wR0

        ; Y
        lda #9
        sta wR1

        ; Width
        lda #15
        sta wR2

        lda #<>aMapWeaponSelectMenu
        sta lR18
        lda #>`aMapWeaponSelectMenu
        sta lR18+1
        jsl rlCreateMenu
        sta aProcSystem.aHeaderUnknownTimer,b,x

        jsl rlMenuSetActiveMenu

        lda aMenuOptions
        and #$00FF
        tax
        lda aSelectedCharacterBuffer.Items,b,x
        sta $4F55,b

        phx
        lda #(`procItemView)<<8
        sta lR44+1
        lda #<>procItemView
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        sep #$20
        lda #$12
        sta bBufferTM
        rep #$20

        plb
        plp
        rtl

        .databank 0

      rlProcMapWeaponSelectMenuCycle1 ; 87/885A

        .al
        .autsiz
        .databank $7E

        phx
        lda #(`procItemSelectPortrait)<<8
        sta lR44+1
        lda #<>procItemSelectPortrait
        sta lR44
        jsl rlProcEngineFindProc
        plx

        bcc +

          rtl
        
        +
        lda #0
        sta aProcSystem.aBody6,b,x
        lda #<>_8879
        sta aProcSystem.aHeaderOnCycle,b,x

        _8879
        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda #<>rlProcMapWeaponSelectMenuCycle2
        sta aProcSystem.aHeaderOnCycle,b,x
        jsl rlMenuDrawAllMenusFromBuffers
        jsr rsDrawPortraitToBG1

        sep #$20
        lda #$17
        sta bBufferTM
        rep #$20

        plb
        plp
        rtl

        .databank 0

      rlProcMapWeaponSelectMenuCycle2 ; 87/8898

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        jsl $8A8126

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlCheckIfHighestPriorityMenu
        bcc +

          lda aProcSystem.aHeaderUnknownTimer,b,x
          jsl rlMenuCopyActiveMenuCopyCurrentSlotToTemp
          jsl rlActionMenuInputHandler

        +
        plb
        plp
        rtl

        .databank 0

      rlMapWeaponSelectMenuAInput ; 87/88C0

        .al
        .autsiz
        .databank $7E

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlProcEngineFreeProc
        jsl rlKillItemView

        phx
        jsl rlClearIconArray
        ldx wSelectedMenuOptionOffset
        stx $4F4A,b
        lda aSelectedCharacterBuffer.Items,b,x
        jsl rlCopyItemDataToBuffer
        jsl rlActionMenuGetAttackTargetsInRange
        ldx $A7AD,b
        stz $A7AF,b,x
        plx

        phx
        lda #(`procBattleForecast)<<8
        sta lR44+1
        lda #<>procBattleForecast
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        lda #0
        rtl

        .databank 0

      procBattleForecast .block ; 87/8900

        .dstruct structProcInfo, "BK", rlProcBattleForecastInit, rlProcBattleForecastCycle, None

      .bend

      aBattleForecastInputRoutines ; 87/8908

        .long rlBattleForecastRebuild   ; on directional input
        .long rlBattleForecastAInput
        .long rlQueueKillBattleForecast
        .long 0         ; X

      rlProcBattleForecastInit ; 87/8914

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

        stz aProcSystem.aBody7,b,x

        lda #<>aBattleForecastInputRoutines
        sta lR18
        lda #>`aBattleForecastInputRoutines
        sta lR18+1
        jsl $858E43

        plb
        plp
        rtl 

        .databank 0

      rlProcBattleForecastCycle ; 87/8932

        .al
        .autsiz
        .databank ?

        phx
        jsl rlGetBattleForecastBGTiles
        plx
        
        lda #<>rlProcBattleForecastCycle2
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl 

        .databank 0

      rlProcBattleForecastCycle2 ; 87/893F

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

        phx
        jsl rlBattleForecastRebuild
        jsl rlSetBattleForecastWindowShading
        plx

        lda #<>rlProcBattleForecastInputHandlerCycle
        sta aProcSystem.aHeaderOnCycle,b,x

        plb
        plp
        rtl 

        .databank 0

      rlProcBattleForecastInputHandlerCycle ; 87/895C

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

        jsl $858E7F

        plb
        plp
        rtl 

        .databank 0

      rlPickMenuSideByUnitCoords ; 87/896D

        .al
        .autsiz
        .databank ?

        phx
        lda <>aActionStructUnit2.X,b
        and #$00FF
        jsl rlGetWindowSideByUnitXCoordinate
        tax
        lda wR0,x
        sta $C123,b
        plx
        rtl

        .databank 0

      rlBattleForecastRebuild ; 87/8980

        .al
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aBody7,b,x
        tax
        lda $7EA7AF,x
        and #$00FF
        sta wR1

        lda #<>aSelectedCharacterBuffer
        sta wR0

        lda $4F4A,b
        sta wR17
        jsl rlActionStructPlayerCombatSelection

        plx

        lda <>aActionStructUnit2.X,b
        and #$00FF
        jsl rlGetWindowSideByUnitXCoordinate
        dec a
        dec a
        and #$0002
        tax
        jsl rlBuildBattleForecastWindow
        rtl

      .databank 0

      rlQueueKillBattleForecast ; 87/89B2

        .al
        .autsiz
        .databank ?

        lda #<>rlKillBattleForecast
        sta aProcSystem.aHeaderOnCycle,b,x

        jsl rlDMABurstWindowTiles

        sep #$20
        lda #T_Setting(false, true, false, false, true)
        sta bBufferTM
        rep #$20

        rtl

      .databank 0

      rlKillBattleForecast ; 87/89C5

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #$17
        sta $A1
        rep #$20

        jsl rlProcEngineFreeProc
        jsl $8594C1

        phx
        lda #(`procActionMenu)<<8
        sta lR44+1
        lda #<>procActionMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        rtl

        .databank 0

      rlBattleForecastAInput ; 87/89E6

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        lda aProcSystem.aBody5,b,x
        jsl rlMenuClearActiveMenu
        jsl rlMenuDrawAllMenusFromBuffers
        jsl rlBattleForecastCheckForInstantCapture
        bcs +

        phx
        phx
        lda #aSelectedCharacterBuffer
        sta wR1
        lda $4F4A,b
        jsl $83C1C5
        plx

        lda aProcSystem.aBody7,b,x
        tax
        lda $7EA7AF,x
        and #$00FF
        sta wR1
        lda #aSelectedCharacterBuffer
        sta wR0
        stz wR17
        jsl rlActionStructCombatStructs
        jsl $8594C1
        jsl $83CD3E ; rlSelectBattleAnimationMode
        plx
        bra ++
        
        +
        sep #$20
        lda #$12
        sta $4FCF,b
        lda $A5A1,b
        sta $4FCE,b
        rep #$30
        lda #aSelectedCharacterBuffer
        sta wR1
        lda $4F4A,b
        jsl $83C1C5
        
        +
        jsl $8594C1
        lda #<>rlFreeProcAndUpdateCursorCoordinates
        sta aProcSystem.aBody4,b,x
        lda #<>rlUnknown879998
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlBattleForecastCheckForInstantCapture ; 87/8A5C

        .al
        .autsiz
        .databank $7E

        phx
        phy
        lda wCapturingFlag
        beq _CLC

          lda aActionStructUnit2.Status
          and #$00FF
          cmp #StatusSleep
          beq _InstantCapture

          cmp #StatusPetrify
          beq _InstantCapture

          stz wR17
          lda #<>rlBattleForecastItemInstantCaptureCheck
          sta lR25
          lda #>`rlBattleForecastItemInstantCaptureCheck
          sta lR25+1
          lda #<>aActionStructUnit2.Items
          jsl rlRunRoutineForAllItemsInInventory

          lda wR17
          beq _InstantCapture

        _CLC
        ply
        plx
        clc
        rtl
        
        _InstantCapture
        ply
        plx
        sec
        rtl

        .databank 0

      rlBattleForecastItemInstantCaptureCheck ; 87/8A92

        .al
        .autsiz
        .databank ?

        jsl rlCopyItemDataToBuffer

        lda aItemDataBuffer.Traits,b
        bit #TraitWeapon
        beq +

          lda #<>aActionStructUnit2
          sta wR1
          jsl rlCheckItemEquippable
          bcc +

            lda aItemDataBuffer.Range,b
            and #$000F
            cmp #3
            bcs +

              inc wR17

        +
        rtl

        .databank 0

      rlFreeProcAndUpdateCursorCoordinates ; 87/8AB7

        .al
        .autsiz
        .databank ?

        ; this needs a better name, as not just the minimap uses it

        jsl rlProcEngineFreeProc
        lda wCursorXCoord,b
        sta wR0
        lda wCursorYCoord,b
        sta wR1
        jsl rlSetCursorToCoordinates

        lda #$FFFF
        sta $7E4F96

        jsl rlUnknown85847C
        rtl

        .databank 0

      rlUnknown878AD5 ; 87/8AD5

        .al
        .autsiz
        .databank ?

        ; Minimap stuff

        lda #11
        sta $0E25,b
        jsl rlUnknown85847C
        rtl

        .databank 0

      procMinimap .block ; 87/8AE0

        .dstruct structProcInfo, None, rlProcMinimapInit, rlFreeProcAndUpdateCursorCoordinates, None

      .bend

      rlProcMinimapInit ; 87/8AE8

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlActionMenuArmoryOptionAvailabilityCheck ; 87/8AE9

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne _HideOption

        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0
        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1
        jsl rlGetMapTileIndexByCoords
        tax
        lda aVisibilityMap,x
        and #$00FF
        beq _HideOption

        lda aTerrainMap,x
        and #$00FF
        cmp #TerrainArmory
        beq +
        
        _HideOption
        lda #MenuOptionHidden
        rtl
        
        +
        lda #MenuOptionValid
        rtl

        .databank 0

      rlActionMenuVendorOptionAvailabilityCheck ; 87/8B21

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne _HideOption

        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0
        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1
        jsl rlGetMapTileIndexByCoords
        tax
        lda aVisibilityMap,x
        and #$00FF
        beq _HideOption

        lda aTerrainMap,x
        and #$00FF
        cmp #TerrainVendor
        beq +
        
        _HideOption
        lda #MenuOptionHidden
        rtl

        +
        lda #MenuOptionValid
        rtl

        .databank 0

      rlActionMenuSecretShopOptionAvailabilityCheck ; 87/8B59

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne _HideOption

        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wActiveTileUnitParameter1
        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wActiveTileUnitParameter2
        jsl $8C9C83
        bcc _HideOption

        ldx wCursorTileIndex,b
        lda aTerrainMap,x
        and #$00FF
        cmp #TerrainArmory
        beq _HideOption

        cmp #TerrainVendor
        beq _HideOption

        ldx #size(aSelectedCharacterBuffer.Items) -2
        
        -
        lda aSelectedCharacterBuffer.Items,b,x
        and #$00FF
        cmp #MemberCard
        beq +

        dec x
        dec x
        bpl -

        _HideOption
        lda #MenuOptionHidden
        rtl
        
        +
        lda #MenuOptionValid
        rtl

        .databank 0

      rlActionMenuTalkOptionAInput ; 87/8BA6

        .al
        .autsiz
        .databank $7E

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlProcEngineFreeProc

        phx
        lda #(`procTalkCommand)<<8
        sta lR44+1
        lda #<>procTalkCommand
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        rtl

        .databank 0

      procTalkCommand .block ; 87/8BC2

        .dstruct structProcInfo, "tk", rlProcTalkCommandInit, rlProcTalkDanceCommandCycle, None

      .bend

      aTalkCommandInputRoutines ; 87/8BCA

        .long 0       ; directional
        .long rlProcTalkCommandAInput
        .long rlProcTalkDanceCommandBInput
        .long 0       ; X

      rlProcTalkCommandInit ; 87/8BD6

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda #$FFFF
        sta wTerrainWindowSide
        jsl rlGetSelectedUnitsTalkOptions
        stz aProcSystem.aBody7,b,x

        lda $A7AF,b
        sta wR0
        lda #<>aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber

        lda #$FFFF
        sta wTerrainWindowSide
        jsl rlCreateAllyInteractionMenuEffect

        lda #<>aTalkCommandInputRoutines
        sta lR18
        lda #>`aTalkCommandInputRoutines
        sta lR18+1
        jsl $858E43
        plb
        plp
        rtl

        .databank 0

      rlProcTalkDanceCommandCycle ; 87/8C16

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlCheckIfHighestPriorityMenu
        bcs +

        jmp ++

        +
        jsl rlCreateAllyInteractionMenu
        
        +
        plb
        plp
        rtl 

        .databank 0

      rlProcTalkDanceCommandBInput ; 87/8C33

        .al
        .autsiz
        .databank $7E

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlProcEngineFreeProc

        phx
        lda #(`procActionMenu)<<8
        sta lR44+1
        lda #<>procActionMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        rtl

        .databank 0

      rlProcTalkCommandAInput ; 87/8C4F

        .al
        .autsiz
        .databank $7E

        phx
        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlMenuDrawAllMenusFromBuffers
        jsl rlProcEngineFreeProc

        lda #(`procActionMenu)<<8
        sta lR44+1
        lda #<>procActionMenu
        sta lR44
        jsl rlProcEngineFindProc
        bcc +

          stz aProcSystem.aHeaderTypeOffset,b,x
        
        +
        plx

        phx
        lda aProcSystem.aBody7,b,x
        tay
        lda $A7AF,b,y
        sta wR0
        lda #<>aTargetingCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber
        jsl $8593EB

        lda aSelectedCharacterBuffer.Character,b
        sta wR0
        lda aTargetingCharacterBuffer.Character,b
        sta wR1
        jsl $8C9CA3

        lda #$FFFF
        sta @l $7E4F96

        phx
        lda #(`procUnknown878CB1)<<8
        sta lR44+1
        lda #<>procUnknown878CB1
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        plx
        rtl

        .databank 0

      procUnknown878CB1 .block ; 87/8CB1

        .dstruct structProcInfo, "EW", rlProcUnknown878CB1Init, rlProcUnknown878CB1Cycle, None

      .bend

      rlProcUnknown878CB1Init ; 87/8CB9

        .al
        .autsiz
        .databank $7E

        rtl

        .databank 0

      rlProcUnknown878CB1Cycle ; 87/8CBA

        .al
        .autsiz
        .databank $7E

        lda wEventEngineStatus,b
        bne +

          jsl rlProcEngineFreeProc
          jsl rlUnknown85847C

        +
        rtl

        .databank 0

      procUnknown878CC8 .block ; 87/8CC8

        .dstruct structProcInfo, "E2", rlProcUnknown878CC8Init, rlProcUnknown878CC8Cycle, None

      .bend

      rlProcUnknown878CC8Init ; 87/8CD0

        .al
        .autsiz
        .databank $7E

        rtl

        .databank 0

      rlProcUnknown878CC8Cycle ; 87/8CD1

        .al
        .autsiz
        .databank $7E

        lda $172C,b
        bne +

          jmp rlFreeProcAndUpdateCursorCoordinates
        
        +
        rtl

        .databank 0

      rlActionMenuVisitOptionAInput ; 87/8CDA

        .al
        .autsiz
        .databank $7E

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlMenuDrawAllMenusFromBuffers
        jsl rlProcEngineFreeProc

        jsl $8593EB
        jsl rlUnknownGetMapTileCoordsBySelectedUnit
        jsl rlRunChapterLocationEvents

        lda #$FFFF
        sta @l $7E4F96

        phx
        lda #(`procUnknown878CC8)<<8
        sta lR44+1
        lda #<>procUnknown878CC8
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        rtl

        .databank 0

      rlActionMenuTradeOptionAvailabilityCheck ; 87/8D0D

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne +

          jsl rlGetSelectedUnitsTradeOptions

          lda $A7AD,b
          beq +

            lda #MenuOptionValid
            rtl

        +
        lda #MenuOptionHidden
        rtl

        .databank 0

      rlGetSelectedUnitsTradeOptions ; 87/8D26

        .al
        .autsiz
        .databank ?

        phx
        stz $A7AD,b
        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateRescuing
        beq +

        ; If you are rescuing someone, you also have to add them to the trade list
        ; if possible

          ; Dont allow trades with friendly NPCs
          lda aSelectedCharacterBuffer.Rescue,b
          jsl $83B3FA
          bcc +

            lda aSelectedCharacterBuffer.Rescue,b
            sta wR0
            lda #aTargetingCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            lda aSelectedCharacterBuffer.Item1ID,b
            ora aTargetingCharacterBuffer.Item1ID,b
            beq +

              ldx $A7AD,b
              lda aTargetingCharacterBuffer.DeploymentNumber,b
              sta $A7AF,b,x
              inc x
              inc x
              stx $A7AD,b

        +
        lda #<>rlGetSelectedUnitsTradeOptionsEffect
        sta $44
        lda #>`rlGetSelectedUnitsTradeOptionsEffect
        sta $44+1
        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0
        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1
        jsl rlGetMapTileIndexByCoords
        tax
        jsl rlRunRoutineForTilesIn1Range
        plx
        rtl 

        .databank 0

      rlGetSelectedUnitsTradeOptionsEffect ; 87/8D84

        .al
        .autsiz
        .databank $7E

        lda aPlayerVisibleUnitMap,x
        and #$00FF
        beq _End

          jsl rlCheckIfAllegianceDoesNotMatchPhase
          bcs _End

            sta wR0
            lda #aTargetingCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            lda aSelectedCharacterBuffer.Item1ID,b
            ora aTargetingCharacterBuffer.Item1ID,b
            beq +

              ldy $A7AD,b
              lda aPlayerVisibleUnitMap,x 
              and #$00FF
              sta $A7AF,b,y
              inc y
              inc y
              sty $A7AD,b

            +
            lda aTargetingCharacterBuffer.Rescue,b
            and #$00FF
            beq _End

              ; Dont allow trades with friendly NPCs
              jsl $83B3FA
              bcc _End

                lda aTargetingCharacterBuffer.Rescue,b
                sta wR0
                lda #aTargetingCharacterBuffer
                sta wR1
                jsl rlCopyCharacterDataToBufferByDeploymentNumber

                lda aSelectedCharacterBuffer.Item1ID,b
                ora aTargetingCharacterBuffer.Item1ID,b
                beq _End

                  ldy $A7AD,b
                  lda aTargetingCharacterBuffer.DeploymentNumber,b
                  and #$00FF
                  sta $A7AF,b,y
                  inc y
                  inc y
                  sty $A7AD,b

        _End
        rtl 

        .databank 0

      rlActionMenuTradeOptionAInput ; 87/8DEC

        .al
        .autsiz
        .databank $7E

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlProcEngineFreeProc
        jsl rlGetSelectedUnitsTradeOptions

        lda #2
        sta wTradeWindowType

        phx
        lda #(`procTradeMenu)<<8
        sta lR44+1
        lda #<>procTradeMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        rtl

        .databank 0

      procTradeMenu .block ; 87/8E12

        .dstruct structProcInfo, "ts", rlProcTradeMenuInit, rlProcTradeMenuCycle, None

      .bend

      aTradeMenuInputRoutines ; 87/8E1A

        .long 0       ; directional
        .long rlProcTradeMenuAInput
        .long rlProcTradeMenuBInput
        .long 0       ; X

      rlProcTradeMenuInit ; 87/8E26

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda #$FFFF
        sta wTerrainWindowSide
        stz aProcSystem.aBody7,b,x

        lda $A7AF,b
        sta wR0
        lda #aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber
        jsl rlCreateTradeInteractionMenuEffect

        lda #<>aTradeMenuInputRoutines
        sta $2F
        lda #>`aTradeMenuInputRoutines
        sta $2F+1
        jsl $858E43
        plb
        plp
        rtl

        .databank 0

      rlProcTradeMenuCycle ; 87/8E5C

        .al
        .autsiz
        .databank ?

        lda #<>rlProcTradeMenuCycle2
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlProcTradeMenuCycle2 ; 87/8E63

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

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlCheckIfHighestPriorityMenu
        bcc +

          jsl rlCreateTradeInteractionMenu

        +
        plb
        plp
        rtl

        .databank 0

      rlProcTradeMenuAInput ; 87/8E7D

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlMenuDrawAllMenusFromBuffers
        jsl rlProcEngineFreeProc

        lda aProcSystem.aBody7,b,x
        tay
        lda $A7AF,b,y
        sta wR0
        lda #<>aItemSkillCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber

        lda #<>$80A044
        sta $A4EC,b
        lda #>`$80A044
        sta $A4EC+1,b
        jsl $80B907

        phx
        lda #(`procActionMenu)<<8
        sta lR44+1
        lda #<>procActionMenu
        sta lR44
        jsl rlProcEngineFindProc
        bcc +

          stz aProcSystem.aHeaderTypeOffset,b,x
        
        +
        plx
        rtl

        .databank 0

      rlProcTradeMenuBInput ; 87/8EC4

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlProcEngineFreeProc

        phx
        lda #(`procActionMenu)<<8
        sta lR44+1
        lda #<>procActionMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        rtl

        .databank 0

      rlActionMenuSeizeOptionAInput ; 87/8EE0

        .al
        .autsiz
        .databank ?

        phx
        jsl rlMenuClearActiveMenus
        jsl rlActionMenuClearBackgrounds
        jsl rlUnknownGetMapTileCoordsBySelectedUnit
        jsl rlRunChapterLocationEvents
        plx

        lda aSelectedCharacterBuffer.UnitState,b
        ora #(UnitStateMovementStar | UnitStateMoved)
        sta aSelectedCharacterBuffer.UnitState,b

        lda #<>rlFreeProcAndUpdateCursorCoordinates
        sta aProcSystem.aBody4,b,x
        lda #<>rlDelayUntilActionFinished
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlActionMenuRetreatArriveOptionAInput ; 87/8F08

        .al
        .autsiz
        .databank ?

        lda $4F98,b
        ora #$0008
        sta $4F98,b
        jmp rlActionMenuSeizeOptionAInput

        .databank 0

      rlActionMenuDoorOptionAvailabilityCheck ; 87/8F14

        .al
        .autsiz
        .databank ?

        lda #MenuOptionHidden
        sta $4F42,b

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne _End

          lda #DoorKey
          jsl rlCheckInventoryForItem
          bcs +

            jsl rlCheckInventoryForUsableLockpick
            bcc _End

          +
          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0
          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1
          jsl rlGetMapTileIndexByCoords
          tax
          lda #<>rlActionMenuDoorOptionAvailabilityCheckEffect
          sta lR25
          lda #>`rlActionMenuDoorOptionAvailabilityCheckEffect
          sta lR25+1
          jsl rlRunRoutineForTilesIn1Range
        
        _End
        lda $4F42,b
        rtl

        .databank 0

      rlActionMenuDoorOptionAvailabilityCheckEffect ; 87/8F58

        .al
        .autsiz
        .databank $7E

        lda aVisibilityMap,x
        and #$00FF
        beq +

          lda aTerrainMap,x
          and #$00FF
          cmp #TerrainDoor
          bne +

            lda #MenuOptionValid
            sta $4F42,b

            ldy $A7AD,b
            txa
            sta $A7AF,b,x
            inc x
            inc x
            stx $A7AD,b

        +
        rtl

        .databank 0

      rlActionMenuDoorOptionAInput ; 87/8F7E

        .al
        .autsiz
        .databank $7E

        phx
        jsl rlMenuClearActiveMenus
        jsl rlActionMenuClearBackgrounds
        lda #<>rlActionMenuDoorOptionAInputEffect
        sta lR25
        lda #>`rlActionMenuDoorOptionAInputEffect
        sta lR25+1
        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0
        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1
        jsl rlGetMapTileIndexByCoords
        tax
        jsl rlRunRoutineForTilesIn1Range
        jsl rlUpdateUnitMapsAndFog

        lda #%00000100
        sta wBGUpdateFlags
        plx

        jsl rlActionCommandDecreaseLockpickUses
        bcs +

          lda #DoorKey
          jsl rlActionCommandDecreaseItemUses
        
        +
        lda #(`procActionMenu)<<8
        sta lR44+1
        lda #<>procActionMenu
        sta lR44
        jsl rlProcEngineFindProc
        bcc +

          stz aProcSystem.aHeaderTypeOffset,b,x
        
        +
        jsl rlFreeProcActionMenu
        rtl

        .databank 0

      rlActionMenuDoorOptionAInputEffect ; 87/8FDA

        .al
        .autsiz
        .databank $7E

        lda aVisibilityMap,x
        and #$00FF
        beq +

          lda aTerrainMap,x
          and #$00FF
          cmp #TerrainDoor
          bne +

            jsl rlGetEventCoordinatesByTileIndex
            jsl rlRunChapterLocationEvents

        +
        rtl

        .databank 0

      rlActionMenuDrawbridgeOptionAvailabilityCheck ; 87/8FF6

        .al
        .autsiz
        .databank $7E

        lda #MenuOptionHidden
        sta $4F42,b

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne _End

          lda #BridgeKey
          jsl rlCheckInventoryForItem
          bcs +

            jsl rlCheckInventoryForUsableLockpick
            bcc _End
          
          +
          stz $A7AD,b

          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0
          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1
          jsl rlGetMapTileIndexByCoords
          tax
          lda #<>rlActionMenuDrawbridgeOptionAvailabilityCheckEffect
          sta lR25
          lda #>`rlActionMenuDrawbridgeOptionAvailabilityCheckEffect
          sta lR25+1
          jsl rlRunRoutineForTilesIn1Range

        _End
        lda $4F42,b
        rtl

        .databank 0

      rlActionMenuDrawbridgeOptionAvailabilityCheckEffect ; 87/903D

        .al
        .autsiz
        .databank $7E

        lda aVisibilityMap,x
        and #$00FF
        beq +

          lda aTerrainMap,x
          and #$00FF
          cmp #TerrainDrawbridge
          bne +

            lda #MenuOptionValid
            sta $4F42,b

            ldy $A7AD,b
            txa
            sta $A7AF,b,x
            inc x
            inc x
            stx $A7AD,b

        +
        rtl

        .databank 0

      rlActionMenuDrawbridgeOptionAInput ; 87/9063

        .al
        .autsiz
        .databank $7E

        phx
        jsl rlMenuClearActiveMenus
        jsl rlActionMenuClearBackgrounds
        lda #<>rlActionMenuDrawbridgeOptionAInputEffect
        sta lR25
        lda #>`rlActionMenuDrawbridgeOptionAInputEffect
        sta lR25+1
        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0
        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1
        jsl rlGetMapTileIndexByCoords
        tax
        jsl rlRunRoutineForTilesIn1Range
        jsl rlUpdateUnitMapsAndFog

        lda #%00000100
        sta wBGUpdateFlags
        plx

        jsl rlActionCommandDecreaseLockpickUses
        bcs +

          lda #BridgeKey
          jsl rlActionCommandDecreaseItemUses

        +
        lda #(`procActionMenu)<<8
        sta lR44+1
        lda #<>procActionMenu
        sta lR44
        jsl rlProcEngineFindProc
        bcc +

          stz aProcSystem.aHeaderTypeOffset,b,x

        +
        jsl rlFreeProcActionMenu
        rtl

        .databank 0

      rlActionMenuDrawbridgeOptionAInputEffect ; 87/90BF

        .al
        .autsiz
        .databank $7E

        lda aVisibilityMap,x
        and #$00FF
        beq +

          lda aTerrainMap,x
          and #$00FF
          cmp #TerrainDrawbridge
          bne +

            jsl rlGetEventCoordinatesByTileIndex
            jsl rlRunChapterLocationEvents

        +
        rtl

        .databank 0

      rlActionMenuChestOptionAvailabilityCheck ; 87/90DB

        .al
        .autsiz
        .databank $7E

        lda #MenuOptionHidden
        sta $4F42,b

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne _End

          lda #ChestKey
          jsl rlCheckInventoryForItem
          bcs +

            jsl rlCheckInventoryForUsableLockpick
            bcc _End

          +
          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0
          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1
          jsl rlGetMapTileIndexByCoords
          tax
          lda aVisibilityMap,x
          and #$00FF
          beq _End

          lda aTerrainMap,x
          and #$00FF
          cmp #TerrainIndoorChest
          beq +

            cmp #TerrainOutdoorChest
            beq +

        _End
        lda $4F42,b
        rtl

        +
        lda #MenuOptionValid
        sta $4F42,b
        rtl

        .databank 0

      rlActionMenuChestOptionAInput ; 87/9130

        .al
        .autsiz
        .databank $7E

        phx
        jsl rlMenuClearActiveMenus
        jsl rlActionMenuClearBackgrounds
        jsl rlUnknownGetMapTileCoordsBySelectedUnit
        jsl rlRunChapterLocationEvents
        jsl rlActionCommandDecreaseLockpickUses
        bcs +

          lda #ChestKey
          jsl rlActionCommandDecreaseItemUses

        +
        plx

        lda #<>rlFreeProcAndUpdateCursorCoordinates
        sta aProcSystem.aBody4,b,x
        lda #<>rlDelayUntilActionFinished
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlActionMenuArenaOptionAvailabilityCheck ; 87/915C

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne _Hidden

          lda $4F98,b
          bit #$0002
          bne _Hidden

            lda aSelectedCharacterBuffer.X,b
            and #$00FF
            sta wR0
            lda aSelectedCharacterBuffer.Y,b
            and #$00FF
            sta wR1
            jsl rlGetMapTileIndexByCoords
            tax
            lda aVisibilityMap,x
            and #$00FF
            beq _Hidden

              lda aTerrainMap,x
              and #$00FF
              cmp #TerrainArena
              beq +
              bra _Hidden
              
                +
                lda aSelectedCharacterBuffer.Status,b
                and #$00FF
                cmp #StatusSilence
                beq _Hidden

                  lda aSelectedCharacterBuffer.Class,b
                  jsl $85EF88

                  lda $2F
                  beq _Hidden

                    lda #MenuOptionValid
                    rtl

        _Hidden
        lda #MenuOptionHidden
        rtl

        .databank 0

      rlActionMenuArenaOptionAInput ; 87/91B4

        .al
        .autsiz
        .databank ?

        lda #$00E0
        jsl $808C7D
        lda #$000D
        sta wUnknown000E25,b
        lda #(`procActionMenu)<<8
        sta lR44+1
        lda #<>procActionMenu
        sta lR44
        jsl rlProcEngineFindProc
        bcc +

          stz aProcSystem.aHeaderTypeOffset,b,x
        
        +
        jsl $80BB73
        lda #3
        rtl

        .databank 0

      rlActionMenuAnimationOptionAvailabilityCheck ; 87/91DC

        .al
        .autsiz
        .databank $7E

        lda aOptions.wAnimation
        cmp #2
        bne +

          lda #MenuOptionValid
          rtl

        +
        lda #MenuOptionHidden
        rtl

        .databank 0

      rlActionMenuAnimationOptionAInput ; 87/91EC

        .al
        .autsiz
        .databank ?

        phx
        lda #(`procAnimationMenu)<<8
        sta lR44+1
        lda #<>procAnimationMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        rtl

        .databank 0

      procAnimationMenu .block ; 87/91FD

        .dstruct structProcInfo, None, rlProcAnimationMenuInit, rlProcAnimationMenuCycle, None

      .bend

      aMapAnimationMenu ; 87/9205

        .word <>aMapAnimationMenuOnOption
        .word <>aMapAnimationMenuOffOption
        .word 0

      aMapAnimationMenuOnOption ; 87/920B

        .long 0
        .long 0
        .long 0
        .long rlMapAnimationMenuOnOptionAInput
        .long rlMapAnimationMenuOptionBInput
        .long 0
        .enc "SJIS"
        .text "　リアル\n"

      aMapAnimationMenuOffOption ; 87/9227

        .long 0
        .long 0
        .long 0
        .long rlMapAnimationMenuOffOptionAInput
        .long rlMapAnimationMenuOptionBInput
        .long 0
        .text "　マップ\n"

      rlProcAnimationMenuInit ; 87/9243

        .al
        .autsiz
        .databank $7E

        php 
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda aActiveMenuSlots
        jsl rlMenuCopyActiveMenuCopyCurrentSlotToTemp
        lda aActiveMenuTemp.Position.Y
        clc
        adc aActiveMenuTemp.BG1Info.Size.H
        and #$00FF
        cmp #22
        bcc +

          lda #22
        
        +
        sta wR1

        lda #<>aMapAnimationMenu
        sta $2F
        lda #>`aMapAnimationMenu
        sta $2F+1
        lda $C123,b
        sta wR0
        lda #6
        sta wR2
        jsl rlCreateMenu
        sta aProcSystem.aHeaderUnknownTimer,b,x

        jsl rlMenuSetActiveMenu
        jsl rlMenuDrawAllMenusFromBuffers
        lda aActiveMenuTemp.Position.X
        and #$00FF
        clc
        adc #6
        sta wR0

        lda aActiveMenuTemp.Position.Y
        and #$00FF
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc wR0
        asl a
        tay
        lda #$22EF
        stz aProcSystem.aBody7,b,x

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMapAnim
        beq +

          lda #2
          sta aProcSystem.aBody7,b,x

        +
        plb
        plp
        rtl

        .databank 0

      rlProcAnimationMenuCycle ; 87/92BE

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlCheckIfHighestPriorityMenu
        bcc +

          lda aProcSystem.aHeaderUnknownTimer,b,x
          jsl rlMenuCopyActiveMenuCopyCurrentSlotToTemp
          jsl rlActionMenuInputHandler

        +
        rtl

        .databank 0

      rlMapAnimationMenuOnOptionAInput ; 87/92D3

        .al
        .autsiz
        .databank ?

        lda aSelectedCharacterBuffer.UnitState,b
        and #~UnitStateMapAnim
        sta aSelectedCharacterBuffer.UnitState,b

        lda aSelectedCharacterBuffer.DeploymentNumber,b
        and #$00FF
        sta wR0
        lda #<>aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber

        lda aBurstWindowCharacterBuffer.UnitState,b
        and #~UnitStateMapAnim
        sta aBurstWindowCharacterBuffer.UnitState,b

        lda #<>aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataFromBuffer

      rlMapAnimationMenuOptionBInput ; 87/92FF

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlProcEngineFreeProc
        rtl

        .databank 0

      rlMapAnimationMenuOffOptionAInput ; 87/930B

        .al
        .autsiz
        .databank ?

        lda aSelectedCharacterBuffer.UnitState,b
        ora #UnitStateMapAnim
        sta aSelectedCharacterBuffer.UnitState,b

        lda aSelectedCharacterBuffer.DeploymentNumber,b
        and #$00FF
        sta wR0
        lda #<>aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber

        lda aBurstWindowCharacterBuffer.UnitState,b
        ora #UnitStateMapAnim
        sta aBurstWindowCharacterBuffer.UnitState,b

        lda #<>aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataFromBuffer
        bra rlMapAnimationMenuOptionBInput

        .databank 0

      rlActionMenuCheckForDancableUnits ; 87/9339

        .al
        .autsiz
        .databank ?

        phx
        stz $A7AD,b
        lda #<>rlActionMenuCheckForDancableUnitsEffect
        sta lR25
        lda #>`rlActionMenuCheckForDancableUnitsEffect
        sta lR25+1
        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0
        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1
        jsl rlGetMapTileIndexByCoords
        tax
        jsl rlRunRoutineForTilesIn1Range
        ldx $A7AD,b
        stz $A7AF,b,x
        plx
        rtl

        .databank 0

      rlActionMenuCheckForDancableUnitsEffect ; 87/9368

        .al
        .autsiz
        .databank $7E

        lda aPlayerVisibleUnitMap,x
        and #$00FF  
        beq _End

          jsl rlCheckIfAllegianceMatchesPhase
          bcs _End

            sta wR0
            lda #<>aTargetingCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            lda aTargetingCharacterBuffer.UnitState,b
            bit #UnitStateGrayed
            beq _End

              lda aTargetingCharacterBuffer.Status,b
              and #$00FF
              cmp #StatusPetrify
              beq _End

                cmp #StatusSleep
                beq _End

                  ldx $A7AD,b
                  lda aTargetingCharacterBuffer.DeploymentNumber,b
                  and #$00FF
                  sta $A7AF,b,x
                  inc x
                  inc x
                  stx $A7AD,b

        _End
        rtl

        .databank 0

      rlActionMenuDanceOptionAvailabilityCheck ; 87/93AB

        .al
        .autsiz
        .databank ?

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne _Hidden

          lda aSelectedCharacterBuffer.Skills1,b
          bit #Skill1Dance
          beq _Hidden

            jsl rlActionMenuCheckForDancableUnits

            lda $A7AD,b
            beq _Hidden

              lda #MenuOptionValid
              rtl

        _Hidden
        lda #MenuOptionHidden
        rtl

        .databank 0

      rlActionMenuDanceOptionAInput ; 87/93CC

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlProcEngineFreeProc

        phx
        lda #(`procDanceCommand)<<8
        sta lR44+1
        lda #<>procDanceCommand
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        rtl

        .databank 0

      procDanceCommand .block ; 87/93E8

        .dstruct structProcInfo, "dk", rlProcDanceCommandInit, rlProcTalkDanceCommandCycle, None

      .bend

      aDanceCommandInputRoutines ; 87/93F0

        .long 0
        .long rlProcDanceCommandAInput
        .long rlProcTalkDanceCommandBInput
        .long 0

      rlProcDanceCommandInit ; 87/93FC

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda #$FFFF
        sta wTerrainWindowSide
        jsl rlActionMenuCheckForDancableUnits
        stz aProcSystem.aBody7,b,x

        lda $A7AF,b
        sta wR0
        lda #<>aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber
        jsl rlCreateAllyInteractionMenuEffect

        lda #<>aDanceCommandInputRoutines
        sta lR18
        lda #>`aDanceCommandInputRoutines
        sta lR18+1
        jsl $858E43
        plb
        plp
        rtl

        .databank 0

      rlProcDanceCommandAInput ; 87/9436

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlMenuDrawAllMenusFromBuffers

        phx
        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        lda aProcSystem.aBody7,b,x
        tax
        lda $A7AF,b,x
        sta wR0
        lda #<>aActionStructUnit2
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber
        jsl rlActionStructDance
        plx

        lda #<>rlUnknown87995E
        sta aProcSystem.aBody4,b,x
        lda #<>rlDelayUntilActionFinished
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlActionMenuMountOptionAvailabilityCheck ; 87/9474

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne _Hidden

        lda wUnknown7E4F98
        bit #$0001
        bne _Hidden

        lda aSelectedCharacterBuffer.Skills1,b
        bit #Skill1Mount
        bne +

        lda #MenuOptionHidden
        rtl
        
        +
        lda aSelectedCharacterBuffer.Class,b
        jsl rlCheckIfClassCanDismount
        bcc +

        _Hidden
        lda #MenuOptionHidden
        rtl

        +
        lda aMountedClassTable,x
        and #$00FF
        sta wR3
        jsl rlCopyTerrainMovementCostBuffer

        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0
        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1
        jsl rlGetMapTileIndexByCoords
        tax
        lda aTerrainMap,x
        and #$00FF
        tay
        lda aTerrainMovementCostBuffer-1,y
        bmi _Hidden

        lda #MenuOptionValid
        rtl

        .databank 0

      rlActionMenuDismountOptionAvailabilityCheck ; 87/94CF

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne _Hidden

        lda wUnknown7E4F98
        bit #$0001
        bne _Hidden

        lda aSelectedCharacterBuffer.Skills1,b
        bit #Skill1Mount
        bne +

        lda #MenuOptionHidden
        rtl
        
        +
        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateRescuing
        bne _Hidden
        
        lda aSelectedCharacterBuffer.Class,b
        jsl rlCheckIfClassCanDismount
        bcs +
        
        _Hidden
        lda #MenuOptionHidden
        rtl
        
        +
        lda aDismountedClassTable,x
        and #$00FF
        sta wR3
        jsl rlCopyTerrainMovementCostBuffer
        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0
        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1
        jsl rlGetMapTileIndexByCoords
        tax
        lda aTerrainMap,x
        and #$00FF
        tay
        lda aTerrainMovementCostBuffer-1,y
        bmi _Hidden

        lda #MenuOptionValid
        rtl

        .databank 0

      rlActionMenuMountOptionAInput ; 87/9532

        .al
        .autsiz
        .databank $7E

        stz aProcSystem.aBody7,b,x
        dec wUnknown7E4F96

        lda wUnknown7E4F98
        ora #$0001
        sta wUnknown7E4F98

        jsl $83AE5F
        jsr rsUnknown8795F2
        rtl

        .databank 0

      rlActionMenuDismountOptionAInput ; 87/9549

        .al
        .autsiz
        .databank $7E

        stz aProcSystem.aBody7,b,x
        dec wUnknown7E4F96

        lda wUnknown7E4F98
        ora #$0001
        sta wUnknown7E4F98

        jsl $83AEAE
        jsr rsUnknown8795F2
        rtl

        .databank 0

      rlUnknown879560 ; 87/9560

        .al
        .autsiz
        .databank $7E

        ; wR1 has unit pointer

        ldy #structCharacterDataRAM.Skills1
        lda (wR1),y
        bit #Skill1Mount
        beq _End

        ldy #structCharacterDataRAM.Class
        lda (wR1),y
        sta wR17
        jsl rlCheckIfClassCanDismount
        bcc _End

        sep #$20
        lda aDismountedClassTable,x
        ldy wR1
        sta structCharacterDataRAM.Class,b,y
        jsl rlCopyClassDataToBuffer
        lda $50FC,b
        sta structCharacterDataRAM.SpriteInfo,b,y

        lda structCharacterDataRAM.Class,b,y
        xba
        lda wR17

        phy
        jsl rlUpdateMountDismountSkills
        ply

        rep #$30
        lda structCharacterDataRAM.X,b,y
        and #$00FF
        sta wR0
        lda structCharacterDataRAM.Y,b,y
        and #$00FF
        sta wR1
        lda structCharacterDataRAM.Class,b,y
        and #$00FF
        sta wR3

        phy
        jsr rsUnknown8795C6
        ply

        sep #$20

        lda wR0
        sta structCharacterDataRAM.X,b,y
        lda wR1
        sta structCharacterDataRAM.Y,b,y

        _End
        rep #$30
        rtl

        .databank 0

      rsUnknown8795C6 ; 87/95C6

        .al
        .autsiz
        .databank $7E

        jsl rlCopyTerrainMovementCostBuffer
        jsl rlGetMapTileIndexByCoords
        tax
        lda aTerrainMap,x
        and #$00FF
        tay
        lda aTerrainMovementCostBuffer-1,y
        bmi +

        rts
        
        +
        lda wR0
        sta wActiveTileUnitParameter1
        lda wR1
        sta wActiveTileUnitParameter2
        jsl rlActionStructStaffGetClosestStandableTile
        lda $400A,b
        jsl rlGetMapCoordsByTileIndex
        rts

        .databank 0

      rsUnknown8795F2 ; 87/95F2

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.DeploymentNumber,b
        and #$00FF
        sta wR0

        lda #aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber

        sep #$20
        lda aSelectedCharacterBuffer.SpriteInfo1,b
        sta aBurstWindowCharacterBuffer.SpriteInfo1,b
        lda aSelectedCharacterBuffer.Skills1,b
        sta aBurstWindowCharacterBuffer.Skills1,b
        lda aSelectedCharacterBuffer.Class,b
        sta aBurstWindowCharacterBuffer.Class,b
        rep #$30

        lda aSelectedCharacterBuffer.SpriteInfo2,b
        sta aBurstWindowCharacterBuffer.SpriteInfo2,b

        lda #aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataFromBuffer
        jsl $8A9013

        lda #aSelectedCharacterBuffer
        sta wR1
        jsl $83A89D

        jsl $8A8D9C
        rts

        .databank 0

      rlActionMenuWaitOptionAvailabilityCheck ; 87/963A

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0

        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1

        jsl rlGetMapTileIndexByCoords
        tax
        sep #$20
        lda aPlayerVisibleUnitMap,x
        beq +

        cmp aSelectedCharacterBuffer.DeploymentNumber,b
        beq +

        rep #$30
        lda #MenuOptionHidden
        rtl

        +
        rep #$30
        lda #MenuOptionValid
        rtl

        .databank 0

      rlActionMenuDropOptionAvailabilityCheck ; 87/9667

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne _Hidden

          bit #UnitStateRescuing
          beq _Hidden

            lda aSelectedCharacterBuffer.Rescue,b
            jsl rlCheckIfTargetableAllegiance
            bcs _Hidden

              jsr rsCheckIfTargetDroppable
              bcc _Hidden

                lda #MenuOptionValid
                rtl

        _Hidden
        lda #MenuOptionHidden
        rtl

        .databank 0

      rsCheckIfTargetDroppable ; 87/968A

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.Rescue,b
        sta wR0
        lda #aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber

        lda aBurstWindowCharacterBuffer.Class,b
        and #$00FF
        sta wR3
        jsl rlCopyTerrainMovementCostBuffer

        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0
        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1
        jsl rlGetMapTileIndexByCoords
        tax
        lda #<>rlCheckIfTargetDroppableEffect
        sta lR25
        lda #>`rlCheckIfTargetDroppableEffect
        sta lR25+1
        stz $A7AD,b
        jsl rlRunRoutineForTilesIn1Range

        lda $A7AD,b
        beq +

          sec
          rts

        +
        clc
        rts

        .databank 0

      rlCheckIfTargetDroppableEffect ; 87/96D3

        .al
        .autsiz
        .databank $7E

        lda aPlayerVisibleUnitMap,x
        and #$00FF
        bne +

          lda aTerrainMap,x
          and #$00FF
          tay
          lda aTerrainMovementCostBuffer-1,y
          bmi +

            ldy $A7AD,b
            txa
            sta $A7AF,b,y
            inc y
            inc y
            sty $A7AD,b

        +
        rtl

        .databank 0

      rlActionMenuDropOptionAInput ; 87/96F4

        .al
        .autsiz
        .databank $7E

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlProcEngineFreeProc

        phx
        lda #(`procDropCommand)<<8
        sta lR44+1
        lda #<>procDropCommand
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        lda #<>aBG1TilemapBuffer
        sta wR0
        lda #$02FF
        jsl rlFillTilemapByWord

        lda #<>aBG3TilemapBuffer
        sta wR0
        lda #$01DF
        jsl rlFillTilemapByWord

        jsl rlEnableBG1Sync
        jsl rlEnableBG3Sync
        rtl

        .databank 0

      aDropCommandInputRoutines ; 87/9730

        .long 0
        .long rlProcDropCommandAInput
        .long rlProcDropCommandBInput
        .long 0

      procDropCommand .block ; 87/973C

        .dstruct structProcInfo, None, rlProcDropCommandInit, rlProcDropCommandCycle, None

      .bend

      rlProcDropCommandInit ; 87/9744

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda #<>aDropCommandInputRoutines
        sta lR18
        lda #>`aDropCommandInputRoutines
        sta lR18+1
        jsl $858E43

        jsr rsCheckIfTargetDroppable

        lda #1
        sta $4F59,b
        plb
        plp
        rtl

        .databank 0

      rlProcDropCommandCycle ; 87/9768

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        jsl $858E7F

        plb
        plp
        rtl

        .databank 0

      rlProcDropCommandBInput ; 87/9779

        .al
        .autsiz
        .databank $7E

        jsl rlProcEngineFreeProc

        phx
        lda #(`procActionMenu)<<8
        sta lR44+1
        lda #<>procActionMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        rtl

        .databank 0

      rlProcDropCommandAInput ; 87/978E

        .al
        .autsiz
        .databank $7E

        phx
        lda aSelectedCharacterBuffer.Rescue,b
        sta wR0
        lda #aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber

        lda aProcSystem.aBody7,b,x
        tax
        lda $A7AF,b,x
        jsl rlGetMapCoordsByTileIndex

        sep #$20
        lda wR0
        sta aBurstWindowCharacterBuffer.X,b
        lda wR1
        sta aBurstWindowCharacterBuffer.Y,b
        lda #$0A
        sta bUnknown7E4FCF
        lda aBurstWindowCharacterBuffer.DeploymentNumber,b
        sta $4FCE,b
        rep #$30

        lda #aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataFromBuffer
        plx

        lda #<>rlFreeProcAndUpdateCursorCoordinates
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlUnknown8797D2 ; 87/97D2

        .al
        .autsiz
        .databank $7E

        phx
        lda #<>aBG1TilemapBuffer
        sta wR0
        lda #$02FF
        jsl rlFillTilemapByWord

        lda #<>aBG3TilemapBuffer
        sta wR0
        lda #$01DF
        jsl rlFillTilemapByWord

        jsl rlEnableBG1Sync
        jsl rlEnableBG3Sync

        lda #aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataFromBuffer
        plx
        jmp rlFreeProcAndUpdateCursorCoordinates

        .databank 0

      rlCheckIfTargetRescuable ; 87/9800

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        phx
        stz $A7AD,b

        lda #<>rlCheckIfTargetRescuableEffect
        sta lR25
        lda #>`rlCheckIfTargetRescuableEffect
        sta lR25+1

        lda aSelectedCharacterBuffer.UnitState,b
        bit #(UnitStateRescued | UnitStateRescuing)
        bne +

          lda #aSelectedCharacterBuffer
          sta wR1
          jsl rlGetEffectiveConstitution
          sta wR17
          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0
          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1
          jsl rlGetMapTileIndexByCoords
          tax
          jsl rlRunRoutineForTilesIn1Range

          ldx $A7AD,b
          stz $A7AF,b,x

        +
        plx
        plb
        plp
        rtl

        .databank 0

      rlCheckIfTargetRescuableEffect ; 87/984E

        .al
        .autsiz
        .databank $7E

        lda aPlayerVisibleUnitMap,x
        and #$00FF
        beq +

          jsl rlCheckIfAllegianceDoesNotMatchPhaseTarget
          bcs +

            sta wR0
            lda #aTargetingCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            lda aTargetingCharacterBuffer.UnitState,b
            bit #(UnitStateRescued | UnitStateRescuing | UnitStateHidden)
            bne +

              lda #aTargetingCharacterBuffer
              sta wR1
              jsl rlGetEffectiveConstitution
              cmp wR17
              bcs +

                ldx $A7AD,b
                lda aTargetingCharacterBuffer.DeploymentNumber,b
                and #$00FF
                sta $A7AF,b,x
                inc x
                inc x
                stx $A7AD,b

        +
        rtl

        .databank 0

      rlActionMenuRescueOptionAvailabilityCheck ; 87/988E

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne +

          jsl rlCheckIfTargetRescuable

          lda $A7AD,b
          beq +

            lda #MenuOptionValid
            rtl

        +
        lda #MenuOptionHidden
        rtl

        .databank 0

      rlActionMenuRescueOptionAInput ; 87/98A7

        .al
        .autsiz
        .databank $7E

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlProcEngineFreeProc

        phx
        lda #(`procRescueCommand)<<8
        sta lR44+1
        lda #<>procRescueCommand
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        lda #3
        sta $4F44,b
        rtl

        .databank 0

      procRescueCommand .block ; 87/98C9

        .dstruct structProcInfo, None, rlProcRescueCommandInit, rlProcRescueCommandCycle, None

      .bend

      aRescueCommandInputRoutines ; 87/98D1

        .long 0
        .long rlProcRescueCommandAInput
        .long rlMapItemMenuBInput
        .long 0

      rlProcRescueCommandInit ; 87/98DD

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        jsl rlCheckIfTargetRescuable
        stz aProcSystem.aBody7,b,x

        lda $A7AF,b
        sta wR0
        lda #aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber

        lda #$FFFF
        sta wTerrainWindowSide
        jsl rlCreateAllyInteractionMenuEffect

        lda #<>aRescueCommandInputRoutines
        sta lR18
        lda #>`aRescueCommandInputRoutines
        sta lR18+1
        jsl $858E43

        plb
        plp
        rtl

        .databank 0

      rlProcRescueCommandCycle ; 87/9917

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlCheckIfHighestPriorityMenu
        bcc +

          jsl rlCreateAllyInteractionMenu

        +
        plb
        plp
        rtl

        .databank 0

      rlProcRescueCommandAInput ; 87/9931

        .al
        .autsiz
        .databank $7E

        phx
        lda aProcSystem.aBody7,b,x
        tax
        lda $A7AF,b,x
        sta $4FCE,b

        lda #1
        sta wCapturingFlag

        sep #$20
        lda #4
        sta bUnknown7E4FCF
        rep #$20

        plx

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlMenuDrawAllMenusFromBuffers

        lda #<>rlFreeProcAndUpdateCursorCoordinates
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlUnknown87995E ; 87/995E

        .al
        .autsiz
        .databank $7E

        jmp rlFreeProcActionMenu

      rlEvaluateGiveTakeDirection ; 87/9961

        .al
        .autsiz
        .databank $7E

        ; wR0 = giver X
        ; wR1 = giver Y
        ; wR2 = taker X
        ; wR3 = taker Y

        php
        sep #$20
        tdc
        lda wR0
        cmp wR2
        beq ++
        bcc +

        ; leftwards
        lda #2
        bra _End
        
        ; rightwards
        +
        lda #4
        bra _End

        +
        lda wR1
        cmp wR3
        bcc +

        ; upwards
        lda #3
        bra _End
        
        ; downwards
        +
        lda #1
        
        _End
        plp
        rtl

        .databank 0

      rlDelayUntilActionFinished ; 87/9983

        .al
        .autsiz
        .databank $7E

        lda wMapBattleFlag
        ora wEventEngineStatus,b
        bne +

          lda aProcSystem.aBody4,b,x
          sta aProcSystem.aHeaderOnCycle,b,x
          sta wR0
          jmp (wR0)

        +
        rtl

        .databank 0

      rlUnknown879998 ; 87/9998

        .al
        .autsiz
        .databank $7E

        lda wMapBattleFlag
        ora wEventEngineStatus,b
        bne +

          phx
          jsl $8593EB
          jsl rlDMABurstWindowTiles
          plx

          lda aProcSystem.aBody4,b,x
          sta aProcSystem.aHeaderOnCycle,b,x
          sta wR0
          jmp (wR0)
        
        +
        rtl

        .databank 0

      rlActionMenuStealOptionAvailabilityCheck ; 87/99B7

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne _Hidden

          lda aSelectedCharacterBuffer.Skills1,b
          bit #Skill1Steal
          beq _Hidden

            jsl rlCheckIfTargetsStealable

            lda $A7AD,b
            beq _Hidden

              lda #MenuOptionValid
              rtl

        _Hidden
        lda #MenuOptionHidden
        rtl

        .databank 0

      rlCheckIfTargetsStealable ; 87/99D8

        .al
        .autsiz
        .databank $7E

        lda #aSelectedCharacterBuffer
        sta wR0
        lda #aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer
        jsl rlCombineCharacterDataAndClassBases

        lda aBurstWindowCharacterBuffer.Speed,b
        and #$00FF
        sta wR17

        stz $A7AD,b

        lda #<>rlCheckIfTargetsStealableEffect
        sta lR25
        lda #>`rlCheckIfTargetsStealableEffect
        sta lR25+1
        lda aSelectedCharacterBuffer.X,b
        and #$00FF  
        sta wR0
        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1
        jsl rlGetMapTileIndexByCoords
        tax
        jsl rlRunRoutineForTilesIn1Range

        ldx $A7AD,b
        stz $A7AF,b,x
        rtl

        .databank 0

      rlCheckIfTargetsStealableEffect ; 87/9A1F

        .al
        .autsiz
        .databank $7E

        lda aPlayerVisibleUnitMap,x
        and #$00FF
        beq _End

          jsl rlCheckIfAllegianceDoesNotMatchPhaseTarget
          bcc _End

            sta wR0
            lda #<>aBurstWindowCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            lda aBurstWindowCharacterBuffer.Class,b
            and #$00FF
            cmp #Ballistician
            beq _End

              cmp #BallisticianIron
              beq _End

                cmp #BallisticianPoison
                beq _End

                  lda #<>aBurstWindowCharacterBuffer
                  sta wR1
                  jsl rlCombineCharacterDataAndClassBases

                  lda aBurstWindowCharacterBuffer.Speed,b
                  and #$00FF
                  cmp wR17
                  bcs _End

                    lda aBurstWindowCharacterBuffer.Item1ID,b
                    ora aSelectedCharacterBuffer.Item1ID,b
                    beq _End

                      ldx $A7AD,b
                      lda aBurstWindowCharacterBuffer.DeploymentNumber,b
                      and #$00FF
                      sta $A7AF,b,x
                      inc x
                      inc x
                      stx $A7AD,b

        _End
        rtl

        .databank 0

      rlActionMenuStealOptionAInput ; 87/9A7A

        .al
        .autsiz
        .databank $7E

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlProcEngineFreeProc

        jsl rlCheckIfTargetsStealable

        lda #1
        sta wTradeWindowType

        phx
        lda #(`procTradeMenu)<<8
        sta lR44+1
        lda #<>procTradeMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        lda #3
        rtl

        .databank 0

      rlCheckIfTargetsCapturable ; 87/9AA3

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        stz $A7AD,b

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateRescuing
        bne _End

        lda #<>rlCheckIfTargetsCapturableEffect
        sta lR25
        lda #>`rlCheckIfTargetsCapturableEffect
        sta lR25+1
        lda #aSelectedCharacterBuffer
        sta wR1
        jsl rlGetEffectiveConstitution
        sta wR17

        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0
        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1
        jsl rlGetMapTileIndexByCoords
        tax
        jsl rlRunRoutineForTilesIn1Range

        ldx $A7AD,b
        stz $A7AF,b,x
        
        _End
        plb
        plp
        rtl

        .databank 0

      rlCheckIfTargetsCapturableEffect ; 87/9AEF

        .al
        .autsiz
        .databank $7E

        lda aPlayerVisibleUnitMap,x
        and #$00FF
        beq _End

          jsl rlCheckIfAllegianceDoesNotMatchPhaseTarget
          bcc _End

            sta wR0
            lda #<>aTargetingCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            lda aTargetingCharacterBuffer.UnitState,b
            bit #UnitStateHidden
            bne _End

              lda aTargetingCharacterBuffer.Skills2,b
              bit #Skill2Unknown ; Anchor
              bne _End

                lda #<>aTargetingCharacterBuffer
                sta wR1
                jsl rlGetEffectiveConstitution
                cmp wR17
                bcs _End

                ldx $A7AD,b
                lda aTargetingCharacterBuffer.DeploymentNumber,b
                and #$00FF
                sta $A7AF,b,x
                inc x
                inc x
                stx $A7AD,b

        _End
        rtl

        .databank 0

      rlActionMenuCaptureOptionAvailabilityCheck ; 87/9B37

        .al
        .autsiz
        .databank $7E

        lda #MenuOptionHidden
        sta $4F42,b

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne +

          lda #<>rlCheckIfItemCanCapture
          sta lR25
          lda #>`rlCheckIfItemCanCapture
          sta lR25+1
          lda #<>aSelectedCharacterBuffer.Items
          jsl rlRunRoutineForAllItemsInInventory

        +
        lda $4F42,b
        rtl

        .databank 0

      rlCheckIfItemCanCapture ; 87/9B5A

        .al
        .autsiz
        .databank $7E

        ldx lR25
        phx
        ldx lR25+1
        phx

        jsl rlCopyItemDataToBuffer

        lda aItemDataBuffer.Traits,b
        bit #TraitWeapon
        beq +

          lda aItemDataBuffer.Range,b
          and #$000F
          cmp #1
          bne +

            lda #<>aSelectedCharacterBuffer
            sta wR1

            jsl rlCheckItemEquippable
            bcc +

              jsl rlCheckIfTargetsCapturable

              lda $A7AD,b
              beq +

                lda #MenuOptionValid
                sta $4F42,b

                stz $A7AD,b

        +
        pla
        sta lR25+1
        pla
        sta lR25
        rtl

        .databank 0

      procCaptureWeaponSelect .block ; 87/9B9B

        .dstruct structProcInfo, "WS", rlProcCaptureWeaponSelectInit, rlProcCaptureWeaponSelectCycle, None

      .bend

      aCaptureWeaponSelectMenu ; 87/9BA3

        .word <>aCaptureWeaponSelectMenuOption
        .word <>aCaptureWeaponSelectMenuOption
        .word <>aCaptureWeaponSelectMenuOption
        .word <>aCaptureWeaponSelectMenuOption
        .word <>aCaptureWeaponSelectMenuOption
        .word <>aCaptureWeaponSelectMenuOption
        .word <>aCaptureWeaponSelectMenuOption
        .word 0

      aCaptureWeaponSelectMenuOption  ; 87/9BB3

        .long rlCaptureWeaponSelectMenuOptionDisplayCheck
        .long rlMapWeaponSelectMenuDrawItemDataByOffset
        .long rlGetItemDelayed
        .long rlCaptureWeaponSelectMenuAInput
        .long rlMapItemMenuBInput
        .long 0
        .enc "SJIS"
        .text "　\n"

      rlCaptureWeaponSelectMenuOptionDisplayCheck ; 87/9BC9

        .al
        .autsiz
        .databank ?

        lda #MenuOptionHidden
        sta $4F42,b

        lda wSelectedMenuOptionOffset
        tax
        lda aSelectedCharacterBuffer.Items,b,x
        jsl rlCheckIfItemCanCapture

        lda $4F42,b
        rtl

        .databank 0

      rlProcCaptureWeaponSelectInit ; 87/9BDF

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        stz aProcSystem.aBody7,b,x

        lda #$FFFF
        sta wCapturingFlag

        phx
        lda aSelectedCharacterBuffer.Character,b
        sta wR0
        lda #0
        jsl rlDrawBGPortraitByCharacter
        jsl rlClearIconArray
        plx

        lda #3
        sta wR0
        lda #9
        sta wR1
        lda #15
        sta wR2
        lda #<>aCaptureWeaponSelectMenu
        sta lR18
        lda #>`aCaptureWeaponSelectMenu
        sta lR18+1
        jsl rlCreateMenu
        sta aProcSystem.aHeaderUnknownTimer,b,x

        jsl rlMenuSetActiveMenu

        lda aMenuOptions
        and #$00FF
        tax
        lda aSelectedCharacterBuffer.Items,b,x
        sta $4F55,b

        phx
        lda #(`procItemView)<<8
        sta lR44+1
        lda #<>procItemView
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        sep #$20
        lda #$12
        sta bBufferTM
        rep #$20

        plb
        plp
        rtl

        .databank 0

      rlProcCaptureWeaponSelectCycle ; 87/9C50

        .al
        .autsiz
        .databank $7E

        phx
        lda #(`procItemSelectPortrait)<<8
        sta lR44+1
        lda #<>procItemSelectPortrait
        sta lR44
        jsl rlProcEngineFindProc
        plx

        bcc +

        rtl
        
        +
        lda #0
        sta aProcSystem.aBody6,b,x
        lda #<>_9C6F
        sta aProcSystem.aHeaderOnCycle,b,x

        _9C6F
        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda #<>rlProcCaptureWeaponSelectCycle2
        sta aProcSystem.aHeaderOnCycle,b,x
        jsl rlMenuDrawAllMenusFromBuffers
        jsr rsDrawPortraitToBG1
        jsl $8A8126

        sep #$20
        lda #$17
        sta $A1
        rep #$20

        plb
        plp
        rtl

        .databank 0

      rlProcCaptureWeaponSelectCycle2 ; 87/9C95

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        jsl $8A8126

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlCheckIfHighestPriorityMenu
        bcc +

          lda aProcSystem.aHeaderUnknownTimer,b,x
          jsl rlMenuCopyActiveMenuCopyCurrentSlotToTemp
          jsl rlActionMenuInputHandler

        +
        plb
        plp
        rtl

        .databank 0

      rlCaptureWeaponSelectMenuAInput ; 87/9CBA

        .al
        .autsiz
        .databank $7E

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlProcEngineFreeProc
        jsl rlKillItemView

        phx
        jsl rlClearIconArray
        ldx wSelectedMenuOptionOffset
        stx $4F4A,b
        lda aSelectedCharacterBuffer.Items,b,x
        jsl rlCopyItemDataToBuffer
        jsl rlCheckIfTargetsCapturable
        plx

        phx
        lda #(`procBattleForecast)<<8
        sta lR44+1
        lda #<>procBattleForecast
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        lda #0
        rtl

        .databank 0

      rlActionMenuReleaseOptionAvailabilityCheck ; 87/9CF4

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne +

          lda aSelectedCharacterBuffer.Rescue,b
          and #$00FF
          beq +

            jsl rlCheckIfTargetableAllegiance
            bcc +

              lda #MenuOptionValid
              rtl

        +
        lda #MenuOptionHidden
        rtl

        .databank 0

      rlActionMenuReleaseOptionAInput ; 87/9D12

        .al
        .autsiz
        .databank $7E

        lda #<>rlFreeProcAndUpdateCursorCoordinates
        sta aProcSystem.aBody4,b,x
        lda #<>rlDelayUntilActionFinished
        sta aProcSystem.aHeaderOnCycle,b,x

        lda aSelectedCharacterBuffer.Rescue,b
        and #$00FF
        sta wR0
        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber
        jsl rlActionStructUnknownSetCallback
        jsl $8EB80E
        stz aActionStructUnit1.Character

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCopyCharacterDataFromBuffer

        lda aSelectedCharacterBuffer.UnitState,b
        and #~UnitStateRescuing
        sta aSelectedCharacterBuffer.UnitState,b

        sep #$20
        stz aSelectedCharacterBuffer.Rescue,b
        rep #$30

        jsl $8593EB

      rlActionMenuClearBackgrounds ; 87/9D57

        .al
        .autsiz
        .databank $7E

        lda #<>aBG1TilemapBuffer
        sta wR0
        lda #$02FF
        jsl rlFillTilemapByWord
        jsl rlEnableBG1Sync

        lda #<>aBG3TilemapBuffer
        sta wR0
        lda #$01DF
        jsl rlFillTilemapByWord
        jsl rlEnableBG3Sync
        rtl

        .databank 0

      rlActionMenuSupplyOptionAvailabilityCheck ; 87/9D78

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne _HideOption

        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0

        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1

        jsl rlGetMapTileIndexByCoords
        tax
        lda aVisibilityMap,x
        and #$00FF
        beq _HideOption

        lda aTerrainMap,x
        and #$00FF
        cmp #TerrainSupply
        beq _ValidOption

        _HideOption
        lda #MenuOptionHidden
        rtl

        _ValidOption
        lda #MenuOptionValid
        rtl

        .databank 0

      rlActionMenuSupplyOptionAInput ; 87/9DB0

        .al
        .autsiz
        .databank $7E

        lda #$000D
        sta wUnknown000E25,b

        lda #(`procActionMenu)<<8
        sta lR44+1
        lda #<>procActionMenu
        sta lR44
        jsl rlProcEngineFindProc
        bcc +

          stz aProcSystem.aHeaderTypeOffset,b,x
        
        +
        lda #<>$80A02F
        sta $A4EC,b
        lda #>`$80A02F
        sta $A4EC+1,b
        jsl $80BA1F
        lda #3
        rtl

        .databank 0

      rlActionMenuGiveOptionAvailabilityCheck ; 87/9DDD

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne +

          jsl rlCheckIfHeldUnitGivable

          lda $A7AD,b
          beq +

            lda #MenuOptionValid
            rtl

        +
        lda #MenuOptionHidden
        rtl

        .databank 0

      rlCheckIfHeldUnitGivable ; 87/9DF6

        .al
        .autsiz
        .databank $7E

        phx
        stz $A7AD,b

        lda aSelectedCharacterBuffer.Rescue,b
        and #$00FF
        beq _End

          sta wR0
          lda #<>aBurstWindowCharacterBuffer
          sta wR1
          jsl rlCopyCharacterDataToBufferByDeploymentNumber
          lda #<>aBurstWindowCharacterBuffer
          sta wR1
          jsl rlGetEffectiveConstitution
          sta aBurstWindowCharacterBuffer.Constitution,b

          lda #<>rlCheckIfHeldUnitGivableEffect
          sta lR25
          lda #>`rlCheckIfHeldUnitGivableEffect
          sta lR25+1
          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0
          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1
          jsl rlGetMapTileIndexByCoords
          tax
          jsl rlRunRoutineForTilesIn1Range

        _End
        ldx $A7AD,b
        stz $A7AF,b,x
        plx
        rtl

        .databank 0

      rlCheckIfHeldUnitGivableEffect ; 87/9E44

        .al
        .autsiz
        .databank $7E

        lda aPlayerVisibleUnitMap,x
        and #$00FF
        beq +

          jsl rlCheckIfAllegianceDoesNotMatchPhase
          bcs +

            sta wR0
            lda #<>aTargetingCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber
            lda aTargetingCharacterBuffer.Rescue,b
            and #$00FF
            bne +

              lda #<>aTargetingCharacterBuffer
              sta wR1
              jsl rlGetEffectiveConstitution
              cmp aBurstWindowCharacterBuffer.Constitution,b
              beq +
              bcc +

                ldx $A7AD,b
                lda aTargetingCharacterBuffer.DeploymentNumber,b
                and #$00FF
                sta $A7AF,b,x
                inc x
                inc x
                stx $A7AD,b

        + 
        rtl

        .databank 0

      rlActionMenuGiveOptionAInput ; 87/9E87

        .al
        .autsiz
        .databank $7E

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlProcEngineFreeProc

        phx
        lda #(`procGiveCommand)<<8
        sta lR44+1
        lda #<>procGiveCommand
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        lda #3
        sta $4F44,b
        rtl

        .databank 0

      procGiveCommand .block ; 87/9EA9

        .dstruct structProcInfo, None, rlProcGiveCommandInit, rlProcGiveCommandCycle, None

      .bend

      aGiveCommandInputRoutines ; 87/9EB1

        .long 0
        .long rlProcGiveCommandAInput
        .long rlMapItemMenuBInput
        .long 0

      rlProcGiveCommandInit ; 87/9EBD

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        jsl rlCheckIfHeldUnitGivable
        stz aProcSystem.aBody7,b,x

        lda $A7AF,b
        sta wR0
        lda #<>aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber

        lda #$FFFF
        sta wTerrainWindowSide
        jsl rlCreateAllyInteractionMenuEffect

        lda #<>aGiveCommandInputRoutines
        sta lR18
        lda #>`aGiveCommandInputRoutines
        sta lR18+1
        jsl $858E43

        lda #<>aSelectedCharacterBuffer
        sta wR14
        jsl rlGetEffectiveMove
        sta wUnknown000E1F,b

        plb
        plp
        rtl

        .databank 0

      rlProcGiveCommandCycle ; 87/9F03

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlCheckIfHighestPriorityMenu
        bcc +

          jsl rlCreateAllyInteractionMenu
        
        +
        plb
        plp
        rtl

        .databank 0

      rlProcGiveCommandAInput ; 87/9F1D

        .al
        .autsiz
        .databank $7E

        ; aSelectedCharacterBuffer = previous holder
        ; aItemSkillCharacterBuffer = new holder
        ; aTemporaryActionStruct = held unit

        lda #<>rlProcGiveCommandCycle2
        sta aProcSystem.aHeaderOnCycle,b,x

        dec $4F96,b

        lda aProcSystem.aBody7,b,x
        tax
        lda $A7AF,b,x
        sta wR0
        lda #<>aItemSkillCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber

        lda aSelectedCharacterBuffer.Rescue,b
        sta wR0
        lda #<>aTemporaryActionStruct 
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber

        lda aSelectedCharacterBuffer.UnitState,b
        and #~UnitStateRescuing
        sta aSelectedCharacterBuffer.UnitState,b

        lda aTemporaryActionStruct.UnitState,b
        and #~UnitStateRescued
        ora #UnitStateHidden
        sta aTemporaryActionStruct.UnitState,b

        sep #$20
        lda aSelectedCharacterBuffer.Rescue,b
        sta aItemSkillCharacterBuffer.Rescue,b
        stz aSelectedCharacterBuffer.Rescue,b

        lda aItemSkillCharacterBuffer.DeploymentNumber,b
        sta aTemporaryActionStruct.Rescue,b
        lda aSelectedCharacterBuffer.X,b
        sta wR0
        lda aSelectedCharacterBuffer.Y,b
        sta wR1
        lda aItemSkillCharacterBuffer.X,b
        sta wR2
        lda aItemSkillCharacterBuffer.Y,b
        sta wR3
        jsl rlEvaluateGiveTakeDirection
        rep #$30

        ora #$FF00
        sta aMovementDirectionArray

        lda #<>aTemporaryActionStruct
        sta wR1
        jsl rlCopyCharacterDataFromBuffer

        lda aSelectedCharacterBuffer.UnitState,b
        ora #UnitStateHidden
        sta aSelectedCharacterBuffer.UnitState,b

        lda #<>aSelectedCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataFromBuffer

        lda aSelectedCharacterBuffer.UnitState,b
        and #~UnitStateHidden
        sta aSelectedCharacterBuffer.UnitState,b

        lda #<>aTemporaryActionStruct
        sta wR1
        jsl $83A89D
        
        lda #<>aMovementDirectionArray
        sta lR18
        lda #>`aMovementDirectionArray
        sta lR18+1
        jsl $8A8D0D
        jsl rlRegisterAllMapSpritesAndStatus

        sep #$20
        lda #$12
        sta $A1
        rep #$20

        rtl

        .databank 0

      rlProcGiveCommandCycle2 ; 87/9FD4

        .al
        .autsiz
        .databank $7E

        phx
        lda #(`$8A8D1C)<<8
        sta lR44+1
        lda #<>$8A8D1C
        sta lR44
        jsl rlProcEngineFindProc
        plx

        bcc +

        rtl

        +
        phx
        lda aItemSkillCharacterBuffer.Coordinates,b
        sta aTemporaryActionStruct.Coordinates,b

        lda aItemSkillCharacterBuffer.UnitState,b
        ora #UnitStateRescuing
        sta aItemSkillCharacterBuffer.UnitState,b

        lda aTemporaryActionStruct.UnitState,b
        ora #UnitStateRescued
        sta aTemporaryActionStruct.UnitState,b

        lda #<>aTemporaryActionStruct
        sta wR1
        jsl rlCopyCharacterDataFromBuffer

        lda #<>aItemSkillCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataFromBuffer
        jsl rlRegisterAllMapSpritesAndStatus
        jsr rsUnknown87A26A
        plx

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlProcEngineFreeProc

        sep #$20
        lda #$17
        sta $A1
        rep #$20

        phx
        lda #(`procActionMenu)<<8
        sta lR44+1
        lda #<>procActionMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        rtl

        .databank 0

      rlActionMenuTakeOptionAvailabilityCheck ; 87/A03E

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne +

          jsl rlCheckIfUnitTakable

          lda $A7AD,b
          beq +

            lda #MenuOptionValid
            rtl

        +
        lda #MenuOptionHidden
        rtl

        .databank 0

      rlCheckIfUnitTakable ; 87/A057

        .al
        .autsiz
        .databank $7E

        phx
        stz $A7AD,b
        lda aSelectedCharacterBuffer.Rescue,b
        and #$00FF
        bne +

          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlGetEffectiveConstitution
          sta aBurstWindowCharacterBuffer.Constitution,b

          lda #<>rlCheckIfUnitTakableEffect
          sta lR25
          lda #>`rlCheckIfUnitTakableEffect
          sta lR25+1
          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0
          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1
          jsl rlGetMapTileIndexByCoords
          tax
          jsl rlRunRoutineForTilesIn1Range
        
        +
        ldx $A7AD,b
        stz $A7AF,b,x
        plx
        rtl

        .databank 0

      rlCheckIfUnitTakableEffect ; 87/A09A

        .al
        .autsiz
        .databank $7E

        lda aPlayerVisibleUnitMap,x
        and #$00FF
        beq +

          jsl rlCheckIfAllegianceDoesNotMatchPhase
          bcs +

            sta wR0
            lda #<>aTargetingCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            lda aTargetingCharacterBuffer.Rescue,b
            and #$00FF
            beq +

              sta wR0
              lda #<>aTemporaryActionStruct
              sta wR1
              jsl rlCopyCharacterDataToBufferByDeploymentNumber

              lda #<>aTemporaryActionStruct
              sta wR1
              jsl rlGetEffectiveConstitution
              cmp aBurstWindowCharacterBuffer.Constitution,b
              bcs +

                ldx $A7AD,b
                lda aTargetingCharacterBuffer.DeploymentNumber,b
                and #$00FF
                sta $A7AF,b,x
                inc x
                inc x
                stx $A7AD,b

        +
        rtl

        .databank 0

      rlActionMenuTakeOptionAInput ; 87/A0E6

        .al
        .autsiz
        .databank $7E

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlProcEngineFreeProc

        phx
        lda #(`procTakeCommand)<<8
        sta lR44+1
        lda #<>procTakeCommand
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        lda #3
        sta $4F44,b
        rtl

        .databank 0

      procTakeCommand .block ; 87/A108

        .dstruct structProcInfo, None, rlProcTakeCommandInit, rlProcTakeCommandCycle, None

      .bend

      aTakeCommandInputRoutines ; 87/A110

        .long 0
        .long rlProcTakeCommandAInput
        .long rlMapItemMenuBInput
        .long 0

      rlProcTakeCommandInit ; 87/A11C

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        jsl rlCheckIfUnitTakable
        stz aProcSystem.aBody7,b,x

        lda $A7AF,b
        sta wR0
        lda #<>aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber

        lda #$FFFF
        sta wTerrainWindowSide
        jsl rlCreateAllyInteractionMenuEffect

        lda #<>aTakeCommandInputRoutines
        sta lR18
        lda #>`aTakeCommandInputRoutines
        sta lR18+1
        jsl $858E43

        lda #<>aSelectedCharacterBuffer
        sta wR14
        jsl rlGetEffectiveMove
        sta wUnknown000E1F,b

        plb
        plp
        rtl

        .databank 0

      rlProcTakeCommandCycle ; 87/A162

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlCheckIfHighestPriorityMenu
        bcc +

          jsl rlCreateAllyInteractionMenu
        
        +
        plb
        plp
        rtl

        .databank 0

      rlProcTakeCommandAInput ; 87/A17C

        .al
        .autsiz
        .databank $7E

        lda #<>rlProcTakeCommandCycle2
        sta aProcSystem.aHeaderOnCycle,b,x

        dec $4F96,b

        lda aProcSystem.aBody7,b,x
        tax
        lda $A7AF,b,x
        sta wR0
        lda #<>aItemSkillCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber

        lda aItemSkillCharacterBuffer.Rescue,b
        sta wR0
        lda #<>aTemporaryActionStruct
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber

        lda aItemSkillCharacterBuffer.UnitState,b
        and #~UnitStateRescuing
        sta aItemSkillCharacterBuffer.UnitState,b

        lda aSelectedCharacterBuffer.UnitState,b
        ora #UnitStateRescuing
        sta aSelectedCharacterBuffer.UnitState,b

        lda aTargetingCharacterBuffer.UnitState,b
        and #~UnitStateRescued
        ora #UnitStateHidden
        sta aTargetingCharacterBuffer.UnitState,b

        sep #$20
        lda aItemSkillCharacterBuffer.Rescue,b
        sta aSelectedCharacterBuffer.Rescue,b
        stz aItemSkillCharacterBuffer.Rescue,b

        lda aSelectedCharacterBuffer.DeploymentNumber,b
        sta aTemporaryActionStruct.Rescue,b
        lda aItemSkillCharacterBuffer.X,b
        sta wR0
        lda aItemSkillCharacterBuffer.Y,b
        sta wR1
        lda aSelectedCharacterBuffer.X,b
        sta wR2
        lda aSelectedCharacterBuffer.Y,b
        sta wR3
        jsl rlEvaluateGiveTakeDirection
        rep #$30

        ora #$FF00
        sta aMovementDirectionArray

        lda #<>aTemporaryActionStruct
        sta wR1
        jsl rlCopyCharacterDataFromBuffer

        lda #<>aItemSkillCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataFromBuffer

        lda #<>aTemporaryActionStruct
        sta wR1
        jsl $83A89D

        lda #<>aMovementDirectionArray
        sta lR18
        lda #>`aMovementDirectionArray
        sta lR18+1
        jsl $8A8D0D
        jsl rlRegisterAllMapSpritesAndStatus

        sep #$20
        lda #$12
        sta $A1
        rep #$20

        rtl

        .databank 0

      rlProcTakeCommandCycle2 ; 87/A22A

        .al
        .autsiz
        .databank $7E

        phx
        lda #(`$8A8D1C)<<8
        sta lR44+1
        lda #<>$8A8D1C
        sta lR44
        jsl rlProcEngineFindProc
        plx

        bcc +
        
        rtl
        
        +
        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlProcEngineFreeProc

        sep #$20
        lda #$17
        sta $A1
        rep #$20

        phx
        lda #(`procActionMenu)<<8
        sta lR44+1
        lda #<>procActionMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        phx
        jsl rlRegisterAllMapSpritesAndStatus
        jsr rsUnknown87A26A
        plx

        rtl

        .databank 0

      rsUnknown87A26A ; 87/A26A

        .al
        .autsiz
        .databank $7E

        lda #<>aSelectedCharacterBuffer
        sta wR14
        jsl rlGetEffectiveMove
        sta wR1
        lda wUnknown000E1F,b
        sta wR0
        jsl $83A29B
        rts

        .databank 0

      rlCheckInventoryForItem ; 87/A27F

        .al
        .autsiz
        .databank $7E

        sta wR0

        ldx #0
        
        -
        lda aSelectedCharacterBuffer.Items,b,x
        and #$00FF
        cmp wR0
        beq +

        inc x
        inc x
        cpx #size(structCharacterDataRAM.Items)
        bne -

        clc
        rtl
        
        +
        sec
        rtl

        .databank 0

      rlCheckInventoryForUsableLockpick ; 87/A299

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.Skills1,b
        bit #Skill1Steal
        beq +

        ldx #0

        -
        lda aSelectedCharacterBuffer.Items,b,x
        and #$00FF
        cmp #Lockpick
        beq ++

        inc x
        inc x
        cpx #size(structCharacterDataRAM.Items)
        bne -
        
        +
        clc
        rtl
        
        +
        sec
        rtl

        .databank 0

      rlActionCommandDecreaseLockpickUses ; 87/A2BA

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.Skills1,b
        bit #Skill1Steal
        beq +

          jsl rlCheckInventoryForUsableLockpick
          bcc +

            lda aSelectedCharacterBuffer.Items,b,x
            jsl rlTryGetBrokenItemID
            sta aSelectedCharacterBuffer.Items,b,x

            lda #<>aSelectedCharacterBuffer
            sta wR1
            jsl rlFillInventoryHoles

            sec
            rtl

        +
        clc
        rtl

        .databank 0

      rlActionCommandDecreaseItemUses ; 87/A2DF

        .al
        .autsiz
        .databank $7E

        jsl rlCheckInventoryForItem

        ; freeze if you somehow managed to lose the item you needed to get here?

        -
        bcc -

        lda aSelectedCharacterBuffer.Items,b,x
        jsl rlTryGetBrokenItemID
        sta aSelectedCharacterBuffer.Items,b,x

        lda #<>aSelectedCharacterBuffer
        sta wR1
        jsl rlFillInventoryHoles
        rtl

        .databank 0

      rlActionMenuStaffOptionAInput ; 87/A2F9

        .al
        .autsiz
        .databank $7E

        jsl rlProcEngineFreeProc

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu

        lda #$FFFF
        sta wTerrainWindowSide

        phx
        lda #(`procStaffMenu)<<8
        sta lR44+1
        lda #<>procStaffMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        lda #3
        rtl

        .databank 0

      rlActionMenuStaffOptionAvailabilityCheck ; 87/A31E

        .al
        .autsiz
        .databank $7E

        lda #MenuOptionHidden
        sta $4F42,b

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne +

          lda #<>rlCheckForUsableStavesEffect
          sta lR25
          lda #>`rlCheckForUsableStavesEffect
          sta lR25+1
          lda #<>aSelectedCharacterBuffer.Items
          jsl rlRunRoutineForAllItemsInInventory

        +
        lda $4F42,b
        rtl

        .databank 0

      rlCheckForUsableStavesEffect ; 87/A341

        .al
        .autsiz
        .databank $7E

        jsl rlCopyItemDataToBuffer

        lda aItemDataBuffer.Traits,b
        bit #TraitStaff
        beq _End

          lda aItemDataBuffer.UseEffect,b
          and #$00FF
          beq _End

            lda #<>aSelectedCharacterBuffer
            sta wR1
            jsl rlCheckItemEquippable
            bcc _End

              jsl rlGetItemUseAvailabilityPointer

              lda lR25
              pha
              lda lR25+1
              pha

              phk
              pea #<>(+)-1
              jml [lR18]

              +
              bcc +

                lda #MenuOptionValid
                sta $4F42,b

              +
              pla
              sta lR25+1
              pla
              sta lR25

        _End
        rtl

        .databank 0

      procStaffMenu .block ; 87/A380

        .dstruct structProcInfo, "rs", rlProcStaffMenuInit, rlProcStaffMenuCycle, None

      .bend

      aStaffSelectMenu ; 87/A388

        .word <>aStaffSelectMenuOption
        .word <>aStaffSelectMenuOption
        .word <>aStaffSelectMenuOption
        .word <>aStaffSelectMenuOption
        .word <>aStaffSelectMenuOption
        .word <>aStaffSelectMenuOption
        .word <>aStaffSelectMenuOption
        .word 0

      aStaffSelectMenuOption ; 87/A398

        .long rlStaffSelectMenuOptionDisplayCheck
        .long rlMapWeaponSelectMenuDrawItemDataByOffset
        .long rlGetItemDelayed
        .long rlStaffSelectMenuAInput
        .long rlMapItemMenuBInput
        .long 0
        .enc "SJIS"
        .text "　\n"

      rlStaffSelectMenuOptionDisplayCheck ; 87/A3AE

        .al
        .autsiz
        .databank ?

        lda #MenuOptionHidden
        sta $4F42,b

        lda wSelectedMenuOptionOffset
        tax
        lda aSelectedCharacterBuffer.Items,b,x
        jsl rlCheckForUsableStavesEffect

        lda $4F42,b
        rtl

        .databank 0

      rlProcStaffMenuInit ; 87/A3C4

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        stz aProcSystem.aBody7,b,x

        phx
        lda aSelectedCharacterBuffer.Character,b
        sta wR0
        lda #0
        jsl rlDrawBGPortraitByCharacter
        jsl rlClearIconArray
        plx

        lda #3
        sta wR0
        lda #9
        sta wR1
        lda #15
        sta wR2
        lda #<>aStaffSelectMenu
        sta lR18
        lda #>`aStaffSelectMenu
        sta lR18+1
        jsl rlCreateMenu
        sta aProcSystem.aHeaderUnknownTimer,b,x

        jsl rlMenuSetActiveMenu

        lda aMenuOptions
        and #$00FF
        tax
        lda aSelectedCharacterBuffer.Items,b,x
        sta $4F55,b

        phx
        lda #(`procItemView)<<8
        sta lR44+1
        lda #<>procItemView
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        sep #$20
        lda #$12
        sta $A1
        rep #$20

        plb
        plp
        rtl

        .databank 0

      rlProcStaffMenuCycle ; 87/A42F

        .al
        .autsiz
        .databank $7E

        phx
        lda #(`procItemSelectPortrait)<<8
        sta lR44+1
        lda #<>procItemSelectPortrait
        sta lR44
        jsl rlProcEngineFindProc
        plx

        bcc +

        rtl

        +
        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda #0
        sta aProcSystem.aBody6,b,x
        jsl $8A8126

        lda #<>rlProcStaffMenuCycle2
        sta aProcSystem.aHeaderOnCycle,b,x

        stz wCapturingFlag
        jsl rlMenuDrawAllMenusFromBuffers
        jsr rsDrawPortraitToBG1

        sep #$20
        lda #$17
        sta $A1
        rep #$20

        plb
        plp
        rtl

        .databank 0

      rlProcStaffMenuCycle2 ; 87/A471

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        jsl $8A8126

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlCheckIfHighestPriorityMenu
        bcc +

          lda aProcSystem.aHeaderUnknownTimer,b,x
          jsl rlMenuCopyActiveMenuCopyCurrentSlotToTemp
          jsl rlActionMenuInputHandler

        +
        plb
        plp
        rtl

        .databank 0

      rlStaffSelectMenuAInput ; 87/A496

        .al
        .autsiz
        .databank $7E

        phx
        stz aProcSystem.aBody7,b,x
        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlKillItemView
        jsl rlClearIconArray

        ldx wSelectedMenuOptionOffset
        stx $4F4A,b
        lda aSelectedCharacterBuffer.Items,b,x
        jsl rlCopyItemDataToBuffer
        jsl rlGetItemUseEffectPointer

        lda #<>aStaffTargetSelectMenuInputRoutines
        sta lR18
        lda #>`aStaffTargetSelectMenuInputRoutines
        sta lR18+1
        jsl $858E43
        plx

        lda #<>rlHandleUseEffectCycle
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      procItemView .block ; 87/A4D0

        .dstruct structProcInfo, "IV", rlProcItemViewInit, rlProcItemViewCycle, None

      .bend

      rlGetItemDelayed ; 87/A4D8

        .al
        .autsiz
        .databank $7E

        ldx wSelectedMenuOptionOffset
        lda aSelectedCharacterBuffer.Items,b,x
        sta aProcSystem.wInput0,b

        phx
        lda #(`procGetItemDelayed)<<8
        sta lR44+1
        lda #<>procGetItemDelayed
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        rtl

        .databank 0

      procGetItemDelayed .block ; 87/A4F2

        .dstruct structProcInfo, None, rlProcGetItemDelayedInit, rlProcGetItemDelayedCycle, None

      .bend

      rlProcGetItemDelayedInit ; 87/A4FA

        .al
        .autsiz
        .databank $7E

        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x
        rtl

        .databank 0

      rlProcGetItemDelayedCycle ; 87/A501

        .al
        .autsiz
        .databank $7E

        lda #<>rlProcGetItemDelayedCycle2
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlProcGetItemDelayedCycle2 ; 87/A508

        .al
        .autsiz
        .databank ?

        lda aProcSystem.wInput0,b
        sta $7E4F55
        jsl rlProcEngineFreeProc
        rtl

        .databank 0

      rlProcItemViewInit ; 87/A514

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        jsl $85853E

        pha
        jsl rlMenuCopyActiveMenuCopyCurrentSlotToTemp
        jsr rsUnknown87A5C3
        clc
        adc #10
        sta wR2
        lda #19
        sta wR0
        lda #9
        sta wR1
        lda #12
        sta wR3
        jsl rlMenuCreateActiveMenu
        sta aProcSystem.aHeaderUnknownTimer,b,x
        sta $4F57,b

        jsl rlMenuSetActiveMenu
        pla

        jsl rlMenuSetActiveMenu

        phx
        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aTargetingCharacterBuffer
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        lda #<>aTargetingCharacterBuffer
        sta wR1
        jsl rlGetEquippableItemInventoryOffset

        lda aItemDataBuffer.DisplayedWeapon,b
        and #$00FF
        beq +

        sta aTargetingCharacterBuffer.Item1ID,b

        lda #<>aTargetingCharacterBuffer
        sta wR0
        stz wR17
        jsl rlActionStructSingleEntry

        lda aActionStructUnit1.BattleMight
        and #$00FF
        sta $51D4,b
        lda aActionStructUnit1.BattleHit
        and #$00FF
        sta $51D6,b
        lda aActionStructUnit1.BattleAvoid
        and #$00FF
        sta $51D8,b
        lda aActionStructUnit1.BattleCrit
        and #$00FF
        sta $51DA,b
        bra ++

        +
        sep #$20
        lda #$FE
        sta $51D4,b
        sta $51D6,b
        sta $51D8,b
        sta $51DA,b

        +
        .as

        plx
        lda #3
        sta wJoyRepeatInterval
        lda #$FF
        sta aProcSystem.aBody4,b,x
        plb
        plp
        rtl

        .databank 0

      rsUnknown87A5C3 ; 87/A5C3

        .al
        .autsiz
        .databank $7E

        php
        sep #$20
        lda $4EEA,b
        cmp #10
        beq +
        bcc +

        lda #$80
        plp
        rts

        +
        lda #$80
        sta $4EE5,b
        rep #$20
        jsl rlMenuCopyActiveMenuCopyTempToCurrentSlot
        lda #0
        plp
        rts

        .databank 0

      rlProcItemViewCycle ; 87/A5E3

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda $4F55,b
        cmp #$FFFF
        beq +

        cmp aProcSystem.aBody4,b,x
        beq _End

        sta aProcSystem.aBody4,b,x
        lda #<>rlProcItemViewCycle2
        sta aProcSystem.aHeaderOnCycle,b,x
        
        _End
        plb
        plp
        rtl
        
        +
        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlProcEngineFreeProc
        bra _End

        .databank 0

      rlProcItemViewCycle2 ; 87/A613

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        phx
        lda aProcSystem.aBody4,b,x
        jsl rlCopyItemDataToBuffer

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuCopyActiveMenuCopyCurrentSlotToTemp

        lda #<>$7E4EF2
        sta aCurrentTilemapInfo.lInfoPointer,b
        lda #>`$7E4EF2
        sta aCurrentTilemapInfo.lInfoPointer+1,b
        jsr rsClearWeaponInfo

        lda aItemDataBuffer.DisplayedWeapon,b
        and #$00FF
        cmp #DrainedTome
        beq +

        lda aItemDataBuffer.Traits,b
        bit #TraitWeapon
        bne ++
        
        +
        jsr rsDrawItemStaffDescription
        bra ++
        
        +
        jsr rsDrawWeaponInfo
        
        +
        plx

        phx
        lda #<>rlProcItemViewCycle
        sta aProcSystem.aHeaderOnCycle,b,x

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuDrawSingleMenuFromBuffer
        plx

        plb
        plp
        rtl

        .databank 0

      rsDrawItemStaffDescription ; 87/A669

        .al
        .autsiz
        .databank $7E

        lda #$2180
        sta aCurrentTilemapInfo.wBaseTile,b
        lda #>`aItemData
        sta lR18+1
        lda aItemDataBuffer.Description,b
        beq +

          sta lR18
          ldx #$0101
          jsl rlDrawMultilineMenuText

        +
        rts

        .databank 0

      rsDrawWeaponInfo ; 87/A683

        .al
        .autsiz
        .databank $7E

        lda #$2180
        sta aCurrentTilemapInfo.wBaseTile,b

        lda #<>aWeaponInfoText
        sta lR18
        lda #>`aWeaponInfoText
        sta lR18+1
        ldx #$0102
        jsl rlDrawMultilineMenuText

        lda aItemDataBuffer.Type,b
        and #$00FF
        and #$000F
        clc
        adc #$00A7
        sta wR2
        lda #24
        sta wR0
        lda #10
        sta wR1
        lda #$0C00
        sta wR3
        jsl rlDrawSingleIcon

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aTargetingCharacterBuffer
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        lda $4F55,b
        sta aTargetingCharacterBuffer.Item1ID,b

        lda #<>aTargetingCharacterBuffer
        sta wR0
        stz wR17
        jsl rlActionStructSingleEntry

        lda aActionStructUnit1.BattleMight
        and #$00FF
        sta wR0
        lda $51D4,b
        sta wR1
        ldx #$0307
        jsr rsDrawBattleStatChange

        lda aActionStructUnit1.BattleHit
        and #$00FF
        sta wR0
        lda $51D6,b
        sta wR1
        ldx #$0507
        jsr rsDrawBattleStatChange

        lda aActionStructUnit1.BattleAvoid
        and #$00FF
        sta wR0
        lda $51D8,b
        sta wR1
        ldx #$0907
        jsr rsDrawBattleStatChange

        lda aActionStructUnit1.BattleCrit
        and #$00FF
        sta wR0
        lda $51DA,b
        sta wR1
        ldx #$0707
        jsr rsDrawBattleStatChange

        rts

        .databank 0

      aWeaponInfoText ; 87/A728

        .enc "SJIS"
        .text "属性　　\n"
        .text "攻撃　　\n"
        .text "命中　　\n"
        .text "必殺　　\n"
        .text "回避　　\n"
        .word 0

      rsDrawBattleStatChange ; 87/A75C

        .al
        .autsiz
        .databank $7E

        lda wR0
        cmp #$00FF
        beq _DoubleDash

        pha
        lda wR1
        cmp #$00FE
        beq _Neutral

        lda wR0
        cmp wR1
        beq +
        bcs _Higher
        
        +
        bcc _Lower
        
        _Neutral
        lda #<>_NeutralText
        bra +

        _Higher
        lda #<>_HigherText
        bra +
        
        _Lower
        lda #<>_LowerText
        
        +
        sta lR18

        lda #(`_Neutral)
        sta lR18+2

        phx
        lda #$2980
        sta aCurrentTilemapInfo.wBaseTile,b
        jsl rlDrawMenuText
        plx

        dec x
        lda #$2AA0
        sta aCurrentTilemapInfo.wBaseTile,b
        stz lR18+1

        pla
        sta lR18
        jsl rlDrawNumberMenuText
        rts

        _NeutralText .text "　\n"
        _HigherText .text "↑\n"
        _LowerText .text "↓\n"

        _DoubleDash
        lda #$2980
        sta aCurrentTilemapInfo.wBaseTile,b
        lda #<>$81D27F
        sta lR18
        lda #>`$81D27F
        sta lR18+1
        dec x
        dec x
        jsl rlDrawMenuText
        rts

        .databank 0

      rsClearWeaponInfo ; 87/A7C9

        .al
        .autsiz
        .databank $7E

        lda #$2180
        sta aCurrentTilemapInfo.wBaseTile,b

        lda #<>aWeaponInfoClearText
        sta lR18
        lda #>`aWeaponInfoClearText
        sta lR18+1
        ldx #$0101
        jsl rlDrawMultilineMenuText

        lda #$0018
        sta wR0
        lda #$000A
        sta wR1
        jsl $8A81D8
        rts

        .databank 0

      aWeaponInfoClearText ; 87/A7EF

        .text "　　　　　　　　\n"
        .text "　　　　　　　　\n"
        .text "　　　　　　　　\n"
        .text "　　　　　　　　\n"
        .text "　　　　　　　　\n"
        .word 0

      rlDrawPortraitToBG1 ; 87/A84B

        .al
        .autsiz
        .databank $7E

        lda #<>aBG1TilemapBuffer+$4A
        sta wR0
        jsl rlDrawPortraitSlot0Tilemap
        rtl

        .databank 0

      rsDrawPortraitToBG1 ; 87/A855

        .al
        .autsiz
        .databank $7E

        lda #<>aBG1TilemapBuffer+$4A
        sta wR0
        jsl rlDrawPortraitSlot0Tilemap
        rts

        .databank 0

      rlKillItemView ; 87/A85F
        
        .al
        .autsiz
        .databank $7E

        lda $4F57,b
        jsl rlMenuClearActiveMenu

        lda #(`procItemView)<<8
        sta lR44+1
        lda #<>procItemView
        sta lR44
        jsl rlProcEngineFindProc
        bcc +

          stz aProcSystem.aHeaderTypeOffset,b,x
        
        +
        lda #4
        sta wJoyRepeatInterval
        rtl

        .databank 0

      rlUnknown87A87F ; 87/A87F
        
        .al
        .autsiz
        .databank $7E

        ldy wR16
        phy

        lda #4
        sta wR16

        jmp ++

      rlMapMenuDrawItemData ; 87/A88A
        
        .al
        .autsiz
        .databank $7E

        ldy wR16
        phy

        ldy #0
        cmp #$0100
        beq +

          ldy #2

        +
        sty wR16
        
        +
        jsl rlGetItemNamePointer

        ; 0 = white, 2 = gray, 4 = yellow?
        ldx wR16
        lda $859BC4,x
        sta aCurrentTilemapInfo.wBaseTile,b

        lda wSelectedMenuOptionYPosition
        inc a
        xba
        and #$FF00
        clc
        adc #4
        tax
        phx
        lda #<>$7E4EF2
        sta aCurrentTilemapInfo.lInfoPointer,b
        lda #>`$7E4EF2
        sta aCurrentTilemapInfo.lInfoPointer+1,b
        jsl rlDrawMenuText

        lda wR16
        and #$0003
        sta aCurrentTilemapInfo.wBaseTile,b
        pla
        clc
        adc #9
        tax
        jsl rlDrawItemCurrentDurability
        lda wSelectedMenuOptionYPosition
        clc
        adc #10
        sta wR1
        lda #5
        sta wR0
        lda $0F51,b
        and #$00FF
        sta wR2
        lda #$0A00
        sta wR3
        jsl rlDrawSingleIcon
        pla
        sta wR16
        rtl

        .databank 0

      rlActionMenuItemsOptionAvailabilityCheck ; 87/A8FA
        
        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.UnitState,b
        bit #UnitStateMoved
        bne +

          lda aSelectedCharacterBuffer.Item1ID,b
          beq +

            lda #MenuOptionValid
            rtl

        +
        lda #MenuOptionHidden
        rtl

        .databank 0

      rlActionMenuItemsOptionAInput ; 87/A90F

        .al
        .autsiz
        .databank ?

        jsl rlProcEngineFreeProc

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu

        phx
        lda #(`procMapItemMenu)<<8
        sta lR44+1
        lda #<>procMapItemMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        rtl

        .databank 0

      procMapItemMenu .block ; 87/A92B

        .dstruct structProcInfo, None, rlProcMapItemMenuInit, rlProcMapItemMenuCycle1, None

      .bend

      aMapItemMenu ; 87/A933

        .word <>aMapItemMenuOption
        .word <>aMapItemMenuOption
        .word <>aMapItemMenuOption
        .word <>aMapItemMenuOption
        .word <>aMapItemMenuOption
        .word <>aMapItemMenuOption
        .word <>aMapItemMenuOption
        .word 0

      aMapItemMenuOption ; 87/A943

        .long rlMapItemMenuOptionDisplayCheck
        .long rlMapItemMenuDrawItemDataByOffset
        .long rlGetItemDelayed
        .long rlMapItemMenuAInput
        .long rlMapItemMenuBInput
        .long 0 ; X Input
        .enc "SJIS"
        .text "　\n"

      rlProcMapItemMenuInit ; 87/A959

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        ; Currently selected option
        stz aProcSystem.aBody7,b,x

        phx
        lda aSelectedCharacterBuffer.Character,b
        sta wR0
        lda #0
        jsl rlDrawBGPortraitByCharacter

        jsl rlClearIconArray
        plx

        ; X
        lda #3
        sta wR0

        ; Y
        lda #9
        sta wR1

        ; Width
        lda #15
        sta wR2

        lda #<>aMapItemMenu
        sta lR18
        lda #>`aMapItemMenu
        sta lR18+1
        jsl rlCreateMenu
        sta aProcSystem.aHeaderUnknownTimer,b,x

        jsl rlMenuSetActiveMenu

        lda aMenuOptions
        and #$00FF
        tax
        lda aSelectedCharacterBuffer.Items,b,x
        sta $4F55,b

        phx
        lda #(`procItemView)<<8
        sta lR44+1
        lda #<>procItemView
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        sep #$20
        lda #$12
        sta bBufferTM
        rep #$20

        plb
        plp
        rtl

        .databank 0

      rlProcMapItemMenuCycle1 ; 87/A9C4

        .al
        .autsiz
        .databank $7E

        phx
        lda #(`procItemSelectPortrait)<<8
        sta lR44+1
        lda #<>procItemSelectPortrait
        sta lR44
        jsl rlProcEngineFindProc
        plx
        bcc +

          rtl
        
        +
        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda #<>rlProcMapItemMenuCycle2
        sta aProcSystem.aHeaderOnCycle,b,x

        stz wCapturingFlag

        jsl rlMenuDrawAllMenusFromBuffers
        jsr rsDrawPortraitToBG1
        jsl $8A8126

        sep #$20
        lda #$17
        sta bBufferTM
        rep #$20

        plb
        plp
        rtl

        .databank 0

      rlProcMapItemMenuCycle2 ; 87/AA00

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

        jsl $8A8126

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlCheckIfHighestPriorityMenu
        bcc +

          lda aProcSystem.aHeaderUnknownTimer,b,x
          jsl rlMenuCopyActiveMenuCopyCurrentSlotToTemp
          jsl rlActionMenuInputHandler
          plb
          plp
          rtl

        +
        lda aProcSystem.aBody7,b,x
        clc
        adc #10
        asl a
        asl a
        asl a
        sta wR1
        lda #24
        sta wR0
        jsl rlDrawRightFacingStaticCursorHighPrio
        plb
        plp
        rtl

        .databank 0

      rlMapItemMenuOptionDisplayCheck ; 87/AA3D

        .al
        .autsiz
        .databank ?

        lda wSelectedMenuOptionOffset
        tax
        lda aSelectedCharacterBuffer.Items,b,x
        beq _HideOption

        jsl rlCopyItemDataToBuffer
        lda aItemDataBuffer.Traits,b
        bit #TraitStaff
        bne _GrayedOut

        bit #TraitWeapon
        bne +

        jsl rlMapItemMenuCheckIfItemUsable
        bcc _GrayedOut

        _ValidOption
        lda #MenuOptionValid
        rtl

        _GrayedOut
        lda #MenuOptionInvalid
        rtl

        +
        lda #<>aSelectedCharacterBuffer
        sta wR1
        jsl rlCheckItemEquippable
        bcs _ValidOption
        bra _GrayedOut

        _HideOption
        lda #MenuOptionHidden
        rtl

        .databank 0

      rlMapItemMenuCheckIfItemUsable ; 87/AA77

        .al
        .autsiz
        .databank ?

        lda aItemDataBuffer.UseEffect,b
        and #$00FF
        beq _End

          jsl rlGetItemUseAvailabilityPointer

          lda lR25
          pha
          lda lR25+1
          pha

          phk
          pea #<>(+)-1
          jmp [lR18]
          
          +
          pla
          sta lR25+1
          pla
          sta lR25
          rtl

        _End
        clc
        rtl

        .databank 0

      rlMapItemMenuDrawItemDataByOffset ; 87/AA99

        .al
        .autsiz
        .databank $7E

        ldy wSelectedMenuOptionOffset
        lda aSelectedCharacterBuffer.Items,b,y
        jsl rlCopyItemDataToBuffer

        lda aMenuOptions,y
        and #$FF00
        jsl rlMapMenuDrawItemData
        rtl

        .databank 0

      rlMapItemMenuAInput ; 87/AAAE

        .al
        .autsiz
        .databank $7E

        jsl rlKillItemView

        ldx wSelectedMenuOptionOffset
        stx $4F4A,b

        phx
        lda #(`procMapItemSubmenu)<<8
        sta lR44+1
        lda #<>procMapItemSubmenu
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        rtl

        .databank 0

      procMapItemSubmenu .block ; 87/AAC9

        .dstruct structProcInfo, None, rlProcMapItemSubmenuInit, rlProcMapItemSubmenuCycle, None

      .bend

      aMapItemSubmenu ; 87/AAD1

        .word <>aMapItemMenuUseOption
        .word <>aMapItemMenuEquipOption
        .word <>aMapItemMenuDiscardOption
        .word 0

      aMapItemMenuEquipOption ; 87/AAD9

        .long rlMapItemSubmenuEquipOptionDisplayCheck
        .long 0
        .long 0
        .long rlMapItemSubmenuEquipOptionSelected
        .long rlCloseMapItemSubmenu
        .long 0
        .enc "SJIS"
        .text "　装備\n"

      aMapItemMenuUseOption ; 87/AAF3

        .long rlMapItemSubmenuUseOptionDisplayCheck
        .long 0
        .long 0
        .long rlMapItemSubmenuUseOptionSelected
        .long rlCloseMapItemSubmenu
        .long 0
        .text "　使う\n"

      aMapItemMenuDiscardOption ; 87/AB0D

        .long rlMapItemSubmenuDiscardOptionDisplayCheck
        .long 0
        .long 0
        .long rlMapItemSubmenuDiscardOptionSelected
        .long rlCloseMapItemSubmenu
        .long 0
        .text "　すてる\n"

      rlProcMapItemSubmenuInit ; 87/AB29

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

        jsr rsUnknown87AB78

        lda #<>aMapItemSubmenu
        sta lR18
        lda #>`aMapItemSubmenu
        sta lR18+1

        ; X
        lda #19
        sta wR0

        ; Y
        lda #9
        sta wR1

        ; Width
        lda #6
        sta wR2
        jsl rlCreateMenu
        sta aProcSystem.aHeaderUnknownTimer,b,x

        jsr rsUnknown87AB96

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuSetActiveMenu
        jsl rlMenuDrawAllMenusFromBuffers
        jsr rsDrawPortraitToBG1

        lda #24
        sta wR0
        lda #10
        sta wR1
        jsl $8A81D8
        plb
        plp
        rtl

        .databank 0

      rsUnknown87AB78 ; 87/AB78

        .al
        .autsiz
        .databank $7E

        lda aActiveMenuSlots
        jsl rlMenuCopyActiveMenuCopyCurrentSlotToTemp

        lda aActiveMenuTemp.BG1Info.Size.H
        and #$00FF
        sta $4FA0,b

        sep #$20
        lda #0
        sta aActiveMenuTemp.ShadingDisabledFlag
        rep #$20

        jsl rlMenuCopyActiveMenuCopyTempToCurrentSlot
        rts

        .databank 0

      rsUnknown87AB96 ; 87/AB96

        .al
        .autsiz
        .databank $7E

        phx
        lda aActiveMenuTemp.BG1Info.Size.H
        and #$00FF
        cmp $4FA0,b
        bcs +

          sep #$20
          lda #$80
          sta aActiveMenuTemp.ShadingDisabledFlag
          rep #$20

          jsl rlMenuCopyActiveMenuCopyTempToCurrentSlot
        
        +
        plx
        rts

        .databank 0

      rlProcMapItemSubmenuCycle ; 87/ABB1

        .al
        .autsiz
        .databank ?

        ; Checks if its the active menu?

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        jsl $8A8126
        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlCheckIfHighestPriorityMenu
        bcc +

          lda aProcSystem.aHeaderUnknownTimer,b,x
          jsl rlMenuCopyActiveMenuCopyCurrentSlotToTemp
          jsl rlActionMenuInputHandler
          plb
          plp
          rtl

        +
        lda aProcSystem.aBody7,b,x
        clc
        adc #10
        asl a
        asl a
        asl a
        sta wR1
        lda #152
        sta wR0
        jsl rlDrawRightFacingStaticCursorHighPrio
        plb
        plp
        rtl

        .databank 0

      rlCloseMapItemSubmenu ; 87/ABEE

        .al
        .autsiz
        .databank ?

        jsl rlClearIconArray

        lda #<>rlMapItemSubmenuCloseProcCycle
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlMapItemSubmenuCloseProcCycle ; 87/ABF9

        .al
        .autsiz
        .databank ?

        jsl rlProcEngineFreeProc

        lda #(`procMapItemMenu)<<8
        sta lR44+1
        lda #<>procMapItemMenu
        sta lR44
        jsl rlProcEngineFindProc
        bcc +

          stz aProcSystem.aHeaderTypeOffset,b,x

        +
        jsl rlMenuClearActiveMenus

        phx
        lda #(`procMapItemMenu)<<8
        sta lR44+1
        lda #<>procMapItemMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        rtl

        .databank 0

      rlMapItemSubmenuUseOptionDisplayCheck ; 87/AC25

        .al
        .autsiz
        .databank ?

        ldy $4F4A,b
        lda aSelectedCharacterBuffer.Items,b,y
        jsl rlCopyItemDataToBuffer

        lda aItemDataBuffer.UseEffect,b
        and #$00FF
        beq ++

          lda aItemDataBuffer.Traits,b
          bit #TraitStaff
          bne ++

            jsl rlMapItemMenuCheckIfItemUsable
            bcc +
            
              lda #MenuOptionValid
              rtl

            +
            lda #MenuOptionInvalid
            rtl
        
        +
        lda #MenuOptionHidden
        rtl

        .databank 0

      rlMapItemSubmenuEquipOptionDisplayCheck ; 87/AC51

        .al
        .autsiz
        .databank ?

        ldy $4F4A,b
        lda aSelectedCharacterBuffer.Items,b,y
        jsl rlCopyItemDataToBuffer

        lda aItemDataBuffer.Traits,b
        bit #TraitWeapon
        beq +

          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCheckItemEquippable
          bcc +
          
            lda #MenuOptionValid
            rtl

        +
        lda #MenuOptionHidden
        rtl

        .databank 0

      rlMapItemSubmenuDiscardOptionDisplayCheck ; 87/AC76

        .al
        .autsiz
        .databank ?

        ldy $4F4A,b
        lda aSelectedCharacterBuffer.Items,b,y
        jsl rlCopyItemDataToBuffer

        lda aItemDataBuffer.Traits,b
        bit #TraitUnsellable
        bne +

          lda #MenuOptionValid
          rtl

        +
        lda #MenuOptionInvalid
        rtl

        .databank 0

      rlMapItemSubmenuUseOptionSelected ; 87/AC90

        .al
        .autsiz
        .databank $7E

        ; Currently selected option
        phx
        lda aProcSystem.aBody7,b,x
        tax
        lda aMenuOptions,x
        plx
        bit #MenuOptionInvalid
        beq +

          ; Command is selected, but grayed out so play a beep
          jmp rlMapItemSubmenuDiscardOptionSelected._MapItemSubmenuOptionDenied

        +
        phx
        lda #(`procMapItemMenu)<<8
        sta lR44+1
        lda #<>procMapItemMenu
        sta lR44
        jsl rlProcEngineFindProc
        bcc +

          stz aProcSystem.aHeaderTypeOffset,b,x
        
        +
        jsl rlMenuClearActiveMenus
        jsl rlMenuDrawAllMenusFromBuffers
        jsl rlClearIconArray

        ldy $4F4A,b
        lda aSelectedCharacterBuffer.Items,b,y
        pha
        jsl rlCopyItemDataToBuffer
        pla
        jsl rlTryGetBrokenItemID
        sta aSelectedCharacterBuffer.Items,b,y
        lda #<>aSelectedCharacterBuffer
        sta wR1
        jsl rlFillInventoryHoles

        jsl rlGetItemUseEffectPointer
        plx
        lda #<>rlHandleUseEffectCycle
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlMapItemSubmenuEquipOptionSelected ; 87/ACE9

        .al
        .autsiz
        .databank ?

        phx
        lda #<>aSelectedCharacterBuffer
        sta wR1
        lda $4F4A,b
        jsl $83C1C5
        plx

        jsl rlProcEngineFreeProc

        lda #(`procMapItemMenu)<<8
        sta lR44+1
        lda #<>procMapItemMenu
        sta lR44
        jsl rlProcEngineFindProc
        bcc +

          stz aProcSystem.aHeaderTypeOffset,b,x
        
        +
        jsl rlMenuClearActiveMenus

        phx
        lda #(`procActionMenu)<<8
        sta lR44+1
        lda #<>procActionMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plx

        rtl

        .databank 0

      rlMapItemSubmenuDiscardOptionSelected ; 87/AD23

        .al
        .autsiz
        .databank $7E

        lda aProcSystem.aBody7,b,x
        tax
        lda aMenuOptions,x
        bit #MenuOptionInvalid
        bne _MapItemSubmenuOptionDenied

          phx
          lda #(`procMapItemDiscardSubmenu)<<8
          sta lR44+1
          lda #<>procMapItemDiscardSubmenu
          sta lR44
          jsl rlProcEngineCreateProc
          plx
          rtl
        
        _MapItemSubmenuOptionDenied
        lda #0
        sta $4F44,b

        lda #34
        jsl rlPlaySound
        rtl

        .databank 0

      procMapItemDiscardSubmenu .block ; 87/AD4E

        .dstruct structProcInfo, None, rlProcMapItemDiscardSubmenuInit, rlProcMapItemDiscardSubmenuCycle, None

      .bend

      aMapItemDiscardSubmenu ; 87/AD56

        .word <>aMapItemDiscardYesOption
        .word <>aMapItemDiscardNoOption
        .word 0

        .enc "SJIS"

      aMapItemDiscardYesOption ; 87/AD5C

        .long 0
        .long 0
        .long 0
        .long rlMapItemMenuDiscardYesAInput
        .long $8A8788
        .long 0
        
        .text "　はい\n"

      aMapItemDiscardNoOption ; 87/AD76

        .long 0
        .long 0
        .long 0
        .long $8A8788
        .long $8A8788
        .long 0
        .text "　いいえ\n"

      rlProcMapItemDiscardSubmenuInit ; 87/AD92

        .al
        .autsiz
        .databank $7E

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        lda aActiveMenuSlots+2
        jsl rlMenuCopyActiveMenuCopyCurrentSlotToTemp

        ; Y pos
        lda aActiveMenuTemp.Position.Y
        clc
        adc aActiveMenuTemp.BG3Info.Size.H
        dec a
        dec a
        and #$00FF
        sta wR1

        pha
        lda #<>aMapItemDiscardSubmenu
        sta lR18
        lda #>`aMapItemDiscardSubmenu
        sta lR18+1

        ; X
        lda #20
        sta wR0

        ; Width
        lda #6
        sta wR2
        jsl rlCreateMenu
        sta aProcSystem.aHeaderUnknownTimer,b,x

        jsl rlMenuSetActiveMenu
        jsl rlMenuDrawAllMenusFromBuffers

        lda #2
        sta aProcSystem.aBody7,b,x

        lda #<>$F4F580
        sta lR18
        lda #>`$F4F580
        sta lR18+1
        lda #6
        sta wR0
        lda #1
        sta wR1

        pla
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc #<>$E7A4
        sta lR19

        stz aCurrentTilemapInfo.wBaseTile,b

        jsl rlDrawTilemapPackedRect
        jsr rsUnknown87AE31
        jsr rsDrawPortraitToBG1
        plb
        plp
        rtl

        .databank 0

      rlProcMapItemDiscardSubmenuCycle ; 87/AE0C

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

        jsl $8A8126

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlCheckIfHighestPriorityMenu
        bcc +

          lda aProcSystem.aHeaderUnknownTimer,b,x
          jsl rlMenuCopyActiveMenuCopyCurrentSlotToTemp
          jsl rlActionMenuInputHandler

        +
        plb
        plp
        rtl

        .databank 0

      rsUnknown87AE31 ; 87/AE31

        .al
        .autsiz
        .databank ?

        sep #$20
        ldx #27

        -
        lda $C107,b,x
        bne +

        dec x
        bra -
        
        +
        rep #$30
        phx
        jsl $8591F0

        lda #9 ; HDMA Y 
        sta wR0

        pla
        sec
        sbc #8
        sta wR1 ; HDMA height
        jsl $859219 ; HDMA
        jsl $859205 ; HDMA
        rts

        .databank 0

        ; 87/AE5A

    .endsection ActionMenuCommandsSection
 
.endif
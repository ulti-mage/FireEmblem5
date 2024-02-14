.weak
  WARNINGS :?= "None"
.endweak

GUARD_ITEM_USE_EFFECTS_COMMANDS :?= false
.if (!GUARD_ITEM_USE_EFFECTS_COMMANDS)
  GUARD_ITEM_USE_EFFECTS_COMMANDS := true

  ; Definitions

  .weak

    rlCopyExpandedCharacterDataBufferToBuffer             :?= address($83905C)
    rlCopyCharacterDataToBufferByDeploymentNumber         :?= address($83901C)
    rlGetWindowSideByUnitXCoordinate                      :?= address($83CB09)
    rlDrawMenuText                                        :?= address($87E728)
    rlGetCharacterNamePointer                             :?= address($839334)
    rlGetClassNamePointer                                 :?= address($839351)
    rlGetEquippableItemInventoryOffset                    :?= address($839705)
    rlGetItemNamePointer                                  :?= address($83931A)
    rlDrawMultilineMenuText                               :?= address($8588E4)
    rlDrawNumberMenuText                                  :?= address($858859)
    rlCopyItemDataToBuffer                                :?= address($83B00D)
    rlDrawItemCurrentDurability                           :?= address($858921)
    rlDrawItemMaxDurability                               :?= address($858912)
    rlCheckItemEquippable                                 :?= address($83965E)
    rlCheckStealableWeightAgainstCon                      :?= address($839745)
    rlDMAByStruct                                         :?= address($80AE2E)
    rlCheckIfDamagedItem                                  :?= address($83B145)
    rlCopyTerrainMovementCostBuffer                       :?= address($80E43B)
    rlClearJoypadInputs                                   :?= address($839B7F)
    rlSetCursorToCoordinates                              :?= address($83C181)
    rlClearJoypadDirectionalInputsWhileCursorScrolling    :?= address($839B84)
    rlGetMapTileIndexByCoords                             :?= address($838E76)
    rlRunRoutineForTilesIn1Range                          :?= address($839969)
    rlCheckIfAllegianceMatchesPhase                       :?= address($83B30C)
    rlRunRoutineForAllUnitsInAllegiance                   :?= address($839825)
    rlCombineCharacterDataAndClassBases                   :?= address($8390BE)
    rlRunRoutineForAllTilesVisibleByPlayer                :?= address($8398E1)
    rlCheckIfTargetableAllegiance                         :?= address($83B380)
    rlCheckIfTileIsGateOrThroneByTileIndex                :?= address($83AF2B)
    rlCopyCharacterDataFromBuffer                         :?= address($839041)
    rlRunRoutineForAllTilesInRange                        :?= address($8398C7)
    rlUnknownGetMapTileCoordsBySelectedUnit               :?= address($83A7FC)
    rlRunChapterLocationEvents                            :?= address($8C9CBD)
    rlGetEventCoordinatesByTileIndex                      :?= address($83A7EC)
    rlCheckIfClassCanDismount                             :?= address($83A80F)
    aMountedClassTable                                    :?= address($888000)
    aDismountedClassTable                                 :?= address($88801C)
    rlGetUnitPromotedClass                                :?= address($83A9A6)
    rlCopyClassDataToBuffer                               :?= address($8393E0)
    rlUpdateMountDismountSkills                           :?= address($83AC5B)
    rlForceDismountOnImpassibleTiles                      :?= address($83AD0C)
    rlDrawRightFacingCursor                               :?= address($859013)
    rlPlaySound                                           :?= address($808C87)
    rlGetMapCoordsByTileIndex                             :?= address($838E84)
    rlCheckIfAllegianceDoesNotMatchPhaseTarget            :?= address($83B34F)
    rlSetupInventoryFullConvoyMenu                        :?= address($86E41A)
    rlRunRoutineForAllFoes                                :?= address($83989F)
    rlRunRoutineForAllAllies                              :?= address($839877)

  .endweak

    .section ItemUseEffectsSection

      aStatBoosterUseEffect ; 87/AEC4

        .long rlStatBoosterAvailabilityCheck
        .long 0
        .long rlStatBoosterUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aSkillManualUseEffect ; 87/AED3

        .long rlSkillManualAvailabilityCheck
        .long 0
        .long rlSkillManualUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aChestKeyUseEffect ; 87/AEE2

        .long rlChestKeyAvailabilityCheck
        .long 0
        .long rlChestKeyUseEffect
        .long rlFreeProcActionMenu

      aDoorKeyUseEffect ; 87/AEEE

        .long rlDoorKeyAvailabilityCheck
        .long 0
        .long rlKeyUseEffect
        .long rlFreeProcActionMenu

      aBridgeKeyUseEffect ; 87/AEFA

        .long rlBridgeKeyAvailabilityCheck
        .long 0
        .long rlKeyUseEffect
        .long rlFreeProcActionMenu

      aLockpickUseEffect ; 87/AF06

        .long rlLockpickAvailabilityCheck
        .long 0
        .long rlKeyUseEffect
        .long rlFreeProcActionMenu

      aVulneraryUseEffect ; 87/AF12

        .long rlVulneraryAvailabilityCheck
        .long 0
        .long rlVulneraryUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aPureWaterUseEffect ; 87/AF21

        .long rlPureWaterAvailabilityCheck
        .long 0
        .long rlPureWaterUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aTorchUseEffect ; 87/AF30

        .long rlTorchAvailabilityCheck
        .long 0
        .long rlTorchUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aAntitoxinUseEffect ; 87/AF3F

        .long rlAntitoxinAvailabilityCheck
        .long 0
        .long rlAntitoxinUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aMasterSealUseEffect ; 87/AF4E

        .long rlMasterSealAvailabilityCheck
        .long 0
        .long rlMasterSealUseEffectDelay
        .long rlMasterSealUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aHealingStaffUseEffect ; 87/AF60

        .long rlHealingStaffUseAvailabilityCheck
        .long rlHealingStaffTargetEffect
        .long rlMakeHealingStaffUseEffectTargetList
        .long rlCreateAllyInteractionMenu
        .long rlClearStaffUseEffectMenu
        .long rlHandleTargetStaffUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aPhysicStaffUseEffect ; 87/AF78

        .long rlRangedHealingStaffUseAvailabilityCheck
        .long rlHealingStaffTargetEffect
        .long rlMakeRangedHealingStaffUseEffectTargetList
        .long rlCreateAllyInteractionMenu
        .long rlClearStaffUseEffectMenu
        .long rlHandleTargetStaffUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aFortifyStaffUseEffect ; 87/AF90

        .long rlRangedHealingStaffUseAvailabilityCheck
        .long rlFortifyTargetEffect
        .long rlMakeRangedHealingStaffUseEffectTargetList
        .long rlClearStaffUseEffectMenu
        .long rlHandleFortifyStaffUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aSilenceStaffUseEffect ; 87/AFA5

        .long rlStatusStaffUseAvailabilityCheck
        .long rlSilenceStaffTargetEffect
        .long rlMakeStatusStaffUseEffectTargetList
        .long rlCreateAllyInteractionMenu
        .long rlClearStaffUseEffectMenu
        .long rlHandleTargetStaffUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aSleepStaffUseEffect ; 87/AFBD

        .long rlStatusStaffUseAvailabilityCheck
        .long rlSleepStaffTargetEffect
        .long rlMakeStatusStaffUseEffectTargetList
        .long rlCreateAllyInteractionMenu
        .long rlClearStaffUseEffectMenu
        .long rlHandleTargetStaffUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aBerserkStaffUseEffect ; 87/AFD5

        .long rlStatusStaffUseAvailabilityCheck
        .long rlBerserkStaffTargetEffect
        .long rlMakeStatusStaffUseEffectTargetList
        .long rlCreateAllyInteractionMenu
        .long rlClearStaffUseEffectMenu
        .long rlHandleTargetStaffUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aRestoreStaffUseEffect ; 87/AFED

        .long rlRestoreStaffUseAvailabilityCheck
        .long rlRestoreTargetEffect
        .long rlMakeRestoreStaffUseEffectTargetList
        .long rlCreateAllyInteractionMenu
        .long rlClearStaffUseEffectMenu
        .long rlHandleTargetStaffUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aWarpStaffUseEffect ; 87/B005

        .long rlWarpingStaffUseAvailabilityCheck
        .long rlWarpTargetEffect
        .long rlMakeWarpingStaffUseEffectTargetList
        .long rlCreateAllyInteractionMenu
        .long rlWarpingStaffUseEffectSetInitialCursor
        .long rlWarpingStaffTargetTileSelect
        .long rlClearStaffUseEffectMenu
        .long rlHandleTargetStaffUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aRewarpStaffUseEffect ; 87/B023

        .long rlRewarpStaffUseAvailabilityCheck
        .long rlRewarpTargetEffect
        .long rlMakeRewarpStaffUseEffectTargetList
        .long rlWarpingStaffUseEffectSetInitialCursor
        .long rlWarpingStaffTargetTileSelect
        .long rlClearStaffUseEffectMenu
        .long rlHandleRewarpStaffUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aEnsorcelStaffUseEffect ; 87/B03E

        .long rlEnsorcelStaffUseAvailabilityCheck
        .long rlBarrierTargetEffect
        .long rlMakeEnsorcelUseEffectTargetList
        .long rlCreateAllyInteractionMenu
        .long rlClearStaffUseEffectMenu
        .long rlHandleTargetStaffUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aRescueStaffUseEffect ; 87/B056

        .long rlRescueStaffUseAvailabilityCheck
        .long rlRescueStaffTargetEffect
        .long rlMakeRescueStaffUseEffectTargetList
        .long rlCreateAllyInteractionMenu
        .long rlClearStaffUseEffectMenu
        .long rlHandleTargetStaffUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aTorchStaffUseEffect ; 87/B06E

        .long rlTorchAvailabilityCheck
        .long rlTorchStaffTargetEffect
        .long rlClearStaffUseEffectMenu
        .long rlUnknown87C22D
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aHammerneStaffUseEffect ; 87/B080

        .long rlHammerneStaffUseAvailabilityCheck
        .long rlHammerneTargetEffect
        .long rlMakeHammerneStaffUseEffectTargetList
        .long rlClearStaffUseEffectMenu
        .long rlStaffItemSelectMenu
        .long rlHandleStaffItemSelectMenu
        .long rlClearStaffUseEffectMenu
        .long rlUnknown87C3BC
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aThiefStaffUseEffect ; 87/B09E

        .long rlThiefStaffUseAvailabilityCheck
        .long rlThiefStaffTargetEffect
        .long rlMakeThiefStaffUseEffectTargetList
        .long rlClearStaffUseEffectMenu
        .long rlStaffItemSelectMenu
        .long rlHandleStaffItemSelectMenu
        .long rlClearStaffUseEffectMenu
        .long rlUnknown87C3BC
        .long rlDelayNextUseRoutine
        .long rlUnknown87C632
        .long rlWaitForThiefStaffProcFinish
        .long rlFreeProcActionMenu

      aUnlockStaffUseEffect ; 87/B0C2

        .long rlUnlockStaffUseAvailabilityCheck
        .long rlUnlockTargetEffect
        .long rlMakeUnlockStaffUseEffectTargetList
        .long rlClearStaffUseEffectMenu
        .long rlUnknown87B2F2
        .long rlUnknown87C3C9
        .long rlDelayNextUseRoutine
        .long rlFreeProcActionMenu

      aReturnStaffUseEffect ; 87/B0DA

        .long rlWarpingStaffUseAvailabilityCheck
        .long rlReturnStaffTargetEffect
        .long rlMakeWarpingStaffUseEffectTargetList
        .long rlCreateAllyInteractionMenu
        .long rlClearStaffUseEffectMenu
        .long rlHandleTargetStaffUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aWatchStaffUseEffect ; 87/B0F2

        .long rlItemUseAvailabilityCheckAlways
        .long rlWatchTargetEffect
        .long rlClearStaffUseEffectMenu
        .long rlFreeWatchStaffUseEffectProc

      aUnknownUseEffect ; 87/B0FE

        .long rlItemUseAvailabilityCheckAlways
        .long rlWatchTargetEffect
        .long rlUnknown87C22D
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aPhaseGraphicEffect ; 87/B10D

        ; Don't ask why this is coded as an item use effect

        .long 0
        .long 0
        .long $81B563
        .long $81B5D9
        .long $81B69E

      aSDrinkUseEffect ; 87/B11C

        .long rlSDrinkUseAvailabilityCheck
        .long 0
        .long rlSDrinkUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      aKiaStaffUseEffect ; 87/B12B

        .long rlKiaStaffUseAvailabilityCheck
        .long rlKiaTargetEffect
        .long rlMakeKiaStaffUseEffectTargetList
        .long rlCreateAllyInteractionMenu
        .long rlClearStaffUseEffectMenu
        .long rlHandleTargetStaffUseEffect
        .long rlDelayedFreeUseEffectProc
        .long rlFreeProcActionMenu

      rlGetItemUseEffectPointer ; 87/B143

        .al
        .autsiz
        .databank $7E

        lda #>`aItemUsePointers
        sta lR18+1

        lda aItemDataBuffer.UseEffect,b
        and #$00FF
        tax
        lda aItemUsePointers,x
        clc
        adc #6
        sta lR18

        lda [lR18]
        sta lItemUseRoutine
        ldy #1
        lda [lR18],y
        sta lItemUseRoutine+1

        lda lR18
        sta lItemUseRoutineCurrentPosition
        lda lR18+1
        sta lItemUseRoutineCurrentPosition+1
        rtl

        .databank 0

      rlGetNextItemUseRoutine ; 87/B171

        .al
        .autsiz
        .databank $7E

        inc lItemUseRoutineCurrentPosition
        inc lItemUseRoutineCurrentPosition
        inc lItemUseRoutineCurrentPosition

        lda lItemUseRoutineCurrentPosition
        sta lR18
        lda lItemUseRoutineCurrentPosition+1
        sta lR18+1
        ldy #1
        lda [lR18],y
        sta lItemUseRoutine+1
        lda [lR18]
        sta lItemUseRoutine
        rtl

        .databank 0

      rlGetItemUseTargetEffect ; 87/B192

        .al
        .autsiz
        .databank $7E

        lda #>`aItemUsePointers
        sta lR19+1
        lda aItemDataBuffer.UseEffect,b
        and #$00FF
        tax
        lda aItemUsePointers,x
        clc
        adc #3
        sta lR19

        lda [lR19]
        sta lR18
        inc lR19
        lda [lR19]
        sta lR18+1
        rtl

        .databank 0

      rlGetItemUseAvailabilityPointer ; 87/B1B3

        .al
        .autsiz
        .databank $7E

        lda #>`aItemUsePointers
        sta lR19+1
        lda aItemDataBuffer.UseEffect,b
        and #$00FF
        tax
        lda aItemUsePointers,x
        sta lR19

        lda [lR19]
        sta lR18
        inc lR19
        lda [lR19]
        sta lR18+1
        rtl

        .databank 0

      rlItemUseAvailabilityCheckAlways ; 87/B1D0

        .al
        .autsiz
        .databank ?

        sec
        rtl

        .databank 0

      rlHealingStaffUseAvailabilityCheck ; 87/B1D2

        .al
        .autsiz
        .databank ?

        jsr rsMakeHealingStaffTargetList

        lda $A7AF,b
        beq +

          sec
          rtl

        +
        clc
        rtl

        .databank 0

      rlMakeHealingStaffUseEffectTargetList ; 87/B1DE

        .al
        .autsiz
        .databank $7E

        stz aProcSystem.aBody7,b,x
        jsr rsMakeHealingStaffTargetList
        jsl rlGetNextItemUseRoutine

        lda lItemUseRoutine
        sta lR18
        lda lItemUseRoutine+1
        sta lR18+1
        rtl

        .databank 0

      rlUnknown87B1F3 ; 87/B1F3

        .al
        .autsiz
        .databank ?

        jmp (lR18)

      rlRangedHealingStaffUseAvailabilityCheck ; 87/B1F6

        .al
        .autsiz
        .databank ?

        jsl rlMakeRangedHealingStaffTargetList

        lda $A7AF,b
        beq +

          sec
          rtl

        +
        clc
        rtl

        .databank 0

      rlMakeRangedHealingStaffUseEffectTargetList ; 87/B203

        .al
        .autsiz
        .databank $7E

        stz aProcSystem.aBody7,b,x
        jsl rlMakeRangedHealingStaffTargetList

        jsl rlGetNextItemUseRoutine
        lda lItemUseRoutine
        sta lR18
        lda lItemUseRoutine+1
        sta lR18+1
        rtl

        .databank 0

      rlUnknown87B219 ; 87/B219

        .al
        .autsiz
        .databank ?

        jmp (lR18)

      rlStatusStaffUseAvailabilityCheck ; 87/B21C

        .al
        .autsiz
        .databank ?

        jsr rsCheckForStatusStaffTarget

        lda $A7AF,b
        beq +

          sec
          rtl

        +
        clc
        rtl

        .databank 0

      rlMakeStatusStaffUseEffectTargetList ; 87/B228

        .al
        .autsiz
        .databank $7E

        stz aProcSystem.aBody7,b,x
        stz $A7AD,b
        jsr rsMakeStatusStaffTargetList

        jsl rlGetNextItemUseRoutine
        lda lItemUseRoutine
        sta lR18
        lda lItemUseRoutine+1
        sta lR18+1
        rtl

        .databank 0

      rlUnknown87B240 ; 87/B240

        .al
        .autsiz
        .databank ?

        jmp (lR18)

        .databank 0

      rlRestoreStaffUseAvailabilityCheck ; 87/B243

        .al
        .autsiz
        .databank ?

        jsr rsMakeRestoreStaffTargetList

        lda $A7AF,b
        beq +

          sec
          rtl

        +
        clc
        rtl

        .databank 0

      rlMakeRestoreStaffUseEffectTargetList ; 87/B24F

        .al
        .autsiz
        .databank $7E

        stz aProcSystem.aBody7,b,x
        jsr rsMakeRestoreStaffTargetList

        jsl rlGetNextItemUseRoutine
        lda lItemUseRoutine
        sta lR18
        lda lItemUseRoutine+1
        sta lR18+1
        rtl

        .databank 0

      rlUnknown87B264 ; 87/B264

        .al
        .autsiz
        .databank ?

        jmp (lR18)

        .databank 0

      rlWarpingStaffUseAvailabilityCheck ; 87/B267

        .al
        .autsiz
        .databank ?

        jsr rsMakeWarpingStaffTargetList

        lda $A7AF,b
        beq +

          sec
          rtl

        +
        clc
        rtl

        .databank 0

      rlMakeWarpingStaffUseEffectTargetList ; 87/B273

        .al
        .autsiz
        .databank $7E

        jsr rsMakeWarpingStaffTargetList

        jsl rlGetNextItemUseRoutine
        lda lItemUseRoutine
        sta lR18
        lda lItemUseRoutine+1
        sta lR18+1
        rtl

        .databank 0

      rlUnknown87B285 ; 87/B285

        .al
        .autsiz
        .databank ?

        jmp (lR18)

      rlRescueStaffUseAvailabilityCheck ; 87/B288

        .al
        .autsiz
        .databank ?

        jsr rsMakeRescueStaffTargetList

        lda $A7AF,b
        beq +

          sec
          rtl

        +
        clc
        rtl

        .databank 0

      rlMakeRescueStaffUseEffectTargetList ; 87/B294

        .al
        .autsiz
        .databank $7E

        stz aProcSystem.aBody7,b,x
        jsr rsMakeRescueStaffTargetList2

        jsl rlGetNextItemUseRoutine
        lda lItemUseRoutine
        sta lR18
        lda lItemUseRoutine+1
        sta lR18+1
        rtl

        .databank 0

      rlUnknown87B2A9 ; 87/B2A9

        .al
        .autsiz
        .databank ?

        jmp (lR18)

        .databank 0

      rlRewarpStaffUseAvailabilityCheck ; 87/B2AC

        .al
        .autsiz
        .databank ?

        sec
        rtl

        .databank 0

      rlMakeRewarpStaffUseEffectTargetList ; 87/B2AE

        .al
        .autsiz
        .databank $7E

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aTargetingCharacterBuffer
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        jsl rlGetNextItemUseRoutine
        lda lItemUseRoutine
        sta lR18
        lda lItemUseRoutine+1
        sta lR18+1
        rtl

        .databank 0

      rlUnknown87B2CB ; 87/B2CB

        .al
        .autsiz
        .databank ?

        jmp (lR18)

        .databank 0

      rlEnsorcelStaffUseAvailabilityCheck ; 87/B2CE

        .al
        .autsiz
        .databank ?

        jsr rsMakeEnsorcelStaffTargetList

        lda $A7AF,b
        beq +

          sec
          rtl

        +
        clc
        rtl

        .databank 0

      rlMakeEnsorcelUseEffectTargetList ; 87/B2DA

        .al
        .autsiz
        .databank ?

        stz aProcSystem.aBody7,b,x
        jsr rsMakeEnsorcelStaffTargetList

      rlMasterSealUseEffectDelay ; 87/B2E0

        .al
        .autsiz
        .databank $7E

        ; This seems pointless but follows the same structure as other use effect

        jsl rlGetNextItemUseRoutine

        lda lItemUseRoutine
        sta lR18
        lda lItemUseRoutine+1
        sta lR18+1
        rtl

        .databank 0

      rlUnknown87B2EF ; 87/B2EF

        .al
        .autsiz
        .databank ?

        jmp (lR18)

        .databank 0

      rlUnknown87B2F2 ; 87/B2F2

        .al
        .autsiz
        .databank ?

        lda $0E6D,b
        bne +

          jsl $858E7F
        
        +
        rtl

        .databank 0

      rlCreateAllyInteractionMenu ; 87/B2FC

        .al
        .autsiz
        .databank ?

        lda $0E6D,b
        bne +

          lda aProcSystem.aBody7,b,x
          tay
          lda $A7AF,b,y
          sta wR0
          lda #<>aBurstWindowCharacterBuffer
          sta wR1
          jsl rlCopyCharacterDataToBufferByDeploymentNumber
          jsl rlCreateAllyInteractionMenuEffect
          jsl $858E7F

        +
        rtl

        .databank 0

      rlCreateAllyInteractionMenuEffect ; 87/B31C

        .al
        .autsiz
        .databank $7E

        phx
        lda aBurstWindowCharacterBuffer.Coordinates,b
        and #$00FF
        jsl rlGetWindowSideByUnitXCoordinate
        cmp wTerrainWindowSide
        beq _End

          sta wTerrainWindowSide
          tax
          lda aAllyInteractionMenuXCoordinates,x
          sta wR0

          lda aActiveMenuSlots
          beq +

            jsl rlMenuClearActiveMenu
          
          +
          lda #1
          sta wR1
          lda #10
          sta wR2
          lda #12
          sta wR3
          jsl rlMenuCreateActiveMenu
          plx
          sta aProcSystem.aHeaderUnknownTimer,b,x

          jsr rsPopulateAllyInteractionMenu

          lda aProcSystem.aHeaderUnknownTimer,b,x
          jsl rlMenuSetActiveMenu
          jsl rlMenuDrawAllMenusFromBuffers
          rtl

        _End
        plx
        rtl

        .databank 0

      aAllyInteractionMenuXCoordinates ; 87/B367

        .word 21
        .word 1

      rsPopulateAllyInteractionMenu ; 87/B36B

        .al
        .autsiz
        .databank ?

        phx
        lda #<>$7E4EF2
        sta aCurrentTilemapInfo.lInfoPointer,b
        lda #>`$7E4EF2
        sta aCurrentTilemapInfo.lInfoPointer+1,b
        lda #$2180
        sta aCurrentTilemapInfo.wBaseTile,b

        lda aBurstWindowCharacterBuffer.Character,b
        jsl rlGetCharacterNamePointer
        ldx #$0101
        jsl rlDrawMenuText

        lda aBurstWindowCharacterBuffer.Class,b
        jsl rlGetClassNamePointer
        ldx #$0301
        jsl rlDrawMenuText

        lda #<>aBurstWindowCharacterBuffer
        sta wR1
        jsl rlGetEquippableItemInventoryOffset
        jsl rlGetItemNamePointer
        ldx #$0501
        jsl rlDrawMenuText

        lda #<>aAllyInteractionMenuText
        sta lR18
        lda #>`aAllyInteractionMenuText
        sta lR18+1
        ldx #$0701
        jsl rlDrawMultilineMenuText

        lda #$2AA0
        sta aCurrentTilemapInfo.wBaseTile,b
        lda aBurstWindowCharacterBuffer.Level,b
        sta lR18
        stz lR18+1
        ldx #$0708
        jsl rlDrawNumberMenuText

        lda aBurstWindowCharacterBuffer.MaxHP,b
        sta lR18
        stz lR18+1
        ldx #$0908
        jsl rlDrawNumberMenuText

        lda aBurstWindowCharacterBuffer.CurrentHP,b
        sta lR18
        stz lR18+1
        ldx #$0905
        jsl rlDrawNumberMenuText
        plx
        rts

        .databank 0

      aAllyInteractionMenuText ; 87/B3F1

        .text "ＬＶ\n"
        .text "ＨＰ　　　／　　\n"
        .word 0

      rlCreateTradeInteractionMenu ; 87/B40B

        .al
        .autsiz
        .databank ?

        lda $0E6D,b
        bne +

          lda aProcSystem.aBody7,b,x
          tay
          lda $A7AF,b,y
          sta wR0
          lda #<>aBurstWindowCharacterBuffer
          sta wR1
          jsl rlCopyCharacterDataToBufferByDeploymentNumber
          jsl rlCreateTradeInteractionMenuEffect
          jsl $858E7F

        +
        rtl

        .databank 0

      rlCreateTradeInteractionMenuEffect ; 87/B42B

        .al
        .autsiz
        .databank $7E

        phx
        lda aBurstWindowCharacterBuffer.Coordinates,b
        and #$00FF
        jsl rlGetWindowSideByUnitXCoordinate
        cmp wTerrainWindowSide
        beq _End

          sta wTerrainWindowSide
          tax
          lda aTradeInteractionMenuXCoordinates,x
          sta wR0

          jsr rsTradeInteractionCountInventoryItems
          clc
          adc #5
          sta wR3
          lda #1
          sta wR1
          lda #12
          sta wR2
          lda aActiveMenuSlots
          beq +

            jsl rlMenuClearActiveMenu

          +
          plx
          jsl rlMenuCreateActiveMenu
          sta aProcSystem.aHeaderUnknownTimer,b,x

          jsr rsPopulateTradeInteractionMenu

          lda aProcSystem.aHeaderUnknownTimer,b,x
          jsl rlMenuSetActiveMenu
          jsl rlMenuDrawAllMenusFromBuffers
          rtl
        
        _End
        plx
        rtl

        .databank 0

      aTradeInteractionMenuXCoordinates ; 87/B47A

        .word 19
        .word 1

      rsTradeInteractionCountInventoryItems ; 87/B47E

        .al
        .autsiz
        .databank ?

        ldx #0
        
        -
        lda aBurstWindowCharacterBuffer.Items,b,x
        beq +

        inc x
        inc x
        cpx #size(structCharacterDataRAM.Items)
        bne -
        
        + 
        txa
        bne +

        dec a

        +
        rts

        .databank 0

      rsPopulateTradeInteractionMenu ; 87/B492

        .al
        .autsiz
        .databank ?

        phx
        lda #<>$7E4EF2
        sta aCurrentTilemapInfo.lInfoPointer,b
        lda #>`$7E4EF2
        sta aCurrentTilemapInfo.lInfoPointer+1,b
        lda #$2180
        sta aCurrentTilemapInfo.wBaseTile,b

        lda aBurstWindowCharacterBuffer.Character,b
        jsl rlGetCharacterNamePointer
        ldx #$0101
        jsl rlDrawMenuText

        stz wR17
        
        -
        ldx wR17
        lda aBurstWindowCharacterBuffer.Items,b,x
        beq _End

        jsl rlCopyItemDataToBuffer
        jsr rsTradeInteractionMenuGetItemColorIndex
        sta wR16
        jsl rlGetItemNamePointer
        ldx wR16
        lda aTradeInteractionMenuItemColor,x
        sta aCurrentTilemapInfo.wBaseTile,b
        ldx wR17
        lda aTradeInteractionMenuItemNameCoordinates,x
        tax
        jsl rlDrawMenuText

        lda wR16
        sta aCurrentTilemapInfo.wBaseTile,b
        ldx wR17
        lda aTradeInteractionMenuItemDurabilityCoordinates,x
        tax
        jsl rlDrawItemCurrentDurability

        inc wR17
        inc wR17
        lda wR17
        cmp #size(structCharacterDataRAM.Items)
        bne -
        
        _End
        plx
        rts

        .databank 0

      aTradeInteractionMenuItemNameCoordinates ; 87/B4FA

        .word $0401
        .word $0601
        .word $0801
        .word $0A01
        .word $0C01
        .word $0E01
        .word $1001

      aTradeInteractionMenuItemDurabilityCoordinates ; 87/B508

        .word $040A
        .word $060A
        .word $080A
        .word $0A0A
        .word $0C0A
        .word $0E0A
        .word $100A

      aTradeInteractionMenuItemColor ; 87/B516

        .word $2180
        .word $2D80

      rsTradeInteractionMenuGetItemColorIndex ; 87/B51A

        .al
        .autsiz
        .databank $7E

        lda wTradeWindowType
        cmp #1
        beq _Stealing

        lda #<>aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCheckItemEquippable
        bcs ++
        bra +
        
        _Stealing
        lda #<>aSelectedCharacterBuffer
        sta wR1
        jsl rlCheckStealableWeightAgainstCon
        bcs ++

        +
        lda #2
        rts

        +
        tdc
        rts

        .databank 0

      rlStaffItemSelectMenu ; 87/B540

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody7,b,x
        tay
        lda $A7AF,b,y
        sta wR0
        lda #<>aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber
        jsl rlStaffItemSelectMenuEffect
        jsl $858E7F
        rtl

        .databank 0

      rlUnknown87B55B ; 87/B55B

        .al
        .autsiz
        .databank ?

        lda $4F33,b
        sta lR18
        lda $4F33+1,b
        sta lR18+1

        phk
        pea #<>(+)-1
        jml [lR18]
        
        +
        rtl

        .databank 0

      rlStaffItemSelectMenuEffect ; 87/B56D

        .al
        .autsiz
        .databank $7E

        phx
        lda aBurstWindowCharacterBuffer.Coordinates,b
        and #$00FF
        jsl rlGetWindowSideByUnitXCoordinate
        cmp wTerrainWindowSide
        beq _End

          sta wTerrainWindowSide
          clc
          adc wTradeWindowType
          tax
          lda aStaffItemSelectXCoordinates,x
          sta wR0

          phx
          jsr rsStaffItemSelectGetItemCount
          clc
          adc #5
          sta wR3
          plx

          lda #1
          sta wR1
          lda aStaffItemSelectWidths,x
          sta wR2

          lda aActiveMenuSlots
          beq +

            jsl rlMenuClearActiveMenu
          
          +
          plx
          jsl rlMenuCreateActiveMenu
          sta aProcSystem.aHeaderUnknownTimer,b,x

          jsr rsPopulateStaffItemSelect

          lda aProcSystem.aHeaderUnknownTimer,b,x
          jsl rlMenuSetActiveMenu
          jsl rlMenuDrawAllMenusFromBuffers

          phx
          lda wBGUpdateFlags
          and #~($2 | $8)
          sta wBGUpdateFlags

          jsl rlDMAByStruct
          .structDMAToVRAM aBG3TilemapBuffer+$40, $0500, VMAIN_Setting(true), $A040

          jsl rlDMAByStruct
          .structDMAToVRAM aBG1TilemapBuffer+$40, $04C0, VMAIN_Setting(true), $E040

          plx
          rtl

        _End
        plx
        rtl

        .databank 0

      aStaffItemSelectXCoordinates ; 87/B5E8

        .word $000F
        .word $0001
        .word $0012
        .word $0001

      aStaffItemSelectWidths ; 87/B5F0

        .word $0010
        .word $0010
        .word $000D
        .word $000D

      rsStaffItemSelectGetItemCount ; 87/B5F8

        .al
        .autsiz
        .databank $7E

        lda wR0
        pha

        stz $4F06,b
        ldx #0
        
        -
        lda aBurstWindowCharacterBuffer.Items,b,x
        beq _End

        ; check if this is the hammere or thief staff
        ldy wTradeWindowType
        cpy #0
        bne +

        ; if hammerne staff: check if item is damaged, else skip
        jsl rlCheckIfDamagedItem
        bcc ++

        +
        ldy $4F06,b
        txa
        inc a
        sta $4F0A,b,y
        inc y
        inc y
        sty $4F06,b
        
        +
        inc x
        inc x
        cpx #size(structCharacterDataRAM.Items)
        bcc -
        
        _End
        pla
        sta wR0

        ldx $4F06,b
        stz $4F0A,b,x
        txa
        rts

        .databank 0

      rsPopulateStaffItemSelect ; 87/B633

        .al
        .autsiz
        .databank $7E

        phx
        lda #<>$7E4EF2
        sta aCurrentTilemapInfo.lInfoPointer,b
        lda #>`$7E4EF2
        sta aCurrentTilemapInfo.lInfoPointer+1,b
        lda #$2180
        sta aCurrentTilemapInfo.wBaseTile,b

        lda aBurstWindowCharacterBuffer.Character,b
        jsl rlGetCharacterNamePointer
        ldx #$0101
        jsl rlDrawMenuText

        stz wR17
        
        _Loop
        ldx wR17
        lda $4F0A,b,x
        bne +

          jmp _End
        
        +
        dec a
        tax
        lda aBurstWindowCharacterBuffer.Items,b,x
        sta $4FA0,b
        jsl rlCopyItemDataToBuffer

        lda wTradeWindowType
        cmp #0
        bne +

          ; hammerne staff
          lda $4FA0,b
          jsl rlCheckIfDamagedItem
          bcc _Next

        +
        stz wR16
        jsl rlGetItemNamePointer

        ldx wR16
        lda aStaffItemSelectItemColors,x
        sta aCurrentTilemapInfo.wBaseTile,b
        ldx wR17
        lda aStaffItemSelectItemNameCoordinates,x
        tax
        jsl rlDrawMenuText

        lda wTradeWindowType
        cmp #4
        bne +

          jmp ++

        +
        lda #<>aStaffItemSelectSlashText
        sta lR18
        lda #>`aStaffItemSelectSlashText
        sta lR18+1
        ldx wR17
        lda aStaffItemSelectSlashCoordinates,x
        tax
        jsl rlDrawMenuText

        lda wR16
        sta aCurrentTilemapInfo.wBaseTile,b
        ldx wR17
        lda aStaffItemSelectMaxDurabilityCoordinates,x
        tax
        jsl rlDrawItemMaxDurability

        +
        lda $4FA0,b
        jsl rlCopyItemDataToBuffer

        lda wR16
        sta aCurrentTilemapInfo.wBaseTile,b
        ldx wR17
        lda aStaffItemSelectCurrentDurabilityCoordinates,x
        tax
        jsl rlDrawItemCurrentDurability
        
        _Next
        inc wR17
        inc wR17
        lda wR17
        cmp #size(structCharacterDataRAM.Items)
        beq _End

        jmp _Loop
        
        _End
        plx
        rts

        .databank 0

      aStaffItemSelectItemNameCoordinates ; 87/B6EE

        .word $0402
        .word $0602
        .word $0802
        .word $0A02
        .word $0C02
        .word $0E02
        .word $1002

      aStaffItemSelectCurrentDurabilityCoordinates ; 87/B6FC

        .word $040B
        .word $060B
        .word $080B
        .word $0A0B
        .word $0C0B
        .word $0E0B
        .word $100B

      aStaffItemSelectMaxDurabilityCoordinates ; 87/B70A

        .word $040E
        .word $060E
        .word $080E
        .word $0A0E
        .word $0C0E
        .word $0E0E
        .word $100E

      aStaffItemSelectItemColors ; 87/B718

        .word $2180
        .word $2D80

      aStaffItemSelectSlashCoordinates ; 87/B71C

        .word $040C
        .word $060C
        .word $080C
        .word $0A0C
        .word $0C0C
        .word $0E0C
        .word $100C

      aStaffItemSelectSlashText ; 87/B72A

        .text "／\n"

      rlWarpingStaffUseEffectSetInitialCursor ; 87/B72E

        .al
        .autsiz
        .databank $7E

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlMenuDrawAllMenusFromBuffers

        lda aTargetingCharacterBuffer.Class,b
        and #$00FF
        sta wR3
        jsl rlCopyTerrainMovementCostBuffer

        lda aTargetingCharacterBuffer.X,b
        and #$00FF
        sta wR0
        lda aTargetingCharacterBuffer.Y,b
        and #$00FF
        sta wR1
        jsl rlSetCursorToCoordinates
        jsl rlClearJoypadInputs

        jsl rlGetNextItemUseRoutine

        lda lItemUseRoutine
        sta lR18
        lda lItemUseRoutine+1
        sta lR18+1
        rtl

        .databank 0

      rlUnknown87B76C ; 87/B76C

        .al
        .autsiz
        .databank ?

        jmp (lR18)

        .databank 0

      rlWarpingStaffTargetTileSelect ; 87/B76F

        .al
        .autsiz
        .databank $7E

        phx
        lda wJoy1Input
        bit #JOY_Y
        beq +

          ; faster cursor movement
          lda wCursorXCoordPixelsScrolling,b
          ora wCursorYCoordPixelsScrolling,b
          and #$0007
          bne +

            jsl $83BDC5

            lda #8
            jsl $83BF67
            bra ++

        +
        jsl rlClearJoypadDirectionalInputsWhileCursorScrolling
        jsl $83BDD1

        lda #4
        jsl $83BF67
        
        +
        jsr rsWarpingStaffCheckIfValidTargetTile
        bcc +

        ; draw up/down moving pointing finger above unit
        jsl $83C753
        bra ++
        
        ; draw static pointing finger and "X"-bubble above unit
        +
        jsl $83C776
        
        +
        plx
        lda wJoy1New
        bit #JOY_A
        beq +

          jsr rsWarpingStaffCheckIfValidTargetTile
          bcc +

            lda wCursorXCoord,b
            sta $4FA0,b
            lda wCursorYCoord,b
            sta $4FA2,b

            jsl rlGetNextItemUseRoutine

            lda lItemUseRoutine
            sta lR18
            lda lItemUseRoutine+1
            sta lR18+1
            rtl

            jmp (lR18)

        +
        lda wJoy1New
        bit #JOY_B
        beq +

          jmp rlStaffTargetSelectMenuBInput

        +
        rtl

        .databank 0

      rsWarpingStaffCheckIfValidTargetTile ; 87/B7E3

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
        cpx wCursorTileIndex,b
        beq _Obstructed

          ldx wCursorTileIndex,b
          lda aPlayerVisibleUnitMap,x
          and #$00FF
          bne _Obstructed

            lda aTerrainMap,x
            and #$00FF
            tay
            lda aTerrainMovementCostBuffer-1,y
            bmi _Obstructed

              sec
              rts

        _Obstructed
        clc
        rts

        .databank 0

      rlHandleUseEffectCycle ; 87/B818

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

        lda lItemUseRoutine
        sta lR18
        lda lItemUseRoutine+1
        sta lR18+1

        phx
        phk
        pea #<>(+)-1
        jml [lR18]
        
        +
        plx
        plb
        plp
        rtl

        .databank 0

      rsMakeHealingStaffTargetList ; 87/B838

        .al
        .autsiz
        .databank ?

        stz $A7AD,b
        lda #<>rlMakeHealingStaffTargetListEffect
        sta lR25
        lda #>`rlMakeHealingStaffTargetListEffect
        sta lR25+1
        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0
        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1
        jsl rlGetMapTileIndexByCoords
        tax
        lda wCurrentPhase,b
        jsl rlRunRoutineForTilesIn1Range
        ldx $A7AD,b
        stz $A7AF,b,x
        rts

        .databank 0

      rlMakeHealingStaffTargetListEffect ; 87/B868

        .al
        .autsiz
        .databank $7E

        lda aPlayerVisibleUnitMap,x
        and #$00FF
        beq +

          jsl rlCheckIfAllegianceMatchesPhase
          bcs +

            sta wR0
            lda #<>aTargetingCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

      rlMakeRangedHealingStaffTargetListEffect ; 87/B881

        .al
        .autsiz
        .databank ?

        lda aTargetingCharacterBuffer.UnitState,b
        bit #(UnitStateDead | UnitStateUnknown1 | UnitStateRescued | UnitStateHidden | UnitStateDisabled | UnitStateCaptured)
        bne +

          sep #$20
          lda aTargetingCharacterBuffer.CurrentHP,b
          cmp aTargetingCharacterBuffer.MaxHP,b
          beq +

            rep #$30
            ldx $A7AD,b
            lda aTargetingCharacterBuffer.DeploymentNumber,b
            and #$00FF
            sta $A7AF,b,x
            inc x
            inc x
            stx $A7AD,b

        +
        rep #$30
        rtl

        .databank 0

      rlMakeRangedHealingStaffTargetList ; 87/B8A9

        .al
        .autsiz
        .databank ?

        stz $A7AD,b
        lda #<>rlMakeRangedHealingStaffTargetListEffect
        sta lR25
        lda #>`rlMakeRangedHealingStaffTargetListEffect
        sta lR25+1
        lda wCurrentPhase,b
        jsl rlRunRoutineForAllUnitsInAllegiance

        ldx $A7AD,b
        stz $A7AF,b,x
        rtl

        .databank 0

      rsMakeStatusStaffTargetList ; 87/B8C4

        .al
        .autsiz
        .databank $7E

        lda aItemDataBuffer.UseEffect,b
        and #$00FF
        ldx #StatusBerserk
        cmp #UseEffectBerserkStaff
        beq +

        ldx #StatusSleep
        cmp #UseEffectSleepStaff
        beq +

        ldx #StatusSilence
        cmp #UseEffectSilenceStaff
        beq +
        
        ldx #-1
        
        + 
        stx $4FA2,b

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCombineCharacterDataAndClassBases

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlGetEquippableItemInventoryOffset

        ldx #<>aActionStructUnit1
        jsl rlActionStructGetItemBonusesItemPreset

        lda aActionStructUnit1.Magic
        and #$00FF
        sta $4FA0,b

        stz $A7AD,b

        lda #<>rlMakeStatusStaffTargetListEffect
        sta lR25
        lda #>`rlMakeStatusStaffTargetListEffect
        sta lR25+1
        jsl rlRunRoutineForAllTilesVisibleByPlayer

        ldx $A7AD,b
        stz $A7AF,b,x
        rts

        .databank 0

      rlMakeStatusStaffTargetListEffect ; 87/B930

        .as
        .autsiz
        .databank ?

        jsl rlCheckIfTargetableAllegiance
        bcs +

          jmp _End
        
        +
        rep #$30
        sta wR0
        lda #<>aTargetingCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber

        _B946

        lda aTargetingCharacterBuffer.Skills2,b
        bit #Skill3Immortal << 8
        bne _End

          lda aTargetingCharacterBuffer.UnitState,b
          bit #(UnitStateDead | UnitStateUnknown1 | UnitStateUnselectable | UnitStateRescued | UnitStateHidden | UnitStateDisabled | UnitStateCaptured)
          bne _End

            lda aTargetingCharacterBuffer.Status,b
            and #$00FF
            cmp #StatusPetrify
            beq _End

              cmp $4FA2,b
              beq _End

                lda aTargetingCharacterBuffer.X,b
                and #$00FF
                sta wR0
                lda aTargetingCharacterBuffer.Y,b
                and #$00FF
                sta wR1
                jsl rlGetMapTileIndexByCoords
                tax
                jsl rlCheckIfTileIsGateOrThroneByTileIndex
                bcs _End

                  lda #<>aTargetingCharacterBuffer
                  sta wR1
                  jsl rlCombineCharacterDataAndClassBases

                  lda #<>aTargetingCharacterBuffer
                  sta wR1
                  jsl rlGetEquippableItemInventoryOffset

                  ldx #<>aTargetingCharacterBuffer
                  jsl rlActionStructGetItemBonusesItemPreset

                  lda aTargetingCharacterBuffer.Magic,b
                  and #$00FF
                  cmp $4FA0,b
                  bcs _End

                    ldx $A7AD,b
                    lda aTargetingCharacterBuffer.DeploymentNumber,b
                    and #$00FF
                    sta $A7AF,b,x
                    inc x
                    inc x
                    stx $A7AD,b

        _End
        sep #$20
        rtl

        .databank 0

      rsMakeRestoreStaffTargetList ; 87/B9B9

        .al
        .autsiz
        .databank ?

        stz $A7AD,b
        lda #<>rlMakeRestoreStaffTargetListEffect
        sta lR25
        lda #>`rlMakeRestoreStaffTargetListEffect
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
        rts

        .databank 0

      rlMakeRestoreStaffTargetListEffect ; 87/B9E6

        .al
        .autsiz
        .databank $7E

        lda aPlayerVisibleUnitMap,x
        and #$00FF
        beq +

          jsl rlCheckIfAllegianceMatchesPhase
          bcs +

            sta wR0
            lda #<>aTargetingCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            lda aTargetingCharacterBuffer.Status,b
            and #$00FF
            beq +

              cmp #StatusPetrify
              beq +

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

      rsMakeWarpingStaffTargetList ; 87/BA1E

        .al
        .autsiz
        .databank ?

        stz $A7AD,b
        lda #<>rlMakeWarpingStaffTargetListEffect
        sta lR25
        lda #>`rlMakeWarpingStaffTargetListEffect
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
        rts

        .databank 0

      rlMakeWarpingStaffTargetListEffect ; 87/BA4B

        .al
        .autsiz
        .databank $7E

        lda aPlayerVisibleUnitMap,x
        and #$00FF
        beq +

          jsl rlCheckIfAllegianceMatchesPhase
          bcs +

            ldx $A7AD,b
            sta $A7AF,b,x
            inc x
            inc x
            stx $A7AD,b

        +
        rtl

        .databank 0

      rsMakeEnsorcelStaffTargetList ; 87/BA65

        .al
        .autsiz
        .databank ?

        stz $A7AD,b
        lda #<>rlMakeEnsorcelStaffTargetListEffect
        sta lR25
        lda #>`rlMakeEnsorcelStaffTargetListEffect
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
        rts

        .databank 0

      rlMakeEnsorcelStaffTargetListEffect ; 87/BA92

        .al
        .autsiz
        .databank $7E

        lda aPlayerVisibleUnitMap,x
        and #$00FF
        beq +

          jsl rlCheckIfAllegianceMatchesPhase
          bcs +

            sta wR0
            lda #<>aTargetingCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            lda aTargetingCharacterBuffer.MagicBonus,b
            and #$00FF
            cmp #7
            beq +

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

      rsMakeRescueStaffTargetList ; 87/BAC8

        .al
        .autsiz
        .databank ?

        stz $A7AD,b
        lda #<>rlMakeRescueStaffTargetListEffect
        sta lR25
        lda #>`rlMakeRescueStaffTargetListEffect
        sta lR25+1
        lda wCurrentPhase,b
        jsl rlRunRoutineForAllUnitsInAllegiance

        ldx $A7AD,b
        stz $A7AF,b,x
        rts

        .databank 0

      rlMakeRescueStaffTargetListEffect ; 87/BAE3

        .al
        .autsiz
        .databank ?

        lda aTargetingCharacterBuffer.UnitState,b
        bit #(UnitStateUnselectable | UnitStateHidden)
        bne +

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

      rsMakeRescueStaffTargetList2 ; 87/BAFD

        .al
        .autsiz
        .databank ?

        stz $A7AD,b
        lda #<>rlMakeRescueStaffTargetListEffect2
        sta lR25
        lda #>`rlMakeRescueStaffTargetListEffect2
        sta lR25+1
        jsl rlRunRoutineForAllTilesVisibleByPlayer

        ldx $A7AD,b
        stz $A7AF,b,x
        rts

        .databank 0

      rlMakeRescueStaffTargetListEffect2 ; 87/BB15

        .as
        .autsiz
        .databank ?

        ; A = aPlayerVisibleUnitMap

        sta wR0
        and #AllAllegiances
        bne +

          ldx $A7AD,b
          lda wR0
          and #$FF
          sta $A7AF,b,x
          inc x
          inc x
          stx $A7AD,b

        +
        rtl

        .databank 0

      aStaffTargetSelectMenuInputRoutines ; 87/BB2B

        .long 0
        .long rlStaffTargetSelectMenuAInput
        .long rlStaffTargetSelectMenuBInput
        .long 0

      rlStaffTargetSelectMenuAInput ; 87/BB37

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody7,b,x
        sta $4FA0,b
        jsl rlGetNextItemUseRoutine
        rtl

        .databank 0

      rlStaffTargetSelectMenuBInput ; 87/BB42

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuClearActiveMenu
        jsl rlMenuDrawAllMenusFromBuffers

        lda #<>rlRestartProcActionMenu
        sta aProcSystem.aHeaderOnCycle,b,x

        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0
        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1
        jsl $81B4ED
        rtl

        .databank 0

      rlHandleTargetStaffUseEffect ; 87/BB68

        .al
        .autsiz
        .databank ?

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        lda #<>aBurstWindowCharacterBuffer
        sta wR0
        lda #<>aActionStructUnit2
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer
        jsl rlActionStructStaff

        lda #<>aActionStructUnit2
        sta wR1
        jsl rlCopyCharacterDataFromBuffer
        jsl rlGetActionStructUnit1CombinedBases

        jsl $83CD3E
        jsl rlGetNextItemUseRoutine
        rtl

        .databank 0

      rlHandleFortifyStaffUseEffect ; 87/BB9E

        .al
        .autsiz
        .databank ?

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer
        jsl rlActionStructStaff

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCopyCharacterDataFromBuffer
        jsl rlGetActionStructUnit1CombinedBases

        jsl $83CD3E
        jsl rlGetNextItemUseRoutine
        rtl

        .databank 0

      rlHandleRewarpStaffUseEffect ; 87/BBC6

        .al
        .autsiz
        .databank ?

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer
        jsl rlActionStructStaff
        jsl rlGetActionStructUnit1CombinedBases

        jsl $83CD3E
        jsl rlGetNextItemUseRoutine
        rtl

        .databank 0

      rlDelayedFreeUseEffectProc ; 87/BBE5

        .al
        .autsiz
        .databank ?

        lda #<>rlFreeProcAndUpdateCursorCoordinates
        sta aProcSystem.aBody4,b,x
        lda #<>rlDelayUntilActionFinished
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlDelayNextUseRoutine ; 87/BBF2

        .al
        .autsiz
        .databank ?

        lda wMapBattleFlag
        ora wEventEngineStatus,b
        bne +

          jsl rlGetNextItemUseRoutine
        
        +
        rtl

        .databank 0

      rlUnknown87BC00 ; 87/BC00

        .al
        .autsiz
        .databank ?

        lda #$FFFF
        sta $400A,b
        lda #$00FF
        sta $4008,b

        lda #<>rlUnknown87BC1B
        sta lR25
        lda #>`rlUnknown87BC1B
        sta lR25+1
        jsl rlRunRoutineForAllTilesInRange
        rtl

        .databank 0

      rlUnknown87BC1B ; 87/BC1B

        .al
        .autsiz
        .databank $7E

        lda aPlayerVisibleUnitMap,x
        beq +

          lda aTargetableUnitMap,x
          beq +

            lda aMovementMap,x
            cmp $4008,b
            bcs +

              sta $4008,b
              stx $400A,b

        +
        rtl

        .databank 0

      rlStatBoosterAvailabilityCheck ; 87/BC34

        .al
        .autsiz
        .databank ?

        jsr rsGetStatBoosterUseIndex

        lda aStatBoosterStatOffset,x
        tay
        lda aSelectedCharacterBuffer,b,y
        cmp aStatBoosterStatCaps,x
        beq +

        rep #$30
        sec
        rtl
        
        +
        rep #$30
        clc
        rtl

        .databank 0

      rsGetStatBoosterUseIndex ; 87/BC4D

        .al
        .autsiz
        .databank ?

        php
        rep #$30
        ldx #0
        lda aItemDataBuffer.UseEffect,b
        and #$00FF
        
        -
        cmp aStatBoosterUseIndex,x
        beq +

        inc x
        inc x
        bra -
        
        +
        plp
        rts

        .databank 0

      aStatBoosterUseIndex ; 87/BC65

        .word UseEffecLuckRing
        .word UseEffectLifeRing
        .word UseEffectSpeedRing
        .word UseEffectMagicRing
        .word UseEffectStrengthRing
        .word UseEffectBodyRing
        .word UseEffectShieldRing
        .word UseEffectSkillRing
        .word UseEffectLegRing

      aStatBoosterStatOffset ; 87/BC77

        .word structCharacterDataRAM.Luck
        .word structCharacterDataRAM.MaxHP
        .word structCharacterDataRAM.Speed
        .word structCharacterDataRAM.Magic
        .word structCharacterDataRAM.Strength
        .word structCharacterDataRAM.Constitution
        .word structCharacterDataRAM.Defense
        .word structCharacterDataRAM.Skill
        .word structCharacterDataRAM.Movement

      aStatBoosterStatGainOffset ; 87/BC89

        .word structActionStructEntry.LevelUpLuckGain
        .word structActionStructEntry.LevelUpHPGain
        .word structActionStructEntry.LevelUpSpeedGain
        .word structActionStructEntry.LevelUpMagicGain
        .word structActionStructEntry.LevelUpStrengthGain
        .word structActionStructEntry.LevelUpConstitutionGain
        .word structActionStructEntry.LevelUpDefenseGain
        .word structActionStructEntry.LevelUpSkillGain
        .word structActionStructEntry.LevelUpMovementGain

      aUnknown87BC9B ; 87/BC9B

        .word $0003
        .word $0007
        .word $0003
        .word $0003
        .word $0003
        .word $0003
        .word $0003
        .word $0003
        .word $0003

      aStatBoosterStatCaps ; 87/BCAD

        .word 20
        .word 80
        .word 20
        .word 20
        .word 20
        .word 20
        .word 20
        .word 20
        .word 20

      rlStatBoosterUseEffect ; 87/BCBF

        .al
        .autsiz
        .databank $7E

        ldx #<>aActionStructUnit1
        jsl rlActionStructClearLevelUpStatGains

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        sep #$20
        lda aSelectedCharacterBuffer.MaxHP,b
        sta aActionStructUnit1.StartingMaxHP
        rep #$20

        lda aItemDataBuffer.UseEffect,b
        sec
        sbc #2
        and #$00FF
        lsr a
        sta wR0
        asl a
        asl a
        clc
        adc wR0
        asl a
        tax
        ldy #0
        
        -
        lda $888297,x
        and #$00FF
        asl a
        asl a
        sta aUnitAdjustedGrowths,y
        inc x
        inc y
        inc y
        cpy #$0012
        bne -

        ldx #<>aActionStructUnit1
        jsl rlActionStructGetLevelUpStatGains

        sep #$20

        _StatBoosters := [(aSelectedCharacterBuffer.CurrentHP, aActionStructUnit1.LevelUpHPGain)]
        _StatBoosters..= [(aSelectedCharacterBuffer.MaxHP, aActionStructUnit1.LevelUpHPGain)]
        _StatBoosters..= [(aSelectedCharacterBuffer.Strength, aActionStructUnit1.LevelUpStrengthGain)]
        _StatBoosters..= [(aSelectedCharacterBuffer.Magic, aActionStructUnit1.LevelUpMagicGain)]
        _StatBoosters..= [(aSelectedCharacterBuffer.Skill, aActionStructUnit1.LevelUpSkillGain)]
        _StatBoosters..= [(aSelectedCharacterBuffer.Speed, aActionStructUnit1.LevelUpSpeedGain)]
        _StatBoosters..= [(aSelectedCharacterBuffer.Defense, aActionStructUnit1.LevelUpDefenseGain)]
        _StatBoosters..= [(aSelectedCharacterBuffer.Constitution, aActionStructUnit1.LevelUpConstitutionGain)]
        _StatBoosters..= [(aSelectedCharacterBuffer.Luck, aActionStructUnit1.LevelUpLuckGain)]
        _StatBoosters..= [(aSelectedCharacterBuffer.Movement, aActionStructUnit1.LevelUpMovementGain)]

        .for _Stat, _Gain in _StatBoosters

          lda _Stat,b
          clc
          adc _Gain
          sta _Stat,b

        .endfor

        stz aActionStructUnit2.Experience
        stz aActionStructUnit2.StartingExperience
        stz aActionStructUnit2.GainedExperience
        rep #$30

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCombineCharacterDataAndClassBases
        jsl rlActionStructUnknownSetCallback
        jsl $84B69A
        jsl rlGetNextItemUseRoutine
        rtl

        .databank 0

      rsGetSkillManualUseIndex ; 87/BD97

        .al
        .autsiz
        .databank ?

        sep #$20
        ldx #0
        lda aItemDataBuffer.UseEffect,b
        
        -
        cmp aSkillManualData,x
        beq +

        inc x
        inc x
        inc x
        inc x
        bra -
        
        +
        inc x
        rep #$30
        rts

        .databank 0

      aSkillManualData ; 87/BDAF

        .byte UseEffectParagonManual, 0, 0, Skill3Paragon
        .byte UseEffectAccostManual, 0, Skill2Assail, 0
        .byte UseEffectBargainManual, Skill1Bargain, 0, 0
        .byte UseEffectVantageManual, 0, Skill2Vantage, 0
        .byte UseEffectWrathManual, 0, 0, Skill3Wrath
        .byte UseEffectAdeptManual, 0, Skill2Adept, 0
        .byte UseEffectMiracleManual, 0, Skill2Miracle, 0
        .byte UseEffectNihilManual, 0, Skill2Nihil, 0
        .byte UseEffectSolManual, 0, 0, Skill3Sol
        .byte UseEffectLunaManual, 0, 0, Skill3Luna

      rlSkillManualAvailabilityCheck ; 87/BDD7

        .al
        .autsiz
        .databank ?

        jsr rsGetSkillManualUseIndex

        lda aSkillManualData,x
        bit aSelectedCharacterBuffer.Skills1,b
        bne +

          lda aSkillManualData+1,x
          bit aSelectedCharacterBuffer.Skills2,b
          bne +

            sec
            rtl

        +
        clc
        rtl

        .databank 0

      rlSkillManualUseEffect ; 87/BDF0

        .al
        .autsiz
        .databank $7E

        jsr rsGetSkillManualUseIndex

        lda aSelectedCharacterBuffer.Skills1,b
        ora aSkillManualData,x
        sta aSelectedCharacterBuffer.Skills1,b

        lda aSelectedCharacterBuffer.Skills2,b
        ora aSkillManualData+1,x
        sta aSelectedCharacterBuffer.Skills2,b

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        sep #$20
        stz aActionStructUnit1.EquippedItemID1
        lda aItemDataBuffer.DisplayedWeapon,b
        sta aActionStructUnit1.EquippedItemID2
        rep #$30

        jsl rlActionStructUnknownSetCallback
        jsl $84B684
        jsl rlGetNextItemUseRoutine
        rtl

        .databank 0

      rlChestKeyAvailabilityCheck ; 87/BE2F

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
        lda aVisibilityMap,x
        and #$00FF
        beq +

        lda aTerrainMap,x
        and #$00FF
        cmp #TerrainIndoorChest
        beq ++

        cmp #TerrainOutdoorChest
        beq ++
        
        +
        clc
        rtl
        
        +
        sec
        rtl

        .databank 0

      rlDoorKeyAvailabilityCheck ; 87/BE60

        .al
        .autsiz
        .databank ?

        ldx #TerrainDoor
        bra +

      rlBridgeKeyAvailabilityCheck ; 87/BE65

        .al
        .autsiz
        .databank ?

        ldx #TerrainDrawbridge
        
        +
        stx wR17
        stz $A7AD,b

        lda #<>rlUseEffectCheckTerrainEffect
        sta lR25
        lda #>`rlUseEffectCheckTerrainEffect
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

        lda $A7AD,b
        beq +

        sec
        rtl
        
        +
        clc
        rtl

        .databank 0

      rlUseEffectCheckTerrainEffect ; 87/BE99

        .al
        .autsiz
        .databank $7E

        lda aVisibilityMap,x
        and #$00FF
        beq +

          lda aTerrainMap,x
          and #$00FF
          cmp wR17
          bne +

            ldy $A7AD,b
            txa
            sta $A7AF,b,y
            inc y
            inc y
            sty $A7AD,b

        +
        rtl

        .databank 0

      rlLockpickAvailabilityCheck ; 87/BEB8

        .al
        .autsiz
        .databank ?

        lda aSelectedCharacterBuffer.Skills1,b
        bit #Skill1Steal
        beq +

        jsl rlChestKeyAvailabilityCheck
        bcs ++

        jsl rlDoorKeyAvailabilityCheck
        bcs ++

        jsl rlBridgeKeyAvailabilityCheck
        bcs ++
        
        +
        clc
        rtl

        +
        sec
        rtl

        .databank 0

      rlVulneraryAvailabilityCheck ; 87/BED6

        .al
        .autsiz
        .databank ?

        lda #<>aSelectedCharacterBuffer
        sta wR1
        jsl rlCheckItemEquippable
        bcc +

          lda aSelectedCharacterBuffer.CurrentHP,b
          sec
          sbc aSelectedCharacterBuffer.MaxHP,b
          and #$00FF
          beq +

            sec
            rtl

        +
        clc
        rtl

        .databank 0

      rlAntitoxinAvailabilityCheck ; 87/BEF1

        .al
        .autsiz
        .databank ?

        lda aSelectedCharacterBuffer.Status,b
        and #$00FF
        cmp #StatusPoison
        bne +

          sec
          rtl

        +
        clc
        rtl

        .databank 0

      rlTorchAvailabilityCheck ; 87/BF00

        .al
        .autsiz
        .databank ?

        lda wDefaultVisibilityFill,b
        bne +

          lda aSelectedCharacterBuffer.VisionBonus,b
          and #$00FF
          cmp #10
          beq +

            sec
            rtl

        +
        clc
        rtl

        .databank 0

      rlTorchUseEffect ; 87/BF14

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

        jsl $8593EB

        lda #<>rlSetUnitTorchVisionBonus
        sta lUnknown7EA4EC
        lda #>`rlSetUnitTorchVisionBonus
        sta lUnknown7EA4EC+1

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlGetEquippableItemInventoryOffset

        sep #$20
        lda aActionStructUnit1.VisionBonus
        sta aActionStructUnit1.EquippedItemID1
        rep #$20

        lda #Torch
        jsl rlCopyItemDataToBuffer
        jsl $84B5FC
        jsl rlGetNextItemUseRoutine

        plb
        plp
        rtl

        .databank 0

      rlSetUnitTorchVisionBonus ; 87/BF61

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

        sep #$20
        lda #10
        sta aSelectedCharacterBuffer.VisionBonus,b
        rep #$20

        lda #<>aSelectedCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataFromBuffer

        plb
        plp
        rtl

        .databank 0

      rlPureWaterAvailabilityCheck ; 87/BF80

        .al
        .autsiz
        .databank ?

        lda aSelectedCharacterBuffer.MagicBonus,b
        and #$00FF
        cmp #7
        beq +

          sec
          rtl

        +
        clc
        rtl

        .databank 0

      rlVulneraryUseEffect ; 87/BF8F

        .al
        .autsiz
        .databank $7E

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aActionStructUnit1 
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        sep #$20
        lda aActionStructUnit1.MaxHP
        sta aActionStructUnit1.StartingMaxHP

        lda aActionStructUnit1.CurrentHP
        sta aActionStructUnit1.StartingCurrentHP

        lda aActionStructUnit1.MaxHP
        sta aActionStructUnit1.CurrentHP
        sta aSelectedCharacterBuffer.CurrentHP,b
        stz aActionStructUnit2.DeploymentNumber
        rep #$30

        lda #<>aSelectedCharacterBuffer
        sta wR1
        jsl rlGetEquippableItemInventoryOffset

        sep #$20
        lda aItemDataBuffer.DisplayedWeapon,b
        sta aActionStructUnit1.EquippedItemID1
        rep #$20

        lda #<>rlUnknown87BFE5
        sta $A4EC,b
        lda #>`rlUnknown87BFE5
        sta $A4EC+1,b

        jsl rlActionStructMarkSelectableTarget
        jsl $84B5D8
        jsl rlGetNextItemUseRoutine

        rtl

        .databank 0

      rlUnknown87BFE5 ; 87/BFE5

        .al
        .autsiz
        .databank ?

        lda #<>aSelectedCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataFromBuffer
        rtl

        .databank 0

      rlPureWaterUseEffect ; 87/BFEF

        .al
        .autsiz
        .databank $7E

        jsl rlActionStructUnknownSetCallback

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlGetEquippableItemInventoryOffset

        sep #$20
        lda aItemDataBuffer.DisplayedWeapon,b
        sta aActionStructUnit1.EquippedItemID1
        rep #$20

        lda #PureWater
        jsl rlCopyItemDataToBuffer
        jsl rlActionStructMarkSelectableTarget
        jsl $84B5F0

        sep #$20
        lda #7
        sta aSelectedCharacterBuffer.MagicBonus,b
        rep #$20

        jsl rlGetNextItemUseRoutine

        rtl

        .databank 0

      rlChestKeyUseEffect ; 87/C031

        .al
        .autsiz
        .databank ?

        jsl rlUnknownGetMapTileCoordsBySelectedUnit
        jsl rlRunChapterLocationEvents
        jsl rlGetNextItemUseRoutine
        rtl

        .databank 0

      rlKeyUseEffect ; 87/C03E

        .al
        .autsiz
        .databank ?

        jsr rsCheckForNearbyKeyUseTerrain

        ldx $A7AF,b
        jsl rlGetEventCoordinatesByTileIndex
        jsl rlRunChapterLocationEvents
        jsl rlGetNextItemUseRoutine
        rtl

        .databank 0

      rsCheckForNearbyKeyUseTerrain ; 87/C051

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
        lda aTerrainMap,x
        and #$00FF
        cmp #TerrainIndoorChest
        beq +

          cmp #TerrainOutdoorChest
          beq +

            lda #<>rlCheckForNearbyKeyUseTerrainEffect
            sta lR25
            lda #>`rlCheckForNearbyKeyUseTerrainEffect
            sta lR25+1
            jsl rlRunRoutineForTilesIn1Range
            rts

        +
        stx $A7AF,b
        rts

        .databank 0

      rlCheckForNearbyKeyUseTerrainEffect ; 87/C089

        .al
        .autsiz
        .databank $7E

        lda aTerrainMap,x
        and #$00FF
        cmp #TerrainDrawbridge
        beq +

          cmp #TerrainDoor
          beq +

            rtl

        +
        stx $A7AF,b
        rtl

        .databank 0

      rlMasterSealAvailabilityCheck ; 87/C09E

        .al
        .autsiz
        .databank ?

        lda aSelectedCharacterBuffer.Level,b
        and #$00FF
        cmp #10
        bcc _False

          lda aSelectedCharacterBuffer.Character,b
          jsl rlGetUnitPromotedClass

          sep #$20
          ora #0
          beq _False

            sta wR15

            lda aSelectedCharacterBuffer.Skills1,b
            bit #Skill1Mount
            beq +

              lda aSelectedCharacterBuffer.Class,b
              jsl rlCheckIfClassCanDismount
              lda aMountedClassTable,x
              cmp wR15
              beq _False
              bra _True

            +
            lda wR15
            cmp aSelectedCharacterBuffer.Class,b
            beq _False

            _True
            rep #$30
            sec
            rtl
        
        _False
        rep #$30
        clc
        rtl

        .databank 0

      rlMasterSealUseEffect ; 87/C0DF

        .al
        .autsiz
        .databank $7E

        lda aSelectedCharacterBuffer.Character,b
        jsl rlGetUnitPromotedClass
        sta wR0

        jsl rlUpdateClassChangeData

        ldx #<>aActionStructUnit1
        jsl rlActionStructGetTerrainTile

        sep #$20
        sta aActionStructUnit1.TerrainType
        rep #$20

        jsl rlActionStructUnknownSetCallback

        lda #7
        sta wActionStructGeneratedRoundCombatType
        jsl $80D2CE

        jsl rlGetNextItemUseRoutine

        lda #$000E
        sta $0E25,b
        rtl

        .databank 0

      rlUpdateClassChangeData ; 87/C113

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

        lda wR0
        pha

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #-1
        sta wR17
        jsl rlActionStructSingleEntry
        jsr rsCopyActionStructUnit1To2

        lda aSelectedCharacterBuffer.Skills1,b
        and #(Skill1Mount | Skill1MountMove)
        cmp #Skill1Mount
        bne +

          pla
          jsl rlCheckIfClassCanDismount

          lda aDismountedClassTable,x
          pha

        +
        pla
        sep #$20
        sta aSelectedCharacterBuffer.Class,b
        jsl rlCopyClassDataToBuffer

        lda aClassDataBuffer.MapSprite
        sta aSelectedCharacterBuffer.SpriteInfo1,b

        stz aSelectedCharacterBuffer.Experience,b

        lda #1
        sta aSelectedCharacterBuffer.Level,b

        ldx #<>aSelectedCharacterBuffer
        stx wR1
        lda aSelectedCharacterBuffer.Class,b
        xba
        lda aActionStructUnit1.StartingClass
        rep #$30

        jsl rlUpdateMountDismountSkills
        jsl rlForceDismountOnImpassibleTiles

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #-1
        sta wR17
        jsl rlActionStructSingleEntry

        sep #$20
        stz aActionStructUnit1.EquippedItemID2
        stz aActionStructUnit1.EquippedItemID1
        stz aActionStructUnit1.EquippedItemMaxDurability
        stz aActionStructUnit2.EquippedItemID2
        stz aActionStructUnit2.EquippedItemID1
        stz aActionStructUnit2.EquippedItemMaxDurability

        lda #$FF
        sta aActionStructUnit1.BattleMight
        sta aActionStructUnit1.BattleAdjustedHit
        sta aActionStructUnit1.BattleDefense
        sta aActionStructUnit2.BattleMight
        sta aActionStructUnit2.BattleAdjustedHit
        sta aActionStructUnit2.BattleDefense
        rep #$30

        jsr rsUnknown87C48C

        plb
        plp
        rtl

        .databank 0

      rsCopyActionStructUnit1To2 ; 87/C1B2

        .al
        .autsiz
        .databank ?

        phb
        ldx #<>aActionStructUnit1
        ldy #<>aActionStructUnit2
        lda #size(structActionStructEntry)-1
        mvn `aActionStructUnit1, `aActionStructUnit2
        plb
        rts

        .databank 0

      rsUnknown87C1C1 ; 87/C1C1

        .al
        .autsiz
        .databank $7E

        sep #$20
        ldx #0
        stx $A7AD,b

        ldx wMapTileCount,b
        dec x

        -
        lda aVisibilityMap,x
        and #$00FF
        beq _Next

        lda aTerrainMap,x
        cmp #TerrainIndoorChest
        beq +

        cmp #TerrainOutdoorChest
        bne _Next
        
        +
        pha
        rep #$30
        ldy $A7AD,b
        txa
        sta $A7AF,b,y
        inc y
        inc y
        sty $A7AD,b

        sep #$20
        pla
        
        _Next
        dec x
        bpl -

        rep #$30
        rts

        .databank 0

      rlUnknown87C1F7 ; 87/C1F7

        .al
        .autsiz
        .databank ?

        jsr rsUnknown87C1C1

        lda $A7AF,b
        beq +

          sec
          rtl

        +
        clc
        rtl

        .databank 0

      rlUnknown87C203 ; 87/C203

        .al
        .autsiz
        .databank $7E

        stz aProcSystem.aBody7,b,x

        lda #1
        sta $4F59,b

        jsr rsUnknown87C1C1
        jsl rlGetNextItemUseRoutine

        lda lItemUseRoutine
        sta lR18
        lda lItemUseRoutine+1
        sta lR18+1
        rtl

        .databank 0

      rlUnknown87C21E ; 87/C21E

        .al
        .autsiz
        .databank ?

        jmp (lR18)

      rlClearStaffUseEffectMenu ; 87/C221

        .al
        .autsiz
        .databank $7E

        stz aActiveMenuSlots
        jsl rlMenuDrawAllMenusFromBuffers
        jsl rlGetNextItemUseRoutine
        rtl

        .databank 0

      rlUnknown87C22D ; 87/C22D

        .al
        .autsiz
        .databank ?

        ; Identical to rlHandleRewarpStaffUseEffect

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer
        jsl rlActionStructStaff
        jsl rlGetActionStructUnit1CombinedBases

        jsl $83CD3E
        jsl rlGetNextItemUseRoutine
        rtl

        .databank 0

      rlHammerneStaffUseAvailabilityCheck ; 87/C24C

        .al
        .autsiz
        .databank ?

        jsr rsMakeHammerneStaffTargetList

        lda $A7AF,b
        beq +

          sec
          rtl

        +
        clc
        rtl

        .databank 0

      rlMakeHammerneStaffUseEffectTargetList ; 87/C258

        .al
        .autsiz
        .databank $7E

        lda #0
        sta aProcSystem.aBody7,b,y
        stz wMenuLineScrollCount

        lda #$FFFF
        sta wTerrainWindowSide

        lda #0
        sta wTradeWindowType

        jsr rsMakeHammerneStaffTargetList

        jsl rlGetNextItemUseRoutine

        lda lItemUseRoutine
        sta lR18
        lda lItemUseRoutine+1
        sta lR18+1
        rtl

        .databank 0

      rlUnknown87C27F ; 87/C27F

        .al
        .autsiz
        .databank ?

        jmp (lR18)

      rsMakeHammerneStaffTargetList ; 87/C282

        .al
        .autsiz
        .databank ?

        stz $A7AD,b

        lda aSelectedCharacterBuffer.X,b
        and #$00FF
        sta wR0
        lda aSelectedCharacterBuffer.Y,b
        and #$00FF
        sta wR1
        jsl rlGetMapTileIndexByCoords
        tax

        lda #<>rlMakeHammerneStaffTargetListEffect
        sta lR25
        lda #>`rlMakeHammerneStaffTargetListEffect
        sta lR25+1
        jsl rlRunRoutineForTilesIn1Range

        ldx $A7AD,b
        stz $A7AF,b,x
        rts

        .databank 0

      rlMakeHammerneStaffTargetListEffect ; 87/C2AF

        .al
        .autsiz
        .databank $7E

        lda aPlayerVisibleUnitMap,x
        and #$00FF
        beq +

          jsl rlCheckIfAllegianceMatchesPhase
          bcs +

            sta wR0
            lda #<>aBurstWindowCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            lda #<>aBurstWindowCharacterBuffer
            sta wR1
            jsr rsCheckInventoryForDamagedItem
            bcc +

              ldx $A7AD,b
              lda aBurstWindowCharacterBuffer.DeploymentNumber,b
              sta $A7AF,b,x
              inc x
              inc x
              stx $A7AD,b

        +
        rtl

        .databank 0

      rsCheckInventoryForDamagedItem ; 87/C2E1

        .al
        .autsiz
        .databank ?

        lda #size(structCharacterDataRAM.Items) / size(word)
        sta wR2

        lda wR1
        clc
        adc #structCharacterDataRAM.Items
        sta wR1

        stz wR17
        
        -
        lda (wR1)
        beq +

        jsl rlCheckIfDamagedItem
        bcc _Next

        sec
        rts

        _Next
        inc wR1
        inc wR1
        dec wR2
        bne -
        
        +
        clc
        rts

        .databank 0

      rlHandleStaffItemSelectMenu ; 87/C306

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderUnknownTimer,b,x
        jsl rlMenuCopyActiveMenuCopyCurrentSlotToTemp

        jsr rsStaffItemSelectMenuInputHandler
        jsr rsDrawStaffItemSelectMenuCursor

        rtl

        .databank 0

      rsDrawStaffItemSelectMenuCursor ; 87/C314

        .al
        .autsiz
        .databank $7E

        lda wMenuLineScrollCount
        clc
        adc #5
        asl a
        asl a
        asl a
        sta wR1
        lda aActiveMenuTemp.Position.X
        and #$00FF
        asl a
        asl a
        asl a
        inc a
        sta wR0
        jsl rlDrawRightFacingCursor
        rts

        .databank 0

      rsStaffItemSelectMenuInputHandler ; 87/C331

        .al
        .autsiz
        .databank $7E

        pea #<>_End-1

        lda wJoy1Repeated
        bit #JOY_Up
        bne _UpPressed

        bit #JOY_Down
        bne _DownPressed

        lda wJoy1New
        bit #JOY_B
        bne _BPressed

        bit #JOY_A
        bne _APressed

        rts
        
        _End
        rts

        _UpPressed
        lda wMenuLineScrollCount
        bne +

        lda wJoy1New
        cmp wJoy1Repeated
        bne _Return

        lda $4F06,b
        sta wMenuLineScrollCount
        
        +
        dec wMenuLineScrollCount
        dec wMenuLineScrollCount

        lda #9
        jsl rlPlaySound
        
        _Return
        rts

        _DownPressed
        lda $4F06,b
        dec a
        dec a
        cmp wMenuLineScrollCount
        bne +

        lda wJoy1New
        cmp wJoy1Repeated
        bne _Return

        lda #$FFFE
        sta wMenuLineScrollCount
        
        +
        inc wMenuLineScrollCount
        inc wMenuLineScrollCount

        lda #9
        jsl rlPlaySound
        rts

        _BPressed
        lda $4F36,b
        sta lR18
        lda $4F36+1,b
        sta lR18+1

        phk
        pea #<>(+)-1
        jml [lR18]
        
        +
        lda #$0021
        jsl rlPlaySound
        rts

        _APressed
        lda wMenuLineScrollCount
        sta $4FA0,b
        jsl rlGetNextItemUseRoutine

        lda #$000D
        jsl rlPlaySound
        rts

        .databank 0

      rlUnknown87C3BC ; 87/C3BC

        .al
        .autsiz
        .databank $7E

        ldx wMenuLineScrollCount
        lda $4F0A,b,x
        dec a
        sta $4FA0,b
        jmp rlHandleTargetStaffUseEffect

        .databank 0

      rlUnknown87C3C9 ; 87/C3C9

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody7,b,x
        tax
        lda $A7AF,b,x
        jsl rlGetMapCoordsByTileIndex

        lda wR0
        sta $4FA0,b
        lda wR1
        sta $4FA2,b
        jmp rlUnknown87C22D

        .databank 0

      rlMakeUnlockStaffTargetList ; 87/C3E1

        .al
        .autsiz
        .databank $7E

        stz $A7AD,b

        ldx #0
        sep #$20

        _Loop
        inc x
        cpx wMapTileCount,b
        beq _End

        lda aVisibilityMap,x
        and #$FF
        beq _Loop

        lda aTerrainMap,x
        cmp #TerrainIndoorChest
        beq +

        cmp #TerrainOutdoorChest
        beq +

        cmp #TerrainDoor
        beq +

        cmp #TerrainDrawbridge
        bne _Loop

        +
        rep #$30
        ldy $A7AD,b
        txa
        sta $A7AF,b,y
        inc y
        inc y
        sty $A7AD,b

        sep #$20
        bra _Loop
        
        _End
        rep #$30
        rtl

        .databank 0

      rlUnlockStaffUseAvailabilityCheck ; 87/C41E

        .al
        .autsiz
        .databank ?

        jsl rlMakeUnlockStaffTargetList

        lda $A7AD,b
        beq +

          sec
          rtl

        +
        clc
        rtl

        .databank 0

      rlMakeUnlockStaffUseEffectTargetList ; 87/C42B

        .al
        .autsiz
        .databank $7E

        stz aProcSystem.aBody7,b,x

        lda #1
        sta $4F59,b

        jsl rlMakeUnlockStaffTargetList

        jsl rlGetNextItemUseRoutine

        lda lItemUseRoutine
        sta lR18
        lda lItemUseRoutine+1
        sta lR18+1
        rtl

        .databank 0

      rlUnknown87C447 ; 87/C447

        .al
        .autsiz
        .databank ?

        jmp (lR18)

        .databank 0

      rlAntitoxinUseEffect ; 87/C44A

        .al
        .autsiz
        .databank $7E

        jsl rlActionStructUnknownSetCallback

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlGetEquippableItemInventoryOffset

        sep #$20
        lda aItemDataBuffer.DisplayedWeapon,b
        sta aActionStructUnit1.EquippedItemID1
        rep #$20

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        lda #Antidote
        jsl rlCopyItemDataToBuffer
        jsl rlActionStructMarkSelectableTarget
        jsl $84B5E4

        sep #$20
        lda #0
        sta aSelectedCharacterBuffer.Status,b
        rep #$20

        jsl rlGetNextItemUseRoutine
        rtl

        .databank 0

      rsUnknown87C48C ; 87/C48C

        .al
        .autsiz
        .databank $7E

        sep #$20

        _ClassStatGains :=[(aActionStructUnit1.CurrentHP, aActionStructUnit2.CurrentHP, aActionStructUnit1.LevelUpHPGain)]
        _ClassStatGains..=[(aActionStructUnit1.Strength, aActionStructUnit2.Strength, aActionStructUnit1.LevelUpStrengthGain)]
        _ClassStatGains..=[(aActionStructUnit1.Magic, aActionStructUnit2.Magic, aActionStructUnit1.LevelUpMagicGain)]
        _ClassStatGains..=[(aActionStructUnit1.Skill, aActionStructUnit2.Skill, aActionStructUnit1.LevelUpSkillGain)]
        _ClassStatGains..=[(aActionStructUnit1.Speed, aActionStructUnit2.Speed, aActionStructUnit1.LevelUpSpeedGain)]
        _ClassStatGains..=[(aActionStructUnit1.Defense, aActionStructUnit2.Defense, aActionStructUnit1.LevelUpDefenseGain)]
        _ClassStatGains..=[(aActionStructUnit1.Constitution, aActionStructUnit2.Constitution, aActionStructUnit1.LevelUpConstitutionGain)]
        _ClassStatGains..=[(aActionStructUnit1.Movement, aActionStructUnit2.Movement, aActionStructUnit1.LevelUpMovementGain)]

        .for _StartStat, _FinalStat, _Gain in _ClassStatGains

          lda _StartStat
          sec
          sbc _FinalStat
          sta _Gain

        .endfor

        rep #$30

        jsl rlActionStructUnknownSetCallback

        ldx #<>aSelectedCharacterBuffer
        ldy #<>aActionStructUnit1
        jsl $83AD94
        rts

        .databank 0

      procUnknown87C4EF .block ; 87/C4EF

        .dstruct structProcInfo, None, rlProcUnknown87C4EFInit, rlHandleUseEffectCycle, None

      .bend

      rlProcUnknown87C4EFInit ; 87/C4F7

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

        stz $0302,b

        lda #PhaseGraphicEffect
        sta aItemDataBuffer.UseEffect,b
        jsl rlGetItemUseEffectPointer

        plb
        plp
        rtl

        .databank 0

      rlUnknown87C511 ; 87/C511

        .al
        .autsiz
        .databank ?

        stz $4061,b

        lda #<>rlUnknown87C52C
        sta lR25
        lda #>`rlUnknown87C52C
        sta lR25+1
        lda wCurrentPhase,b
        jsl rlRunRoutineForAllUnitsInAllegiance

        ldx $4061,b
        stz $4063,b,x
        rtl

        .databank 0

      rlUnknown87C52C ; 87/C52C

        .al
        .autsiz
        .databank ?

        lda aTargetingCharacterBuffer.UnitState,b
        bit #(UnitStateHidden | UnitStateGrayed)
        bne +

          lda aTargetingCharacterBuffer.Status,b
          and #$00FF
          cmp #StatusBerserk
          bne +

            ldx $4061,b
            lda $0EF4,b
            and #$00FF
            sta $4063,b,x
            inc $4061,b

        +
        rtl

        .databank 0

      rlMakeThiefStaffTargetList ; 87/C54F

        .al
        .autsiz
        .databank ?

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aTemporaryActionStruct
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer
        jsl rlCombineCharacterDataAndClassBases

        lda #<>aTemporaryActionStruct
        sta wR1
        jsl rlGetEquippableItemInventoryOffset

        ldx #<>aTemporaryActionStruct
        jsl rlActionStructGetItemBonusesItemPreset

        lda aTemporaryActionStruct.Magic,b
        and #$00FF
        sta wR17

        stz $A7AD,b

        lda #<>rlMakeThiefStaffTargetListEffect
        sta lR25
        lda #>`rlMakeThiefStaffTargetListEffect
        sta lR25+1
        jsl rlRunRoutineForAllTilesVisibleByPlayer

        ldx $A7AD,b
        stz $A7AF,b,x
        rtl

        .databank 0

      rlMakeThiefStaffTargetListEffect ; 87/C591

        .al
        .autsiz
        .databank ?

        jsl rlCheckIfAllegianceDoesNotMatchPhaseTarget
        bcc +

          rep #$30
          sta wR0

          lda #<>aTargetingCharacterBuffer
          sta wR1
          jsl rlCopyCharacterDataToBufferByDeploymentNumber

          _C5A4
          lda aTargetingCharacterBuffer.Skills2,b
          bit #Skill3Immortal << 8
          bne +

            lda aTargetingCharacterBuffer.UnitState,b
            bit #(UnitStateDead | UnitStateUnknown1 | UnitStateUnselectable | UnitStateRescued | UnitStateHidden | UnitStateDisabled | UnitStateCaptured)
            bne +

              lda aTargetingCharacterBuffer.Items,b
              beq +

                lda #<>aTargetingCharacterBuffer
                sta wR1
                jsl rlCombineCharacterDataAndClassBases

                lda #<>aTargetingCharacterBuffer
                sta wR1
                jsl rlGetEquippableItemInventoryOffset

                ldx #<>aTargetingCharacterBuffer
                jsl rlActionStructGetItemBonusesItemPreset

                lda aTargetingCharacterBuffer.Magic,b
                and #$00FF
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
        sep #$20
        rtl

        .databank 0

      rlThiefStaffUseAvailabilityCheck ; 87/C5F0

        .al
        .autsiz
        .databank ?

        jsl rsCheckForThiefStaffTarget

        lda $A7AF,b
        beq +

          sec
          rtl

        +
        clc
        rtl

        .databank 0

      rlMakeThiefStaffUseEffectTargetList ; 87/C5FD

        .al
        .autsiz
        .databank $7E

        lda #0
        sta aProcSystem.aBody7,b,x

        stz wMenuLineScrollCount

        lda #$FFFF
        sta wTerrainWindowSide

        lda #4
        sta wTradeWindowType

        jsl rlMakeThiefStaffTargetList

        jsl rlGetNextItemUseRoutine

        lda lItemUseRoutine
        sta lR18
        lda lItemUseRoutine+1
        sta lR18+1
        rtl

        .databank 0

      rlUnknown87C625 ; 87/C625

        .al
        .autsiz
        .databank ?

        jmp (lR18)

        .databank 0

      rlGetActionStructUnit1CombinedBases ; 87/C628

        .al
        .autsiz
        .databank ?

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCombineCharacterDataAndClassBases
        rtl

        .databank 0

      rlUnknown87C632 ; 87/C632

        .al
        .autsiz
        .databank ?

        lda $4FA2,b
        beq +

          jsl rlCopyItemDataToBuffer
          jsl rlMenuClearActiveMenus
          jsl rlSetupInventoryFullConvoyMenu

        +
        jsl rlGetNextItemUseRoutine
        rtl

        .databank 0

      rlWaitForThiefStaffProcFinish ; 87/C648

        .al
        .autsiz
        .databank ?

        phx
        lda #(`$86E475)<<8
        sta lR44+1
        lda #<>$86E475
        sta lR44
        jsl rlProcEngineFindProc
        plx
        bcs +

          jsl rlGetNextItemUseRoutine
        
        +
        rtl

        .databank 0

      rlFreeWatchStaffUseEffectProc ; 87/C65F

        .al
        .autsiz
        .databank ?

        jsl rlProcEngineFreeProc

        lda #3
        sta $0302,b
        lda #1
        sta $0E2B,b

        jsl $838A72
        rtl

        .databank 0

      procUnknown87C674 .block ; 87/C674

        .dstruct structProcInfo, None, rlProcUnknown87C674Init, rlHandleUseEffectCycle, None

      .bend

      rlProcUnknown87C674Init ; 87/C67C

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

        lda #6
        sta $0E25,b
        stz $0302,b
        lda #UseEffectUnknown
        sta aItemDataBuffer.UseEffect,b
        jsl rlGetItemUseEffectPointer

        plb
        plp
        rtl

        .databank 0

      rlSDrinkUseAvailabilityCheck ; 87/C69C

        .al
        .autsiz
        .databank ?

        lda aSelectedCharacterBuffer.Character,b
        cmp #Leif
        beq +

        lda aSelectedCharacterBuffer.Fatigue,b
        and #$00FF
        beq +

        sec
        rtl
        
        +
        clc
        rtl

        .databank 0

      rlSDrinkUseEffect ; 87/C6B0

        .al
        .autsiz
        .databank $7E

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        lda #<>aSelectedCharacterBuffer
        sta wR1
        jsl rlGetEquippableItemInventoryOffset

        sep #$20
        lda aActionStructUnit1.CurrentHP
        sta aActionStructUnit1.StartingCurrentHP

        lda aActionStructUnit1.MaxHP
        sta aActionStructUnit1.StartingMaxHP

        lda aItemDataBuffer.DisplayedWeapon,b
        sta aActionStructUnit1.EquippedItemID1

        stz aSelectedCharacterBuffer.Fatigue,b
        rep #$30

        jsl rlActionStructUnknownSetCallback
        jsl rlActionStructMarkSelectableTarget
        jsl $84B5D8
        jsl rlGetNextItemUseRoutine
        rtl

        .databank 0

      rlKiaStaffUseAvailabilityCheck ; 87/C6F1

        .al
        .autsiz
        .databank ?

        jsr rsMakeKiaStaffTargetList

        lda $A7AF,b
        beq +

          sec
          rtl

        +
        clc
        rtl

        .databank 0

      rlMakeKiaStaffUseEffectTargetList ; 87/C6FD

        .al
        .autsiz
        .databank $7E

        stz aProcSystem.aBody7,b,x

        jsr rsMakeKiaStaffTargetList

        jsl rlGetNextItemUseRoutine

        lda lItemUseRoutine
        sta lR18
        lda lItemUseRoutine+1
        sta lR18+1
        rtl

        .databank 0

      rlUnknown87C712 ; 87/C712

        .al
        .autsiz
        .databank ?

        jmp (lR18)

      rsMakeKiaStaffTargetList ; 87/C715

        .al
        .autsiz
        .databank ?

        stz $A7AD,b

        lda #<>rlMakeKiaStaffTargetListEffect
        sta lR25
        lda #>`rlMakeKiaStaffTargetListEffect
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
        rts

        .databank 0

      rlMakeKiaStaffTargetListEffect ; 87/C742

        .al
        .autsiz
        .databank $7E

        lda aPlayerVisibleUnitMap,x
        and #$00FF
        beq +

          jsl rlCheckIfAllegianceDoesNotMatchPhaseTarget
          bcs +

            sta wR0
            lda #<>aTargetingCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            lda aTargetingCharacterBuffer.Status,b
            and #$00FF
            cmp #StatusPetrify
            bne +

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

      rlUnknown87C778 ; 87/C778

        .al
        .autsiz
        .databank ?

        sta wR0

        php
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb

        jsl rlUpdateClassChangeData

        plb
        plp
        rtl

        .databank 0

      rsCheckForStatusStaffTarget ; 87/C78B

        .al
        .autsiz
        .databank $7E

        lda aItemDataBuffer.UseEffect,b
        and #$00FF

        ldx #StatusBerserk
        cmp #UseEffectBerserkStaff
        beq +

        ldx #StatusSleep
        cmp #UseEffectSleepStaff
        beq +

        ldx #StatusSilence
        cmp #UseEffectSilenceStaff
        beq +

        ldx #$FFFF
        
        +
        stx $4FA2,b

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCombineCharacterDataAndClassBases

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlGetEquippableItemInventoryOffset

        ldx #<>aActionStructUnit1
        jsl rlActionStructGetItemBonusesItemPreset

        lda aActionStructUnit1.Magic
        and #$00FF
        sta $4FA0,b

        stz $A7AD,b

        lda #<>rlCheckForStatusStaffTargetEffect
        sta lR25
        lda #>`rlCheckForStatusStaffTargetEffect
        sta lR25+1
        jsl rlRunRoutineForAllFoes

        ldx $A7AD,b
        stz $A7AF,b,x
        rts

        .databank 0

      rlCheckForStatusStaffTargetEffect ; 87/C7F7

        .al
        .autsiz
        .databank ?

        lda $A7AD,b
        bne +

          jsl rlMakeStatusStaffTargetListEffect._B946
          rep #$30

        +
        rtl

        .databank 0

      rsCheckForThiefStaffTarget ; 87/C803

        .al
        .autsiz
        .databank ?

        lda #<>aSelectedCharacterBuffer
        sta wR0
        lda #<>aTemporaryActionStruct
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer
        jsl rlCombineCharacterDataAndClassBases

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlGetEquippableItemInventoryOffset

        ldx #<>aActionStructUnit1
        jsl rlActionStructGetItemBonusesItemPreset

        lda aTemporaryActionStruct.Magic,b
        and #$00FF
        sta wR17

        stz $A7AD,b

        lda #<>rlCheckForThiefStaffTargetEffect
        sta lR25
        lda #>`rlCheckForThiefStaffTargetEffect
        sta lR25+1
        jsl rlRunRoutineForAllFoes

        ldx $A7AD,b
        stz $A7AF,b,x
        rtl

        .databank 0

      rlCheckForThiefStaffTargetEffect ; 87/C845

        .al
        .autsiz
        .databank ?

        lda $A7AD,b
        bne +

          jsl rlMakeThiefStaffTargetListEffect._C5A4
          rep #$30

        +
        rtl

        .databank 0

        ; 87/C851

    .endsection ItemUseEffectsSection
 
.endif
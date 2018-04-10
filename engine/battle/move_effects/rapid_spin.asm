BattleCommand_ClearHazards: ; 37b39
; clearhazards

	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	bit SUBSTATUS_LEECH_SEED, [hl]
	jr z, .not_leeched
	res SUBSTATUS_LEECH_SEED, [hl]
	ld hl, ShedLeechSeedText
	call StdBattleTextBox
.not_leeched

	ld hl, wPlayerScreens
	ld de, wPlayerWrapCount
	ld a, [hBattleTurn]
	and a
	jr z, .got_screens_wrap
	ld hl, wEnemyScreens
	ld de, wEnemyWrapCount
.got_screens_wrap
	bit SCREENS_SPIKES, [hl]
	jr z, .no_spikes
	res SCREENS_SPIKES, [hl]
	ld hl, BlewSpikesText
	push de
	call StdBattleTextBox
	pop de
.no_spikes

	ld a, [de]
	and a
	ret z
	xor a
	ld [de], a
	ld hl, ReleasedByText
	jp StdBattleTextBox

; 37b74
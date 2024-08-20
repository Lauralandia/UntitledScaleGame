extends Node2D


var visible_characters = 0
@onready var text_sound_sfx = $TextSoundSFX
@onready var end_mission_log = $endMissionLog

var playEndMissionLog = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if end_mission_log.visible_ratio < 1 && playEndMissionLog == true:
		end_mission_log.visible_ratio += 0.1 * delta
		if !text_sound_sfx.is_playing():
			text_sound_sfx.play()
	await get_tree().create_timer(180).timeout
	get_parent().restartGame()

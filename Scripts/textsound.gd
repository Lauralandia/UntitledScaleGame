extends Control

var visible_characters = 0
@onready var text_sound_sfx = $TextSoundSFX
@onready var mission_log = $MissionLog
var playMissionLog = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mission_log.visible_ratio < 1 && playMissionLog == true:
		mission_log.visible_ratio += 0.1 * delta
		if !text_sound_sfx.is_playing():
			text_sound_sfx.play()
	#if visible_characters != $MissionLog.visible_characters:
		#visible_characters = $MissionLog.visible_characters

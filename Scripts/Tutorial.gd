extends Node

@onready var controls_label = $ControlsLabel
@onready var objectives_label = $ObjectivesLabel
@onready var intro_missionlog = $"../introMissionlog"


func startTutorial():
	controls_label.visible = true
	objectives_label.visible = true
	await get_tree().create_timer(30).timeout
	controls_label.visible = false
	objectives_label.visible = false

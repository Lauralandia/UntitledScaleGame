extends Node2D

@onready var pause_menu = $HUD/pauseMenu
var paused = false
var map = false
@onready var map_border = $HUD/mapBorder
@onready var map_overlay = $HUD/mapBorder/mapScreen
@onready var marker = $HUD/mapBorder/mapScreen/marker


func _process(delta):

	if Input.is_action_just_pressed("pause"):
		pauseMenu()	
	if Input.is_action_just_pressed("map"):
		mapOverlay()

		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused

func mapOverlay():
	marker.position.x = get_node("areaOne").get_node("mainShip").position.x
	marker.position.y = get_node("areaOne").get_node("mainShip").position.y
	if map:
		map_border.hide()
		Engine.time_scale = 1
	else:
		map_border.show()
		Engine.time_scale = 0
	map = !map

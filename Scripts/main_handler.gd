extends Control

@onready var settings_menu = $settingsMenu

func _ready():
	get_node("mainMenu/MarginContainer/VBoxContainer/newGame").pressed.connect(on_new_game_pressed)
	get_node("mainMenu/MarginContainer/VBoxContainer/settings").pressed.connect(on_settings_pressed)
	get_node("mainMenu/MarginContainer/VBoxContainer/exitGame").pressed.connect(on_exit_game_pressed)

func on_new_game_pressed():
	get_node("mainMenu").queue_free()
	var game_scene = load("res://Scenes/main_game.tscn").instantiate()
	add_child(game_scene)

func on_settings_pressed():
	settings_menu.show()

func on_exit_game_pressed():
	get_tree().quit()

func restartGame():
	get_tree().reload_current_scene()
	Engine.time_scale = 1
	#get_node("mainGame").queue_free()
	#var game_scene = load("res://Scenes/main_game.tscn").instantiate()
	#add_child(game_scene)

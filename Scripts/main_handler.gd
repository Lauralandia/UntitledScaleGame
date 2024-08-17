extends Control

@onready var settings_menu = $settingsMenu

func _ready():
	get_node("mainMenu/MarginContainer/VBoxContainer/newGame").pressed.connect(on_new_game_pressed)
	get_node("mainMenu/MarginContainer/VBoxContainer/settings").pressed.connect(on_settings_pressed)
	get_node("mainMenu/MarginContainer/VBoxContainer/exitGame").pressed.connect(on_exit_game_pressed)


func on_new_game_pressed():
	get_node("mainMenu").queue_free()

func on_settings_pressed():
	settings_menu.show()

func on_exit_game_pressed():
	get_tree().quit()


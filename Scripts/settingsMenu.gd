extends Control

@onready var bg_vol_slider = $ColorRect/MarginContainer/VBoxContainer/BG_vol_slider
@onready var sfx_vol_slider = $ColorRect/MarginContainer/VBoxContainer/SFX_vol_slider
var bus_index_bg
var bus_index_sfx

func _ready():
	bus_index_bg = AudioServer.get_bus_index("BG")
	bus_index_sfx = AudioServer.get_bus_index("SFX")
	#bg_vol_slider.value_changed.connect(_on_bg_vol_slider_value_changed)
	#sfx_vol_slider.value_changed.connect(_on_sfx_vol_slider_value_changed)

func _on_bg_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_db(bus_index_bg, linear_to_db(bg_vol_slider.value))

func _on_sfx_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_db(bus_index_sfx, linear_to_db(sfx_vol_slider.value))

func _on_back_pressed():
	hide()

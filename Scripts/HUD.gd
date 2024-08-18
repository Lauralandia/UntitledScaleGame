extends CanvasLayer

@onready var health_bar = $healthBG/healthBar
@onready var fuel_bar = $fuelBG/fuelBar
@onready var fuel_timer = $fuelBG/fuelTimer

var ship_health = 100
var ship_fuel = 1000

func _process(delta) -> void:
	health_bar.value = ship_health
	fuel_bar.value = ship_fuel

	if health_bar.value <= 0 or fuel_bar.value <= 0:
		get_parent().get_parent().restartGame()

func _on_fuel_timer_timeout():
	ship_fuel -= 1

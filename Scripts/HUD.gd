extends CanvasLayer

@onready var health_bar = $healthBG/healthBar
@onready var fuel_bar = $fuelBG/fuelBar
@onready var fuel_timer = $fuelBG/fuelTimer
@onready var main_ship = get_parent().get_node("areaOne").get_node("mainShip")
@onready var debris_counter = $DebrisCounter

var ship_health = 50
var ship_fuel = 500

func _process(delta) -> void:
	health_bar.value = ship_health
	fuel_bar.value = ship_fuel
	debris_counter.text = "Space Debris Collected: " + str(main_ship.upgrade_resource)
	
	if health_bar.value <= 0 or fuel_bar.value <= 0:
		get_parent().get_parent().restartGame()

func _on_fuel_timer_timeout():
	ship_fuel -= 1

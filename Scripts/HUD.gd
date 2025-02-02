extends CanvasLayer

@onready var health_bar = $healthBG/healthBar
@onready var fuel_bar = $fuelBG/fuelBar
@onready var fuel_timer = $fuelBG/fuelTimer
@onready var main_ship = get_parent().get_node("areaOne").get_node("mainShip")
@onready var debris_counter = $DebrisCounter
@onready var intro_missionlog = $introMissionlog
@onready var camera_2d = $"../areaOne/mainShip/Camera2D"
@onready var tutorial = $Tutorial

var playedTutorial = false
var playedMissionLog = false
var ship_health = 50
var ship_fuel = 500

func _ready():
	#Engine.time_scale = 0
	get_tree().paused = true

func _process(delta) -> void:
	if Input.is_action_just_pressed("laser_attack"):
		intro_missionlog.visible = false
		get_tree().paused = false
		intro_missionlog.playMissionLog = false
		playedMissionLog = true
		
	if playedTutorial == false && playedMissionLog == true:
		tutorial.startTutorial()
		playedTutorial = true
		
	health_bar.value = ship_health
	fuel_bar.value = ship_fuel
	debris_counter.text = "Space Debris Collected: " + str(main_ship.upgrade_resource)
	
	if health_bar.value <= 0 or fuel_bar.value <= 0:
		Engine.time_scale = 0.1
		camera_2d.startCameraShake(delta)
		main_ship.ship_explosion.visible = true
		main_ship.ship_explosion.play()
		await get_tree().create_timer(.5).timeout
		Engine.time_scale = 1
		get_parent().get_parent().restartGame()

func _on_fuel_timer_timeout():
	ship_fuel -= 1


extends Area2D

@onready var spawn_timer = $spawnTimer
@onready var target_ship = get_parent().get_parent().get_node("mainShip")
@export var spawn_range = 300
@export var debrisTypeMax = 3
@export var debrisTypeMin = 1
@onready var collision_shape_2d = $CollisionShape2D

func _physics_process(delta) -> void:
	var dist_to_targ = global_position.distance_to(target_ship.global_position)
	if dist_to_targ < spawn_range && spawn_timer.is_stopped():
		spawn_timer.start()

func _on_spawn_timer_timeout():
	var debris : PackedScene
	var randomDebris = randi_range(debrisTypeMin,debrisTypeMax)
	match(randomDebris):
		1:
			debris = load("res://Scenes/space_debris.tscn")
		2:
			debris = load("res://Scenes/debris_tier2.tscn")
		3:
			debris = load("res://Scenes/debris_tier3.tscn")
	if debris != null:
		var new_debris = debris.instantiate()
		get_parent().get_parent().get_node("Debris").add_child(new_debris)
		new_debris.global_position.x = position.x + randf_range(-200, 200)
		new_debris.global_position.y = position.y + randf_range(-200, 200)

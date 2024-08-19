extends Area2D

@onready var spawn_timer = $spawnTimer
@onready var target_ship = get_parent().get_parent().get_node("mainShip")
var spawn_range = 500

func _physics_process(delta) -> void:
	var dist_to_targ = global_position.distance_to(target_ship.global_position)
	if dist_to_targ < spawn_range && spawn_timer.is_stopped():
		spawn_timer.start()
	print(dist_to_targ)

func _on_spawn_timer_timeout():
	var ufo_enemy :  PackedScene = load("res://Scenes/enemy_ufo.tscn")
	var new_enemy = ufo_enemy.instantiate()
	get_parent().get_parent().add_child(new_enemy)
	#var t = Transform2D()
	#t.x *= 0.5
	#t.y *= 0.5
	#new_enemy.transform = t
	new_enemy.global_position.x = position.x + randf_range(-400, 400)
	new_enemy.global_position.y = position.y + randf_range(-400, 400)

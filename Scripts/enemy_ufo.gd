extends CharacterBody2D

var enemy_health = 100
@onready var gun_one = $gunOne
@onready var gun_two = $gunTwo
@onready var target_ship = get_parent().get_parent().get_node("mainShip")
var target_pos
var orig_pos
var speed = 100
var rotation_speed = 1
var aggro_range = 500
var min_pursuit = 100

func _physics_process(delta) -> void:
	orig_pos = target_ship.global_position
	target_pos = (orig_pos -  global_position).normalized()
	rotation_degrees += rotation_speed
	#look_at(orig_pos)
	
	var dist_to_targ = position.distance_to(orig_pos)
	
	if dist_to_targ > aggro_range:
		speed = 0
	elif dist_to_targ > min_pursuit:
		speed = 100
	else:
		speed = 0
	
	if enemy_health <= 0:
		queue_free()
		
	velocity = target_pos * speed
	move_and_slide()

func fire_guns():
	if (position.distance_to(target_ship.global_position) <= aggro_range):
		var basic_gunfire :  PackedScene = load("res://Scenes/gun_fire.tscn")
		var proj_one = basic_gunfire.instantiate()
		get_parent().add_child(proj_one)
		proj_one.global_position = gun_one.global_position
		proj_one.dir = (target_ship.global_position - global_position).normalized()
		var proj_two = basic_gunfire.instantiate()
		get_parent().add_child(proj_two)
		proj_two.global_position = gun_two.global_position
		proj_two.dir = (target_ship.global_position - global_position).normalized()
	
func _on_gun_fire_timeout():
	fire_guns()

extends CharacterBody2D

var enemy_health = 30
@onready var gun_mount = $gunMount
@onready var target_ship = get_parent().get_parent().get_node("mainShip")
var target_pos
var orig_pos
var speed = 100
@onready var sprite = $Sprite2D
@onready var port_in = $AnimatedSprite2D

var aggro_range = 400
var min_pursuit = 200

func _ready() -> void:
	port_in.play()
	await get_tree().create_timer(0.9).timeout
	sprite.visible = true
	port_in.visible = false

func _physics_process(delta) -> void:
	orig_pos = target_ship.global_position
	target_pos = (orig_pos -  global_position).normalized()
	look_at(orig_pos)
	
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
		var proj = basic_gunfire.instantiate()
		get_parent().add_child(proj)
		proj.global_position = gun_mount.global_position
		proj.dir = (target_ship.global_position - global_position).normalized()
	
func _on_gunfire_cd_timeout():
	fire_guns()

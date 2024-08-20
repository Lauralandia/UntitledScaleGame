extends CharacterBody2D

@onready var ship_sprite = $Sprite2D
@export var MAX_SPEED := 300
@onready var HUD = get_parent().get_parent().get_node("HUD")
@onready var ship_hit = $shipHit
@onready var ship_thruster = $ship_thruster
@onready var ship_thruster_2 = $ship_thruster2
@onready var ship_thruster_3 = $ship_thruster3

@onready var right_wing_t_1 = $right_wing_t1
@onready var right_wing_t_2 = $right_wing_t2
@onready var left_wing_t_1 = $left_wing_t1
@onready var left_wing_t_2 = $left_wing_t2
@onready var cockpit_t_1 = $cockpit_t1
@onready var cockpit_t_2 = $cockpit_t2
@onready var AP = $HitFlashAnimation
@onready var collision_shape_0 = $hitBox/CollisionShape0
@onready var collision_shape_1 = $hitBox/CollisionShape1
@onready var collision_shape_2 = $hitBox/CollisionShape2
@onready var collision_shape_3 = $hitBox/CollisionShape3
@onready var collision_shape_4 = $hitBox/CollisionShape4
@onready var collision_shape_5 = $hitBox/CollisionShape5
@onready var collision_shape_6 = $hitBox/CollisionShape6

var upgrade_tier = 0
var upgrade_resource = 0

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_west", "move_east", "move_north", "move_south")

	if direction != Vector2.ZERO:
		if upgrade_tier > 5:
			MAX_SPEED = 700
			ship_thruster_3.show()
		elif upgrade_tier > 2:
			MAX_SPEED = 500
			ship_thruster_2.show()
		else:
			MAX_SPEED = 300
			ship_thruster.show()
	else:
		ship_thruster.hide()
		ship_thruster_2.hide()
		ship_thruster_3.hide()
	
	velocity = direction * MAX_SPEED

	move_and_slide()
	look_at(get_global_mouse_position())
	
#func _unhandled_key_input(event):
	#if Input.is_action_just_pressed("interact"):
		#upgrade_tier += 1
		#update_tier()

func update_tier ():
	if (upgrade_resource >= 180):
		upgrade_tier = 6
	elif (upgrade_resource >= 125):
		upgrade_tier = 5
	elif (upgrade_resource >= 80):
		upgrade_tier = 4
	elif (upgrade_resource >= 50):
		upgrade_tier = 3
	elif (upgrade_resource >= 35):
		upgrade_tier = 2
	elif (upgrade_resource >= 20):
		upgrade_tier = 1
	
	match (upgrade_tier):
		0:
			right_wing_t_1.hide()
			left_wing_t_1.hide()
			cockpit_t_1.hide()
			right_wing_t_2.hide()
			left_wing_t_2.hide()
			cockpit_t_2.hide()
		1:
			collision_shape_1.disabled = false
			right_wing_t_1.show()
		2:
			collision_shape_1.disabled = false
			collision_shape_2.disabled = false
			right_wing_t_1.show()
			left_wing_t_1.show()
		3:
			collision_shape_1.disabled = false
			collision_shape_2.disabled = false
			collision_shape_3.disabled = false
			right_wing_t_1.show()
			left_wing_t_1.show()
			cockpit_t_1.show()
		4:
			collision_shape_1.disabled = false
			collision_shape_2.disabled = false
			collision_shape_3.disabled = false
			collision_shape_4.disabled = false
			right_wing_t_1.show()
			left_wing_t_1.show()
			cockpit_t_1.show()
			right_wing_t_2.show()
		5:
			collision_shape_1.disabled = false
			collision_shape_2.disabled = false
			collision_shape_3.disabled = false
			collision_shape_4.disabled = false
			collision_shape_5.disabled = false
			right_wing_t_1.show()
			left_wing_t_1.show()
			cockpit_t_1.show()
			right_wing_t_2.show()
			left_wing_t_2.show()
		6:
			collision_shape_1.disabled = false
			collision_shape_2.disabled = false
			collision_shape_3.disabled = false
			collision_shape_4.disabled = false
			collision_shape_5.disabled = false
			collision_shape_6.disabled = false
			right_wing_t_1.show()
			left_wing_t_1.show()
			cockpit_t_1.show()
			right_wing_t_2.show()
			left_wing_t_2.show()
			cockpit_t_2.show()

func _on_hit_box_body_entered(body):
	if body.is_in_group("gunfire"):
		HUD.ship_health -= 1
		if AP != null && !AP.is_playing():
			AP.play("hit_flash")
		ship_hit.play()
		body.queue_free()

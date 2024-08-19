extends CharacterBody2D

@onready var ship_sprite = $Sprite2D
@export var MAX_SPEED := 300
@onready var HUD = get_parent().get_parent().get_node("HUD")
@onready var ship_hit = $shipHit

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_west", "move_east", "move_north", "move_south")
	velocity = direction * MAX_SPEED
	move_and_slide()
	look_at(get_global_mouse_position())

func _on_hit_box_body_entered(body):
	HUD.ship_health -= 1
	ship_hit.play()
	if body.is_in_group("gunfire"):
		body.queue_free()
	ship_sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	ship_sprite.modulate = Color.WHITE

extends Area2D

@onready var target_ship = get_parent().get_parent().get_node("mainShip")
var visibility_range = 500

func _physics_process(delta):
	var dist_to_targ = global_position.distance_to(target_ship.global_position)
	if dist_to_targ < visibility_range:
		modulate = Color.YELLOW
		await get_tree().create_timer(1).timeout
		modulate = Color.WHITE

func _on_body_entered(body):
	pass # Replace with function body.

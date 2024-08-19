extends Area2D

@onready var AP = $AP
@onready var target_ship = get_parent().get_parent().get_node("mainShip")
@onready var collect_resource = $CollectResource

var visibility_range = 300

func _physics_process(delta):
	var dist_to_targ = global_position.distance_to(target_ship.global_position)
	if dist_to_targ < visibility_range:
		if AP != null && !AP.is_playing():
			AP.play("flash")

func _on_body_entered(body):
	if body.is_in_group("main_ship"):
		body.get_node("collectResource").play()
		var value := randi_range(1, 3)
		var old_tier = body.upgrade_tier
		body.upgrade_resource += value
		body.update_tier()
		if body.upgrade_tier > old_tier:
			body.get_node("upgradeTierSFX").play()
		
		queue_free()
		var number = Label.new()
		target_ship.get_parent().add_child(number)
		number.global_position.x = position.x + 40
		number.global_position.y = position.y - 40
		number.z_index = 5
		number.text = "+" + str(value)
		number.label_settings = LabelSettings.new()
		number.label_settings.font_size = 20
		number.label_settings.font_color = Color(0, 1, 0, 1)
		number.label_settings.outline_color = Color(0, 0, 0, 1)
		number.label_settings.outline_size = 1		
		#call_deferred("add_child", number)		
		await number.resized		
		number.pivot_offset = Vector2(number.size/2)		
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		tween.tween_property(number, "position:y", number.position.y - 24, 0.25).set_ease(Tween.EASE_OUT)
		tween.tween_property(number, "position:y", number.position.y, 0.5).set_ease(Tween.EASE_IN).set_delay(0.25)
		tween.tween_property(number, "scale", Vector2.ZERO, 0.25).set_ease(Tween.EASE_IN).set_delay(0.5)
		
		await tween.finished
		number.queue_free()
		

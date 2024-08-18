extends RayCast2D

@onready var line_2d = $Line2D
@onready var beam_particles = $BeamParticles
@onready var start_particles = $startParticles
@onready var end_particles = $endParticles
@onready var laser_sound = $laser_sound
@onready var laser_hit = $laser_hit

var tween_beam
var is_casting := false

func _ready() -> void:
	tween_beam = create_tween()

func _physics_process (delta: float) -> void:
	if Input.is_action_pressed("laser_attack") && get_parent().get_parent().get_parent().paused == false && get_parent().get_parent().get_parent().map == false:
		is_casting = true
		start_particles.emitting = is_casting
		beam_particles.emitting = is_casting
		end_particles.emitting = is_colliding()
		if !laser_sound.is_playing():
			laser_sound.play()
		show_beam()
		use_laser()
	else:
		is_casting = false
		start_particles.emitting = is_casting
		beam_particles.emitting = is_casting
		end_particles.emitting = is_colliding() && is_casting
		line_2d.points[1] =  Vector2.ZERO
		laser_sound.stop()
		hide_beam()
	
func use_laser():
	
	if (is_casting):
		var cast_point := target_position
		force_raycast_update()
		line_2d.points[1] = cast_point

		if is_colliding():
			var end_point := get_collision_point()
			var beam_length = global_position.distance_to(end_point)
			line_2d.points[1] = Vector2(beam_length, 0)
			beam_particles.process_material.emission_shape_scale.x = beam_length/2
			beam_particles.process_material.emission_shape_offset.x = beam_length/2
			end_particles.global_rotation = get_collision_normal().angle()
			end_particles.position = Vector2(beam_length, 0)
			do_damage()
			
func show_beam():
	if tween_beam.is_running():
		tween_beam.stop()
	tween_beam = create_tween()
	tween_beam.tween_property(line_2d, "width", 5, 0.1)
	tween_beam.play()
	
func hide_beam():
	if tween_beam.is_running():
		tween_beam.stop()
	tween_beam = create_tween()
	tween_beam.tween_property(line_2d, "width", 0, 0.1)
	tween_beam.play()
	
func do_damage():
	if is_colliding():
		laser_hit.play()
		var target = get_collider()
		target.enemy_health -= 1
		target.get_node("Sprite2D").modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		if target != null:
			target.get_node("Sprite2D").modulate = Color.WHITE


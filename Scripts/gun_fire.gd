extends CharacterBody2D

@export var SPEED = 200.0
@export var dir := Vector2.ZERO

func _physics_process(delta) -> void:
	velocity = dir * SPEED
	move_and_slide()

func _on_expire_timeout():
	queue_free()

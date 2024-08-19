extends ParallaxBackground

@onready var back_layer = $BackLayer
@onready var front_layer = $FrontLayer
@onready var mid_layer = $MidLayer


func _process(delta):
	mid_layer.motion_offset.y += 5*delta
	mid_layer.motion_offset.x += 5*delta
	front_layer.motion_offset.y += 10*delta
	front_layer.motion_offset.x += 10*delta

extends Line2D

var tween = create_tween()

func use_laser():
	tween.tween_property(self, "width", 10, 1)

extends Label


func _ready() -> void:
	percent_visible = 0
	triggerAnimation()

func triggerAnimation() -> void:
	$Tween.interpolate_property(self, "percent_visible", 0, 1, 0.6, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.2)
	$Tween.start()

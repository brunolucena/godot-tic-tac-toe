extends ImageClass


func _init() -> void:
	mark = GameConfig.UserMark.Circle

func _ready() -> void:
	value = 0

func animate_in():
	var tween = $Tween
	tween.interpolate_property(self, "value", 0, 100, 1, Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
	tween.start()

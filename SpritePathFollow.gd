extends Node


func _ready() -> void:
	var initial_position = $Path2D.curve.get_baked_points()[0]
	$Path2D/PathFollow2D/SpritePathFollow.position = initial_position

func _process(delta: float) -> void:
	$Path2D/PathFollow2D.offset += 250 * delta

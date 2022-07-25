class_name Mark
extends Area2D

onready var Circle := $Circle
onready var Cross := $Cross

var mark: ImageClass = null setget set_mark


func start(_mark: int):
	set_mark(_mark)
	mark.animate_in()

func set_mark(_mark):
	match _mark:
		GameConfig.UserMark.Cross:
			mark = Cross
		GameConfig.UserMark.Circle:
			mark = Circle

func _on_Mark_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if !mark:
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
			start(GameConfig.current_turn)
			GameConfig.emit_signal("mark_added", [self])

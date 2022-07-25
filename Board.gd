class_name Board
extends ColorRect

onready var MarkButton := preload("res://Mark.tscn")

export var animation_speed := 0.4

var board := [
	[null, null, null],
	[null, null, null],
	[null, null, null],
]


func _init() -> void:
	GameConfig.connect("mark_added", self, '_on_GameConfig_mark_added')

func _ready() -> void:
	create_board()
	animate_in()

func animate_in() -> void:
	$Bars/VerticalBars.rect_scale = Vector2(0, 1)
	$Bars/HorizontalBars.rect_scale = Vector2(0, 1)
	yield(get_tree().create_timer(1), "timeout")
	var tween = $Tween
	tween.interpolate_property($Bars/VerticalBars, 'rect_scale', Vector2(0, 1), Vector2(1, 1), animation_speed, Tween.TRANS_CIRC, Tween.EASE_OUT)
	tween.interpolate_property($Bars/HorizontalBars, 'rect_scale', Vector2(0, 1), Vector2(1, 1), animation_speed, Tween.TRANS_CIRC, Tween.EASE_OUT)
	tween.start()

func create_board():
	for row in range(3):
		for column in range(3):
			var node_position = get_node("Rows/Row%s/%s-%s" % [row, column, row]) as Position2D			
			var mark = MarkButton.instance()
			mark.position = node_position.position
			board[row][column] = mark

			add_child(mark)

func _on_GameConfig_mark_added(_mark: Mark):
	check_win()

func check_win():
	var winner: Mark = null
	
	# check rows
	for row in range(board.size()):
		var has_winner = true
		var first_mark = board[row][0]

		for column in range(board[row].size()):
			var current = board[row][column]

			if (current and current.mark) && (first_mark and first_mark.mark):
				var mark = first_mark.mark.mark
				var current_mark =  current.mark.mark

				if current_mark != mark:
					has_winner = false
					break

		if has_winner:
			winner = first_mark
			break

	# check columns
#	for row in range(board.size()):
#		var has_winner = false
#		var first_mark
#
#		for column in range(board[row].size()):
#			first_mark = board[column][0]
#			var current = board[column][row]
#
#			if (current and current.mark) && (first_mark and first_mark.mark):
#				var mark = first_mark.mark.mark
#				var current_mark =  current.mark.mark
#
#				if current_mark != mark:
#					has_winner = false
#					break
#
#		if has_winner:
#			winner = first_mark
#			break

	var matches = 0
	
	# check first diagonal
#	for i in range(board.size()):
#		var has_winner = true
#		var current = board[0][0]
#
#		if i < board.size():
#			var next = board[i][i]
#
#			if (next and next.mark and next.mark.mark) and (current and current.mark and current.mark.mark):
#				var current_mark = current.mark.mark
#				var next_mark = next.mark.mark
#
#				if next_mark == current_mark:
#					matches += 1
#		if matches == 3:
#			winner = board[0][0]
#
#	matches = 0	
			
	if winner:
		GameConfig.emit_signal("game_ended", [winner])

extends Node

signal mark_added(mark)
signal game_ended(winner)

var current_turn = UserMark.Cross
var winner: Mark = null

enum UserMark {
	None = 0,
	Cross = 1,
	Circle = 2,
}

func get_next_turn() -> int:
	return UserMark.Cross if current_turn == UserMark.Circle else UserMark.Circle

func _on_GameConfig_mark_added(_mark: Mark):
	current_turn = get_next_turn()

func _on_GameConfig_game_ended(_winner: Mark):
	print("game ended", _winner)
	winner = _winner

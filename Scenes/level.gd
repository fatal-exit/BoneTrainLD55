extends Node2D

func _on_player_entered_border(area):
	if area.is_in_group("PlayerHead"):
		GameManager._game_over()

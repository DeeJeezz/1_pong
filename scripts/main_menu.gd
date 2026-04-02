extends Control

const _AI_GAME_SCENE_NAME: String = "res://scenes/ai_game.tscn"
const _PLAYER_GAME_SCENE_NAME: String = "res://scenes/game.tscn"


func _on_vsai_button_button_down() -> void:
	get_tree().change_scene_to_file(_AI_GAME_SCENE_NAME)


func _on_vs_player_button_button_down() -> void:
	get_tree().change_scene_to_file(_PLAYER_GAME_SCENE_NAME)


func _on_exit_button_button_down() -> void:
	get_tree().quit()

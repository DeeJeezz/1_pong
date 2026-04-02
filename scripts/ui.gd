extends Control
class_name UI


@export var start_game_panel: Panel
@export var left_player_score_label: Label
@export var right_player_score_label: Label
@export var menu_panel: Panel
	
	
func show_start_screen() -> void:
	start_game_panel.show()
	
	
func hide_start_screen() -> void:
	start_game_panel.hide()


func set_left_player_score(score: int) -> void:
	left_player_score_label.text = "%s" % score
	
	
func set_right_player_score(score: int) -> void:
	right_player_score_label.text = "%s" % score
	
	
func show_menu() -> void:
	menu_panel.show()
	
	
func hide_menu() -> void:
	menu_panel.hide()


func _on_resume_button_button_down() -> void:
	Signals.resume_game.emit()


func _on_restart_game_button_button_down() -> void:
	Signals.restart_game.emit()


func _on_exit_button_button_down() -> void:
	Signals.exit_game.emit()

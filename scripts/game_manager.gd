extends Node2D

const _BALL_SCENE_NAME: String = "res://scenes/ball.tscn"
const _MAIN_MENU_SCENE_NAME: String = "res://scenes/main_menu.tscn"
const _DEFAULT_START_SCORE: int = 0

@onready var ball_scene: PackedScene = preload(_BALL_SCENE_NAME)

@export var left_paddle: BasePaddle
@export var right_paddle: BasePaddle
@export var ui: UI


var _current_ball: Ball
var _screen_size: Vector2
var _ball_spawn_position: Vector2
var _left_player_score: int
var _right_player_score: int

var _vs_ai: bool = false


func _ready() -> void:
	
	# Vs other player or vs AI.
	_vs_ai = right_paddle is AIPaddle
	
	_screen_size = get_viewport_rect().size
	_ball_spawn_position = _screen_size / 2
	
	# Setup UI.
	ui.show_start_screen()
	ui.set_left_player_score(_DEFAULT_START_SCORE)
	ui.set_right_player_score(_DEFAULT_START_SCORE)
	
	# Connect signals.
	Signals.resume_game.connect(_on_resume_game)
	Signals.restart_game.connect(_on_restart_game)
	Signals.exit_game.connect(_on_exit_game)


func _pause_game() -> void:
	ui.show_menu()
	get_tree().paused = true


func _on_resume_game() -> void:
	ui.hide_menu()
	get_tree().paused = false
	
	
func _on_restart_game() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	
	
func _on_exit_game() -> void:
	get_tree().change_scene_to_file(_MAIN_MENU_SCENE_NAME)


func _launch_ball() -> Ball:
	var ball: Ball = ball_scene.instantiate()
	ball.global_position = _ball_spawn_position
	add_child(ball)
	if _vs_ai:
		right_paddle.set_target(ball)

	return ball


func _handle_input() -> void:
	if Input.is_action_just_pressed("launch_ball"):
		if !_current_ball:
			ui.hide_start_screen()
			_current_ball = _launch_ball()
			
	if Input.is_action_just_pressed("menu"):
		_pause_game()


func _check_if_ball_leave_screen() -> void:
	if !_current_ball:
		return
		
	if _current_ball.global_position.x < 0 || _current_ball.global_position.x > _screen_size.x:
		if _current_ball.global_position.x < 0:
			_left_player_score += 1
			ui.set_left_player_score(_left_player_score)
		elif _current_ball.global_position.x > _screen_size.x:
			_right_player_score += 1
			ui.set_right_player_score(_right_player_score)
		_current_ball.queue_free()
		ui.show_start_screen()


func _process(_delta: float) -> void:
	_handle_input()
	_check_if_ball_leave_screen()

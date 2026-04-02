extends BasePaddle
class_name PlayerPaddle


const AXES: Array = [
	["wasd_move_left", "wasd_move_right"],
	["arrow_move_left", "arrow_move_right"],
]
@export_enum('WASD', 'ARROWS') var input_axis


var _chosen_input_axis: Array

func _ready() -> void:
	_chosen_input_axis = AXES[input_axis]
	
	super._ready()


func _handle_input(delta: float) -> void:
	var input: float = Input.get_axis(_chosen_input_axis[0], _chosen_input_axis[1])
	if input:
		position.y += input * delta * SPEED


func _process(delta: float) -> void:
	_handle_input(delta)
	clamp_movement()

extends BasePaddle
class_name AIPaddle


const _FOLLOW_SPEED: float = 3.2

var _target: Ball


func set_target(target: Ball) -> void:
	_target = target
	
	
func _process(delta: float) -> void:
	if !_target:
		return
		
	position.y = lerp(position.y, _target.position.y, _FOLLOW_SPEED * delta)
	clamp_movement()

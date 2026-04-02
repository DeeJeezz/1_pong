extends StaticBody2D
class_name BasePaddle


const SPEED: float = 450.0
const _WALL_OFFSET: float = 30.0

@export var paddle: Node2D
@export var collision_shape: CollisionShape2D
@export var color: Color

var _screen_size: Vector2
var _top_border: Vector2
var _bottom_border: Vector2
var _half_paddle_size: float


func _ready() -> void:
	# Setup collision size.
	var sprite: Sprite2D = paddle.get_child(0)
	collision_shape.shape.size = sprite.scale
	
	# Setup constant values.
	_screen_size = get_viewport_rect().size
	_half_paddle_size = collision_shape.shape.size.y / 2
	_top_border = Vector2(
		position.x,
		_WALL_OFFSET + _half_paddle_size,
	)
	_bottom_border = Vector2(
		position.x,
		_screen_size.y - _WALL_OFFSET - _half_paddle_size,
	)
	
	sprite.modulate = color
	


func clamp_movement() -> void:
	position = position.clamp(
		_top_border,
		_bottom_border,
	)

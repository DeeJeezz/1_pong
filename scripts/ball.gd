extends RigidBody2D
class_name Ball

const THRUST: Vector2 = Vector2(42500.0, 0)
const RANDOM_ROTATION_ANGLE: float = 22.5

@export var sprite: Sprite2D
@export var collision_shape: CollisionShape2D


func _ready() -> void:
	# Setup collision shape.
	if collision_shape.shape is CircleShape2D:
		collision_shape.shape.radius = sprite.texture.get_width() / 2

	apply_central_force(THRUST.rotated(_get_random_angle_radians()))


func _get_random_angle_radians() -> float:
	return deg_to_rad(
		randf_range(
			-RANDOM_ROTATION_ANGLE, 
			RANDOM_ROTATION_ANGLE,
		),
	)

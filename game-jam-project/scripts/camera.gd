class_name PlayerCamera
extends Camera3D

@export var target: CharacterBody3D
@export var env: Node3D
var dead_zone: float = 0.1667
var limit_left: Marker3D
var limit_right: Marker3D
var smoothing_speed: float
var screen_size: Vector2
var left: float
var right: float

func _ready() -> void:
	# Init Variables
	limit_left = env.limit_left
	limit_right = env.limit_right
	
		# Security
	assert(env != null, "env non assigné sur PlayerCamera")
	assert(limit_left != null, "limit_left manquant sur env")
	assert(limit_right != null, "limit_right manquant sur env")

	smoothing_speed = (get_parent() as Player).SPEED / 10
	screen_size = get_viewport().get_visible_rect().size
	left  = screen_size.x * (0.5 - dead_zone)
	right = screen_size.x * (0.5 + dead_zone)
	get_viewport().size_changed.connect(_on_viewport_resized)

# Security
func _on_viewport_resized() -> void:
	screen_size = get_viewport().get_visible_rect().size
	left  = screen_size.x * (0.5 - dead_zone)
	right = screen_size.x * (0.5 + dead_zone)

func _process(delta: float) -> void:
	if not target:
		return

	var screen_pos: Vector2 = unproject_position(target.global_position)
	var dynamic_speed: float

	if screen_pos.x > right and not is_position_in_frustum(limit_right.global_position):
		dynamic_speed = remap(screen_pos.x, right, screen_size.x, smoothing_speed, smoothing_speed * 5.0)
	elif screen_pos.x < left and not is_position_in_frustum(limit_left.global_position):
		dynamic_speed = remap(screen_pos.x, left, 0.0, smoothing_speed, smoothing_speed * 5.0)
	else:
		return
	global_position.x = lerp(global_position.x, target.global_position.x, dynamic_speed * delta)

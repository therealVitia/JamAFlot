extends Node3D

@export var color_rect: ColorRect
@export var player: CharacterBody3D
@export var camera: Camera3D
@export var hidden_time_required: float = 0.5
@export var transition_duration: float = 1.0

var visibility_points: Node3D
var hidden_timer: float = 0.0
var transition_started: bool = false
var current_tween: Tween = null

func _ready() -> void:
	visibility_points = player.get_node("visibilityPoints")

func _physics_process(delta: float) -> void:
	if is_player_fully_hidden():
		hidden_timer += delta
		if hidden_timer >= hidden_time_required and not transition_started:
			start_transition()
	else:
		hidden_timer = 0.0
		if transition_started:
			cancel_transition()

func start_transition() -> void:
	transition_started = true
	var mat = color_rect.material as ShaderMaterial
	current_tween = create_tween()
	current_tween.tween_method(
		func(value: float): mat.set_shader_parameter("progress", value),
		0.0, 1.0, transition_duration
	)

func cancel_transition() -> void:
	transition_started = false
	if current_tween:
		current_tween.kill()
		current_tween = null
	reset_shader()

func reset_shader() -> void:
	var mat = color_rect.material as ShaderMaterial
	mat.set_shader_parameter("progress", 0.0)

func is_player_fully_hidden() -> bool:
	var space_state = get_world_3d().direct_space_state
	for point in visibility_points.get_children():
		var query = PhysicsRayQueryParameters3D.create(
			camera.global_position,
			point.global_position
		)
		query.collide_with_bodies = true
		query.collide_with_areas = false
		var result = space_state.intersect_ray(query)
		if result.is_empty() or result.collider == player:
			return false
	return true

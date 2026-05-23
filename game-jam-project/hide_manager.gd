extends Node

@export var player: CharacterBody3D
@export var camera: Camera3D
@export var visibility_points: Node3D
@export var hidden_time_required: float = 0.5

var hidden_timer: float = 0.0
var transition_started: bool = false

func _physics_process(delta: float) -> void:
	if transition_started:
		return

	if is_player_fully_hidden():
		hidden_timer += delta
		if hidden_timer >= hidden_time_required:
			start_transition()
	else:
		hidden_timer = 0.0

func is_player_fully_hidden() -> bool:
	var space_state = get_world_3d().direct_space_state

	for point in visibility_points.get_children():
		var query = PhysicsRayQueryParameters3D.create(
			camera.global_position,
			point.global_position
		)
		query.exclude = [player.get_rid()]  # on ignore le joueur
		query.collide_with_bodies = true
		query.collide_with_areas = false

		var result = space_state.intersect_ray(query)

		# Aucun obstacle → ce point est visible directement
		if result.is_empty():
			return false

	return true

func start_transition() -> void:
	transition_started = true
	print("Transition !")
	# TODO : cinématique + swap monde

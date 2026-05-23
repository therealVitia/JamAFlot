extends Node3D

@export var enemy: CharacterBody3D

var last_pos: Vector3

func _ready() -> void:
	get_tree().paused = true

func _process(delta: float) -> void:
	pass
	

func new_game() -> void:
	$Player.start($StartPosition)

func swap_world() -> void:
	var new_pos: Vector3 = last_pos
	last_pos = $Player.position
	$Player.start(new_pos)


func _on_hud_start_game() -> void:
	$HUD.hide()
	get_tree().paused = false

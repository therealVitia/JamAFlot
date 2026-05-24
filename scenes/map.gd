extends Node3D

@export var enemy: CharacterBody3D
@onready var lvl: Resource = preload("res://scenes/end.tscn")

var last_pos: Vector3

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	var count_collectible: int = get_tree().get_nodes_in_group("collectible").size()
	print(count_collectible)
	if count_collectible == 0:
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_packed(lvl)
	

func new_game() -> void:
	$Player.start($StartPosition)

func swap_world() -> void:
	var new_pos: Vector3 = last_pos
	last_pos = $Player.position
	$Player.start(new_pos)


func _on_hud_start_game() -> void:
	$HUD.hide()
	get_tree().paused = false

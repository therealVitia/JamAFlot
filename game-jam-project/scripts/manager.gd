class_name Manager
extends Node

var count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_collectible_collected() -> void:
	count += 1
	if count == 4:
		print("All collectible collected")

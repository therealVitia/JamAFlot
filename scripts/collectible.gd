class_name Collectible
extends Node

signal collected

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		collected.emit()
		queue_free()

class_name Collectible
extends Node

@onready var anim: AnimatedSprite3D = $AnimatedSprite3D


signal collected

func _ready() -> void:
	anim.play("collectible")

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		collected.emit()
		AutoBus.collectible_found.emit()
		queue_free()

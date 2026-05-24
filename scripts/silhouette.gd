extends Node3D

@onready var body: RigidBody3D = $RigidBody3D
@onready var collision: CollisionShape3D = $RigidBody3D/CollisionShape3D
@onready var anim: AnimatedSprite3D = $AnimatedSprite3D
@export var type_shape: int = 0
@export var type_voice: int = 0
var isWorld: bool = true

func _ready() -> void:
	type_shape = type_shape % 5
	type_voice = type_voice % 6
	AutoBus.swap_complete.connect(switch)

func switch() -> void:
	if isWorld:
		call_deferred("_disable_all")
	else:
		call_deferred("_enable_all")

func _disable_all() -> void:
	collision.disabled = true
	anim.stop()
	anim.visible = false
	body.freeze = true
	isWorld = false

func _enable_all() -> void:
	match type_shape:
		1: anim.play("Bnpc1")
		2: anim.play("Bnpc2")
		3: anim.play("Bnpc3")
		4: anim.play("Bnpc4")
		_: pass
	anim.visible = true
	collision.disabled = false
	body.freeze = false
	isWorld = true

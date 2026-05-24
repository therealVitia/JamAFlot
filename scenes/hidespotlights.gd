extends Node3D

@onready var _isReal: bool = true
@export var anim: AnimationPlayer
@export var spotlight: SpotLight3D

func _ready() -> void:
	AutoBus.swap.connect(_turnOffLights)

func _turnOffLights() -> void:
	var anim_player: AnimationPlayer = spotlight.get_node_or_null("AnimationPlayer")

	if _isReal:
		_isReal = false
		spotlight.light_energy = 3.0
		visible = true
		anim_player.play()
	else:
		_isReal = true
		spotlight.light_energy = 0.0
		visible = false
		anim.stop()

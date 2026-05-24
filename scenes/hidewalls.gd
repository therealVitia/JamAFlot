extends Node3D

@onready var _isReal: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AutoBus.swap.connect(_hide_wall)

func _hide_wall() -> void:
	if _isReal:
		_isReal = false
		visible = false
	else:
		_isReal = true
		visible = true

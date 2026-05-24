extends Node3D

@onready var _isReal: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AutoBus.swap.connect(_swap_floor)

func _swap_floor() -> void:
	if _isReal:
		_isReal = false
		visible = true
	else:
		_isReal = true
		visible = false;

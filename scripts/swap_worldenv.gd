extends WorldEnvironment

@onready var _isReal: bool = true
@export var env_light: Environment
@export var env_dark: Environment

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AutoBus.swap.connect(_swap_env_file)


func _swap_env_file() -> void:
	if _isReal:
		_isReal = false
		if (get_environment() == env_dark):
			set_environment(env_light)
	else:
		_isReal = true
		if (get_environment() == env_light):
			set_environment(env_dark)

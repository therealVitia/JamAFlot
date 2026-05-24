extends AudioStreamPlayer

@onready var isWorld : bool = true

func _ready() -> void:
	AutoBus.contact.connect(incBPM)
	AutoBus.swap.connect(decBPM)

func incBPM() -> void:
	pitch_scale = 2.0

func decBPM() -> void:
	if isWorld:
		pitch_scale = 0.5
		isWorld = false
	else:
		pitch_scale = 1.0
		isWorld = true

	

extends CanvasLayer

@onready var color_rect : ColorRect = $ColorRect  # l'enfant direct
@onready var isWorld: bool = true

func _ready() -> void:
	AutoBus.swap.connect(_turnOnOff)

func _turnOnOff() -> void:
	if isWorld:
		color_rect.visible = !isWorld
		isWorld = !isWorld
	else:
		color_rect.visible = !isWorld
		isWorld = !isWorld

extends AudioStreamPlayer

@export var musicSafe: AudioStream
@export var musicUnsafe: AudioStream

var isWorld : bool = true

func _ready() -> void:
	AutoBus.swap.connect(_switch_music)
	volume_db -= 20
	stream = musicSafe
	play(0.0)
	

func _switch_music() -> void:
	stop()
	if isWorld:
		stream = musicUnsafe
		play(0.0)
		isWorld = false
	else:
		stream = musicSafe
		isWorld = true
		play(0.0)

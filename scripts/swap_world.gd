extends Node3D
@export var transition_duration: float = 1.0
var nodeWorld: Node3D
var nodeImagine: Node3D
var _tween: Tween
var _is_swapped: bool = false
var meshImagine: MeshInstance3D
var meshWorld: MeshInstance3D


func _ready() -> void:
	nodeWorld = get_child(0)
	nodeImagine = get_child(1)
	meshImagine = nodeImagine.get_child(0)
	meshWorld = nodeWorld.get_child(0)
	meshWorld.transparency = 0.0
	meshImagine.transparency = 1.0
	AutoBus.swap.connect(_on_shader_trigger)

func _on_shader_trigger() -> void:
	if not _is_swapped:
		_smooth_transition_to(1.0, 0.0)
	else:
		_smooth_transition_to(0.0, 1.0)
	_is_swapped = !_is_swapped

func _smooth_transition_to(world_target: float, imagine_target: float) -> void:
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.set_trans(Tween.TRANS_CUBIC)
	_tween.set_parallel(true)
	_tween.tween_property(meshWorld, "transparency", world_target, transition_duration)
	_tween.tween_property(meshImagine, "transparency", imagine_target, transition_duration)
	_tween.chain().tween_callback(func(): AutoBus.swap_complete.emit())

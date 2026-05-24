extends Control
@onready var lvl: Resource = preload("res://scenes/map.tscn")
var option: bool = false

func _ready() -> void:
	$Options.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		$Options.hide()
		$VBoxContainer.show()
		$Message.show()
		option = false

# Function with signal
func _on_start_button_button_down() -> void:
	await get_tree().create_timer(1).timeout # A changer si on doit attendre plus longtemps avant de lancer le jeu
	get_tree().change_scene_to_packed(lvl)

func _on_quit_button_button_down() -> void:
	get_tree().quit()


func _on_options_button_down() -> void:
	$Options.show()
	$VBoxContainer.hide()
	$Message.hide()
	option = true

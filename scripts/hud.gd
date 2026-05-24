extends CanvasLayer

@onready var button_container: VBoxContainer = $MainButtons
@onready var options: VBoxContainer = $Options

var pause: bool = false
var option: bool = false

func _ready() -> void:
	hide()
	$Options.hide()

func pause_unpaused() -> void:
	pause = !pause
	if pause:
		show()
	else:
		hide()
	get_tree().paused = pause

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if option == false:
			pause_unpaused()
		else:
			$Options.hide()
			$MainButtons.show()
			$Message.show()
			option = false
			

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	$Options.show()
	$MainButtons.hide()
	$Message.hide()
	option = true
	

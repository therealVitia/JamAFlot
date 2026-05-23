extends CanvasLayer

signal start_game

func show_message(txt) -> void:
	$Message.text = txt
	$Message.show()
	
func start() -> void:
	show_message("Game Name")
	await $TimeButton.timout
	$StartButton.show()

func _on_start_button_pressed() -> void:
	start_game.emit()

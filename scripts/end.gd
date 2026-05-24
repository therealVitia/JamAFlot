extends Control

@onready var label: Label = $PanelContainer/MarginContainer/Label

func _ready() -> void:
	$PanelContainer.hide()
	$QuitButton.hide()
	await get_tree().create_timer(5).timeout
	label.text = "De qui te caches-tu?"
	$PanelContainer.show()
	await get_tree().create_timer(10).timeout
	label.text = "Des autres ?"
	await get_tree().create_timer(10).timeout
	label.text = "Ou juste de toi ?"
	await get_tree().create_timer(3).timeout
	$QuitButton.show()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

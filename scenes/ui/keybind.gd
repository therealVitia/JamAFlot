extends Control

@onready var label: Label = $Label
@onready var button: Button = $Button

@export var action_name: String = "move_forward"

func _ready() -> void:
	set_process_unhandled_key_input(false)
	
func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	
	button.text = "%s" %action_keycode

func _on_button_pressed() -> void:
	button.text = "Press any key"

func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		button.text = "Press any key"
		set_process_unhandled_key_input(toggled_on)
			
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i != self:
				i.button.disabled = true
				i.set_process_unhandled_key_input(false)
	else:
		set_process_unhandled_key_input(false)
		set_text_for_key()
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i != self:
				i.button.disabled = false
		
func _unhandled_key_input(event: InputEvent) -> void:
	rebind_action_key(event)
	button.button_pressed = false
	for i in get_tree().get_nodes_in_group("hotkey_button"):
		if i != self:
			i.button.disabled = false

func rebind_action_key(event) -> void:
	if event.echo:
		return
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	set_process_unhandled_key_input(false)
	set_text_for_key()
	button.set_pressed_no_signal(false)

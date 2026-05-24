extends Button
@onready var label: Label = $"../Label"
@onready var button: Button = $"."

func set_txt_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	
	button.text = "%s" %action_key_code

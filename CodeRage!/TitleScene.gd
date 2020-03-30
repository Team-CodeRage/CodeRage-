extends Control

var scene_path_to_load

func _ready():
	LocalStorage.load_settings()
	$TitleVBoxContainer/Buttons.grab_focus()
	for button in $TitleVBoxContainer/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	pass

func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	get_tree().change_scene(scene_path_to_load)
	pass

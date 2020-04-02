extends VBoxContainer

onready var sVolume = get_node("SFXVolume/SFXSlider")

func _ready():
	sVolume.value = AudioServer.get_bus_volume_db(0)

func _on_SFXSlider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)
	LocalStorage.set_setting("volume", "number", value)
	pass # Replace with function body.

func _on_SettingsButton_pressed():
	get_parent().get_node("TitleVBoxContainer/Control/AnimationPlayer/LeftStar").hide()
	get_parent().get_node("TitleVBoxContainer/Control/AnimationPlayer/MiddleStar").hide()
	get_parent().get_node("TitleVBoxContainer/Control/AnimationPlayer/RightStar").hide()
	get_parent().get_node("TitleVBoxContainer").hide()
	get_parent().get_node("SettingsVBoxContainer").show()
	pass # Replace with function body.


func _on_BackButton_pressed():
	get_parent().get_node("TitleVBoxContainer/Control/AnimationPlayer/LeftStar").show()
	get_parent().get_node("TitleVBoxContainer/Control/AnimationPlayer/MiddleStar").show()
	get_parent().get_node("TitleVBoxContainer/Control/AnimationPlayer/RightStar").show()
	get_parent().get_node("SettingsVBoxContainer").hide()
	get_parent().get_node("TitleVBoxContainer").show()
	pass # Replace with function body.

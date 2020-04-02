#####
#
# Created on Sunday March 29th 2020
# By Eric Sy
#
# Description:
# 	Stores, saves and loads game Settings in an ini-style file
# 
# Functions:
#	_ready():
#		Does nothing
#
#	save_settings():
#		Writes all setting to the file and saves it
#
#	new_settings():
#		Rewrites and sets the file data to the starting data
#
#	load_settings():
#		Open the file
#		Check if it opened
#		Retrieve the values
#		Store them in _settings
#
#	getLevels():
#		Returns an array of levels in the stars
#
#	setLevels(items):
#		Sets an array of levels in the stars
#
#	get_setting(category, key):
#		Returns a specific setting from data
#
#	set_setting(category, key, value):
#		Sets a specific setting in data
#
#####
extends Node

const SAVE_PATH = "user://savegame.cfg"

var _config_file = ConfigFile.new()
var _settings = {
	"version": {
		"number": "0.0.0"
		},
	"volume": {
		"number": -30
		},
	"font": {
		"size" : 0
		},
	"stars" : {
		"level1" : 0,
		"level2" : 0
	}
}

func _ready():
	set_setting("version", "number", ProjectSettings.get_setting("application/config/version"))
	AudioServer.set_bus_volume_db(0, get_setting("volume", "number"))
	pass

func save_settings():
	for section in _settings.keys():
		for key in _settings[section]:
			_config_file.set_value(section, key, _settings[section][key])

	_config_file.save(SAVE_PATH)
	pass

func new_settings():
	print("New Game")
	for section in _settings.keys():
		for key in _settings[section]:
			if(section == "stars" or section == "font" or section == "volume"):
				set_setting(section, key, 0)
	pass

func load_settings(): # could pass path as parameter, could create and return a dictionary instead of editing one
	print("Loading Game")
	var error = _config_file.load(SAVE_PATH)
	if error != OK:
		print("Failed loading settings file. Error code %s % error")
		return null
		
	for section in _settings.keys():
		for key in _settings[section]:
			_settings[section][key] = _config_file.get_value(section, key, null)
	pass

func getLevels():
	var items = [0,0]
	items[0] = get_setting("stars", "level1")
	items[1] = get_setting("stars", "level2")
	return items
	
func setLevels(items):
	set_setting("stars", "level1", items[0])
	set_setting("stars", "level2", items[1])
	pass

func get_setting(category, key):
	return _settings[category][key]

func set_setting(category, key, value):
	_settings[category][key] = value

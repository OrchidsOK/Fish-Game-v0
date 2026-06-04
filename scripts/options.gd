extends Control

var config = ConfigFile.new()
var config_path = "user://settings.cfg"

func _ready():
	$VBoxContainer/Button.pressed.connect(_on_back_pressed)
	$VBoxContainer/CheckBox.toggled.connect(_on_fullscreen_toggled)
	$VBoxContainer/HSlider.value_changed.connect(_on_volume_changed)
	load_settings()
	$VBoxContainer/InvertY.toggled.connect(_on_invert_y_toggled)
	
func _on_invert_y_toggled(enabled):
	config.set_value("settings", "invert_y", enabled)
	config.save(config_path)
	
func _on_color_changed(color):
	config.set_value("settings", "player_color", color)
	config.save(config_path)
	
func load_settings():
	if config.load(config_path) == OK:
		$VBoxContainer/CheckBox.button_pressed = config.get_value("settings", "fullscreen", false)
		$VBoxContainer/HSlider.value = config.get_value("settings", "volume", 1.0)
		$VBoxContainer/InvertY.button_pressed = config.get_value("settings", "invert_y", false)

func _on_fullscreen_toggled(enabled):
	if enabled:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	config.set_value("settings", "fullscreen", enabled)
	config.save(config_path)

func _on_volume_changed(value):
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
	config.set_value("settings", "volume", value)
	config.save(config_path)

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

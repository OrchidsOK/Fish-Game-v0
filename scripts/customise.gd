extends Control

var config = ConfigFile.new()
var config_path = "user://settings.cfg"

func _ready():
	config.load(config_path)
	$VBoxContainer/SkinColor.color = config.get_value("character", "skin_color", Color(1.0, 0.8, 0.6))
	$VBoxContainer/ClothesColor.color = config.get_value("character", "clothes_color", Color(0.2, 0.4, 0.8))
	$VBoxContainer/SaveBack.pressed.connect(_on_save_back)

func _on_save_back():
	config.set_value("character", "skin_color", $VBoxContainer/SkinColor.color)
	config.set_value("character", "clothes_color", $VBoxContainer/ClothesColor.color)
	config.save(config_path)
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

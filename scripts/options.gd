extends Control

func _ready():
	$VBoxContainer/Button.pressed.connect(_on_back_pressed)

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

extends Control

func _ready():
	$VBoxContainer/Button1.pressed.connect(_on_play_pressed)
	$VBoxContainer/Button2.pressed.connect(_on_options_pressed)
	$VBoxContainer/Button3.pressed.connect(_on_quit_pressed)
	$VBoxContainer/Button4.pressed.connect(_on_customise_pressed)

func _on_customise_pressed():
	get_tree().change_scene_to_file("res://scenes/customise.tscn")
	
func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/options.tscn")
	
func _on_quit_pressed():
	get_tree().quit()

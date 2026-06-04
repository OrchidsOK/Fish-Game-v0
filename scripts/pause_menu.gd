extends CanvasLayer

signal closing

func _ready():
	$VBoxContainer/Resume.pressed.connect(_on_resume)
	$VBoxContainer/ExitToMenu.pressed.connect(_on_exit)
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_resume()

func _on_resume():
	get_tree().paused = false
	emit_signal("closing")
	queue_free()

func _on_exit():
	get_tree().paused = false
	emit_signal("closing")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

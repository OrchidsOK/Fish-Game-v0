extends Node3D

@onready var label = $"../CharacterBody3D/BubbleAnchor/ItemLabel"

func _ready():
	Inventory.add_item("Apple", "res://assets/sprites/food/Apple.png")
	Inventory.add_item("Fish", "res://assets/sprites/fish/TestFish1.png")
	update_display()

func _process(_delta):
	if Input.is_action_just_pressed("ui_right"):
		Inventory.scroll_right()
		update_display()
	if Input.is_action_just_pressed("ui_left"):
		Inventory.scroll_left()
		update_display()

func update_display():
	var item = Inventory.get_selected_item()
	if item:
		label.text = item["name"] + " (" + str(Inventory.selected_slot + 1) + "/" + str(Inventory.items.size()) + ")"
	else:
		label.text = "Empty"

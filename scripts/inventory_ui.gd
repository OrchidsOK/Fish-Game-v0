extends Node3D

@onready var sprite = $"../CharacterBody3D/BubbleAnchor/ItemSprite"
@onready var bubble = $"../CharacterBody3D/BubbleAnchor"

func _ready():
	Inventory.add_item("Apple", "res://assets/sprites/items/food/Apple.png")
	Inventory.add_item("Banana", "res://assets/sprites/items/food/Banana.png")
	Inventory.add_item("Bread", "res://assets/sprites/items/food/Bread.png")
	Inventory.add_item("Raw Meat", "res://assets/sprites/items/food/RawMeat.png")
	Inventory.add_item("Seeds", "res://assets/sprites/items/plants/Seeds.png")
	Inventory.add_item("Banjo", "res://assets/sprites/items/tools/Banjo.png")
	Inventory.add_item("Rod", "res://assets/sprites/items/tools/Rod1.png")
	Inventory.add_item("Fish", "res://assets/sprites/items/fish/TestFish1.png")
	bubble.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("toggle_inv"):
		bubble.visible = !bubble.visible
	if bubble.visible:
		if Input.is_action_just_pressed("ui_right"):
			Inventory.scroll_right()
			update_display()
		if Input.is_action_just_pressed("ui_left"):
			Inventory.scroll_left()
			update_display()

func update_display():
	var item = Inventory.get_selected_item()
	if item:
		sprite.texture = load(item["icon"])
	else:
		sprite.texture = null

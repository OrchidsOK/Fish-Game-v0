extends Node

var items = []
var max_slots = 5
var selected_slot = 0

func add_item(item_name: String, icon_path: String):
	if items.size() < max_slots:
		items.append({"name": item_name, "icon": icon_path})
		return true
	return false

func get_selected_item():
	if items.size() > 0:
		return items[selected_slot]
	return null

func scroll_right():
	if items.size() > 0:
		selected_slot = (selected_slot + 1) % items.size()

func scroll_left():
	if items.size() > 0:
		selected_slot = (selected_slot - 1 + items.size()) % items.size()

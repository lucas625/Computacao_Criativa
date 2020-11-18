extends Area2D

var typing = ""

onready var label = $Label

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode >= 65 and event.scancode <= 90: #a to z
			update_typing(typing + char(event.scancode))
			check_for_match(typing)
		elif typing.length() > 0 and event.scancode == 16777220: #backspace
			update_typing(typing.substr(0, typing.length()-1))
			check_for_match(typing)
	pass

func update_typing(word):
	typing = word
	label.text = word

func check_for_match(word):
	var zombies = get_tree().get_nodes_in_group("zombies")
	var still_matches = false
	for zombie in zombies:
		if zombie.word.begins_with(typing):
			still_matches = true
		if zombie.word.casecmp_to(typing) == 0:
			zombie.queue_free()
			update_typing("")

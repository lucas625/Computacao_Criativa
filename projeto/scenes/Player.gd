extends Area2D

var typing = ""

onready var label = $Label

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode >= 65 and event.scancode <= 90: #a to z
			typing = typing + char(event.scancode)
			print (event.scancode)
			print (char(event.scancode))
			label.text = typing
		elif typing.length() > 0 and event.scancode == 16777220: #backspace
			typing = typing.substr(0, typing.length()-1)
			label.text = typing
	pass

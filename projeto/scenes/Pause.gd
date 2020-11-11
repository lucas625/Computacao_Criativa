extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		var pause_state = not get_tree().paused
		get_tree().paused = pause_state
		visible = pause_state
	if event.is_action_pressed("restart"):
		get_tree().paused = false
		get_tree().reload_current_scene()

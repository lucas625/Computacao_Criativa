extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		var pause_state = not get_tree().paused
		get_tree().paused = pause_state
		visible = pause_state
	if event.is_action_pressed("restart"):
		get_tree().paused = false
		get_tree().reload_current_scene()


func _on_PauseBtn_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		var pause_state = not get_tree().paused
		get_tree().paused = pause_state
		visible = pause_state

func _on_btnrestart_button_down():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_btncontinue_button_down():
	var pause_state = not get_tree().paused
	get_tree().paused = pause_state
	visible = pause_state

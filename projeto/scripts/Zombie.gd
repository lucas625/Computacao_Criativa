extends KinematicBody2D

export (float) var speed = 35

export (Vector2) var target = Vector2(0,0)

func set_target(value):
	target = value

func _physics_process(delta):
	var direction = (target - self.position).normalized()
	var velocity = direction * speed
	move_and_slide(velocity)



func _on_Area2D_body_entered(body):
	get_tree().reload_current_scene() # Replace with function body.

extends KinematicBody2D

export (float) var speed = 50

export (Vector2) var target = Vector2(0,0)

func set_target(value):
	target = value

func _physics_process(delta):
	var direction = (target - self.position).normalized()
	var velocity = direction * speed
	move_and_slide(velocity)

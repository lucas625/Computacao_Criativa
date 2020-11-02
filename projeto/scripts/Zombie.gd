extends KinematicBody2D

export (float) var speed = 100.0

var target = Vector2(0,0)
var vector_speed: Vector2 = Vector2(0,0)


func _physics_process(delta):
	# TODO: fix the get_pos()
	vector_speed = speed * (target - get_pos()).normalized()

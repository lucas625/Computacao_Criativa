extends KinematicBody2D

export (float) var speed = 100.0

var zombie = get_tree().get_root().get_node("Zombie")
var target = Vector2(0,0)


func _physics_process(delta):
	# TODO: fix the get_pos()
	zombie.move_toward(zombie.get_pos(), target, speed)

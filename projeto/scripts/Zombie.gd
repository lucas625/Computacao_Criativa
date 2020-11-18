extends Area2D

export (float) var speed = 35

export (Vector2) var target = Vector2(0,0)

var word = ""

onready var label = $Label

func set_target(value):
	target = value

func set_word(value):
	word = value

func _ready():
	add_to_group("zombies")
	label.text = word

func _physics_process(delta):
	var direction = (target - self.position).normalized()
	var velocity = direction * speed
	position += velocity*delta

func _on_Zombie_area_entered(area):
	get_tree().reload_current_scene() # Replace with function body.

extends Area2D

export var velocity = 60.0

var target
var word

var lerp_step = 0.05

onready var label = $Label

func set_bullet(target, word):
	self.target = target
	self.word = word

func _ready():
	label.text = word

func _physics_process(delta):
	position = lerp(position, target.position, lerp_step)
	lerp_step = lerp_step + 0.05
	
	if lerp_step >= 1.0:
		target.queue_free()
		queue_free()

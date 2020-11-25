extends Area2D

export var head_max = 40.0

export (float) var speed = 35

var target

var word = ""

var texture: Texture
var head_scale = 1.0
onready var label = $Z/Label
onready var head = $HeadSprite

func set_target(value):
	target = value

func set_word(value):
	word = value

func set_texture(value):
	texture = value
	head_scale = min(head_max / texture.get_width(), head_max / texture.get_height())

func _ready():
	add_to_group("zombies")
	label.text = word
	head.texture = texture
	head.scale.x = head_scale
	head.scale.y = head_scale

func _physics_process(delta):
	if target != null:
		var direction = (target.position - self.position).normalized()
		var velocity = direction * speed
		position += velocity*delta

func _on_Zombie_area_entered(area):
	if "typing" in area:
		get_tree().reload_current_scene() # Replace with function body.

extends Area2D

export var head_max = 40.0

export (float) var speed = 35

export (Vector2) var target = Vector2(0,0)

var word = ""

var texture: Texture
var head_scale = 1.0
onready var sound_player = $AudioStreamPlayer
var pitch = 1.0
onready var label = $Label
onready var head = $HeadSprite

func play_death():
	sound_player.play()

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
	sound_player.pitch_scale = pitch

func _physics_process(delta):
	var direction = (target - self.position).normalized()
	var velocity = direction * speed
	position += velocity*delta

func _on_Zombie_area_entered(area):
	if "typing" in area:
		get_tree().reload_current_scene() # Replace with function body.

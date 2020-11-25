extends Area2D

enum TypingFeedback {
	KILL = 0,
	RIGHT = 1,
	WRONG = 2
}

signal score(value)
signal bullet(value)

export var move_speed = 100

export (AudioStream) var kill_sound
export (AudioStream) var right_sound
export (AudioStream) var wrong_sound

var typing = ""

var score = 0

var bullet_scene = preload("res://scenes/Bullet.tscn")

onready var label = $Label
onready var audio = $AudioStreamPlayer

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode >= 65 and event.scancode <= 90: #a to z
			update_typing(typing + char(event.scancode))
			check_for_match(typing)
		elif typing.length() > 0 and event.scancode == 16777220: #backspace
			update_typing(typing.substr(0, typing.length()-1))
			check_for_match(typing)
	pass

func _physics_process(delta):
	var direction = Vector2(0,0)
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	position = position + (direction.normalized() * move_speed * delta)

func update_typing(word):
	typing = word
	label.text = word

func check_for_match(word):
	var zombies = get_tree().get_nodes_in_group("zombies")
	var feedback = TypingFeedback.WRONG
	
	for zombie in zombies:
		if zombie.word.begins_with(typing):
			feedback = TypingFeedback.RIGHT

		if zombie.word == typing:
			#instance bullet that will home into zombie, send to main through signal
			var bullet_instance = bullet_scene.instance()
			bullet_instance.set_bullet(zombie, typing)
			bullet_instance.position = position
			emit_signal("bullet", bullet_instance)
			#increase score, send value to amin through signal
			score = score + 1
			emit_signal("score", score)
			#erase typing
			update_typing("")
			#sound feedback
			feedback = TypingFeedback.KILL
			break
	
	match feedback:
		TypingFeedback.KILL:
			audio.stream = kill_sound
			audio.play()
		TypingFeedback.RIGHT:
			audio.stream = right_sound
			audio.play()
			label.set("custom_colors/font_color", Color.green)
		TypingFeedback.WRONG:
			audio.stream = wrong_sound
			audio.play()
			label.set("custom_colors/font_color", Color.red)

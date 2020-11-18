extends Node2D

var words = []
var words_loaded = false
var word_index = 0

var textures = []

export (float) var seconds_between_zombies = 1.5
var screen_size = Vector2(600,600)
var zombie_scene = preload("res://scenes/Zombie.tscn")

onready var score = $Score

func _ready():
	randomize()
	
	if !words_loaded:
		load_words()
	find_images()
	
	var timer = Timer.new()

	# Set timer interval
	timer.set_wait_time(seconds_between_zombies)

	# Set it as repeat
	timer.set_one_shot(false)

	# Connect its timeout signal to the function you want to repeat
	timer.connect("timeout", self, "create_zombie")

	# Add to the tree as child of the current node
	add_child(timer)

	timer.start()
	
	words.shuffle()

func load_words():
	var words_dict = {}
	var file = File.new()
	file.open("res://words/base_words.json", file.READ)
	var text = file.get_as_text()
	words_dict = JSON.parse(text).result
	file.close()
	var lower_words = words_dict["words"]
	
	for word in lower_words:
		words.append(word.to_upper())
		
	words_loaded = true

func create_zombie():
	var zombie_instance = zombie_scene.instance()
	zombie_instance.set_target(self.get_node("Player").position)
	
	var random_position = find_random_position(screen_size)
	zombie_instance.set_position(random_position)
	
	var zombie_word = words[word_index]
	zombie_instance.set_word(zombie_word)
	
	if textures.size() > 0:
		var texture_index = randi() % textures.size()
		zombie_instance.set_texture(textures[texture_index])
	
	word_index = word_index + 1
	if word_index == words.size():
		word_index = 0

	self.add_child(zombie_instance)

func find_random_position(screen_size):
	# Finds a random position based on the screen size, creating a circle
	# Centered in the middle of the screen.
	var center = 0.5 * screen_size
	var vector_radius = screen_size - center
	
	var random_generator = RandomNumberGenerator.new()
	random_generator.randomize()
	var random_number = random_generator.randf_range(0, 360)
	
	var circle_point = vector_radius.rotated(deg2rad(random_number))
	
	return circle_point + center
	
func find_images():
	var dir = Directory.new()
	var exe_path = OS.get_executable_path().get_base_dir()
	if dir.open(exe_path.plus_file("faces")) == OK:
		
		var image_names = []
		
		#finding valid file names
		dir.list_dir_begin(true)
		var file = dir.get_next()
		while file != "":
			if not dir.current_is_dir() and (file.ends_with(".jpg") or file.ends_with(".png") or file.ends_with(".bmp") or file.ends_with(".webp")):
				image_names.append(file)
			file = dir.get_next()
		
		#loading images
		for image_name in image_names:
			var tex = ImageTexture.new()
			var image = Image.new()
			image.load(exe_path.plus_file("faces").plus_file(image_name))
			tex.create_from_image(image)
			textures.append(tex)
	else:
		dir.open(exe_path)
		dir.make_dir("faces")


func _on_Player_score(value):
	score.text = String(value)

extends Node2D

var example_words = [
	"FEAR",
	"DARK",
	"SOMEONE",
	"THERE",
	"ALWAYS",
	"PHOBIA",
	"NICE",
	"PUNCH",
	"HORIZON",
	"KING",
	"MOTHER",
	"WORLD",
	"HEART",
	"ROCK",
	"THUNDER",
	"PAINT",
	"BARRACUDA",
	"CIRCUS",
	"PSYCHO",
	"WIND",
	"CHANGE",
	"HERO",
	"HELL",
	"WEDDING",
	"TURBO"
]
var word_index = 0

export (float) var seconds_between_zombies = 1.5
var screen_size = Vector2(600,600)
var zombie_scene = preload("res://scenes/Zombie.tscn")

func _ready():
	randomize()
	
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
	
	example_words.shuffle()

func create_zombie():
	var zombie_instance = zombie_scene.instance()
	zombie_instance.set_target(self.get_node("Player").position)
	
	var random_position = find_random_position(screen_size)
	zombie_instance.set_position(random_position)
	
	var zombie_word = example_words[word_index]
	zombie_instance.set_word(zombie_word)
	
	word_index = word_index + 1
	if word_index == example_words.size():
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
	


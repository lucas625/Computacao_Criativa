extends Node2D

export (float) var seconds_between_zombies = 1.5
var screen_size = Vector2(600,600)

func _ready():
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


func create_zombie():
	var zombie_scene = load("scenes/Zombie.tscn")
	var zombie_scene_instanced = zombie_scene.instance()
	zombie_scene_instanced.set_target(self.get_node("Player").position)
	var random_position = find_random_position(screen_size)
	zombie_scene_instanced.set_position(random_position)
	self.add_child(zombie_scene_instanced)
	

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
	


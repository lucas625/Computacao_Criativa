extends Node2D

func _ready():
	
	var timer = Timer.new()

	# Set timer interval
	timer.set_wait_time(3.0)

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
	zombie_scene_instanced.set_position(Vector2(1000, 500)) # add random position
	self.add_child(zombie_scene_instanced)


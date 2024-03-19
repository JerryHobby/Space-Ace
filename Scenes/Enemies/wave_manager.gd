extends Node2D

@onready var zippers = $Paths/Zippers
@onready var biomechs = $Paths/Biomechs
@onready var bombers = $Paths/Bombers

# used for testing specific scenes only
const TEST_MODE:bool = false
const TEST_SCENES:Array = [
		GameData.ENEMY_TYPE.ZIPPER,
		#GameData.ENEMY_TYPE.BIO,
		#GameData.ENEMY_TYPE.BOMBER,
	]

const ANIM_FRAMES = {
	GameData.ENEMY_TYPE.ZIPPER: ["zipper_1", "zipper_2", "zipper_3"],
	GameData.ENEMY_TYPE.BIO: ["biomech_1", "biomech_2", "biomech_3"],
	GameData.ENEMY_TYPE.BOMBER: ["bomber_1", "bomber_2", "bomber_3"]
}

const ENEMY_SCENES = {
	GameData.ENEMY_TYPE.ZIPPER: preload("res://Scenes/Enemies/enemy_zipper.tscn"),
	GameData.ENEMY_TYPE.BIO: preload("res://Scenes/Enemies/enemy_bio.tscn"),
	GameData.ENEMY_TYPE.BOMBER: preload("res://Scenes/Enemies/enemy_bomber.tscn")
}

var _zipper_paths:Array = []
var _biomechs_paths:Array = []
var _bombers_paths:Array = []


func _ready():
	_zipper_paths = zippers.get_children()
	_biomechs_paths = biomechs.get_children()
	_bombers_paths = bombers.get_children()
	spawn_wave()


func create_enemy(speed:float, anim_name:String, enemy_type:GameData.ENEMY_TYPE):
	var enemy_scene = ENEMY_SCENES[enemy_type].instantiate()
	enemy_scene.setup(speed, anim_name)
	return enemy_scene


func spawn_wave():
	var enemy_type = GameData.ENEMY_TYPE.values().pick_random()
	
	# used for testing specific scenes only
	if TEST_MODE:
		while enemy_type not in TEST_SCENES:
			enemy_type = GameData.ENEMY_TYPE.values().pick_random()

	var anim = ANIM_FRAMES[enemy_type].pick_random()
	var enemy_speed = 1.0


	var path:Path2D
	
	match enemy_type:
		GameData.ENEMY_TYPE.ZIPPER:
			path = _zipper_paths.pick_random()
			enemy_speed = .6
		GameData.ENEMY_TYPE.BIO:
			path = _biomechs_paths.pick_random()
			enemy_speed = .3
		GameData.ENEMY_TYPE.BOMBER:
			path = _bombers_paths.pick_random()
			enemy_speed = .15
		_:
			path = _zipper_paths.pick_random()

	enemy_speed = normalize_speed(path, enemy_speed)
	
	# create one to get count
	var waves = create_enemy(enemy_speed, anim, enemy_type).waves
	
	# create enemies
	for num in range(waves):
		var new_enemy = create_enemy(enemy_speed, anim, enemy_type)
		await get_tree().create_timer(1 - enemy_speed * .1).timeout
		path.add_child(new_enemy)


func normalize_speed(path:Path2D, enemy_speed:float) -> float:
	var length = path.curve.get_baked_length()
	var reduction:int = 500 # higher number slows speed
	var new_speed = (enemy_speed / length) * reduction

	return new_speed


func _on_spawn_timer_timeout():
	spawn_wave()

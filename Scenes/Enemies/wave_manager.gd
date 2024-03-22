extends Node2D

@onready var zippers = $Paths/Zippers
@onready var biomechs = $Paths/Biomechs
@onready var bombers = $Paths/Bombers
@onready var spawn_timer = $SpawnTimer

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

var wave_list:WaveListResource

var wave_res:WaveResource 

var _paths = {
	GameData.ENEMY_TYPE.ZIPPER:
		{
			"paths":  [],
			"last_path": 0
		},
	GameData.ENEMY_TYPE.BIO: 
		{
			"paths":  [],
			"last_path": 0
		},
	GameData.ENEMY_TYPE.BOMBER: 
		{
			"paths":  [],
			"last_path": 0
		}
}

func _ready():
	_paths[GameData.ENEMY_TYPE.ZIPPER].paths = zippers.get_children()
	_paths[GameData.ENEMY_TYPE.BIO].paths = biomechs.get_children()
	_paths[GameData.ENEMY_TYPE.BOMBER].paths = bombers.get_children()
	wave_list = load("res://Resources/Waves/wave_list.tres")
	
	spawn_timer.wait_time = wave_list.wave_gap
	spawn_timer.start()
	spawn_wave()


func create_enemy(speed:float, anim_name:String, enemy_type:GameData.ENEMY_TYPE, bullet_wait_time:float):
	var enemy_scene = ENEMY_SCENES[enemy_type].instantiate()
	enemy_scene.setup(speed, anim_name, bullet_wait_time)
	return enemy_scene


func update_speeds() -> void:
	wave_list.wave_gap -= wave_list.speed_factor
	
	if wave_list.wave_gap < 2:
		wave_list.wave_gap = 2
	
	wave_res.speed += (wave_list.speed_factor)/10
	
	wave_res.gap -= ScoreManager.get_waves()/200
	if wave_res.gap < 0.01:
		wave_res.gap = 0.1

	wave_res.bullet_wait_time -= wave_list.speed_factor * 0.3
	if wave_res.bullet_wait_time < .5:
		wave_res.bullet_wait_time = .5


func spawn_wave():
	wave_res = wave_list.get_next_wave()
	var enemy_type = wave_res.enemy_type
	var normalized_speed:float

	# used for testing specific scenes only
	if TEST_MODE:
		while enemy_type not in TEST_SCENES:
			enemy_type = GameData.ENEMY_TYPE.values().pick_random()

	var anim = ANIM_FRAMES[enemy_type].pick_random()
	var path = _paths[enemy_type].paths.pick_random()
	update_speeds()
	
	normalized_speed = normalize_speed(path, wave_res.speed)
	var waves = wave_res.min + floor(wave_list.speed_factor * ScoreManager.get_waves())

	if waves > wave_res.max:
		waves = wave_res.max

	ScoreManager.increment_waves()
	# create enemies
	for num in range(waves):
		var new_enemy = create_enemy(normalized_speed, anim, enemy_type, wave_res.bullet_wait_time)
		await get_tree().create_timer(wave_res.gap).timeout
		path.add_child(new_enemy)
	
	spawn_timer.wait_time = wave_list.wave_gap


func normalize_speed(path:Path2D, enemy_speed:float) -> float:
	var length = path.curve.get_baked_length()
	var reduction:int = 500 # higher number slows speed
	var new_speed = (enemy_speed / length) * reduction

	return new_speed


func _on_spawn_timer_timeout():
	spawn_wave()

extends PathFollow2D
@onready var health_bar = $HealthBar
@onready var state_machine = $AnimationTree["parameters/playback"]
@onready var booms = $Area2D/Booms
@onready var sound = $Sound

const SPEED:float = 0.05
const SHOOT_PROGRESS:float = 0.02
const FIRE_OFFSETS = [0.25, 0.5, 0.75]


var powerup_scene = preload("res://Scenes/power_up.tscn")

var _missile_scene:PackedScene = preload("res://Scenes/Bullets/homing_missile.tscn")
var _shooting:bool = false
var _dead = false

var _shots_fired:int = 0


func _ready():
	progress = 0.0
	if GameManager.sounds() == false:
		sound.process_mode = Node.PROCESS_MODE_DISABLED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _shooting == false:
		progress_ratio += SPEED * delta
		try_shoot()


func _on_area_2d_area_entered(area):
	health_bar.take_damage(10) # Replace with function body.


func update_shots_fired() -> void:
	_shots_fired += 1
	if _shots_fired >= len(FIRE_OFFSETS):
		_shots_fired = 0


func try_shoot() -> void:
	if _shots_fired >= len(FIRE_OFFSETS):
		return
		
	if abs(progress_ratio - FIRE_OFFSETS[_shots_fired]) < SHOOT_PROGRESS:
		state_machine.travel("shoot")
		update_shots_fired()


func set_shooting(v:bool) -> void:
	_shooting = v


func shoot() -> void:
	var missile = _missile_scene.instantiate()
	get_tree().root.add_child(missile)
	missile.global_position = global_position


func die() -> void:
	if _dead:
		return
	_dead = true
	set_process(true)
	make_powerup()
	make_booms()
	queue_free()

func make_powerup() -> void:
	var powerup = powerup_scene.instantiate()

	powerup.global_position = global_position
	get_tree().root.add_child(powerup)
	
	var pu = GameData.POWERUP_TYPE.values().pick_random()
	powerup.set_powerup_type(pu)


func make_booms() -> void:
	for b in booms.get_children():
		ObjectMaker.create_boom(b.global_position, self)


func _on_health_bar_died():
	die()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

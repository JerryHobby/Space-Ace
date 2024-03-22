extends Node2D

var asteroid_scene:PackedScene = preload("res://Scenes/Enemies/asteroid.tscn")

const ASTEROID_SPRITES = [
	preload("res://assets/asteroids/a1.png"),
	preload("res://assets/asteroids/a2.png"),
	preload("res://assets/asteroids/a3.png"),
]

@export var demo_mode:bool = false

const WAIT_TIME:float = 20.0
const WAIT_VAR:float = 2.0
const INITIAL_DELAY:float = 2

@onready var timer = $Timer
@onready var paths = $Paths.get_children()

var _wait_time:float = WAIT_TIME


func _ready():
	if !demo_mode:
		await get_tree().create_timer(INITIAL_DELAY).timeout
	spawn_asteroid()


func spawn_asteroid() -> void:
	var p = paths.pick_random()
	var s = ASTEROID_SPRITES.pick_random()
	var asteroid = asteroid_scene.instantiate()

	p.add_child(asteroid)
	asteroid.set_sprite(s)

	if demo_mode:
		asteroid.hide_health()
		Utils.set_and_start_time(timer, 10, 0)
	else:
		Utils.set_and_start_time(timer, WAIT_TIME, WAIT_VAR)


func _on_timer_timeout():
	spawn_asteroid()

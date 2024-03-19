extends Node2D

var saucer_scene:PackedScene = preload("res://Scenes/Enemies/saucer.tscn")

const WAIT_TIME:float = 20.0
const WAIT_VAR:float = 2.0

@onready var timer = $Timer
@onready var paths = $Paths.get_children()


func _ready():
	spawn_saucer()
	#Utils.set_and_start_time(timer, WAIT_TIME, WAIT_VAR)


func spawn_saucer() -> void:
	var p = paths.pick_random()
	var saucer = saucer_scene.instantiate()
	p.add_child(saucer)
	Utils.set_and_start_time(timer, WAIT_TIME, WAIT_VAR)


func _on_timer_timeout():
	spawn_saucer()

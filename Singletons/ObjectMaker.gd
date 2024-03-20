extends Node

enum SCENE_KEY { EXPLOSION, BOOM }

const SIMPLE_SCENES = {
	SCENE_KEY.EXPLOSION: preload("res://Scenes/Explosions/explosion.tscn"),
	SCENE_KEY.BOOM: preload("res://Scenes/Explosions/boom.tscn")
}

var powerup_scene = preload("res://Scenes/power_up.tscn")

func add_child_deferred(child_to_add, parent:Node2D) -> void:
	parent.add_child(child_to_add)


func call_add_child(child_to_add, parent:Node2D) -> void:
	if parent and child_to_add:
		call_deferred("add_child_deferred", child_to_add, parent)


func create_simple_scene(start_pos: Vector2, key: SCENE_KEY, parent:Node2D) -> void:
	var new_exp = SIMPLE_SCENES[key].instantiate()
	new_exp.global_position = start_pos
	call_add_child(new_exp, parent)


func create_powerup(pos:Vector2) -> void:
	var pu = GameData.POWERUP_TYPE.values().pick_random()
	create_powerup_type(pos, pu)


func create_powerup_type(pos:Vector2, type:GameData.POWERUP_TYPE) -> void:
	var powerup = powerup_scene.instantiate()
	powerup.set_powerup_type(type)
	powerup.global_position = pos
	get_tree().current_scene.call_deferred("add_child", powerup)


func create_explosion(start_pos: Vector2, parent:Node2D) -> void:
	create_simple_scene(start_pos, SCENE_KEY.EXPLOSION, parent)


func create_boom(start_pos: Vector2) -> void:
	create_simple_scene(start_pos, SCENE_KEY.BOOM, get_tree().current_scene)

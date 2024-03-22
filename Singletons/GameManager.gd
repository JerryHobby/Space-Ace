extends Node

const level_scene:PackedScene = preload("res://Scenes/level.tscn")
const main_scene:PackedScene = preload("res://Scenes/main.tscn")
const gameover_scene:PackedScene = preload("res://Scenes/game_over.tscn")

var _music = true
var _sounds = true
var _god_mode = false


func load_main_scene() -> void:
	get_tree().change_scene_to_packed(main_scene)

func load_gameover_scene() -> void:
	get_tree().change_scene_to_packed(gameover_scene)

func load_level_scene() -> void:
	get_tree().change_scene_to_packed(level_scene)

func toggle_music() -> void:
	_music = !_music

func toggle_sounds() -> void:
	_sounds = !_sounds

func sounds() -> bool:
	return _sounds

func music() -> bool:
	return _music

func god_mode() -> bool:
	return _god_mode

func toggle_god_mode() -> void:
	_god_mode = !_god_mode
	SignalManager.god_mode.emit()

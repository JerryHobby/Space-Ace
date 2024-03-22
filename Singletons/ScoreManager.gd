extends Node

var _score:int = 0
var _high_score:int = 0
var _waves:int = 1
var _used_cheat = false

func _ready():
	_high_score = DataStorage.get_high_score()


func used_cheats() -> void:
	_used_cheat = true


func increment_waves() -> void:
	_waves += 1
	SignalManager.on_score_updated.emit(_score)


func get_waves() -> int:
	return _waves


func increment_score(v:int) -> void:
	if GameManager.god_mode():
		used_cheats()

	_score += v
	if !_used_cheat and _high_score < _score:
		_high_score = _score
		DataStorage.save_data()
	SignalManager.on_score_updated.emit(_score)


func format_score(v:int) -> String:
	var s = str(v)
	if s.length() > 9:
		s = s.insert(s.length() - 9, ",")
	if s.length() > 6:
		s = s.insert(s.length() - 6, ",")
	if s.length() > 3:
		s = s.insert(s.length() - 3, ",")
	return s


func get_score() -> int:
	return _score


func get_score_formatted() -> String:
	return format_score(_score)


func get_high_score() -> int:
	return _high_score


func set_high_score(v:int) -> void:
	_high_score = v


func get_high_score_formatted() -> String:
	return format_score(_high_score)


func reset_score() -> void:
	_score = 0
	_waves = 1
	_used_cheat = false
	SignalManager.on_score_updated.emit(_score)

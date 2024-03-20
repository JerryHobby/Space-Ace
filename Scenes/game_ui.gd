extends Control

@onready var health_bar = $ColorRect/MarginContainer/HBoxContainer/HealthBar
@onready var score_label = $ColorRect/MarginContainer/HBoxContainer/ScoreLabel

var _score:int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_health_bonus.connect(on_health_bonus)
	SignalManager.on_score_updated.connect(on_score_updated)
	SignalManager.on_player_hit.connect(on_player_hit)
	SignalManager.on_player_died.connect(on_player_died)


func on_health_bonus(v:int) -> void:
	health_bar.inc_value(v)


func format_score(v:int) -> String:
	var s = str(v)
	if s.length() > 9:
		s = s.insert(s.length() - 9, ",")
	if s.length() > 6:
		s = s.insert(s.length() - 6, ",")
	if s.length() > 3:
		s = s.insert(s.length() - 3, ",")

	return s


func on_score_updated(v:int) -> void:
	_score += v
	score_label.text = format_score(_score)


func on_player_hit(v:int) -> void:
	health_bar.take_damage(v)


func on_player_died() -> void:
	pass


func _on_health_bar_died():
	pass # Replace with function body.

extends Control

@onready var health_bar = $ColorRect/MarginContainer/HBoxContainer/HealthBar
@onready var score_label = $ColorRect/MarginContainer/HBoxContainer/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_health_bonus.connect(on_health_bonus)
	SignalManager.on_score_updated.connect(on_score_updated)
	SignalManager.on_player_hit.connect(on_player_hit)


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
	score_label.text = format_score(v)


func on_player_hit(v:int) -> void:
	health_bar.take_damage(v)


func on_health_bonus(v:int) -> void:
	health_bar.inc_value(v)


func _on_health_bar_died():
	SignalManager.on_player_died.emit()
	GameManager.load_main_scene()

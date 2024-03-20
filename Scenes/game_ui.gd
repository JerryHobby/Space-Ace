extends Control

@onready var health_bar = $ColorRect/MarginContainer/HBoxContainer/HealthBar
@onready var score_label = $ColorRect/MarginContainer/HBoxContainer/ScoreLabel
@onready var god_label = $ColorRect/MarginContainer/HBoxContainer/GodLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_health_bonus.connect(on_health_bonus)
	SignalManager.on_score_updated.connect(on_score_updated)
	SignalManager.on_player_hit.connect(on_player_hit)
	SignalManager.god_mode.connect(god_mode)
	god_mode()


func god_mode() -> void:
	if GameManager.god_mode():
		god_label.show()
	else:
		god_label.hide()


func on_score_updated(v:int) -> void:
	score_label.text = ScoreManager.get_score_formatted()


func on_player_hit(v:int) -> void:
	health_bar.take_damage(v)


func on_health_bonus(v:int) -> void:
	health_bar.inc_value(v)


func _on_health_bar_died():
	SignalManager.on_player_died.emit()
	GameManager.load_main_scene()

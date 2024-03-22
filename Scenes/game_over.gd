extends Control
@onready var score_label = $ColorRect/VBoxContainer/ScoreLabel
@onready var high_score_label = $ColorRect/VBoxContainer/HighScoreLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	set_labels()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		GameManager.load_main_scene()
		
	if Input.is_action_just_pressed("pause"):
		GameManager.load_main_scene()


func on_score_updated(v:int) -> void:
	set_labels()


func set_labels() -> void:
	high_score_label.text = "High Score: " + ScoreManager.get_high_score_formatted()
	score_label.text = "Your Score: %s" % ScoreManager.get_score_formatted()

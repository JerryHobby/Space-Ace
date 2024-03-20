extends ParallaxBackground

@onready var parallax_layer_bg = $ParallaxLayerBg
@onready var parallax_layer_1 = $ParallaxLayer1
@onready var parallax_layer_2 = $ParallaxLayer2
@onready var parallax_layer_3 = $ParallaxLayer3

const SPEED:float = 150.0


func _ready():
	ScoreManager.reset_score()


func _process(delta):
	parallax_layer_bg.motion_offset.y += SPEED * delta * 0.1
	parallax_layer_1.motion_offset.y += SPEED * delta * 0.15
	parallax_layer_2.motion_offset.y += SPEED * delta * 0.2
	parallax_layer_3.motion_offset.y += SPEED * delta * 0.25


func set_running(running:bool) -> void:
	set_running(running)


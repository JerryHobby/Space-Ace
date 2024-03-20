extends Node

enum ENEMY_TYPE { ZIPPER, BIO, BOMBER }
enum POWERUP_TYPE { HEALTH, SHIELD }

const HEALTH_BONUS:int = 50
const SHIELD_LIFE:float = 3.0
const POWERUP_CHANCE:float = 0.15

const GROUP_PLAYER:String = "player"
const GROUP_HOMING_MISSILE:String = "homing missile"
const GROUP_SAUCER:String = "saucer"
const GROUP_ASTEROID:String = "asteroid"
const GROUP_ENEMY_SHIP:String = "enemy ship"
const GROUP_BULLET:String = "bullet"

const DAMAGE_BULLET:int = 15
const DAMAGE_COLLISION:int = 40
const DAMAGE_SAUCER_COLLISION:int = 80
const DAMAGE_ASTEROID_COLLISION:int = 120
const DAMAGE_MISSILE:int = 25

const SCORE_ASTEROID:int = 2000
const SCORE_SAUCER:int = 1000
const SCORE_ENEMY:int = 500
const SCORE_MISSILE:int = 50
const SCORE_POWERUP:int = 50

const INITIAL_WAVE_SPEED:float = 12.0
const ACCELERATOR:float = 0.1

const LAYER_PLAYER:int = 1
const LAYER_ENEMY:int = 2
const LAYER_PLAYER_BULLET:int = 4
const LAYER_ENEMY_BULLET:int = 8
const LAYER_HOMING_MISSILE:int = 16

const POWER_UPS = {
	POWERUP_TYPE.HEALTH: preload("res://assets/misc/powerupGreen_bolt.png"),
	POWERUP_TYPE.SHIELD: preload("res://assets/misc/shield_gold.png")
}

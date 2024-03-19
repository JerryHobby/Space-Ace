extends Node

enum ENEMY_TYPE { ZIPPER, BIO, BOMBER }
enum POWERUP_TYPE { HEALTH, SHIELD }

const POWERUP_CHANCE:float = 0.10

const GROUP_PLAYER:String = "player"
const GROUP_HOMING_MISSILE:String = "homing missile"

const LAYER_PLAYER:int = 1
const LAYER_ENEMY:int = 2
const LAYER_PLAYER_BULLET:int = 4
const LAYER_ENEMY_BULLET:int = 8
const LAYER_HOMING_MISSILE:int = 16

const POWER_UPS = {
	POWERUP_TYPE.HEALTH: preload("res://assets/misc/powerupGreen_bolt.png"),
	POWERUP_TYPE.SHIELD: preload("res://assets/misc/shield_gold.png")
}

extends  Node

signal pause
signal on_powerup_hit(powe_up:GameData.POWERUP_TYPE)
signal game_over
signal god_mode

signal on_player_hit(v:int)
signal on_player_died
signal on_score_updated(v:int)
signal on_health_bonus(v:int)



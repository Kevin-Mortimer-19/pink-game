extends PlayerState


func enter(_msg = {}) -> void:
	player.start_animation("player_knockback")
	player.gravity_multiplier = 0.8


func exit() -> void:
	player.velocity.x = 0
	player.stop_animation()

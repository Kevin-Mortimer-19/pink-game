extends PlayerState


func enter(_msg: Dictionary) -> void:
	player.start_animation("player_dash")
	player.velocity.y = 0
	player.gravity_multiplier = 0
	player.dash_timer.start()


func exit() -> void:
	player.stop_animation()
	player.flip_check()


func _physics_update(_delta: float) -> void:
	player.dash_movement()

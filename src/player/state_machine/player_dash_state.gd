extends PlayerState


func enter(_msg: Dictionary) -> void:
	player.start_animation("player_dash")
	EventBus.play_sfx.emit(player.dash_sfx)
	player.velocity.y = 0
	player.gravity_multiplier = 0
	player.dash_timer.start()
	player.set_collision_mask_value(2, false)


func exit() -> void:
	player.dash_cooldown_timer.start()
	player.stop_animation()
	player.flip_check()
	player.set_collision_mask_value(2, true)


func _physics_update(_delta: float) -> void:
	player.dash_movement()

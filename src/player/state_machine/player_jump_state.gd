extends PlayerState


func enter(_msg: Dictionary) -> void:
	player.start_animation("player_jump")
	player.velocity.y = -player.jump_force
	player.gravity_multiplier = 1.0


func exit() -> void:
	player.stop_animation()


func _physics_update(_delta: float) -> void:
	player.handle_movement()
	if player.velocity.y == 0:
		machine.transition_to("Air")
	if player.is_on_floor():
		machine.transition_to("Walk")

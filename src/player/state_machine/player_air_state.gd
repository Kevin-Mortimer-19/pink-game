extends PlayerState


func enter(_msg: Dictionary) -> void:
	player.start_animation("player_air")
	player.gravity_multiplier = 1.5


func exit() -> void:
	player.stop_animation()


func _physics_update(_delta: float) -> void:
	player.handle_movement(_delta)
	if Input.is_action_just_pressed("dash") and player.can_dash():
		machine.transition_to("Dash")
	elif player.is_on_floor():
		machine.transition_to("Walk")
	elif not player.coyote_timer.is_stopped() and Input.is_action_just_pressed("up"):
		machine.transition_to("Jump")

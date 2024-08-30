extends PlayerState


func enter(_msg: Dictionary) -> void:
	player.start_animation("player_walk")


func exit() -> void:
	player.stop_animation()


func _physics_update(_delta: float) -> void:
	player.handle_movement()
	if (
			Input.is_action_pressed("up") 
			or (player.is_on_floor() and player.jump_buffered) 
	):
		machine.transition_to("Jump")
	elif Input.is_action_just_pressed("dash"):
		machine.transition_to("Dash")
	elif not Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		machine.transition_to("Idle")
	elif not player.is_on_floor():
		machine.transition_to("Air")
 

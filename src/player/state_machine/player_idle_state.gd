extends PlayerState


func enter(_msg: Dictionary) -> void:
	player.start_animation("player_idle")


func exit() -> void:
	player.stop_animation()


func _physics_update(_delta: float) -> void:
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		machine.transition_to("Walk")
	elif Input.is_action_just_pressed("up"):
		machine.transition_to("Jump")
	elif not player.is_on_floor():
		machine.transition_to("Air")

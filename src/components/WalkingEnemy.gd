extends MoveComponent

func move(speed: float, gravity: float) -> void:
	character.velocity.x = -speed if character.sprite.flip_h else speed
	if not character.is_on_floor():
		character.velocity.y += gravity
	else:
		character.velocity.y = 0
	character.move_and_slide()
	look_ahead()


func look_ahead() -> void:
	if character.ray.is_colliding():
		var collider = character.ray.get_collider()
		if collider.is_in_group("Terrain") or collider.is_in_group("Enemy"):
			character.turn()

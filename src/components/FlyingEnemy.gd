extends MoveComponent

func move(speed: float, _gravity: float) -> void:
	character.velocity.x = -speed if character.sprite.flip_h else speed
	character.move_and_slide()

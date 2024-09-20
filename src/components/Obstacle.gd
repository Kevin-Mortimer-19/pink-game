extends CharacterComponent


func damage(player: Player) -> void:
	player.hurt(character.position)

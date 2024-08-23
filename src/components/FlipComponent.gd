extends CharacterComponent

@export var sprite: Sprite2D

func flip():
	sprite.flip_h = not sprite.flip_h

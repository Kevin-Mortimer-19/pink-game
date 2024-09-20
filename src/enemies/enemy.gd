extends CharacterBody2D

@export_group("Node References")
@export var animation_player: AnimationPlayer
@export var sprite: Sprite2D
@export var hitbox: CollisionPolygon2D
@export var ray: RayCast2D
@export var sfx_player: AudioStreamPlayer

@export_group("Movement")
@export var speed: float
@export var gravity: float
@export var start_flipped: bool

@export_group("Components")
@export var components: Node
@export var flip_component: CharacterComponent
@export var obstacle_component: CharacterComponent
@export var move_component: MoveComponent

@export_group("Animation")
@export var animation_name: String

@export_group("SFX")
@export var hurt_sfx: AudioStream


func _ready() -> void:
	animation_player.play(animation_name)
	if start_flipped:
		turn()
	
	for component in components.get_children():
		component.set_character(self)


func _physics_process(_delta: float) -> void:
	move_component.move(speed, gravity)


func damage(player: CharacterBody2D):
	obstacle_component.damage(player)


func hurt():
	EventBus.play_sfx.emit(hurt_sfx)
	queue_free()


func turn() -> void:
	if sprite.flip_h:
		hitbox.scale.x = 1
		ray.scale.x = 1
		flip_component.flip()
	else:
		hitbox.scale.x = -1
		ray.scale.x = -1
		flip_component.flip()


func play_sfx(sound: AudioStream) -> void:
	sfx_player.stream = sound
	sfx_player.play()

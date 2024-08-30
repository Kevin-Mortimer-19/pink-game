extends CharacterBody2D

@export_group("Node References")
@export var animation_player: AnimationPlayer
@export var sprite: Sprite2D
@export var hitbox: CollisionPolygon2D
@export var ray: RayCast2D

@export_group("Movement")
@export var speed: float
@export var gravity: float
@export var start_flipped: bool

@export_group("Components")
@export var components: Node
@export var flip_component: CharacterComponent


func _ready() -> void:
	animation_player.play("beetle_walk")
	if start_flipped:
		turn()


func _physics_process(_delta: float) -> void:
	velocity.x = -speed if sprite.flip_h else speed
	if not is_on_floor():
		velocity.y += gravity
	else:
		velocity.y = 0
	move_and_slide()
	if ray.is_colliding():
		print("Colliding")
		var collider = ray.get_collider()
		if collider.is_in_group("Terrain") or collider.is_in_group("Enemy"):
			print("Turning")
			turn()


func damage(player: CharacterBody2D):
	player.hurt(position)


func hurt():
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

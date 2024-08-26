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
		if ray.get_collider().is_in_group("Terrain"):
			print("Ray")
			turn()
	
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#if collision.get_collider().name == "Player":
			#damage(collision.get_collider())


func damage(player: CharacterBody2D):
	player.hurt(position)


func turn() -> void:
	if sprite.flip_h:
		hitbox.scale.x = 1
		ray.scale.x = 1
		flip_component.flip()
	else:
		hitbox.scale.x = -1
		ray.scale.x = -1
		flip_component.flip()

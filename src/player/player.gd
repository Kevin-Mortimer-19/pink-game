class_name Player extends CharacterBody2D

@export_group("Node References")
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer
@export var machine: StateMachine
@export var coyote_timer: Timer
@export var jump_buffer_timer: Timer
@export var knockback_timer: Timer
@export var dash_timer: Timer
@export var hitbox: Area2D

@export_group("Components")
@export var components: Node
@export var flip: CharacterComponent

@export_group("Movement")
@export var walk_speed: float
@export var gravity: float
@export var jump_force: float
@export var max_falling_speed: float

@export_group("Dash")
@export var dash_speed: float
@export var dash_time: float

@export_group("Game Feel")
@export var coyote_time: float
@export var jump_buffer_time: float

@export_group("Knockback Physics")
@export var knockback_multiplier: float
@export var knockback_time: float
@export var upwards_knockback: float

var gravity_multiplier: float = 1.0

# Game feel helper variables
var was_on_floor: bool = true
var jump_buffered: bool = false

func _ready() -> void:
	coyote_timer.wait_time = coyote_time
	
	jump_buffer_timer.wait_time = jump_buffer_time
	jump_buffer_timer.timeout.connect(remove_jump_buffer)
	
	knockback_timer.wait_time = knockback_time
	knockback_timer.timeout.connect(end_knockback)
	
	dash_timer.wait_time = dash_time
	dash_timer.timeout.connect(end_dash)
	
	hitbox.body_entered.connect(hit_detected)
	
	for state in machine.get_children():
		state.set_player(self)
	
	for component in components.get_children():
		component.set_character(self)


func _physics_process(_delta: float) -> void:
	apply_gravity()
	was_on_floor = is_on_floor()
	move_and_slide()
	
	if was_on_floor and not is_on_floor():
		coyote_timer.start()
	if Input.is_action_just_pressed("up") and not is_on_floor():
		jump_buffered = true
		jump_buffer_timer.start()


func apply_gravity() -> void:
	velocity.y += gravity * gravity_multiplier


func handle_movement() -> void:
	flip_check()
	velocity.x = Input.get_axis("left", "right") * walk_speed

func dash_movement() -> void:
	var dir = -1 if sprite.flip_h else 1
	velocity.x = dash_speed * dir


func end_dash() -> void:
	machine.transition_to("Air")


func flip_check() -> void:
	var flipped = sprite.flip_h
	if (
			(Input.is_action_pressed("left") and not flipped)
			or (Input.is_action_pressed("right") and flipped)
	):
		flip.flip()


func hurt(src_direction: Vector2) -> void:
	velocity = (position - src_direction - Vector2(0, upwards_knockback)) * knockback_multiplier
	machine.transition_to("Knockback")
	knockback_timer.start()


func hit_detected(body: Node2D):
	if body.is_in_group("Enemy"):
		body.damage(self)


func end_knockback() -> void:
	if is_on_floor():
		machine.transition_to("Idle")
	else:
		machine.transition_to("Air")


func start_animation(key: String) -> void:
	animation_player.play(key)


func stop_animation() -> void:
	animation_player.stop()


func remove_jump_buffer():
	jump_buffered = false

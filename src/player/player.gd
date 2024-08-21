class_name Player extends CharacterBody2D

@export_group("Node References")
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer
@export var machine: StateMachine
@export var coyote_timer: Timer

@export_group("Movement")
@export var walk_speed: float
@export var gravity: float
@export var jump_force: float
@export var max_falling_speed: float
@export var coyote_time: float

var gravity_multiplier: float = 1.0

var was_on_floor: bool = true


func _ready() -> void:
	coyote_timer.wait_time = coyote_time
	for state in machine.get_children():
		state.set_player(self)


func _physics_process(_delta: float) -> void:
	flip_check()
	handle_movement()
	was_on_floor = is_on_floor()
	move_and_slide()
	if was_on_floor and not is_on_floor():
		coyote_timer.start()

func handle_movement():
	velocity.x = Input.get_axis("left", "right") * walk_speed
	velocity.y += gravity * gravity_multiplier


func flip_check() -> void:
	var flipped = sprite.flip_h
	if Input.is_action_just_pressed("left") and not flipped:
		sprite.flip_h = true
	elif Input.is_action_just_pressed("right") and flipped:
		sprite.flip_h = false


func start_animation(key: String) -> void:
	animation_player.play(key)


func stop_animation() -> void:
	animation_player.stop()

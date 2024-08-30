class_name StateMachine extends Node

@export var initial_state: State
var current_state: State


func get_current_state() -> String:
	return current_state.name


func _ready() -> void:
	current_state = initial_state


func _process(delta) -> void:
	current_state._update(delta)


func _physics_process(delta) -> void:
	current_state._physics_update(delta)


func transition_to(target_state: String, msg: Dictionary = {}) -> void:
	current_state.exit()
	current_state = get_node(target_state)
	current_state.enter(msg)
	

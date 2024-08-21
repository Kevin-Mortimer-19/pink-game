class_name State extends Node

var machine: StateMachine


func _ready() -> void:
	machine = get_parent()


func enter(_msg: Dictionary) -> void:
	pass


func exit() -> void:
	pass


func _update(_delta: float) -> void:
	pass


func _physics_update(_delta: float) -> void:
	pass

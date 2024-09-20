extends Node


func _ready() -> void:
	EventBus.play_sfx.connect(play_sfx)


func play_sfx(sound: AudioStream) -> void:
	var bus = find_empty_bus()
	bus.stream = sound
	bus.play()


func find_empty_bus() -> AudioStreamPlayer:
	for bus in get_children():
		if not bus.playing:
			return bus
	return get_child(0)

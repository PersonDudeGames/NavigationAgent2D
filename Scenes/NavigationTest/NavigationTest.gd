extends Node2D

onready var character : KinematicBody2D = $Character
onready var line : Line2D = $Line2D

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			var target = get_global_mouse_position()
			SignalHub.emit_signal("set_target", target)

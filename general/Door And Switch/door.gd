@tool
class_name Door extends Node2D

const DOOR_CRASH_AUDIO = preload("uid://xwneu81nxed")

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if Engine.is_editor_hint():
		return
		
	for c in get_children():
		if c is switch:
			c.activated.connect(_on_switch_activated)
			if c.is_open == true:
				_on_switch_is_open()
	pass
	
	
func _on_switch_activated() -> void:
	animation_player.play("open")
	pass
	
func _on_switch_is_open() -> void:
	animation_player.play("opened")
	pass
	
func _get_configuration_warnings() -> PackedStringArray:
	if _check_for_switch() == false:
		return ["Requires a Switch Node"]
	return []
	
func _check_for_switch() -> bool:
	for c in get_children():
		if c is switch:
			return true
	return false

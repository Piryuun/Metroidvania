class_name switch extends Node2D

signal activated

const DOOR_SWITCH_AUDIO = preload("uid://dqub8i2lmdklp")

var is_open:bool = false

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	if SaveManager.persistent_data.get_or_add(unique_name(), "closed") == "open":
		set_open()
	else:
		area_2d.body_entered.connect(_on_player_entered)
		area_2d.body_exited.connect(_on_player_exited)
	pass
	
func _on_player_entered( _n:Node2D) -> void:
	Messages.input_hint_changed.emit("interact")
	Messages.player_interacted.connect(_on_player_interacted)
	
func _on_player_exited( _n:Node2D) -> void:
	Messages.input_hint_changed.emit("")
	Messages.player_interacted.disconnect(_on_player_interacted)
	
func _on_player_interacted(_player:Player) -> void:
	activated.emit()
	set_open()
	
func set_open() -> void:
	is_open = true
	SaveManager.persistent_data[unique_name()] = "open"
	sprite_2d.flip_h = true
	sprite_2d.modulate = Color.GRAY
	area_2d.queue_free()
	
func unique_name() -> String:
	var u_name:String = ResourceUID.path_to_uid(owner.scene_file_path)
	u_name += "/" + get_parent().name + "/" + name
	return u_name
	

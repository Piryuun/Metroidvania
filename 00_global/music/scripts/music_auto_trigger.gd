class_name MusicAutoTrigger extends Node

@export var track:AudioStream
@export var reverb : Audio.REVERB_TYPE = Audio.REVERB_TYPE.NONE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Audio.play_music(track)
	Audio.set_reverb(reverb)
	pass # Replace with function body.

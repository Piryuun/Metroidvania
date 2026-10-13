extends Button

@export var particle_settings:HitParticleSettings

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_on_pressed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_pressed() -> void:
	var player : Player = get_tree().get_first_node_in_group("Player")
	player.double_jump = true
	pass

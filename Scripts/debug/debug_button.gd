extends Button

@export var particle_settings:HitParticleSettings

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_on_pressed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_pressed() -> void:
	var player : Vector2 = get_tree().get_first_node_in_group("Player").global_position
	VisualEffect.hit_particles(player, Vector2(0,-1), particle_settings)
	pass

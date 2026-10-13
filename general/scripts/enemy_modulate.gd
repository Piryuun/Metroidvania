class_name EnemeyModulate extends Node

@export var color_flash:Color = Color(2.701, 0.0, 0.0, 1.0)

var tween:Tween

func _ready() -> void:
	if owner is Enemy:
		owner.was_hit.connect(_modulate_node)
	else:
		for c in get_children():
			if c is DamageArea:
				c.damage_taken.connect(_modulate_node)


func _modulate_node(_a:AttackArea) -> void:
	if tween:
		tween.kill()
	owner.modulate = color_flash
	tween = create_tween()
	tween.tween_property(owner, "modulate", Color.WHITE, 0.5)

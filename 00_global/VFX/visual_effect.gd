extends Node

const DUST_EFFECT = preload("uid://clcpjvm7nuh8h")

signal camera_shook(strength:float)

func create_dust_effect(pos:Vector2) -> DustEffect:
	var dust:DustEffect = DUST_EFFECT.instantiate()
	add_child(dust)
	dust.global_position = pos
	return dust
	
func jump_dust(pos:Vector2) -> void:
	var dust:DustEffect = create_dust_effect(pos)
	dust.start(DustEffect.TYPE.JUMP)
	
func land_dust(pos:Vector2) -> void:
	var dust:DustEffect = create_dust_effect(pos)
	dust.start(DustEffect.TYPE.LAND)
	
func hit_dust(pos:Vector2) -> void:
	var dust:DustEffect = create_dust_effect(pos)
	dust.start(DustEffect.TYPE.HIT)
	
func hit_particles() -> void:
	pass
	
func camera_shake(strength:float = 1.0) -> void:
	camera_shook.emit(strength)
	
	

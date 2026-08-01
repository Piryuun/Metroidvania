@tool
class_name BOD extends Enemy
func change_dir(new_dir:float) -> void:
	super(new_dir)
	if sprite:
		if new_dir < 0:
			sprite.flip_h = true
			sprite.offset.x = 70
		elif new_dir > 0:
			sprite.flip_h = false
			sprite.offset.x = 0
	pass

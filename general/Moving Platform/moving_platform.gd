class_name MovingPlatform extends Path2D

@export var path_time:float = 1.0
@export var ease:Tween.EaseType
@export var transition:Tween.TransitionType
@export var path_follow_2d:PathFollow2D

func _ready() -> void:
	move_tween()
	
func move_tween() -> void:
	var tween = get_tree().create_tween().set_loops()
	tween.tween_property(path_follow_2d, "progress_ratio", 1.0, path_time).set_ease(ease).set_trans(transition)
	tween.tween_property(path_follow_2d, "progress_ratio", 0.0, path_time).set_ease(ease).set_trans(transition)

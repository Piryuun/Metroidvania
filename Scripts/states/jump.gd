class_name PlayerStateJump extends PlayerState
const JUMP = preload("uid://cq28tss517jqk")

@export var jump_velocity : float = 450.0

var ground_slam_jump_velocity = 100


func init() -> void:
	pass

func enter() -> void:
	if player.previous_state == ground_slam:
		ground_slam_jump_velocity = -200
	else:
		ground_slam_jump_velocity = 0
		
	if player.is_on_floor():
		VisualEffect.jump_dust(player.global_position)
	else:
		VisualEffect.hit_dust(player.global_position)
	player.animation_player.play("jump")
	player.animation_player.pause()
	
	do_jump()
	
	if player.previous_state == fall and not Input.is_action_pressed("jump"):
		await get_tree().physics_frame
		player.velocity.y *= 0.5
		player.change_state(fall)
		pass
	pass
	 
func exit() -> void:
	#player.add_debug_indicatro(Color.YELLOW)
	pass
	
func handle_input(event:InputEvent) -> PlayerState:
	if event.is_action_pressed("dash") and player.can_dash():
		return dash
	if event.is_action_pressed("attack"):
		if player.ground_slam and Input.is_action_pressed("down"):
			return ground_slam
		return attack
	if event.is_action_released("jump"):
		player.velocity.y *= 0.5
		return fall
	return next_state
	
func process(_delta:float) -> PlayerState:
	set_jump_frame()
	return next_state
	
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	elif player.velocity.y >= 0:
		return fall
		
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
	
func do_jump() -> void:
	if player.jump_count > 0 and not player.previous_state == ground_slam:
		if player.double_jump == false:
			return
		elif player.jump_count > 1:
			return
	player.jump_count += 1
	player.velocity.y = -jump_velocity + ground_slam_jump_velocity
	Audio.play_spatial_sound(JUMP, player.global_position, false, true, 0.25)
	
func set_jump_frame() -> void:
	var frame : float = remap(player.velocity.y, -jump_velocity + ground_slam_jump_velocity, 0.0, 0.0, 0.5)
	player.animation_player.seek(frame, true)

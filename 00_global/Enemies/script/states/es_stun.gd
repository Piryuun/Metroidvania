class_name ESStun
extends EnemyState

#meta-name: EnemyState
#meta-description: Boilerplate decision engine script
#meta-default: true

#EnemyState class will inherit the following variables:
#@export var animation
#var state_machine:EnemyStateMachine
#var enemy:Enemy
#var blackboard:BlackBoard
@export var knocbak_strength:float = 100
var vel_x:float = 0
var duration:float = 0
var timer:float = 0

func start() -> void:
	var anim:String = animation_name if animation_name else "stun"
	if enemy.animation.current_animation == anim:
		enemy.animation.seek(0)
	else:
		enemy.play_animation(anim)
	duration = enemy.animation.current_animation_length
	timer = 0
	_calc_velocity(blackboard.damage_source)
	blackboard.damage_source = null
	blackboard.can_decide = false
func enter() -> void:
	start()
	pass
	
func re_enter() -> void:
	pass
	
func exit() -> void:
	blackboard.can_decide = true
	pass
	
func physics_update(_delta:float) -> void:
	timer += _delta
	enemy.velocity.x = vel_x * (1 - timer / duration)
	if timer >= duration:
		blackboard.can_decide = true
	pass
	
func _calc_velocity(a: AttackArea) -> void:
	vel_x = 1
	if a.global_position.x > enemy.global_position.x:
		vel_x = -1
	vel_x *= knocbak_strength
	pass

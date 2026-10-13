class_name PlayerStateGroundSlam extends PlayerState

const DASH_AUDIO = preload("uid://c6camvgrvayds")
const BOOM_AUDIO = preload("uid://dqnskmoyw0fm8")
const BREAK_WOOD_AUDIO = preload("uid://dvktgpbrnr7ck")
const HIT_WOOD_LARGE = preload("uid://cpsiqfn35qxl6")
const HIT_WOOD_MEDIUM = preload("uid://d02oox1u0g5ou")
const HIT_WOOD_SMALL = preload("uid://cmuewnlfrqfqa")

@export var velocity:float = 400
@export var effect_delay:float = 0.075

var effect_timer:float = 0

@onready var damage_area: DamageArea = %DamageArea
@onready var ground_slam_shape_cast: ShapeCast2D = $"../../GroundSlamShapeCast"
@onready var ground_slam_attack: AttackArea = %GroundSlamAttack

func init() -> void:
	pass

func enter() -> void:
	player.animation_player.play("ground_slam")
	player.sprite.tween_color()
	Audio.play_spatial_sound(BOOM_AUDIO, player.global_position)
	damage_area.start_invulnerable()
	ground_slam_attack.set_active()
	pass
	
func exit() -> void:
	VisualEffect.camera_shake(10.0)
	VisualEffect.land_dust(player.global_position)
	VisualEffect.hit_dust(player.global_position)
	Audio.play_spatial_sound(DASH_AUDIO, player.global_position)
	damage_area.end_invulnerable()
	ground_slam_attack.set_active(false)
	pass
	
func handle_input(_event:InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump") and player.jump_count <= 2:
			return jump
	return next_state
	
func process(_delta:float) -> PlayerState:
	check_collisions(_delta)
	effect_timer =- _delta
	if effect_timer < 0:
		effect_timer = effect_delay
		player.sprite.ghost()
	return next_state
	
func physics_process(_delta: float) -> PlayerState:
	player.velocity = Vector2(0, velocity)
	if player.is_on_floor():
		if not check_collisions(_delta):
			return idle
	return next_state
	
func check_collisions(_delta:float) -> bool:
	ground_slam_shape_cast.target_position.y = velocity * _delta
	ground_slam_shape_cast.force_shapecast_update()
	if ground_slam_shape_cast.is_colliding():
		for i in ground_slam_shape_cast.get_collision_count():
			var c = ground_slam_shape_cast.get_collider(i)
			var pos:Vector2 = ground_slam_shape_cast.get_collision_point(i)
			
			VisualEffect.hit_dust(pos)
			VisualEffect.camera_shake(10.0)
			
			if c.get_parent() is Breakable:
				var b:Breakable = c.get_parent()
				b.queue_free()
				Audio.play_spatial_sound(b.destroy_audio, pos)
				for p in b.destroy_particles:
					VisualEffect.hit_particles(pos, Vector2.DOWN, p)
			else:
				c.queue_free()
				VisualEffect.hit_particles(pos, Vector2.DOWN, HIT_WOOD_LARGE)
				VisualEffect.hit_particles(pos, Vector2.DOWN, HIT_WOOD_MEDIUM)
				VisualEffect.hit_particles(pos, Vector2.UP, HIT_WOOD_SMALL)
				Audio.play_spatial_sound(BREAK_WOOD_AUDIO, pos)
				

		return true
	return false

extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _on_gate_player_entered_gate(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)


func _on_player_on_laser_fired(pos: Vector2, direction: Vector2):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation = direction.angle()
	laser.direction = direction
	$Projectiles.add_child(laser)

func _on_player_on_grenade_fired(pos: Vector2, direction: Vector2):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)

func _on_house_player_entered():
	var tween = create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1,1), 1)

func _on_house_player_exited():
	var tween = create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6,0.6), 1)

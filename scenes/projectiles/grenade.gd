extends RigidBody2D

const speed = 750


func _on_explosion_timer_timeout():
	$AnimationPlayer.play("Explosion")

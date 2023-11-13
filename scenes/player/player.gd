extends CharacterBody2D

var can_laser: bool = true
var can_grendade: bool = true

signal on_laser_fired(position: Vector2, direction: Vector2)
signal on_grenade_fired(position: Vector2, direction: Vector2)

@export var max_speed: int = 500
var speed: int = max_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	look_at(get_global_mouse_position())
	
	if (Input.is_action_pressed("primary action") && can_laser):
		$LaserParticleEmitter.emitting = true
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		var laser_direction = _get_projectile_direction()
		can_laser = false
		$LaserTimer.start()
		on_laser_fired.emit(selected_laser.global_position, laser_direction)
		
	if (Input.is_action_pressed("secondary action") && can_grendade):
		$GrenadeTimer.start()
		var pos_marker = $LaserStartPositions.get_children()[0].global_position
		var grenade_direction = _get_projectile_direction()
		on_grenade_fired.emit(pos_marker, grenade_direction)
		can_grendade = false


func _get_projectile_direction():
	return (get_global_mouse_position() - position).normalized()

func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grendade = true # Replace with function body.

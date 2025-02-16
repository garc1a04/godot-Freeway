extends RigidBody2D

func _ready() -> void:
	var cars = $SpriteCars.sprite_frames.get_animation_names();
	var typeCar = cars[randi_range(0,13)];
	$SpriteCars.animation = typeCar;
	
func _on_notifier_cars_screen_exited() -> void:
	queue_free();

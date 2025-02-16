extends Node

var car_scene: PackedScene = load("res://Src/Scene/Objects/car.tscn");

var score = 0;
var fast_track = [104, 272, 488];
var slow_track =  [160, 216, 324, 384, 438, 544, 600];

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	$MusicTheme.play();
	restartGame();
	
func _on_speed_cars_timeout() -> void:
	var track = fast_track[randi_range(0,2)];
	$Cars.add_child(configCar(200,210,track));
	
func _on_slow_cars_timeout() -> void:
	var track = slow_track[randi_range(0,6)];
	$Cars.add_child(configCar(0,10,track));
	
func configCar(firstVel,LastVel,track):
	var car = car_scene.instantiate();
	var randomVelocity = randf_range(firstVel+speed_cars(score), LastVel+speed_cars(score));

	car.position = Vector2(-10, track) if track > 380 else Vector2(1290, track)
	car.linear_velocity.x = randomVelocity if track > 380 else -randomVelocity;
	car.linear_damp = -0.5;
	
	if(track < 380):
		car.set_rotation_degrees(180);
		
	return car;
	
func speed_cars(score):
	if(score <= 0):
		return 100;
	
	var velocity = score*100;
	if(velocity > 500):
		return 500
		
	return velocity;
	
func _on_chicken_pointed() -> void:
	score+=1;
	timeCars(score);
		
	if(score >= 10):
		stop_game();
		var Win = "res://Src/Scene/Layers/player_win.tscn"
		assert(get_tree().change_scene_to_file(Win) == OK);
		return;
		
	$Pointed._set_playing(true);
	$HUD/Container/Score.text = "Score: " + str(score);


func timeCars(score):
	var seconds = score/10.0;
	
	if(seconds >= 0.5):
		return;
		
	$SpeedCars.start(0.8-seconds);
	$SlowCars.start(1-seconds);
	
func stop_game():
	$Chicken.isMove = false;
	$Chicken.position = Vector2(640,690);
	$SpeedCars.stop();
	$SlowCars.stop();
	$MusicTheme.stop();
	
	for child in $Cars.get_children():
		child.free()
			
func restartGame():
	$SpeedCars.start(1);
	$SlowCars.start(1.2);
	$Chicken.isMove = true;
	score = 0;

func _on_chicken_collision() -> void:
	var child = $HUD/HBoxContainer.get_child(0);
	
	if(child != null):
		$HUD/HBoxContainer.remove_child(child);

func _on_chicken_die() -> void:
	stop_game();
	var Lose = "res://Src/Scene/Layers/player_gameOver.tscn"
	assert(get_tree().change_scene_to_file(Lose) == OK);

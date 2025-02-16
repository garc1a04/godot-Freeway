extends Node

var car_scene: PackedScene = load("res://Src/Scene/Objects/car.tscn");

var score = 0;
var score2 = score;
var fast_track = [104, 272, 488];
var slow_track =  [160, 216, 324, 384, 438, 544, 600];

func _ready() -> void:
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
	
func _on_first_chicken_pointed() -> void:
	score+=1;
	timeCars();
	
	if(score >= 10):
		ganhou(1);
	
	$SoundPointed._set_playing(true);
	$HUD/HBoxContainer/Player1/Score.text = "Player1: " + str(score);

func _on_second_chicken_2_pointed() -> void:
	score2+=1;
	timeCars();
	
	if(score2 >= 10):
		ganhou(2);
		
	$SoundPointed._set_playing(true);
	$HUD/HBoxContainer/Player2/Score.text = "Player2: " + str(score2);
	
func ganhou(player):
	var ganhou_scene = load("res://Src/Scene/Layers/player_win_Local.tscn").instantiate()
	ganhou_scene.player = player
	get_tree().root.add_child(ganhou_scene) 
	get_tree().current_scene.queue_free() 
	get_tree().current_scene = ganhou_scene
	
func timeCars():
	var score = score if score > score2 else score2
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
	
	for child in $Cars.get_children():
		child.free()
			
func restartGame():
	$SoundTheme.play();
	$SpeedCars.start(1);
	$SlowCars.start(1.2);
	score = 0;
	
func _on_first_chicken_die() -> void:
	ganhou(2);
	
func _on_second_chicken_2_die() -> void:
	ganhou(1);
	
func _on_first_chicken_collision() -> void:
	var child = $HUD/Life1.get_child(0);
	$HUD/Life1.remove_child(child);
	
func _on_second_chicken_2_collision() -> void:
	var child = $HUD/Life2.get_child(0); 
	$HUD/Life2.remove_child(child);

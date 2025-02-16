extends CanvasLayer

var direction = Vector2(0,2);
var speed = 300;
var player: int;
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	configTitle(player);
	var random = Vector2(randi_range(0,1280),-10)
	$SpriteChicken.position = random;
	$Car.position = Vector2(random.x,-250);
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$SpriteChicken.position += direction*delta*speed;
	$Car.position += direction*delta*speed;
	commands(screen_exited($SpriteChicken.position,$Car.position));

func configTitle(player):
	$VBoxContainer/Ttile.text = "PLAYER "+ str(player) + " WIN";

func commands(definition) -> void:
	if(definition == 1):
		$SpriteChicken.animation = 'Up';
		$Car.set_rotation_degrees(0);
		direction = Vector2(0,-2);
		
	if(definition == -1):
		$SpriteChicken.animation = 'Down';
		$Car.set_rotation_degrees(180);
		direction = Vector2(0,2);

func screen_exited(size: Vector2, size2: Vector2):
	
	if(size2.y > 820):
		var random = randi_range(0,1280)
		$SpriteChicken.position.x = random;
		$Car.position.x = random;
		return 1;
	if(size.y < -100):
		var random = randi_range(0,1280)
		$SpriteChicken.position.x = random;
		$Car.position.x = random;
		return -1;
		
func _on_restart_pressed() -> void:
	var Local: String = "res://Src/Scene/Multiplayer/MultiplayerLocal.tscn";
	assert(get_tree().change_scene_to_file(Local) == OK)
	
func _on_menu_pressed() -> void:
	var start: String = "res://Src/Scene/Layers/start.tscn";
	assert(get_tree().change_scene_to_file(start) == OK)

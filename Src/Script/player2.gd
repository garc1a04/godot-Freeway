extends Area2D

@export var speed = 100;
var start_position = Vector2(640,690);
var screen_size = Vector2(1280,720);
var isMove = true;
var life = 3;

signal pointed;
signal collision;
signal die;

func _ready() -> void:
	position.y = start_position.y
	
func _process(delta: float) -> void:
	var velocity = moviment(delta);
	animation_choose(velocity);
	animation_action(velocity);
	
	position +=  velocity
	position.y = clamp(position.y, 0, screen_size.y);
	
func moviment(delta):
	if(!isMove):
		return Vector2(0,0);
	
	var velocity :Vector2;
	
	if(Input.is_action_pressed("ui_up")):
		velocity.y-=1;
	if(Input.is_action_pressed("ui_down")):
		velocity.y+=1;
		
	return velocity.normalized() * speed * delta;
	
func animation_choose(velocity):
	if(velocity.y > 0):
		$AnimatedSprite2D.animation = 'down'
		return;
		
	$AnimatedSprite2D.animation = 'up'

func animation_action(velocity):
	if(velocity.length() > 0):
		$AnimatedSprite2D.play();
		return;
		
	$AnimatedSprite2D.pause();
	
func _on_body_entered(body: Node2D) -> void:
	if(body.name == "End"):
		position.y = start_position.y;
		pointed.emit();
		return;
		
	if(life <= 1):
		die.emit();
	
	life-=1;
	$AudioStreamPlayer2D.play();
	collision.emit();
	restartChicken();
	
func restartChicken():
	isMove = false;
	position.y = start_position.y;
	$ChickenDamage.start(0.5);
	
func _on_chicken_damage_timeout() -> void:
	isMove = true;
	$ChickenDamage.stop();

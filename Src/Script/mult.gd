extends CanvasLayer

var Local: String = "res://Src/Scene/Multiplayer/MultiplayerLocal.tscn";
var Menu: String = "res://Src/Scene/Layers/start.tscn"

func _process(delta: float) -> void:
	if($HBoxContainer/ButtonHost.button_pressed):
		pass
	if($HBoxContainer/ButtonJoin.button_pressed):
		pass
	if($HBoxContainer/ButtonLocal.button_pressed):
		local()
	if($ButtonMenu.button_pressed):
		menu()
			
func local():
	assert(get_tree().change_scene_to_file(Local) == OK);

func menu():
	assert(get_tree().change_scene_to_file(Menu) == OK);

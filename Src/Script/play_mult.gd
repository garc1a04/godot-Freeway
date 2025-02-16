extends Button

var mult: String = "res://Src/Scene/Multiplayer/MultiplayerLocal.tscn";

func _on_pressed() -> void:
	assert(get_tree().change_scene_to_file(mult) == OK);

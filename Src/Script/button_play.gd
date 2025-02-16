extends Button

var main: String = "res://Src/Scene/main.tscn";

func _on_pressed() -> void:
	assert(get_tree().change_scene_to_file(main) == OK);

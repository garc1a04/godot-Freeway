extends CanvasLayer

func _on_restart_pressed() -> void:
	var main: String = "res://Src/Scene/main.tscn";
	assert(get_tree().change_scene_to_file(main) == OK)
	
func _on_menu_pressed() -> void:
	var start: String = "res://Src/Scene/Layers/start.tscn";
	assert(get_tree().change_scene_to_file(start) == OK)

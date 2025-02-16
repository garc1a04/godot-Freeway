extends CanvasLayer

var tutorialSolo: String = "res://Src/Scene/Layers/tutorialSolo.tscn";
var tutorialMult: String = "res://Src/Scene/Layers/tutorialMult.tscn";

func _process(delta: float) -> void:
	if($HBoxContainer/ButtonSolo.button_pressed):
		soloPlayer();
	if($HBoxContainer/ButtonMultiplayer.button_pressed):
		multPlayer();
		
func soloPlayer():
	assert(get_tree().change_scene_to_file(tutorialSolo) == OK);

func multPlayer():
	assert(get_tree().change_scene_to_file(tutorialMult) == OK);

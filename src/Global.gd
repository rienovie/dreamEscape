extends Node

var GM : Class_Grid_Manager

func _ready() -> void:
	if(!GM):
		GM = load("res://src/GridManager.gd").new()
		add_child(GM)

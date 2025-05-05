extends Node

var GM : Class_Grid_Manager

var m3SlotTexture : Texture2D = preload("res://Assets/match-3-art-pack/match_3_art_pack/bg/cave/cave_bricks_01.png")

func _ready() -> void:
	if(!GM):
		GM = load("res://src/GridManager.gd").new()
		add_child(GM)

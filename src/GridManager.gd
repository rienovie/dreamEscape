extends Node
class_name Class_Grid_Manager

var tileScene : PackedScene = preload("res://Scenes/m3_slot.tscn")

func _ready() -> void:
	addTile(Vector2i(2,2))
	addTile(Vector2i(0,0))
	addTile(Vector2i(1,1))
	addTile(Vector2i(3,3))
	addTile(Vector2i(4,4))
	addTile(Vector2i(5,5))
	addTile(Vector2i(6,6))
	addTile(Vector2i(-1,-1))

func addTile(location : Vector2i):
	var newTile : Class_M3_Slot = tileScene.instantiate()
	newTile.gridLocation = location
	add_child(newTile)


extends Node

var GM : Class_Grid_Manager

var m3Slot : class_data_m3_slot = preload("res://Data/UI/Match3/TileSlots/data_m3_slot_basic.tres")

var m3Slot_List : Array[class_data_m3_slot] = [
	preload("res://Data/UI/Match3/TileSlots/data_m3_slot_basic.tres"),
]

func _ready() -> void:
	if(!GM):
		GM = load("res://src/GridManager.gd").new()
		add_child(GM)

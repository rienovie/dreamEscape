extends Node

signal refesh_M3_Slot_Textures

var GM : Class_Grid_Manager

var m3Slot : class_data_m3_slot = preload("res://Data/UI/Match3/TileSlots/data_m3_slot_basic.tres") :
	set(value):
		m3Slot = value
		refesh_M3_Slot_Textures.emit()

# NOTE: manually adding each because dynamic loading would require an additional plugin or manually modifing the exported game
var m3Slot_List : Dictionary [String, class_data_m3_slot] = {
	"Cave" : preload("res://Data/UI/Match3/TileSlots/data_m3_slot_basic.tres"),
	"Grass" : preload("res://Data/UI/Match3/TileSlots/data_m3_slot_grass.tres"),
	"Desert" : preload("res://Data/UI/Match3/TileSlots/data_m3_slot_desert.tres"),
	"Simple" : preload("res://Data/UI/Match3/TileSlots/data_m3_slot_simple.tres"),
	"Simple(Dark)" : preload("res://Data/UI/Match3/TileSlots/data_m3_slot_simple_dark.tres"),
	"Wood" : preload("res://Data/UI/Match3/TileSlots/data_m3_slot_wood.tres"),
}

func _ready() -> void:
	if(!GM):
		GM = load("res://src/GridManager.gd").new()
		add_child(GM)

extends Node

signal refesh_M3_Slot_Textures

var GM : Class_Grid_Manager
var GSM : GridSaveManager

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

var m3Dropper_List : Dictionary [String, Texture2D] = {
	"South" : load("res://Assets/dreamEscape/dropper_south.png"),
	"North" : load("res://Assets/dreamEscape/dropper_north.png"),
	"West" : load("res://Assets/dreamEscape/dropper_west.png"),
	"East" : load("res://Assets/dreamEscape/dropper_east.png")
}

var m3Floor_List : Dictionary [String, Texture2D] = {
	"South" : load("res://Assets/dreamEscape/floor_south.png"),
	"North" : load("res://Assets/dreamEscape/floor_north.png"),
	"West" : load("res://Assets/dreamEscape/floor_west.png"),
	"East" : load("res://Assets/dreamEscape/floor_east.png"),
}

var m3Gem_List : Dictionary [String, class_data_m3_gem]

func _ready() -> void:
	if(!GSM):
		GSM = load("res://src/GridSaveManager.gd").new()
		add_child(GSM)

	if(!GM):
		GM = load("res://src/GridManager.gd").new()
		add_child(GM)


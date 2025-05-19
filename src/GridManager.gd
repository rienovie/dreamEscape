extends Node
class_name Class_Grid_Manager

signal updateTileSize(newSize)
signal updateGridCenter(newSize)
signal updateTileGap(newSize)

var currentGrid : Dictionary

var gridCenter = Vector2(0.0,0.0) :
	set(value):
		gridCenter = value
		updateGridCenter.emit(gridCenter)

var tileSize = Vector2(64.0,64.0) :
	set(value):
		tileSize = value
		updateTileSize.emit(value)

var tileGap = Vector2(5.0,5.0) :
	set(value):
		tileGap = value
		updateTileGap.emit(value)

func gridCenterToCenterScreen():
	var vp = get_viewport().get_visible_rect().size
	gridCenter = Vector2(vp.x / 2, vp.y / 2)

var tileScene : PackedScene = preload("res://Scenes/m3_slot.tscn")

# TODO: create gem resource type
var currentGemTypes : Array

func _ready() -> void:
	gridCenterToCenterScreen()

	addTile(Vector2i(2,2))
	addTile(Vector2i(0,0))
	addTile(Vector2i(1,1))
	addTile(Vector2i(3,3))
	addTile(Vector2i(4,4))
	addTile(Vector2i(5,5))
	addTile(Vector2i(6,6))
	addTile(Vector2i(-1,-1))

func addTile(location : Vector2i):
	if(currentGrid.has(location)):
		push_warning("Attempted to add a tile that already exists at location: ",location)
		return
	var newTile : Class_M3_Slot = tileScene.instantiate()
	newTile.gridLocation = location
	currentGrid.set(location,newTile)
	add_child(newTile)
	print("Added tile at:",location)

func killGrid() -> void:
	for item in currentGrid.values():
		item.removeSlot()
	currentGrid.clear()

func removeTile(location : Vector2i):
	if(!currentGrid.has(location)):
		push_warning("Attempted to remove a tile that does not exist at location: ",location)
		return
	currentGrid.get(location).removeSlot()
	currentGrid.erase(location)
	print("Removed tile at:",location)

func dropGem(_location : Vector2i) -> void:
	pass

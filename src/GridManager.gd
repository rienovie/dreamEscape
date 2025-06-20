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
	if currentGrid.is_empty():
		gridCenter = get_viewport().get_visible_rect().size / 2.0
		return

	var keys = currentGrid.keys()
	var gridMin : Vector2i = keys[0]
	var gridMax : Vector2i = keys[0]
	for i in range(1, keys.size()):
		var key = keys[i]
		gridMin.x = min(gridMin.x, key.x)
		gridMin.y = min(gridMin.y, key.y)
		gridMax.x = max(gridMax.x, key.x)
		gridMax.y = max(gridMax.y, key.y)

	var centerOfGrid : Vector2 = Vector2(gridMin) + (Vector2(gridMax - gridMin) / 2.0)
	var totalTileSize = tileSize + tileGap
	gridCenter = centerOfGrid * totalTileSize

var tileScene : PackedScene = preload("res://Scenes/m3_slot.tscn")

# TODO: create gem resource type
var currentGemTypes : Array

func _ready() -> void:
	G.GSM.load_grid("3x3")

	gridCenterToCenterScreen()
	determineFloorTiles()

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

# Relies on the gridCenter variable being set prior to call
func gridToWorldLocation(gridLocation : Vector2i) -> Vector2:
	var vp_center = get_viewport().get_visible_rect().size / 2.0
	var totalTileSize = tileSize + tileGap
	var output = vp_center + (Vector2(gridLocation) * totalTileSize) - gridCenter
	return output

func assignFloorToTile(location : Vector2i, isVisible : bool = true) -> void:
	print("Assigning floor to tile: ",location)
	if(!currentGrid.has(location)):
		push_warning("Attempted to assign a floor to a tile that does not exist at location: ",location)
		return
	currentGrid.get(location).floorIsVisible = isVisible

func determineFloorTiles() -> void:
	var dropperTiles = getAllDropperTiles()
	var nextTile = Vector2i(0,0)
	var prevTile = Vector2i(0,0)
	for dropperTile in dropperTiles:
		nextTile = dropperTile.gridLocation
		while(nextTile in currentGrid):
			prevTile = nextTile
			if dropperTile.gravityDirection == Class_M3_Slot.gravity_direction.South:
				nextTile.y += 1
			elif dropperTile.gravityDirection == Class_M3_Slot.gravity_direction.North:
				nextTile.y -= 1
			elif dropperTile.gravityDirection == Class_M3_Slot.gravity_direction.West:
				nextTile.x -= 1
			elif dropperTile.gravityDirection == Class_M3_Slot.gravity_direction.East:
				nextTile.x += 1
		assignFloorToTile(prevTile)

func getAllDropperTiles() -> Array:
	var dropperTiles : Array = []
	for tile in currentGrid.values():
		if tile.dropperType != Class_M3_Slot.dropper_type.None:
			dropperTiles.append(tile)
	return dropperTiles
extends Node

signal updateTileSize(newSize)
signal updateGridCenter(newSize)
signal updateTileGap(newSize)

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

func _ready() -> void:
	gridCenterToCenterScreen()

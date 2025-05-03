extends Node

@export_category("Tile Size")
@export var TileSize_X_SpnBx : SpinBox
@export var TileSize_Y_SpnBx : SpinBox
@export var TileSize_X_HSldr : HSlider
@export var TileSize_Y_HSldr : HSlider
@export var TileSize_Lock_ChkBx : CheckBox

@export_category("Grid Origin")
@export var GridOrigin_X_SpnBx : SpinBox
@export var GridOrigin_Y_SpnBx : SpinBox
@export var GridOrigin_X_HSldr : HSlider
@export var GridOrigin_Y_HSldr : HSlider

var bTileSize_Lock : bool = true :
	set(value):
		bTileSize_Lock = value
		TileSize_Lock_ChkBx.button_pressed = value

func _ready() -> void:
	TileSize_X_HSldr.value = G.tileSize.x
	TileSize_Y_HSldr.value = G.tileSize.y
	TileSize_X_SpnBx.value = G.tileSize.x
	TileSize_Y_SpnBx.value = G.tileSize.y
	TileSize_Lock_ChkBx.button_pressed = bTileSize_Lock
	GridOrigin_X_HSldr.value = G.gridCenter.x
	GridOrigin_Y_HSldr.value = G.gridCenter.y
	GridOrigin_X_SpnBx.value = G.gridCenter.x
	GridOrigin_Y_SpnBx.value = G.gridCenter.y

func _on_spn_bx_tile_size_x_value_changed(value: float) -> void:
	if(value == G.tileSize.x):
		return
	if(value != TileSize_X_HSldr.value):
		TileSize_X_HSldr.value = value
	if(bTileSize_Lock && value != TileSize_Y_SpnBx.value):
		TileSize_Y_SpnBx.value = value
	G.tileSize.x = value


func _on_spn_bx_tile_size_y_value_changed(value: float) -> void:
	if(value == G.tileSize.y):
		return
	if(value != TileSize_Y_HSldr.value):
		TileSize_Y_HSldr.value = value
	if(bTileSize_Lock && value != TileSize_X_SpnBx.value):
		TileSize_X_SpnBx.value = value
	G.tileSize.y = value


func _on_h_sldr_tile_size_x_value_changed(value: float) -> void:
	if(value == G.tileSize.x):
		return
	if(value != TileSize_X_SpnBx.value):
		TileSize_X_SpnBx.value = value


func _on_h_sldr_tile_size_y_value_changed(value: float) -> void:
	if(value == G.tileSize.y):
		return
	if(value != TileSize_Y_SpnBx.value):
		TileSize_Y_SpnBx.value = value


func _on_chk_bx_tile_size_lock_toggled(toggled_on: bool) -> void:
	bTileSize_Lock = toggled_on


func _on_btn_grid_origin_center_pressed() -> void:
	G.gridCenterToCenterScreen()
	if(G.gridCenter.x != GridOrigin_X_HSldr.value):
		GridOrigin_X_HSldr.value = G.gridCenter.x
	if(G.gridCenter.y != GridOrigin_Y_HSldr.value):
		GridOrigin_Y_HSldr.value = G.gridCenter.y
	if(G.gridCenter.x != GridOrigin_X_SpnBx.value):
		GridOrigin_X_SpnBx.value = G.gridCenter.x
	if(G.gridCenter.y != GridOrigin_Y_SpnBx.value):
		GridOrigin_Y_SpnBx.value = G.gridCenter.y


func _on_grid_origin_x_spn_bx_value_changed(value: float) -> void:
	if(value == G.gridCenter.x):
		return
	if(value != GridOrigin_X_HSldr.value):
		GridOrigin_X_HSldr.value = value
	G.gridCenter.x = value


func _on_grid_origin_x_h_sldr_value_changed(value: float) -> void:
	if(value == G.gridCenter.x):
		return
	if(value != GridOrigin_X_SpnBx.value):
		GridOrigin_X_SpnBx.value = value


func _on_grid_origin_y_spn_bx_value_changed(value: float) -> void:
	if(value == G.gridCenter.y):
		return
	if(value != GridOrigin_Y_HSldr.value):
		GridOrigin_Y_HSldr.value = value
	G.gridCenter.y = value


func _on_grid_origin_y_h_sldr_value_changed(value: float) -> void:
	if(value == G.gridCenter.y):
		return
	if(value != GridOrigin_Y_SpnBx.value):
		GridOrigin_Y_SpnBx.value = value

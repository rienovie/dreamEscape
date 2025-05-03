extends Node

@export_category("Misc")
@export var MainTab : TabContainer

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

@export_category("Tile Gap")
@export var TileGap_X_SpnBx : SpinBox
@export var TileGap_Y_SpnBx : SpinBox
@export var TileGap_X_HSldr : HSlider
@export var TileGap_Y_HSldr : HSlider
@export var TileGap_Lock_ChkBx : CheckBox

var bTileSize_Lock : bool = true :
	set(value):
		bTileSize_Lock = value
		TileSize_Lock_ChkBx.button_pressed = value
var bTileGap_Lock : bool = true :
	set(value):
		bTileGap_Lock = value
		TileGap_Lock_ChkBx.button_pressed = value

func _ready() -> void:
	# HACK:
	# for some reason always selects the first tab even when set to -1 in editor
	MainTab.current_tab = -1

	TileSize_X_HSldr.value = G.GM.tileSize.x
	TileSize_Y_HSldr.value = G.GM.tileSize.y
	TileSize_X_SpnBx.value = G.GM.tileSize.x
	TileSize_Y_SpnBx.value = G.GM.tileSize.y
	TileSize_Lock_ChkBx.button_pressed = bTileSize_Lock
	GridOrigin_X_HSldr.value = G.GM.gridCenter.x
	GridOrigin_Y_HSldr.value = G.GM.gridCenter.y
	GridOrigin_X_SpnBx.value = G.GM.gridCenter.x
	GridOrigin_Y_SpnBx.value = G.GM.gridCenter.y
	TileGap_X_HSldr.value = G.GM.tileGap.x
	TileGap_Y_HSldr.value = G.GM.tileGap.y
	TileGap_X_SpnBx.value = G.GM.tileGap.x
	TileGap_Y_SpnBx.value = G.GM.tileGap.y
	TileGap_Lock_ChkBx.button_pressed = bTileGap_Lock

func _on_spn_bx_tile_size_x_value_changed(value: float) -> void:
	if(value == G.GM.tileSize.x):
		return
	if(value != TileSize_X_HSldr.value):
		TileSize_X_HSldr.value = value
	if(bTileSize_Lock && value != TileSize_Y_SpnBx.value):
		TileSize_Y_SpnBx.value = value
	G.GM.tileSize.x = value

func _on_spn_bx_tile_size_y_value_changed(value: float) -> void:
	if(value == G.GM.tileSize.y):
		return
	if(value != TileSize_Y_HSldr.value):
		TileSize_Y_HSldr.value = value
	if(bTileSize_Lock && value != TileSize_X_SpnBx.value):
		TileSize_X_SpnBx.value = value
	G.GM.tileSize.y = value

func _on_h_sldr_tile_size_x_value_changed(value: float) -> void:
	if(value == G.GM.tileSize.x):
		return
	if(value != TileSize_X_SpnBx.value):
		TileSize_X_SpnBx.value = value

func _on_h_sldr_tile_size_y_value_changed(value: float) -> void:
	if(value == G.GM.tileSize.y):
		return
	if(value != TileSize_Y_SpnBx.value):
		TileSize_Y_SpnBx.value = value

func _on_chk_bx_tile_size_lock_toggled(toggled_on: bool) -> void:
	bTileSize_Lock = toggled_on

func _on_btn_grid_origin_center_pressed() -> void:
	G.GM.gridCenterToCenterScreen()
	if(G.GM.gridCenter.x != GridOrigin_X_HSldr.value):
		GridOrigin_X_HSldr.value = G.GM.gridCenter.x
	if(G.GM.gridCenter.y != GridOrigin_Y_HSldr.value):
		GridOrigin_Y_HSldr.value = G.GM.gridCenter.y
	if(G.GM.gridCenter.x != GridOrigin_X_SpnBx.value):
		GridOrigin_X_SpnBx.value = G.GM.gridCenter.x
	if(G.GM.gridCenter.y != GridOrigin_Y_SpnBx.value):
		GridOrigin_Y_SpnBx.value = G.GM.gridCenter.y

func _on_grid_origin_x_spn_bx_value_changed(value: float) -> void:
	if(value == G.GM.gridCenter.x):
		return
	if(value != GridOrigin_X_HSldr.value):
		GridOrigin_X_HSldr.value = value
	G.GM.gridCenter.x = value

func _on_grid_origin_x_h_sldr_value_changed(value: float) -> void:
	if(value == G.GM.gridCenter.x):
		return
	if(value != GridOrigin_X_SpnBx.value):
		GridOrigin_X_SpnBx.value = value

func _on_grid_origin_y_spn_bx_value_changed(value: float) -> void:
	if(value == G.GM.gridCenter.y):
		return
	if(value != GridOrigin_Y_HSldr.value):
		GridOrigin_Y_HSldr.value = value
	G.GM.gridCenter.y = value

func _on_grid_origin_y_h_sldr_value_changed(value: float) -> void:
	if(value == G.GM.gridCenter.y):
		return
	if(value != GridOrigin_Y_SpnBx.value):
		GridOrigin_Y_SpnBx.value = value

func _on_tile_gap_lock_chk_bx_toggled(toggled_on:bool) -> void:
	bTileGap_Lock = toggled_on

func _on_tile_gap_x_spn_bx_value_changed(value:float) -> void:
	if(value == G.GM.tileGap.x):
		return
	if(value != TileGap_X_HSldr.value):
		TileGap_X_HSldr.value = value
	if(bTileGap_Lock && value != TileGap_Y_SpnBx.value):
		TileGap_Y_SpnBx.value = value
	G.GM.tileGap.x = value

func _on_tile_gap_x_h_sldr_value_changed(value:float) -> void:
	if(value == G.GM.tileGap.x):
		return
	if(value != TileGap_X_SpnBx.value):
		TileGap_X_SpnBx.value = value

func _on_tile_gap_y_spn_bx_value_changed(value:float) -> void:
	if(value == G.GM.tileGap.y):
		return
	if(value != TileGap_Y_HSldr.value):
		TileGap_Y_HSldr.value = value
	if(bTileGap_Lock && value != TileGap_X_SpnBx.value):
		TileGap_X_SpnBx.value = value
	G.GM.tileGap.y = value

func _on_tile_gap_y_h_sldr_value_changed(value:float) -> void:
	if(value == G.GM.tileGap.y):
		return
	if(value != TileGap_Y_SpnBx.value):
		TileGap_Y_SpnBx.value = value

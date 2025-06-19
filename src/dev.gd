extends Node

@export_category("Misc")
@export var MainTab : TabContainer
@export var SlotTexture_OptBx : OptionButton
@export var Timer_Second : Timer
@export var TileLbl : Label

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

@export_category("Grid Edit")
@export var AddTile_Btn : Button
@export var RemoveTile_Btn : Button
@export var SaveGrid_Btn : Button
@export var LoadGrid_Btn : Button
@export var DeleteGrid_Btn : Button
@export var PopulateGrid_Btn : Button
@export var TileSelect_X_SpnBx : SpinBox
@export var TileSelect_Y_SpnBx : SpinBox
@export var GridList_OptBx : OptionButton
@export var NewGrid_TxtBx : TextEdit
@export var ClearGrid_Btn : Button
@export var Dropper_OptBx : OptionButton

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

	setItemValues()
	populateSlotTexturesList()
	populate_saved_grids_list()
	populate_dropper_list()

	Timer_Second.connect("timeout",tick_sec)

# Hooked into a timer repeating every second
func tick_sec() -> void:
	TileLbl.text = str("Tiles [",G.GM.currentGrid.size(),"]")


func setItemValues() -> void:
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

func populateSlotTexturesList() -> void:
	SlotTexture_OptBx.clear()

	for i in G.m3Slot_List.keys():
		SlotTexture_OptBx.add_item(i)

func populate_dropper_list() -> void:
	Dropper_OptBx.clear()
	for type_name in Class_M3_Slot.dropper_type.keys():
		Dropper_OptBx.add_item(type_name)

func populate_saved_grids_list() -> void:
	GridList_OptBx.clear()
	var save_files = G.GSM.get_grid_names()
	for file_name in save_files:
		GridList_OptBx.add_item(file_name)

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

func _on_clear_grid_btn_pressed() -> void:
	G.GM.killGrid()
	TileSelect_X_SpnBx.value = 0
	TileSelect_Y_SpnBx.value = 0

func _on_add_tile_btn_pressed() -> void:
	G.GM.addTile(Vector2i(round(TileSelect_X_SpnBx.value),round(TileSelect_Y_SpnBx.value)))

func _on_print_grid_btn_pressed() -> void:
	print("---Grd---")
	for item in G.GM.currentGrid:
		print(item)
	print("---End---")

func _on_remove_tile_btn_pressed() -> void:
	var location = Vector2i(round(TileSelect_X_SpnBx.value),round(TileSelect_Y_SpnBx.value))
	G.GM.removeTile(location)

func _on_slot_texture_opt_bx_item_selected(index:int) -> void:
	G.m3Slot = G.m3Slot_List.get(SlotTexture_OptBx.get_item_text(index))

func _on_save_grid_btn_pressed() -> void:
	var save_name = NewGrid_TxtBx.text
	if save_name.is_empty():
		push_warning("Save name cannot be empty.")
		return
	
	G.GSM.save_grid(save_name)
	populate_saved_grids_list()
	NewGrid_TxtBx.clear()

func _on_load_grid_btn_pressed() -> void:
	if GridList_OptBx.get_selected_id() == -1:
		push_warning("No save file selected.")
		return
	
	var save_name = GridList_OptBx.get_item_text(GridList_OptBx.selected)
	G.GSM.load_grid(save_name)
	setItemValues()

func _on_delete_grid_btn_pressed() -> void:
	if GridList_OptBx.get_selected_id() == -1:
		push_warning("No save file selected to delete.")
		return
	
	var save_name = GridList_OptBx.get_item_text(GridList_OptBx.selected)
	G.GSM.delete_grid(save_name)
	populate_saved_grids_list()


func _on_populate_grid_btn_pressed() -> void:
	G.GM.killGrid()

	for x in range(TileSelect_X_SpnBx.value):
		for y in range(TileSelect_Y_SpnBx.value):
			G.GM.addTile(Vector2i(x,y))

	G.GM.gridCenterToCenterScreen()

func _on_update_dropper_btn_pressed() -> void:
	var location = Vector2i(round(TileSelect_X_SpnBx.value),round(TileSelect_Y_SpnBx.value))
	if !G.GM.currentGrid.has(location):
		push_warning("No tile at location: " + str(location))
		return

	var tile : Class_M3_Slot = G.GM.currentGrid[location]
	var selected_dropper_type_index = Dropper_OptBx.selected
	var selected_dropper_type_name = Dropper_OptBx.get_item_text(selected_dropper_type_index)
	
	var dropper_type_value = Class_M3_Slot.dropper_type.get(selected_dropper_type_name)
	
	tile.dropperType = dropper_type_value
	tile.updateDropper()

extends Node
class_name GridSaveManager

const SAVE_PATH = "res://Data/Grids/"
const SAVE_FILE = "predefined_grids.json"
var _full_path: String

var _grids: Dictionary = {}

func _ready() -> void:
	var dir = DirAccess.open("res://")
	if not dir.dir_exists(SAVE_PATH):
		dir.make_dir_recursive(SAVE_PATH)

	_full_path = SAVE_PATH.path_join(SAVE_FILE)

	if not FileAccess.file_exists(_full_path):
		var file = FileAccess.open(_full_path, FileAccess.WRITE)
		if file:
			file.store_string("{}")
			file.close()
		else:
			push_error("Failed to create grid save file at: " + _full_path)
			return
			
	_load_from_disk()

func _load_from_disk() -> void:
	var file = FileAccess.open(_full_path, FileAccess.READ)
	if not file:
		push_error("Failed to open grid save file: " + _full_path)
		return

	var json_string = file.get_as_text()
	file.close()

	var parse_result = JSON.parse_string(json_string)

	if parse_result == null:
		push_error("Failed to parse JSON from grid save file: " + _full_path)
		return
	
	_grids = parse_result

func _save_to_disk() -> void:
	var file = FileAccess.open(_full_path, FileAccess.WRITE)
	if file:
		var json_string = JSON.stringify(_grids, "\t")
		file.store_string(json_string)
		file.close()
	else:
		push_error("Failed to save grid to: " + _full_path)

func get_grid_names() -> Array:
	return _grids.keys()

func save_grid(save_name: String) -> void:
	if save_name.is_empty():
		push_error("Save name cannot be empty.")
		return

	var tiles = []
	for pos in G.GM.currentGrid:
		tiles.append([pos.x, pos.y])
	
	_grids[save_name] = tiles
	_save_to_disk()
	print("Grid saved: " + save_name)

func load_grid(save_name: String) -> void:
	if not _grids.has(save_name):
		push_error("Grid not found in save file: " + save_name)
		return

	G.GM.killGrid()
	
	var tiles = _grids[save_name]
	for pos_array in tiles:
		G.GM.addTile(Vector2i(pos_array[0], pos_array[1]))
	
	G.GM.gridCenterToCenterScreen()
	print("Grid loaded: " + save_name)

func delete_grid(save_name: String) -> void:
	if _grids.has(save_name):
		_grids.erase(save_name)
		_save_to_disk()
		print("Grid deleted: " + save_name)
	else:
		push_warning("Attempted to delete a grid that does not exist: " + save_name) 

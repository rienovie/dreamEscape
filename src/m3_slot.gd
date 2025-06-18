extends Node2D
class_name Class_M3_Slot

@export var iconSprite : Sprite2D
@export var gridLocation : Vector2i

func _ready() -> void:
	G.GM.updateTileSize.connect(setSize)
	G.GM.updateGridCenter.connect(updateLocation)
	G.GM.updateTileGap.connect(updateLocation)
	G.refesh_M3_Slot_Textures.connect(updateIcon)

	updateIcon()

func setSize(sizeValue : Vector2):
	var imgSize = iconSprite.texture.get_size()

	self.scale.x = sizeValue.x / imgSize.x
	self.scale.y = sizeValue.y / imgSize.y

	updateLocation(null)

# input can be a few different things so unused for specificity
func updateLocation(_v):
	global_transform.origin = G.GM.gridToWorldLocation(gridLocation)

func removeSlot():
	queue_free()

func updateIcon() -> void:
	iconSprite.texture = G.m3Slot.textures.pick_random()
	setSize(G.GM.tileSize)

extends Node2D
class_name Class_M3_Slot

@export var iconSprite : Sprite2D
@export var gridLocation : Vector2i

func _ready() -> void:
	G.updateTileSize.connect(setSize)
	G.updateGridCenter.connect(updateLocation)
	G.updateTileGap.connect(updateLocation)

	setSize(G.tileSize)

func setSize(sizeValue : Vector2):
	var imgSize = iconSprite.texture.get_size()

	self.scale.x = sizeValue.x / imgSize.x
	self.scale.y = sizeValue.y / imgSize.y

	updateLocation(null)

# input can be a few different things so unused for specificity
func updateLocation(_v):
	global_transform.origin = Vector2(gridLocation) * G.tileSize + G.gridCenter + ((Vector2(gridLocation) * G.tileGap))

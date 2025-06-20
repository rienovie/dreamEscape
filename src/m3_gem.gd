extends Node2D
class_name Class_M3_Gem

@export var iconSprite : Sprite2D
@export var gridLocation : Vector2i
@export var movementCurve : Curve

func _process(_delta: float) -> void:
	pass

func _ready() -> void:
	assert(iconSprite != null, "Icon sprite is null in gem")

	updateIcon()

func setSize(sizeValue : Vector2):
	var imgSize = iconSprite.texture.get_size()

	self.scale.x = sizeValue.x / imgSize.x
	self.scale.y = sizeValue.y / imgSize.y

	updateLocation(null)

# input can be a few different things so unused for specificity
func updateLocation(_v):
	global_transform.origin = Vector2(gridLocation) * G.GM.tileSize + G.GM.gridCenter + ((Vector2(gridLocation) * G.GM.tileGap))

func removeGem():
	queue_free()

func updateIcon() -> void:
	iconSprite.texture = G.m3Slot.textures.pick_random()
	setSize(G.GM.tileSize)


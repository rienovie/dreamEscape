extends Node2D

@export var iconSprite : Sprite2D
@export var gridLocation : Vector2i

@export var movementCurve : Curve

func _process(_delta: float) -> void:
	pass

func _ready() -> void:

	# TODO: replace with updateIcon function later which will include this
	setSize(G.GM.tileSize)

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

# TODO: make this function
# func updateIcon() -> void:
# 	iconSprite.texture = G.m3Slot.textures.pick_random()
# 	setSize(G.GM.tileSize)

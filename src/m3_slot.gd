extends Node2D
class_name Class_M3_Slot

enum dropper_type {
	None,
	South,
	North,
	West,
	East,
}

enum gravity_direction {
	South,
	North,
	West,
	East,
}

@export var iconSprite : Sprite2D
@export var dropperSprite : Sprite2D
@export var floorSprite : Sprite2D
@export var floorIsVisible : bool = false :
	set(value):
		floorIsVisible = value
		updateFloor()

@export var gridLocation : Vector2i
@export var dropperType : dropper_type = dropper_type.None
@export var gravityDirection : gravity_direction = gravity_direction.South

func _ready() -> void:
	assert(iconSprite != null, "Icon sprite is null in slot")
	assert(dropperSprite != null, "Dropper sprite is null in slot")
	assert(floorSprite != null, "Floor sprite is null in slot")

	G.GM.updateTileSize.connect(setSize)
	G.GM.updateGridCenter.connect(updateLocation)
	G.GM.updateTileGap.connect(updateLocation)
	G.refesh_M3_Slot_Textures.connect(updateIcon)

	updateIcon()
	updateDropper()
	updateGravityDirection()
	updateFloor()

func setSize(sizeValue : Vector2):
	var imgSize = iconSprite.texture.get_size()
	var dropperImgSize = dropperSprite.texture.get_size()
	var floorImgSize = floorSprite.texture.get_size()

	iconSprite.scale.x = sizeValue.x / imgSize.x
	iconSprite.scale.y = sizeValue.y / imgSize.y

	dropperSprite.scale.x = sizeValue.x / dropperImgSize.x
	dropperSprite.scale.y = sizeValue.y / dropperImgSize.y

	floorSprite.scale.x = sizeValue.x / floorImgSize.x
	floorSprite.scale.y = sizeValue.y / floorImgSize.y

	updateLocation(null)

# input can be a few different things so unused for specificity
func updateLocation(_v):
	global_transform.origin = G.GM.gridToWorldLocation(gridLocation)

func removeSlot():
	queue_free()

func updateIcon() -> void:
	iconSprite.texture = G.m3Slot.textures.pick_random()
	setSize(G.GM.tileSize)

func updateDropper() -> void:
	match dropperType:
		dropper_type.South:
			dropperSprite.texture = G.m3Dropper_List["South"]
		dropper_type.North:
			dropperSprite.texture = G.m3Dropper_List["North"]
		dropper_type.West:
			dropperSprite.texture = G.m3Dropper_List["West"]
		dropper_type.East:
			dropperSprite.texture = G.m3Dropper_List["East"]
		dropper_type.None:
			dropperSprite.texture = null

func updateGravityDirection():
	match gravityDirection:
		gravity_direction.South:
			floorSprite.texture = G.m3Floor_List["South"]
		gravity_direction.North:
			floorSprite.texture = G.m3Floor_List["North"]
		gravity_direction.West:
			floorSprite.texture = G.m3Floor_List["West"]
		gravity_direction.East:
			floorSprite.texture = G.m3Floor_List["East"]

func updateFloor() -> void:
	floorSprite.visible = floorIsVisible

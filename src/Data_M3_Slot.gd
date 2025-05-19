extends Resource
class_name class_data_m3_slot

@export_category("Base")
@export var textures : Array[Texture2D]

@export_category("Gap")
@export var gap_useTextures = false
@export var gap_Textures : Array[Texture2D]
# Will match index of gapTexture To base texture array index or random if false
@export var gap_useSpecificTextureIndex = false

@export var gap_values : Array[int] = [2]
# Will match index of gapValue To base texture array index or random if false
@export var gap_useSpecificValueIndex = false
@export var gap_useColor = false
@export var gap_Color = Color(0,0,0,1)

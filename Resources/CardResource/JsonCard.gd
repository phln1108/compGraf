@tool
extends Resource
class_name JsonCard

@export var type: String 

@export var sprite: Texture

@export var text: String
@export var noMsg: String
@export var yesMsg: String

@export var yesValues: Array[float]
@export var noValues: Array[float]
#
#@export var yesPath: Array[CardResource] = []

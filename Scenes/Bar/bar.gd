@tool
extends Control

@export var under: Texture = null
@export var progress: Texture = null

@export var value: float = 50
@export var id : int = 0

# green -> 77dd76
# red   -> ff6962

var toAdd: float = 0
var velocity: float = 60

@onready var dot = $dot
@onready var bar: ProgressBar = $bar
@onready var bar2: TextureProgressBar = $bar2

var sb: StyleBoxFlat = null

func _ready():
	sb = StyleBoxFlat.new()
	bar.add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color("999999")
	sb.corner_radius_top_left = 4
	sb.corner_radius_top_right = 4
	
	bar.value = value
	dot.visible = false

func valueHint_show(point: float):
	if !point:
		return
	dot.visible = true
	if point > 10:
		dot.scale = Vector2 (1.5,1.5)
		dot.position = Vector2(8,96) - (dot.size / 4)
		return
	dot.scale = Vector2(1,1)
	dot.position = Vector2(8,96)

func valueHint_hide():
	dot.visible = false

func addValue(point: float):
	Achievements.setBarValue(id,point+value)
	if value + point <= 0:
		SignalBus.emit_signal("gameEnd",id,false)
	if value + point >= 100:
		SignalBus.emit_signal("gameEnd",id,true)
	
	toAdd = point
	
func _process(delta):
	if is_inside_tree():
		if under != $bar2.texture_under and under != null:
			bar2.texture_under = under
		if progress != $bar2.texture_progress and progress != null:
			bar2.texture_progress = progress
		
		
		if toAdd == 0:
			sb.bg_color = Color("999999")
		else:
			var v =  clamp(delta*velocity,0,abs(toAdd))
			
			if toAdd < 0:
				v = -v

			toAdd -= v
			value += v
			bar.value  += v
			bar2.value += v
		

extends ColorRect

var show: bool = false
var pivotPoint: Vector2
var velocity: float = 10

func _ready():
	pivotPoint = global_position
	
func _process(delta):
	if show:
		var motion = pivotPoint.y + size.y - global_position.y
		global_position.y += motion*delta*velocity
	else:
		var motion = pivotPoint.y - global_position.y
		global_position.y += motion*delta*velocity

func setMsg(text: String) -> void:
	$Label.text = text
	

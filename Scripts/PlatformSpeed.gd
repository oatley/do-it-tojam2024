extends AnimatableBody2D

#@export var size = Vector2 (64,64)

var isFloor = true
var isSpikes = false
var isIcy = false
var isSpeed = true
var isBounce = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.shape.size.x = $Sprite2D.region_rect.size.x
	$CollisionShape2D.shape.size.y = $Sprite2D.region_rect.size.y
	$CollisionShape2D.position = $Sprite2D.position
	$CollisionShape2D.scale = $Sprite2D.scale
	$CollisionShape2D.rotation = $Sprite2D.rotation
	
	#$Sprite2D.region_rect = Rect2(get_parent().position.x, get_parent().position.y, size.x, size.y)
	


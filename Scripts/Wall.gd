extends AnimatableBody2D

var isFloor = false
var isSpikes = false
var isIcy = false
var isSpeed = false
var isBounce = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#print ($Sprite2D.region_rect.size)
	$CollisionShape2D.shape.size.x = $Sprite2D.region_rect.size.x
	$CollisionShape2D.shape.size.y = $Sprite2D.region_rect.size.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

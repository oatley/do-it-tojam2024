extends Area2D

#@export var size = Vector2 (64,64)

var isFloor = true
var isSpikes = false
var isIcy = false
var isSpeed = false
var isBounce = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.visible = false
	$Label2.visible = false
	$CollisionShape2D.shape.size.x = $Sprite2D.region_rect.size.x
	$CollisionShape2D.shape.size.y = $Sprite2D.region_rect.size.y
	$CollisionShape2D.position = $Sprite2D.position
	$CollisionShape2D.scale = $Sprite2D.scale
	$CollisionShape2D.rotation = $Sprite2D.rotation
	
	#$Sprite2D.region_rect = Rect2(get_parent().position.x, get_parent().position.y, size.x, size.y)
	



func _on_body_entered(body):
	$Label.visible = true
	pass # Replace with function body.


func _on_body_exited(body):
	$Label2.visible = true
	pass # Replace with function body.

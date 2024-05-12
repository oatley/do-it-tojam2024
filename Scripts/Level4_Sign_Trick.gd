extends Area2D

# Properties
var isSign = true
var isFloor = false
var isSpikes = false
var isIcy = false
var isSpeed = false
var isBounce = false


var playerTalking = false


var currentMessage = 0
var messages = [
	"No, this is the end >:)"
]


# Called when the node enters the scene tree for the first time.
func _ready():
	$TrickSpikes1.visible = false
	$TrickSpikes2.visible = false
	$TrickSpikes3.visible = false
	$AnimatedSprite2D.play("Sign")
	$Label.text = messages[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if playerTalking:
		var interact = Input.is_action_just_pressed("interact")
		if interact:
			$TrickPlatform.visible = false
			$TrickPlatform.queue_free()
			$TrickSpikes1.visible = true
			$TrickSpikes2.visible = true
			$TrickSpikes3.visible = true
			$Label.text = messages[currentMessage]
			currentMessage += 1
			if currentMessage >= len(messages):
				currentMessage = 0
		
	
	


func _on_body_entered(body):
	if body.name == "Player":
			playerTalking = true


func _on_body_exited(body):
	if body.name == "Player":
			playerTalking = false

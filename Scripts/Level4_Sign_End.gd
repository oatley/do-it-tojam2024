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
	"This is the end",
	"You win!",
	":) :) :)",
	"Back to the beginning",
	"Level 1 incomming",
	"click once more to restart",
	"meow"
	
]


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("Sign")
	$Label.text = messages[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if playerTalking:
		var interact = Input.is_action_just_pressed("interact")
		if interact:
			$Label.text = messages[currentMessage]
			currentMessage += 1
			if currentMessage >= len(messages):
				get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")
				currentMessage = 0
		
	
	


func _on_body_entered(body):
	if body.name == "Player":
			playerTalking = true


func _on_body_exited(body):
	if body.name == "Player":
			playerTalking = false

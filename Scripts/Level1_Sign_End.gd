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
	"Hey, lets go to level 2"
	
]


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("Sign")
	$Label.text = messages[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playerTalking:
		var interact = Input.is_action_just_pressed("interact")
		if interact:
			#scene.SceneTree.change_scene_to_file("res://Scenes/Levels/Level2.tscn")
			#get_tree().change_scene("res://Scenes/Levels/Level2.tscn")
			#print("res://Scenes/Levels/Level"+str(int(get_tree().current_scene.filename[-6])+1)+".tscn")
			#get_tree().change_scene_to_file("res://Scenes/Levels/Level"+sget_tree().change_scene_to_file("res://Scenes/Levels/Level2.tscn")tr(int(get_tree().current_scene.filename[-6])+1)+".tscn")
			get_tree().change_scene_to_file("res://Scenes/Levels/Level2.tscn")
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

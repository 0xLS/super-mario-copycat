extends Node

@onready var points_label: Label = %PointsLabel
@export var hearts : Array[Node]

var points = 0
var lives = 3

func increaseHealth():
	lives += 1

func decreaseHealth():
	lives -= 1
	
	for i in 3:
		if (i < lives):
			hearts[i].show()
		else:
			hearts[i].hide()
	
	if (lives == 0):
		get_tree().change_scene_to_file("res://scenes/restart_menu.tscn")

func addPoint():
	points += 1
	points_label.text = 'Points: ' + str(points)

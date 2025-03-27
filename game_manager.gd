extends Node

@onready var points_label: Label = %PointsLabel

var points = 0

func addPoint():
	points += 1
	points_label.text = 'Points: ' + str(points)

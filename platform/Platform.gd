extends Node2D

export(int, 0, 100) var cell_movement = 2
export(float) var cell_per_seconds = 2
export(float) var idle_duration = .5
export(bool) var horizontal = true

onready var tween : = $Tween as Tween
onready var kinematic : = $Kinematic as KinematicBody2D

var cell_size : = 16
var follow : = Vector2.ZERO

func _ready() -> void:
	var move_to : Vector2 = (Vector2.RIGHT if horizontal else Vector2.UP) * (cell_size * cell_movement)
	var duration : float = move_to.length() / (cell_per_seconds * cell_size)
	
	tween.interpolate_property(self, "follow", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, idle_duration)
	tween.interpolate_property(self, "follow", move_to, Vector2.ZERO, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + idle_duration * 2)
	tween.start()
	
func _physics_process (delta: float) -> void:
	kinematic.position = kinematic.position.linear_interpolate (follow, 0.1)

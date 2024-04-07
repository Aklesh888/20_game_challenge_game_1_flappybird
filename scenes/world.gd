extends Node2D


@onready var parallax_background = $ParallaxBackground
@onready var obstacles = $obstacles
@onready var score_label = $score_label
@onready var highscore_label = $highscore_label


@onready var spawner_1 = $spawners/spawner_1
@onready var spawner_2 = $spawners/spawner_2
@onready var spawner_3 = $spawners/spawner_3
@onready var spawner_4 = $spawners/spawner_4

var obstacle = preload('res://scenes/obstacles.tscn')

var high_score_save_path = 'user://highscore.save'

var score = 0
var high_score = 0

func _ready():
	load_score()

func _physics_process(delta):
	score_label.text = str(score)
	highscore_label.text = str(high_score)
	obstacles.position.x += -300 * delta
	parallax_background.scroll_base_offset.x += -100 * delta
	
	if high_score != null and high_score <= score:
		save_score()


func _on_timer_timeout():
	randomize()
	var rand_var = randf()
	
	spawn_obstacle(spawner_1)

	if rand_var > 0.8:
		spawn_obstacle(spawner_4)
	
	randomize()
	
	spawn_obstacle(spawner_2)
	
	if rand_var > 0.8:
		spawn_obstacle(spawner_4)

func spawn_obstacle(spawner):
	var new_obstacle = obstacle.instantiate()
	obstacles.add_child(new_obstacle)
	new_obstacle.global_position = spawner.global_position

func save_score():
	var file = FileAccess.open(high_score_save_path, FileAccess.WRITE)
	file.store_var(score)

func load_score():
	if FileAccess.file_exists(high_score_save_path):
		var file = FileAccess.open(high_score_save_path, FileAccess.READ)
		high_score = file.get_var(score)
	else:
		high_score = 0


func _on_area_2d_body_entered(body):
	if body.is_in_group('bird'):
		body.hurt()

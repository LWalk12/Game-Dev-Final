extends Node2D

var sword =false
@export var hasSword = false
var x

#var action = Input.action_press("ui_select")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	$Player/CharacterBody2D.SPEED = 300
	$Player/CharacterBody2D/atckr.disabled = true
	$Player/CharacterBody2D/atckl.disabled = true
	if $Player/CharacterBody2D.velocity.x > 0:
		x = 'right'
	elif $Player/CharacterBody2D.velocity.x < 0:
		x = 'left'
	if hasSword && Input.is_action_pressed("attack"):
		attack(x)
	if hasSword && Input.is_action_just_released("attack"):
		$Player/CharacterBody2D/Sprite2D.animation = 'release'


func _on_world_limit_body_entered(body: Node2D) -> void:
	body.position = $playerSpawn.position


func _on_area_2d_body_entered(body: Node2D) -> void:
	var tween=get_tree().create_tween()
	if $buildings/Area2D/CollisionShape2D:
		tween.tween_property($world/building,"self_modulate", Color.TRANSPARENT,0.25)
	if $buildings/Area2D/shed:
		tween.tween_property($world/shed,"self_modulate", Color.TRANSPARENT,0.25)
	if $buildings/Area2D/castle:
		tween.tween_property($world/castle,"self_modulate", Color.TRANSPARENT,0.25)

func _on_area_2d_body_exited(body: Node2D) -> void:
		var tween=get_tree().create_tween()
		if $buildings/Area2D/CollisionShape2D:
			tween.tween_property($world/building,"self_modulate", Color.WHITE,0.25)
		if $buildings/Area2D/shed:
			tween.tween_property($world/shed,"self_modulate", Color.WHITE,0.25)
		if $buildings/Area2D/castle:
			tween.tween_property($world/castle,"self_modulate", Color.WHITE,0.25)


func _on_sword_body_entered(body: Node2D) -> void:
	sword = true

func _input(event: InputEvent) -> void:
	if sword && event.is_action_pressed("ui_select"):
		hasSword = true
		$world/sword.visible = false
		

func attack(x):
	
	if x == 'right':
		$Player/CharacterBody2D/atckr.disabled = false
	elif  x == 'left':
		$Player/CharacterBody2D/atckl.disabled = false
	$Player/CharacterBody2D/Sprite2D.animation = 'release'
	$Player/CharacterBody2D.SPEED *= 0.5
	

func _on_sword_body_exited(body: Node2D) -> void:
	sword = false

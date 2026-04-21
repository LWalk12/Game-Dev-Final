extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	$Sprite2D.animation = 'idle'
	$Sprite2D.play()

func _physics_process(delta: float) -> void:
	$atck.disabled =true
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	var attack := Input.is_action_pressed("attack")
	if direction:
		velocity.x = direction * SPEED
		$Sprite2D.animation = 'walk'
		$Sprite2D.flip_h = velocity.x < 0
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$Sprite2D.animation = 'idle'
	
	if velocity.x < 0:
		$atck.position.x *= -1
	
	if attack:
		$Sprite2D.animation = 'quickAttack'
		$atck.disabled = false
		velocity.x = (direction * SPEED) * 0.5
		
	move_and_slide()

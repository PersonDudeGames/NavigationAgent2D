extends KinematicBody2D

onready var nav_agent : NavigationAgent2D = $CharacterNavAgent
onready var line : Line2D = get_node("../Line2D")

var velocity : Vector2 = Vector2.ZERO
var speed : int = 360

func _ready() -> void:
	nav_agent.avoidance_enabled = true
	var desired_distance : float = floor(speed / 100)
	nav_agent.path_desired_distance = desired_distance
	nav_agent.target_desired_distance = desired_distance
	
	SignalHub.connect("set_target", self, "navigate")

func navigate(target: Vector2) -> void:
	nav_agent.set_target_location(target)
	nav_agent.get_next_location()
	line.points = nav_agent.get_nav_path()
		
func _physics_process(delta: float) -> void:
	if not nav_agent.is_navigation_finished():
		var current_pos = global_position
		var target = nav_agent.get_next_location()
		velocity = current_pos.direction_to(target) * speed
		nav_agent.set_velocity(velocity)
		

func _on_CharacterNavAgent_velocity_computed(safe_velocity: Vector2) -> void:
	move_and_slide(safe_velocity)


func _on_CharacterNavAgent_target_reached() -> void:
	line.points = nav_agent.get_nav_path()


func _on_CharacterNavAgent_navigation_finished() -> void:
	line.points = []

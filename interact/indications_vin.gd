extends "res://interact/interactable.gd"

@onready var prompt = $prompt_vin # Assurez-vous que "prompt_help" est une référence au noeud UI (par ex. un Label ou une TextureRect)

# Temps d'affichage du prompt en secondes
const PROMPT_DISPLAY_TIME = 3.0

# Chronomètre pour cacher le prompt après un délai
var prompt_timer: Timer = null

func _ready() -> void:
	# Initialisation : cache le prompt et configure le timer
	prompt.visible = false
	prompt_timer = Timer.new()
	add_child(prompt_timer)
	prompt_timer.one_shot = true
	
	# Corriger la connexion du signal
	prompt_timer.timeout.connect(_on_prompt_timeout)

# Fonction appelée à chaque interaction
func _on_interacted(body: Variant) -> void:
	_show_prompt()

# Affiche le prompt et démarre le timer
func _show_prompt() -> void:
	prompt.visible = true
	prompt_timer.start(PROMPT_DISPLAY_TIME)

# Cache le prompt lorsque le timer expire
func _on_prompt_timeout() -> void:
	prompt.visible = false

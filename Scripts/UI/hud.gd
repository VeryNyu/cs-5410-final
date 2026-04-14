extends Control


var score: int = 0
var time_elapsed: float = 0.0
var is_stopped: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	time_elapsed = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_stopped:
		time_elapsed += delta
		$Time/Time.text = str(time_elapsed).pad_decimals(2)
		$Score/Score.text = str(score)


func Game_Start():
	time_elapsed = 0.0
	$Score/Score.text = "00000"
	show()
	is_stopped = false


func stop() -> void:
	is_stopped = true

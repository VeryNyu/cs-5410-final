extends Control

signal Change

var page_number: int = 0
var page_times: Array
var page_scores: Array


func TEST():
	display()
	print("TIMES:")
	for t in SaveLoad.Times:
		print(str(t) + ": " + str(SaveLoad.Times[t]))
	
	print("SCORES:")
	for s in SaveLoad.Scores:
		print(str(s) + ": " + str(SaveLoad.Scores[s]))


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display()


func display():
	_clear_display()
	page_times = SaveLoad.Times.get_or_add(page_number, [])
	page_scores = SaveLoad.Scores.get_or_add(page_number, [])
	_display_helper("time", page_times)
	_display_helper("score", page_scores)


func _clear_display():
	for d in ["time", "score"]:
		for i in range(5):
			get_node("Container/Display/%s/%d" % [d, i]).text = ""


func _display_helper(type: String, page: Array):
	for i in page.size():
		var label = get_node("Container/Display/%s/%d" % [type, i])
		label.text = "%s: %s" % [page[i]["tag"], page[i][type]]


func _on_button_pressed(key: String) -> void:
	match key:
		"Back": Change.emit("Back")
		"Reset":
			SaveLoad.clear_scores()
			display()


func _on_nav_pressed(key: String) -> void:
	var label: String = "Container/Title/Level/"
	
	match key:
		"Right": page_number += 1
		"Left": page_number -= 1

	if page_number == 0: get_node(label + "Left").hide()
	elif page_number == SaveLoad.Scores.size() - 1:  get_node(label + "Right").hide()
	else: for dir in ["Left", "Right"]: get_node(label + dir).show()
	
	$Container/Title/Level.text = "Level: " + str(page_number + 1)
	display()

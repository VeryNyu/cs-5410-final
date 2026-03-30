extends Control

signal Change

var page_number: int = 0
var page_times: Array
var page_scores: Array


func TEST():
	print("TIMES:")
	for t in SaveLoad.Times:
		print(SaveLoad.Times[t])
	
	print("SCORES:")
	for s in SaveLoad.Scores:
		print(SaveLoad.Scores[s])


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	page_times = SaveLoad.Times[page_number]
	page_scores = SaveLoad.Scores[page_number]
	_display()


func _display():
	_display_helper("time", page_times)
	_display_helper("score", page_scores)


func _display_helper(type: String, page: Array):
	for i in page.size():
		print(page)
		var label = get_node("Container/Display/%s/%d" % [type, i])
		label.text = "%s: %s" % [page[i]["tag"], page[i][type]]


func _on_button_pressed(key: String) -> void:
	match key:
		"Back": Change.emit("Back")

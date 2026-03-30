extends Node

const TIMEPATH: String = "user://TimeSaveFile.json"
const SCOREPATH: String = "user://ScoreSaveFile.json"


var file: FileAccess
var Times: Dictionary
var Scores: Dictionary

var TimeSaveSchema: Dictionary = {
	"tag": "TAG",
	"level": 0,
	"time": "0.0"
}

var ScoreSaveSchema: Dictionary = {
	"tag": "TAG",
	"level": 0,
	"score": 0
}


func _ready() -> void:
	#for i in range(5):		# CAN AUTOMATE INDEX PER LEVEL COUNT
		#Times[i] = []
		#Scores[i] = []
	load_scores()

func save_scores(tag: String, level: int, score: int, time: float):
	var time_string = _format_time(time)
	var time_data = _save_helper(TimeSaveSchema, tag, level, "time", time_string)
	if Times.is_empty():
		var temp_list: Array
		temp_list.append(time_data)
		Times[level] = temp_list
	else:
		Times[level] = time_data
	_trim_data("time", Times[level])
	_save(Times, TIMEPATH)
	
	var score_data = _save_helper(ScoreSaveSchema, tag, level, "score", score)
	Scores[level].append(score_data)
	_trim_data("score", Scores[level])
	_save(Scores, SCOREPATH)


func _save_helper(schema: Dictionary, tag: String, level: int, key: String, value):
	var temp_schema: Dictionary = schema.duplicate()
	
	temp_schema["tag"] = tag
	temp_schema["level"] = level
	temp_schema[key] = value
	return temp_schema


func _save(data: Dictionary, path: String):
	file = FileAccess.open(path, file.WRITE)
	file.store_var(data.duplicate())
	file.close()


func _trim_data(type: String, list: Array):
	match type:
		"time": list.sort_custom(func(a, b): return a["time"] < b["time"])
		"score": list.sort_custom(func(a, b): return a["score"] > b["score"])
	if list.size() > 5: list.resize(5)


func load_scores():
	_load_helper(Times, TIMEPATH)
	_load_helper(Scores, SCOREPATH)
	
	return {"Times": Times, "Scores": Scores}


func _load_helper(list: Dictionary, path: String):
	if FileAccess.file_exists(path):
		file = FileAccess.open(path, FileAccess.READ)
		#print(file.get_var())
		var temp_data: Dictionary = file.get_var()
		file.close()
		
		for item in temp_data:
			list[item] = temp_data[item]
	else: return []


func clear_scores():
	Times.clear()
	_save({}, TIMEPATH)
	Scores.clear()
	_save({}, SCOREPATH)


func _format_time(total_seconds: float) -> String:
	# Calculate components
	var seconds: float = fmod(total_seconds, 60.0)
	var minutes: int = int(total_seconds / 60.0) % 60

	# Format with leading zeros: %02d (2-digit int), %05.2f (float, 5 total, 2 decimal)
	return "%02d:%05.2f" % [minutes, seconds]

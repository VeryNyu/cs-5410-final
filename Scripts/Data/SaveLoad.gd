extends Node

const TIMEPATH: String = "user://TimeSaveFile.json"
const SCOREPATH: String = "user://ScoreSaveFile.json"


var file: FileAccess
var Times: Array = []
var Scores: Array = []

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

func save_scores(tag: String, level: int, score: int, time: float):
	var time_string = _format_time(time)
	var time_data = _save_helper(TimeSaveSchema, tag, level, "time", time_string)
	Times.append(time_data)
	_trim_data("time", Times)
	_save(Times, TIMEPATH)
	
	var score_data = _save_helper(ScoreSaveSchema, tag, level, "score", score)
	Scores.append(score_data)
	_trim_data("score", Scores)
	_save(Scores, SCOREPATH)


func _save_helper(schema: Dictionary, tag: String, level: int, key: String, value):
	var temp_schema: Dictionary = schema.duplicate()
	
	temp_schema["tag"] = tag
	temp_schema["level"] = level
	temp_schema[key] = value
	return temp_schema


func _save(data: Array, path: String):
	file = FileAccess.open(path, file.WRITE)
	file.store_var(data.duplicate())
	file.close()


func _trim_data(type: String, list: Array):
	if list.size() > 1:
		match type:
			"time": list.sort_custom(func(a, b): return a["time"] < b["time"])
			"score": list.sort_custom(func(a, b): return a["score"] > b["score"])
	if list.size() > 5: list.resize(5)


func load_scores():
	var time_data = _load_helper(TIMEPATH)
	Times = time_data
	
	var score_data = _load_helper(SCOREPATH)
	Scores = score_data
	
	return {"Times": Times, "Scores": Scores}


func _load_helper(path: String):
	if FileAccess.file_exists(path):
		file = FileAccess.open(path, FileAccess.READ)
		var temp_data: Array = file.get_var()
		file.close()
		
		return temp_data.duplicate()
	else: return []


func clear_scores():
	Times.clear()
	_save([], TIMEPATH)
	Scores.clear()
	_save([], SCOREPATH)


func _format_time(total_seconds: float) -> String:
	# Calculate components
	var seconds: float = fmod(total_seconds, 60.0)
	var minutes: int = int(total_seconds / 60.0) % 60

	# Format with leading zeros: %02d (2-digit int), %05.2f (float, 5 total, 2 decimal)
	return "%02d:%05.2f" % [minutes, seconds]

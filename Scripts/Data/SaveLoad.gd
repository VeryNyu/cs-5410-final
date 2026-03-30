extends Node

const TIMEPATH: String = "user://TimeSaveFile.json"
const SCOREPATH: String = "user://ScoreSaveFile.json"


var file: FileAccess
var Times: Array = []
var Scores: Array = []

var TimeSaveSchema: Dictionary = {
	"tag": "TAG",
	"time": 0.0
}

var ScoreSaveSchema: Dictionary = {
	"tag": "TAG",
	"score": 0
}

func save_scores(tag: String, score: int, time: float):
	var time_data = _save_helper(TimeSaveSchema, tag, "time", time)
	Times.append(time_data)
	_save(Times, TIMEPATH)
	
	var score_data = _save_helper(TimeSaveSchema, tag, "score", score)
	Scores.append(score_data)
	_save(Scores, SCOREPATH)


func _save_helper(schema: Dictionary, tag: String, key: String, value):
	schema["tag"] = tag
	schema[key] = value
	return schema


func _save(data: Array, path: String):
	file = FileAccess.open(path, file.WRITE)
	file.store_var(data.duplicate())
	file.close()


func load_scores():
	var time_data = _load_helper(TIMEPATH)
	Times = time_data
	
	var score_data = _load_helper(SCOREPATH)
	Scores = score_data

func _load_helper(path: String):
	if FileAccess.file_exists(path):
		file = FileAccess.open(path, FileAccess.READ)
		var temp_data: Array = file.get_var()
		file.close()
		
		return temp_data.duplicate

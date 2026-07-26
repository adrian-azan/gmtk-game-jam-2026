extends Node

var mistakes: int
var dayCount: int = 1

func Check(output: String):
	if dayCount == 1:
		return Level1(output)
	elif dayCount == 2:
		return Level2(output)
	else:
		return Level1(output)
	
func _ready():
	CustomSignals.MistakeMade.connect(MistakeMade)

func MistakeMade():
	mistakes += 1

func Level1(output: String):		
	return [output, 0]

func Level2(output: String):
	var	currentMistakes = 0
	var formattedOutput: String = ""
	
	for i in range(output.length()):
		if i != 0 and (i+1) % 5 == 0 and output[i].to_lower() != 'a':
			currentMistakes += 1

	
	return [formattedOutput, currentMistakes]

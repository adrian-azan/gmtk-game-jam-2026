extends Node

var mistakes: int
var dayCount: int = 1

var patternCounter = 0

func Check(output: String):
	if dayCount == 0:
		return Level0(output)
	if dayCount == 1:
		return Level1(output)
	elif dayCount == 2:
		return Level2(output)
	elif dayCount == 3:
		return Level3(output)
	elif dayCount == 4:
		return Level4(output)
	else:
		return Level5(output)
	
func _ready():
	CustomSignals.MistakeMade.connect(MistakeMade)

func MistakeMade():
	mistakes += 1


func Level0(output: String):		
	return 0
	
func Level1(output: String):
	var pattern = "WASD"
	if output[patternCounter] != pattern[patternCounter % 4]:
		return 1
		
	patternCounter += 1
	return 0

func Level2(output: String):
	var pattern = "KLIDA"
	if output[patternCounter] != pattern[patternCounter % 5]:
		return 1
		
	patternCounter += 1
	return 0

func Level3(output: String):
	
	if output.length() % 5 == 0 and output[patternCounter].to_lower() != 'a':
		return 1
	elif output.length() % 6 == 0 and output[patternCounter].to_lower() != 'k':
		return 1

	patternCounter += 1
	return 0
	
func Level4(output: String):
	
	if output.length() % 4 == 0 and output[patternCounter].to_lower() != 'j':
		return 1
	elif output.length() % 7 == 0 and output[patternCounter].to_lower() != 's':
		return 1
		
	patternCounter += 1	
	return 0

func Level5(output: String):
	var pattern = "WIALSKDJ"
	if output[patternCounter] != pattern[patternCounter % 8]:
		return 1
		
	patternCounter += 1
	return 0

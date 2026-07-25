extends Node

var mistakes: int

func Level2(output: String):
	mistakes = 0
	var formattedOutput: String = ""
	
	for i in range(output.length()):
		print(output[i])
		if i != 0 and i % 4 == 0 and output[i].to_lower() != 'a':
			formattedOutput +=  "[color=red]%s[/color]" % [output[i]]
			mistakes += 1
		else:
			formattedOutput +=  output[i]

	print(mistakes)
	
	return [formattedOutput, mistakes]

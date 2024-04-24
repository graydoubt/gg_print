extends Node

## Loaded as "gg" autoload/singleton to provide debug printing
##
## Provides a "gg.print()" method, which accepts a string that will be logged to the
## Output panel via [method @GlobalScope.print_rich]
##
## @experimental
## @tutorial(variadic functions proposal): https://github.com/godotengine/godot-proposals/issues/1034


## Prints the [param text] string to the output panel and makes it clickable
func print(text: String) -> void:
	var stack: Array = get_stack()
	# stack[0] is us, the invocation the gg.print() is stack[1]
	print_rich("[url=%s]%s[/url]" % [JSON.stringify(stack[1]), text])

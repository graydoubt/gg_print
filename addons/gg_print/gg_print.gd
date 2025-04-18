class_name GGPrint extends Node

## Provide debug printing with link back to the source.
##
## This class provides a [method print] method. It accepts a string that will be logged to the
## output panel via [method @GlobalScope.print_rich].
## [br][br]
## [b]Note[/b]: This class shouldn't be called directly. It is loaded as the [code]gg[/code] autoload/singleton
## by the editor plugin.
## It should be called by calling [code]gg.print()[/code]. For example:
## [codeblock]
## gg.print("Click me")
## [/codeblock]
##
##
## @experimental


## Prints the [param text] string to the output panel and makes it clickable to easily
## find where it was printed from.
func print(text: String) -> void:
	
	## If the game isn't running via the editor, print nothing.
	if not OS.has_feature("editor"):
		return
	
	var stack: Array[Dictionary] = get_stack()
	# stack[0] is us, the invocation of gg.print() is stack[1]
	
	print_rich("[[url=%s]%s:%d[/url]]: %s" % [
		JSON.stringify(stack[1]),
		String(stack[1]["source"]).get_file(),
		stack[1]["line"],
		text
	])

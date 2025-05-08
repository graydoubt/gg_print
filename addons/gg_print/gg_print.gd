class_name GGPrint extends Node

## Provide debug printing with a link back to the source.
## @experimental
##
## This class provides a [method print] method. It accepts a string that will be logged to the
## output panel via [method @GlobalScope.print_rich].
## [br][br]
## [b]Note[/b]: This class shouldn't be called directly. It is loaded as the [code]gg[/code] autoload/singleton
## by the editor plugin.
## It should be called using the [code]gg.print()[/code] convention. For example:
## [codeblock]
## gg.print("Click me")
## [/codeblock]
##
## If you use want to use it from within your own reusable component, and link back to its
## caller, increase the [param stack_depth] to [code]2[/code] when calling [method print].


## Prints the [param text] string to the output panel and makes it clickable to easily
## find where it was printed from.
func print(text: Variant, stack_depth: int = 1) -> void:
	## If the game isn't running via the editor, print nothing.
	if not OS.has_feature("editor"):
		return

	text = str(text)

	var stack: Array[Dictionary] = get_stack()
	# stack[0] is us, the invocation of gg.print() is stack[1]

	if stack.size() <= stack_depth:
		push_error("Invalid stack_depth.")
		return

	print_rich("[[url=%s]%s:%d[/url]]: %s" % [
		JSON.stringify(stack[stack_depth]),
		String(stack[stack_depth]["source"]).get_file(),
		stack[stack_depth]["line"],
		text
	])

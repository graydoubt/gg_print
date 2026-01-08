class_name GGPrint extends Node

## Prints text in the editor's output panel with a clickable link back to the source script.
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


## A drop-in replacement for the regular [method @GlobalScope.print] statement.
## Prints the [param params] to the output panel and makes it clickable to easily
## find where it was printed from.
func print(...params: Array) -> void:
	print_depth(", ".join(params), 2)


## Prints the [param text].
## If [param stack_depth] is provided, it'll link back to the respective source
## (see [method @GDScript.get_stack]).
## [br][br]
## [b]Note:[/b] This method is intended for custom components that need to
## specify the [param stack_depth].
func print_depth(text: Variant = "", stack_depth: int = 1) -> void:
	## If the game isn't running via the editor, print nothing.
	if not OS.has_feature("editor"):
		return

	text = str(text)

	var stack: Array[Dictionary] = get_stack()
	# stack[0] is where get_stack() was called from, right here.
	# stack[1] is where print_depth() was called from.
	# stack[2] is where print() was called from (if print() was called).
	if stack.size() <= stack_depth:
		push_error("Invalid stack_depth.")
		return

	var link_data: Dictionary = stack[stack_depth].duplicate()
	link_data.erase("function")

	print_rich("[[url=%s]%s:%d[/url]]: %s" % [
		JSON.stringify(link_data),
		String(link_data["source"]).get_file(),
		link_data["line"],
		text
	])

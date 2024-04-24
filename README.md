## gg.print() - an experimental logger with links to the source

This little project was inspired by [this reddit post](https://www.reddit.com/r/godot/comments/1cc0zh3/easier_way_to_find_what_script_is_printing_a_msg/) asking if print messages can link back to the source script in the editor.

Since the Godot editor is powered by the Godot Engine, it's possible with an [EditorPlugin](https://docs.godotengine.org/en/stable/tutorials/plugins/editor/making_plugins.html).

The plugin does two things:

1. Provide a "gg" [singleton/autoload](https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html) with a `print()` method that uses [`print_rich()`](https://docs.godotengine.org/en/stable/classes/class_@globalscope.html#class-globalscope-method-print-rich) to print messages with link that contain the stack trace (via [`get_stack()`](https://docs.godotengine.org/en/stable/classes/class_@gdscript.html#class-gdscript-method-get-stack)).
2. Attach a "meta_clicked" signal handler to the EditorLog (the output panel), so that clicks on the link can be opened in the editor.

With that, it's possible to call:

```gdscript
gg.print("Clicking me links back to the source file.")
```

## Demo

Run the `main.tscn` scene and click the buttons to see print messages in the output.
Clicking the messages will take you to the script source where they were called.

## Limitations

- Since this is an editor plugin, it won't run for exported games, which means the `gg` autoload won't be available, which means errors.
  You'd have to either remove all the `gg.print()` calls, search and replace them all with a regular `print()` statement, or autoload a dummy script, so `gg.print()` is available.

- `gg.print()` also only accepts a string, [variadic functions are still in the proposal stage](https://github.com/godotengine/godot-proposals/issues/1034).

This is only a proof of concept.

## Notes

[`EditorInterface`](https://docs.godotengine.org/en/stable/classes/class_editorinterface.html) helps when creating editor plugins, but I was surprised that there's no clean, good way to get access to any of the existing panels.
You have to traverse the tree yourself, which feels a bit brittle.
The [EditorLog](https://github.com/godotengine/godot/blob/4.2.2-stable/editor/editor_log.cpp#L384) defines the node structure in the source.
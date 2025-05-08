extends Button

## Button 3

var stopwatch: MyStopWatch


func _ready() -> void:
	stopwatch = MyStopWatch.create(false)
	pressed.connect(_on_button3_pressed)
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)


func _on_button3_pressed() -> void:
	gg.print("I'm hiding here!")


func _on_button_down() -> void:
	stopwatch.start()


func _on_button_up() -> void:
	# The MyStopWatch::stop() function calls gg.print() with stack_depth 2, so it'll print where
	# stop() was invoked from.
	stopwatch.stop("for the button press")

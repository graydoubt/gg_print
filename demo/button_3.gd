extends Button

## Button 3

var stopwatch := MyStopWatch.create(false)


func _ready() -> void:
	pressed.connect(_on_button3_pressed)
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)


func _on_button3_pressed() -> void:
	gg.print("I'm hiding here!")


func _on_button_down() -> void:
	stopwatch.start()


func _on_button_up() -> void:
	stopwatch.stop("for the button press")

class_name MyStopWatch extends RefCounted

## A simple stop watch to help measure performance.

## When the timer was started.
## This is simply the ticks in milliseconds, as provided by [method Time.get_ticks_msec].
var start_time: int


## Creates a stopwatch and starts it automatically, unless [param start] is
## set to [code]false[/code].
static func create(start: bool = true) -> MyStopWatch:
	var instance := MyStopWatch.new()
	if start:
		instance.start()
	return instance


## Starts (or restarts) the stop watch.
func start() -> void:
	start_time = Time.get_ticks_msec()


## Prints how much time has passed along with the [param message].
## Resets the timer if [param reset] is set to [code]true[/code].
func time(message: String, reset: bool = false) -> void:
	var stop_time = Time.get_ticks_msec()
	var duration = stop_time - start_time
	if reset:
		start_time = stop_time
	gg.print("(%d msec) %s" % [duration, message], 2)


## Stops the timer and prints how much time has passed along with the [param message].
func stop(message: String) -> void:
	var stop_time = Time.get_ticks_msec()
	var duration = stop_time - start_time
	start_time = stop_time
	gg.print("(%d msec) %s" % [duration, message], 2)

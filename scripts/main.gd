extends Node2D

func seconds():
	return float(Time.get_ticks_msec()) / 1000.0


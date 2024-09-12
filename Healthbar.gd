extends TextureProgressBar

func update(min_val,val,max_val):
	max_value = max_val
	min_value = min_val
	value = val
	if value == max_value:
		visible = false
	else:
		visible = true

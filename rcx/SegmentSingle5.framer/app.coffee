# Import file "Chart5"
sketch = Framer.Importer.load("imported/Chart5@1x")

#Hovering on right side
dropdown = sketch.GoalsDropdown
dropdownBoundaries = sketch.DropdownBoundaries
dropdown.opacity = 0
dropdownBoundaries.onMouseOver ->
	# Finding index
	dropdown.animate
		properties:
			opacity: 1
		duration: 0.5
		curve: "spring"
#dropdown.onMouseOut ->
#	dropdown.animate
#		properties:
#			opacity: 0
#	duration: 0.5
	
#Activating
hoverObjects = [sketch.New, sketch.Open, sketch.Won, sketch.Lost, sketch.None]
hover = [sketch.NewHover, sketch.OpenHover, sketch.WonHover, sketch.LostHover, sketch.Original]
for layer,index in hoverObjects
	hover[index].opacity = 0
	layer.hover = hover[index]
	layer.onClick ->
		# Finding index
		dropdown.animate
			properties:
				opacity: 0
			duration: 0.5
		for layer in hover	
			layer.animate
				properties:
					opacity: 0
				duration: 0.2
		this.hover.animate
			properties:
				opacity: 1
			duration: 0.4
			curve: "spring"

sketch.Original.opacity = 1
	

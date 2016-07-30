# Use desktop cursor
document.body.style.cursor = "auto"

# Import file "Chart4"
sketch = Framer.Importer.load("imported/Chart4@1x")
hoverObjects = [sketch.New, sketch.Open, sketch.Won, sketch.Lost]
hover = [sketch.NewHover, sketch.OpenHover, sketch.WonHover, sketch.LostHover]

#Interaction
for layer,index in hoverObjects
	hover[index].opacity = 0
	layer.hover = hover[index]
	layer.onMouseOver ->
		# Finding index
		this.hover.animate
			properties:
				opacity: 1
			duration: 1
			curve: "spring"
		document.body.style.cursor = "pointer"

	layer.onMouseOut ->
		this.hover.animate
			properties:
				opacity: 0
			duration: 0.2
		document.body.style.cursor = "auto"
		
		
				
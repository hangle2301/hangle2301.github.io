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
			duration: 0.5
			curve: "spring"
	layer.onMouseOut ->
		this.hover.animate
			properties:
				opacity: 0
			duration: 0.2
		
		
				
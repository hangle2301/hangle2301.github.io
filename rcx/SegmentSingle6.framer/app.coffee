# Import file "Chart6"
sketch = Framer.Importer.load("imported/Chart6@1x")

hoverObjects = [sketch.Select1Area, sketch.Select2Area, sketch.Select3Area]
hover = [sketch.Select1, sketch.Select2, sketch.None]

#Interaction
for layer,index in hoverObjects
	hover[index].opacity = 0
	layer.hover = hover[index]
	layer.onClick ->
		# Finding index
		for otherHover in hover
			otherHover.animate
				properties:
					opacity: 0
				duration: 0.1
		this.hover.animate
			properties:
				opacity: 1
			duration: 0.5
			curve: "spring"
sketch.None.opacity = 1				
		
				
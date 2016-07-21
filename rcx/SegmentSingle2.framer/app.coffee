# Import file "Chart"
sketch = Framer.Importer.load("imported/Chart2@1x")

#Dropdown
overlay = sketch.Overlay
overlay.opacity = 0
dropdown = sketch.Dropdown
dropdown.onClick ->
	if(overlay.opacity == 1)
		overlay.animate
			properties: 
				opacity: 0
			time: 0.5
			curve: "spring"
		sketch.None.opacity = 1
	else
		sketch.Overlay.animate
			properties: 
				opacity: 1
			time: 0.5
			curve: "spring"
		sketch.None.opacity = 0

nowlChart = new Array(sketch.New, sketch.Open, sketch.Won, sketch.Loss)
tooltips = new Array(sketch.Tooltip1, sketch.Tooltip2, sketch.Tooltip3, sketch.Tooltip4)
for tooltip in tooltips
	tooltip.opacity = 0

for chart in nowlChart
	chart.onMouseOver ->
		if(sketch.None.opacity == 0)
			tooltips[nowlChart.indexOf(this)].animate
				properties: 
					opacity: 1
				time: 0.5
				curve: "spring"
	chart.onMouseOut ->
			tooltips[nowlChart.indexOf(this)].animate
				properties: 
					opacity: 0
				time: 0.5
				curve: "spring"


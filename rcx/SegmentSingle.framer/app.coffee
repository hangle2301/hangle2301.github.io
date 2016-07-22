# Import file "Chart"
sketch = Framer.Importer.load("imported/Chart@1x")
#Interaction
nowlChart = new Array(sketch.New, sketch.Open, sketch.Won, sketch.Lost)


#Switching between overlaying New and Won
switchOverlay = sketch.DropdownNew

sketch.Dropdown.onClick ->
	if(switchOverlay.opacity == 1)
		switchOverlay.opacity = 0
		sketch.DonutNew.animate
			properties: 
				opacity: 0
			duration: 1
			curve: "spring"
		sketch.DonutWon.animate
			properties: 
				opacity: 1
			duration: 1
			curve: "spring"
			delay: 0.5
	else
		switchOverlay.opacity = 1
		sketch.DonutNew.animate
			properties: 
				opacity: 1
			duration: 1
			curve: "spring"
			delay: 0.5
		sketch.DonutWon.animate
			properties: 
				opacity: 0
			duration: 1
			curve: "spring"
		
# Intro animation
baseDonut = sketch.DonutNewBottom
donutTop1 = sketch.DonutNewTop1
donutTop2 = sketch.DonutNewTop2 
donutTop1.originX = 0
donutTop1.originY = 0.6
donutTop1.opacity = 0
donutTop1.rotation -= 45

donutTop2.originX = 0.52
donutTop2.originY = -0.85
donutTop2.opacity = 0
donutTop2.rotation -= 45
sketch.DonutWon.opacity = 0
associatedNew = new Array(donutTop1, donutTop2)

doIntroAnimation = () ->
	for layer in nowlChart
		layer.scaleY = 0
		layer.animate
			properties:
				scaleY: 1
			duration: 0.75
			curve: "spring"
			delay: nowlChart.indexOf(layer)*0.2
	for donutPiece in associatedNew
		donutPiece.animate
			properties:
	        	rotation: donutTop1.rotation + 45
	        	opacity: 1
	    	duration: 0.75
	    	curve: "spring"
	    	delay: associatedNew.indexOf(donutPiece) * 0.15 + 1.2;
	sketch.SideChart.opacity = 0
	sketch.SideChart.animate
		properties: 
			opacity: 1
		duration: 0.75
		delay: 0.8

window.onload = doIntroAnimation()

#Clicking
layerClick = -1;
for layer in nowlChart
	layer.onClick ->
		# Only moving chart when it's open
		if(switchOverlay.opacity == 0)
		    #Dimming other parts
		    for layer2 in nowlChart
		    	layer2.opacity = 0.5
			this.opacity = 1
 

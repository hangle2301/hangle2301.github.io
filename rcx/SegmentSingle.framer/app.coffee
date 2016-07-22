# Import file "Chart"
sketch = Framer.Importer.load("imported/Chart@1x")
#Setting up
baseDonut = sketch.DonutNewBottom
donutTop1 = sketch.DonutNewTop1
donutTop2 = sketch.DonutNewTop2 
nowlChart = new Array(sketch.New, sketch.Open, sketch.Won, sketch.Lost)
associatedNew = new Array(donutTop1, donutTop2)
donutTop1.originX = 0
donutTop1.originY = 0.6
donutTop1.opacity = 0
donutTop1.rotation -= 45

donutTop2.originX = 0.52
donutTop2.originY = -0.85
donutTop2.opacity = 0
donutTop2.rotation -= 45
sketch.DonutWon.opacity = 0

#Switching between overlaying New and Won
switchOverlay = sketch.DropdownNew
dimOpacity = 0.3

sketch.Dropdown.onClick ->
	if(switchOverlay.opacity == 1)
		switchOverlay.opacity = 0
		sketch.DonutNew.animate
			properties: 
				opacity: 0
			duration: 0.5
			curve: "spring"
		sketch.DonutWon.animate
			properties: 
				opacity: 1
			duration: 1
			curve: "spring"
		doAnimation(0)
	else
		switchOverlay.opacity = 1
		sketch.DonutNew.opacity = 1		
		sketch.DonutWon.animate
			properties: 
				opacity: 0
			duration: 0.5
			curve: "spring"
		for donutPiece in associatedNew
			donutPiece.rotation -= 45
			donutPiece.opacity = 0
			donutPiece.animate
				properties:
		        	rotation: donutPiece.rotation + 45
		        	opacity: 1
		    	duration: 0.75
		    	curve: "spring"
		    	delay: associatedNew.indexOf(donutPiece) * 0.15;
		#Reset what was clicked
		for layer in nowlChart
			layer.animate
				properties:
					opacity: 1
				duration: 0.5
				
		
# Intro animation
doIntroAnimation = () ->
	for layer in nowlChart
		layer.scaleY = 0
		layer.originY = 1
		layer.animate
			properties:
				scaleY: 1
			duration: 0.75
			curve: "spring"
			delay: nowlChart.indexOf(layer)*0.2 + 1
	for donutPiece in associatedNew
		donutPiece.animate
			properties:
	        	rotation: donutPiece.rotation + 45
	        	opacity: 1
	    	duration: 0.75
	    	curve: "spring"
	    	delay: associatedNew.indexOf(donutPiece) * 0.15 + 2.2;
	sketch.SideChart.opacity = 0
	sketch.SideChart.animate
		properties: 
			opacity: 1
		duration: 0.75
		delay: 0.8 + 1
#Intro animation on load of window
window.onload = doIntroAnimation()

#Setup donuts on Won
donutWons = new Array(sketch.WonNew, sketch.WonOpen, sketch.WonWon, sketch.WonLoss)
donutWonsTops = new Array(sketch.WonNewTop, sketch.WonOpenTop, sketch.WonWonTop, sketch.WonLossTop)
donutWonsBottoms = new Array(sketch.WonNewBottom, sketch.WonOpenBottom, sketch.WonWonBottom, sketch.WonLossBottom)
for donut in donutWonsTops
	donut.originalRotation = donut.rotation
	donut.rotation -= 45
	donut.originX = 0.5
	donut.originY = 0.5
	donut.opacity = 0
for donut in donutWons
	donut.opacity = 0


#Clicking
layerClick = -1;
for layer in nowlChart
	layer.onClick ->
		# Only moving chart when it's open
		if(switchOverlay.opacity == 0)
			index = nowlChart.indexOf(this)
			doAnimation(index)
			layerClick = this

doAnimation = (index) ->
	#Dimming other parts
	for layer2 in nowlChart
		layer2.animate
			properties:
				opacity: dimOpacity
			duration: 0.5
	nowlChart[index].animate
		properties:
			opacity: 1
		duration: 0.5
	#Animation out other donuts
	for donut in donutWons	
		donut.animate
			properties:
				opacity: 0
			duration: 0.5
	for donut in donutWonsTops
		donut.rotation = donut.originalRotation - 45
		donut.opacity = 0
	#Animation in the donut	
	donutWons[index].animate
		properties:
			opacity: 1	
		duration: 0.5
	donutWonsTops[index].animate
		properties:
			rotation: donut.originalRotation
			opacity: 1
		duration: 0.75
		

 

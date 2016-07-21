# Import file "Chart"
sketch = Framer.Importer.load("imported/Chart@1x")

#Animation
baseDonut = sketch.Donut_Bottom
donutTop1 = sketch.Donut_Top1
donutTop2 = sketch.Donut_Top2 
donutTop1.originX = 0
donutTop1.originY = 0.6
donutTop1.opacity = 0
donutTop1.rotation -= 45

donutTop2.originX = 0.52
donutTop2.originY = -0.85
donutTop2.opacity = 0
donutTop2.rotation -= 45


#Interaction
nowlChart = new Array(sketch.New, sketch.Open, sketch.Won, sketch.Lost)
associatedNew = new Array(donutTop1, donutTop2)

#Clicking
layerClick = -1;
for layer in nowlChart
	layer.onClick ->
		layerClick = this
		doAnimation(this)

doAnimation = (layerClicked) ->
	for donutPiece in associatedNew
		donutPiece.animate
			properties:
	        	rotation: donutTop1.rotation + 45
	        	opacity: 1
	    	duration: 0.75
	    	curve: "spring"
	    	delay: associatedNew.indexOf(donutPiece) * 0.15
    #Dimming other parts
    for layer2 in nowlChart
    	layer2.opacity = 0.5
	layerClicked.opacity = 1
 

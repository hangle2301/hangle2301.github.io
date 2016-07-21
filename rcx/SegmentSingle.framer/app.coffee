# Import file "Chart"
sketch = Framer.Importer.load("imported/Chart@1x")

#Animation
baseDonut = sketch.Donut_Bottom
donutTop1 = sketch.Donut_Top1
donutTop1.originX = 0
donutTop1.originY = 0.6
donutTop1.opacity = 0
donutTop1.rotation -= 45

#Interaction
nowlChart = new Array(sketch.New, sketch.Open, sketch.Won, sketch.Lost);

layerClick = -1;

for layer in nowlChart
	layer.onClick ->
		layerClick = this
		doAnimation(this)

	
doAnimation = (layerClicked) ->
	appearAnimation = new Animation
		layer: donutTop1
		properties:
        	rotation: donutTop1.rotation + 45
        	opacity: 1
    	duration: 0.75
    	curve: "spring"
    #Dimming other parts
    for layer2 in nowlChart
    	layer2.opacity = 0.5
	layerClicked.opacity = 1
	appearAnimation.start()
 

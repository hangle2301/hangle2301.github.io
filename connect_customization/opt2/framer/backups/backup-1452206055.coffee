# Import file "0107-Prototype-Option3"
sketch = Framer.Importer.load("imported/0107-Prototype-Option3@1x")

# Array-ing layers
labelLayers = sketch.LeftPanelList.subLayers
dimOpacity = 0.4
fullOpacity = 1

# Managing available labels
maxLeft = 10
currentLeft = 9
sketch.QuickFactsTitle.style = 
	"color" : "#333"
	"font-size" : "15px"
displayTitleLeft = () ->
	sketch.QuickFactsTitle.html = "Quick Facts " + currentLeft + "/" + maxLeft
	
displayTitleLeft()

for layer, index in labelLayers
	layer.on Events.Click, (event, layerClicked)->
		if layerClicked.opacity == dimOpacity
			#Turning on this layer
			if currentLeft < maxLeft
				layerClicked.animate
					properties:
						opacity: fullOpacity
					time: 0.3
					curve: "ease-in-out"
				currentLeft = currentLeft + 1
				displayTitleLeft()
		else
			#Turning off this layer
			if currentLeft > 1
				layerClicked.animate
					properties:
						opacity: dimOpacity
					time: 0.3
					curve: "ease-in-out"
				currentLeft = currentLeft - 1
				displayTitleLeft()

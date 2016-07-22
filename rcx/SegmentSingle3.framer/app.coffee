# Import file "Chart3"
sketch = Framer.Importer.load("imported/Chart3@1x")

# Prep for intro
newArray = new Array(sketch.New1, sketch.New2, [sketch.NewText.children[1].children[0],sketch.NewText.children[1].children[1]], sketch.NewText.children[0])
openArray = new Array(sketch.Open1, sketch.Open2, [sketch.OpenText.children[1].children[0],sketch.OpenText.children[1].children[1]], sketch.OpenText.children[0])
wonArray = new Array(sketch.Won1, sketch.Won2, [sketch.WonText.children[1].children[0],sketch.WonText.children[1].children[1]], sketch.WonText.children[0])
lossArray = new Array(sketch.Loss1, sketch.Loss2, [sketch.LossText.children[1].children[0],sketch.LossText.children[1].children[1]], sketch.LossText.children[0])
globalArray = new Array(newArray, openArray, wonArray, lossArray)

for object in globalArray
	for subObject, index in object
		if(index < 2)
			subObject.scaleY = 0
			subObject.originY = 0.75
		else if (index == 2)
			for circle in subObject
				circle.opacity = 0
		else
			subObject.opacity = 0


#Intro Animation
doAnimationPiece = (animationPiece, delay) ->
	console.log(animationPiece)
	for animateObject, index in animationPiece
		if(index < 2)
			animateObject.animate
				properties:
					scaleY: 1
				duration: 0.5
				curve: "spring"	
				delay: index * 0.15 + delay
		else if (index == 2)
			#Animate the overlays
			for circle, indexCircle in animateObject
				circle.animate
					properties:
						opacity: 1
					duration: 0.5
					delay: index * 0.4 + delay
				if (indexCircle < 1)
					circle.animate
						properties:
							y: circle.y - 5
						duration: 0.3
						curve: "ease"
						delay: index * 0.4 + 0.2 + delay
				else
					circle.animate
						properties:
							y: circle.y + 5
						duration: 0.3
						curve: "ease"
						delay: index * 0.4 + 0.2 + delay
		else 
			#Doing text
			animateObject.animate
				properties:
					opacity: 1
				duration: 0.5
				delay: index * 0.45 + delay

doIntroAnimation = () ->
	sketch.ChartPreload.opacity = 0
	for animationPiece, index in globalArray
		delay = index * 1.5
		doAnimationPiece(animationPiece, delay)
#OnLoad
window.onload = doIntroAnimation()

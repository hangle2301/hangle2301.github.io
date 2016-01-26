# Import file "Connect Preloader"
sketch = Framer.Importer.load("imported/Connect Preloader@1x")
# --- Blinking --- #
option2 = sketch.Page1
option2.opacity = 0
animationC = new Animation
	layer: option2
	properties: 
		opacity: 0.2
	time:1.5
animationD = new Animation
	layer: option2
	properties: 
		opacity: 0.8
	time:1.5
animationC.on Events.AnimationEnd, ->
	animationD.start()
animationD.on Events.AnimationEnd, ->
	animationC.start()	
animationD.start()		

# --- Rotation --- #
option3 = sketch.OuterLayer
animationA = new Animation
	layer: option3
	properties: 
		rotation: 360
	time: 5
	curve: "linear"
animationA.on Events.AnimationEnd, ->
	option3.rotation = 0
	animationA.start()
	
animationA.start()		

# --- First inner circle --- #
option4 = sketch.innercircles
option4sub = option4.subLayers
option4.scale = 0
animationBA = new Animation
	layer: option4
	properties: 
		scale: 1
	time:0.5
	curve: "spring(140,15,0)"
animationB = new Animation
	layer: option4
	properties: 
		rotation: 360
	time: 4
	curve: "linear"
animationB.on Events.AnimationEnd, ->
	option4.rotation = 0
	animationB.start()
animationBA.on Events.AnimationEnd, ->
	animationB.start()
animationBA.start()	

# --- Second inner circles --- #
option5 = sketch.innercircles2.subLayers
middleX = sketch.Letter.x - sketch.innercircles.x + sketch.Letter.width/2
middleY = sketch.Letter.y - sketch.innercircles.y + sketch.Letter.height/2 - 2
animations5 = []
for layer, index in option5
	layer.originalY = layer.y
	layer.originalX = layer.x
	layer.x = middleX
	layer.y = middleY
	thisAnimation = new Animation
		layer: layer
		properties: 
			x: layer.originalX
			y: layer.originalY
		time:0.5
		curve: "spring(140,15,0)"	
		delay: index * 0.15	
	animations5.push(thisAnimation)
	thisAnimation.start()
	if (index == option5.length - 1)
		layer.on Events.AnimationEnd, ->
			for layer2, index2 in option5
				reverseAnimation = animations5[index2].reverse()
				reverseAnimation.start()
				animations5[index2] = reverseAnimation
	
# --- Right "R" --- #		
option6R1 = sketch.R1
option6R2 = sketch.R2
option6Oval = sketch.Oval

animationG1 = new Animation
	layer: option6Oval
	properties: 
		opacity: 0
	time: 2.5
animationG2 = new Animation
	layer: option6R1
	properties: 
		opacity: 0
	time: 2.5
animationG3 = animationG2.reverse()
animationG4 = animationG1.reverse()

animationG1.start()
animationG2.start()
animationG2.on Events.AnimationEnd, ->
	animationG3.start()
	animationG4.start()
animationG3.on Events.AnimationEnd, ->
	animationG2.start()
	animationG1.start()

# --- Jump Rope --- #
option7 = sketch.line
option7.originX = 0.5
option7.originY = 0
option7.rotationX = -90
option7L = sketch.Letter7
option7L.originalY = option7L.y
animationF = new Animation
	layer: option7
	properties: 
		rotationX: 180
	time: 0.5
animationF2 =  new Animation
	layer: option7
	properties: 
		rotationX: 0
	time: 0.5
animationF3 = new Animation
	layer: option7L
	properties: 
		y: option7L.originalY - 10
	time: 0.3
	delay: 0.2
	curve: "easeinout"
animationF4 = new Animation
	layer: option7L
	properties: 
		y: option7L.originalY
	time: 0.3
animationF.on Events.AnimationEnd, ->
	animationF2.start()
	animationF3.start()
animationF2.on Events.AnimationEnd, ->
	animationF.start()
	animationF4.start()
animationF.start()

	
		
	
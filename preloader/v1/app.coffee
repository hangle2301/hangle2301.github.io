# Import file "Connect Preloader"
sketch = Framer.Importer.load("imported/Connect Preloader@1x")
# --- Blinking --- #
option2 = sketch.Page1
option2.opacity = 0
animationC = new Animation
	layer: option2
	properties: 
		opacity: 0
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

# --- Rotation --- #
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
#animationB.start()		
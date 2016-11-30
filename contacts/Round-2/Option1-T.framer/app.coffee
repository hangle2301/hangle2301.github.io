# Import file "Contacts-Prototype-R2-O1-T"
sketch = Framer.Importer.load("imported/Contacts-Prototype-R2-O1-T@1x")

# CURSOR CHANGE & SCROLLING
document.body.style.cursor = "auto"
Framer.Extras.Hints.disable()
Framer.Extras.Preloader.setLogo("https://radiusintel-wpengine.netdna-ssl.com/wp-content/themes/vate/src/serve/assets/images/common/radius-logo.svg")

#Make interactive
makeInteractive = (object) ->
	object.onMouseOver ->
		document.body.style.cursor = "pointer"
	object.onMouseOut ->
		document.body.style.cursor = "auto"

# Make scroll
# Include a Layer 
scroll = ScrollComponent.wrap(sketch.everything)
scroll.width = Screen.width
scroll.height = Screen.height
scroll.mouseWheelEnabled = true
sketch.everything.draggable.enabled = false
# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Hang Le"
	twitter: ""
	description: ""


#Setting up Funnels
funnelStages = [sketch.New, sketch.Open, sketch.Won, sketch.Lost]
# Close all by default except New
for stage, index in funnelStages
	if (index == 0)
		# Opening New by default
		stage.children[0].opacity = 1
		stage.children[1].opacity = 0
	else
		# Collapse other stages by Defaults
		stage.children[0].opacity = 0
		stage.children[1].opacity = 1
# Function to position all stages correctly
verticalGutter = 30
rePosition = ()->
	currentPos = funnelStages[0].y
	for stage, index in funnelStages[0..2]
		if(stage.children[0].opacity)
			# If this stage is closed	
			funnelStages[index+1].y = currentPos + stage.children[0].height + verticalGutter
			currentPos = funnelStages[index+1].y
		else
			# If this stage is open	
			funnelStages[index+1].y = currentPos + stage.children[1].height + verticalGutter
			currentPos = funnelStages[index+1].y
			
rePosition()

	
# Accordion Clicking interaction
for stage, index in funnelStages
	makeInteractive(stage)
	stage.children[1].onClick ->
		if (this.parent.children[1].opacity == 1)
			this.parent.children[1].opacity = 0
			this.parent.children[0].opacity = 1
		else
			this.parent.children[1].opacity = 1
			this.parent.children[0].opacity = 0
		rePosition()

# Next bt click
makeInteractive(sketch.nextBt)
sketch.nextBt.onClick ->
	window.location.href = 'https://hangle2301.github.io/contacts/Round-2/Option2-T.framer/index.html'		



		







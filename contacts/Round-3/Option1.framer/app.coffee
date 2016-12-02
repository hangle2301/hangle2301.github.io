# Import file "Contacts-Prototype-R3-O1"
sketch = Framer.Importer.load("imported/Contacts-Prototype-R3-O1@1x")
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


#Company by default
switcher = sketch.switcher

# Clicking 
clickLocation = sketch.locations
clickCompany = sketch.accounts
clickContact = sketch.contacts
#Associating
clickCompany.panel = sketch.accountPanel
clickLocation.panel = sketch.locationPanel
clickContact.panel = sketch.contactPanel
# Charts
clickCompany.panel.charts = [sketch.new, sketch.open, sketch.won, sketch.loss]
clickLocation.panel.charts = [sketch.new1, sketch.open1, sketch.won1, sketch.loss1]
clickContact.panel.charts = [sketch.new2, sketch.open2, sketch.won2, sketch.loss2]

makeInteractive(clickLocation)
makeInteractive(clickCompany)
makeInteractive(clickContact)

#Hovering
titles = [clickCompany, clickLocation, clickContact]
current = 0

for titleBlock in titles
	titleBlock.children[1].originY = 1
	titleBlock.panel.opacity = 0
	
	for chart in titleBlock.panel.charts
		chart.originX = 0
		chart.originalWidth = chart.width
	
	titleBlock.onMouseOver ->
		if(this.panel.opacity == 0)
			this.children[1].animate
				properties:
					scaleY: 30
				time: 0.5
	titleBlock.onMouseOut ->
		if(this.panel.opacity == 0)
			this.children[1].animate
				properties:
					scaleY: 1
				time: 0.5
	titleBlock.onClick ->		
		this.children[1].animateStop()
		# Chart animation
		for chartLine,chartIndex in titles[current].panel.charts
			console.log("Current scale " + chartLine.scaleX)
			chartLine.animate
				properties:
					scaleX: this.panel.charts[chartIndex].width / chartLine.width
				time: 0.3
			chartLine.animate
				properties:
					scaleX: 1
				time: 0.1
				delay: 0.5
		# Title animation
		current = titles.indexOf(this)
		for titleBlock2, indexBlock in titles
			titleBlock2.children[1].opacity = 0.1
			if(indexBlock != current)
				titleBlock2.panel.animate
					properties:
						opacity: 0
					time: 0.5
		this.panel.animate
			properties:
				opacity:1
			time: 0.5
		this.children[1].animate
			properties:
				scaleY: 1
				opacity: 1
			time: 0.5		
		
		
			
#Defaulting on Accounts
clickLocation.children[1].opacity = 0.1
clickContact.children[1].opacity = 0.1
clickCompany.panel.opacity = 1	


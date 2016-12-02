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

makeInteractive(clickLocation)
makeInteractive(clickCompany)
makeInteractive(clickContact)

#Hovering
titles = [clickCompany, clickLocation, clickContact]
for titleBlock in titles
	titleBlock.children[1].originY = 1
	titleBlock.panel.opacity = 0
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
		for titleBlock2 in titles
			titleBlock2.children[1].opacity = 0.1
			titleBlock2.panel.opacity = 0
		this.children[1].animate
				properties:
					scaleY: 1
					opacity: 1
				time: 0.5		
		this.panel.opacity = 1
			
#Defaulting on Accounts
clickLocation.children[1].opacity = 0.1
clickContact.children[1].opacity = 0.1
clickCompany.panel.opacity = 1	


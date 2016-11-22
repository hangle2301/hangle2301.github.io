# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Hang Le"
	twitter: ""
	description: ""


# Import file "Contacts-Prototype-R2-Opt1"
sketch = Framer.Importer.load("imported/Contacts-Prototype-R2-Opt1@1x")


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

# Center all
pageContent = sketch.everything
pageContent.x = Align.center()
bars = [sketch.New, sketch.Open, sketch.Won, sketch.Lost]
hovers = [sketch.NewHover, sketch.OpenHover, sketch.WonHover, sketch.LostHover]
sketch.New.hover = sketch.NewHover
sketch.Open.hover = sketch.OpenHover
sketch.Won.hover = sketch.WonHover
sketch.Lost.hover = sketch.LostHover
for hover in hovers
	hover.opacity = 0
for bar in bars
	makeInteractive(bar)
	bar.onMouseOver ->
		this.hover.opacity = 1
	bar.onMouseOut ->
		this.hover.opacity = 0
		
		

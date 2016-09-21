# Disable hints
Framer.Extras.Hints.disable()
Framer.Extras.Preloader.setLogo("https://radiusintel-wpengine.netdna-ssl.com/wp-content/themes/vate/src/serve/assets/images/common/radius-logo.svg")


# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: "Segment Builder"
	author: "Hang Le"
	twitter: ""
	description: ""
sketch = Framer.Importer.load("imported/builder-prototype-2@2x")
# Use desktop cursor
document.body.style.cursor = "auto"

#Make interactive
makeInteractive = (object) ->
	object.onMouseOver ->
		document.body.style.cursor = "pointer"
	object.onMouseOut ->
		document.body.style.cursor = "auto"

# Make scroll
# Include a Layer 
scroll = ScrollComponent.wrap(sketch.Builder_Open)
scroll.width = Screen.width
scroll.height = Screen.height
scroll.mouseWheelEnabled = true
scroll.scrollHorizontal = false
sketch.Builder_Open.draggable.enabled = false

#Setting background color
topMenu = sketch.Builder_Open
topMenu.html="<div id='top-bg'></div><div id='bottom-line'></div>"

topBackground = topMenu.querySelectorAll("#top-bg")[0]
topBackground.style["background-color"] = "#2b84c6"
topBackground.style["width"] = "100%"
topBackground.style["height"] = "60px"

topLine = topMenu.querySelector('#bottom-line')
topLine.style["border-bottom"] = "1px solid #D9DEE2"
topLine.style["height"] = "77px"

pageContent = sketch.everything
pageContent.x = Align.center()

#Attempt to scale
pageContent.scale = 0.5
pageContent.originX = 0
pageContent.originY = 0
#Prep file
industryRowClosed = sketch.row_prod_tech
industryRowOpen = sketch.row_tech_open
industryRowEdit = sketch.row_prod_tech_edit
industryRowEdit.opacity = 0
doneButton = sketch.Button_Done
bottomHalf = sketch.moveDown
industryRowOpen.opacity = 0
bottomHalf.closeY = bottomHalf.y
bottomHalf.openY = bottomHalf.y + industryRowOpen.height - 20
bottomHalf.y = bottomHalf.closeY

makeInteractive(industryRowClosed)
makeInteractive(doneButton)

#Industry Row open and Close
industryRowClosed.onClick ->
	#Open Row
	industryRowClosed.ignoreEvents = true
	bottomHalf.animate
		properties: 
			y: bottomHalf.openY
		curve: "spring"
		time: 1	
	industryRowOpen.animate
		properties: 
			opacity: 1
		curve: "linear"
		time: 0.25
	industryRowClosed.animate
		properties: 
			opacity: 0
		curve: "linear"
		time: 0.25
	industryRowEdit.animate
		properties: 
			opacity: 0
		curve: "linear"
		time: 0.25
	
doneButton.onClick ->		
	#Close Row
	industryRowClosed.ignoreEvents = false
	bottomHalf.animate
		properties: 
			y: bottomHalf.closeY
		curve: "spring"
		time: 1	
		delay: 0.25
	industryRowOpen.animate
		properties: 
			opacity: 0
		curve: "linear"
		time: 0.25
	industryRowEdit.animate
		properties: 
			opacity: 1
		curve: "linear"
		time: 0.25

#Product search 
prodSearchOn = sketch.input_prodsearch_on
prodSearchOff = sketch.Input_prodsearch_off
microsPOS = sketch.list_item_31
prodSearchOn.opacity = 0
makeInteractive(prodSearchOn)


prodSearchOn.onClick ->
	prodSearchOn.opacity = 1
microsPOSListOn = sketch.Selected_Industries_on
multiSelectBoxOn = sketch.Multi_Select_List_on
multiSelectBoxOff = sketch.Multi_Select_List_off
multiSelectBoxOn.opacity = 0
pulsingAnimationA = new Animation
	layer: multiSelectBoxOff
	properties: 
		opacity: 0.5
	time: 1
	curve: "ease-in-out"
pulsingAnimationB = pulsingAnimationA.reverse()
pulsingAnimationA.on(Events.AnimationEnd, pulsingAnimationB.start)
pulsingAnimationB.on(Events.AnimationEnd, pulsingAnimationA.start)
 
prodSearchOn.html = "<input id='prodSearch' type='text' value=''>"
searchTextInput = prodSearchOn.querySelector("#prodSearch")
searchTextInput.onkeyup = (event)->
	# Faking loading Animation
	pulsingAnimationA.stop()
	pulsingAnimationB.stop()
	if(event.keyCode != 13)
		pulsingAnimationA.start()
	else
		multiSelectBoxOn.animate
			properties:
				opacity:1
			time: 0.5	
		multiSelectBoxOff.animate
			properties:
				opacity:0
			time: 0.5	
	
searchTextInput.style["background-color"] = "rgba(255,255,255,0)"
searchTextInput.style["font"] = "Apex New"
searchTextInput.style["font-size"] = "14px"
searchTextInput.style["color"] = "#303b3e"
searchTextInput.style["width"] = "650px"
searchTextInput.style["padding"] = "5px 10px 5px 10px"
searchTextInput.style["margin-top"] = "8px" 
searchTextInput.style["outline"] = "none" 

#Sidebar
sidebarBefore = sketch.sidebar_Before
sidebarAfter = sketch.sidebar_After
sidebarAfter.opacity = 0

#Micros POS click
microsPOS.children[2].opacity = 0
microsPOS.children[2].scale = 0.7
microsItems = multiSelectBoxOn.children
for item,index in microsItems
	makeInteractive(item)
	item.children[0].opacity = 0
	item.onMouseOver ->
		this.children[0].opacity = 1
	item.onMouseOut ->
		this.children[0].opacity = 0
microsPOSListOn.opacity = 0
microsPOS.onClick ->
	#Animation
	this.children[2].animate
		properties:
			opacity:1
			scale: 1
		time: 0.5
		curve: "spring"
	microsPOSListOn.animate
		properties:
			opacity:1
		time: 0.5	
	#Value on right side
	sidebarBefore.animate
		properties: 
			opacity: 0
		time: 1	
	sidebarAfter.animate
		properties: 
			opacity: 1
		time: 1
	
	

# SAVE BUTTON
saveButtonOn = sketch.button_save_on
saveButtonOff = sketch.button_save_off
makeInteractive(saveButtonOn)
saveButtonOff.opacity = 0

saveButtonOn.onClick ->
	#Go to segment single
	window.location.href = 'https://hangle2301.github.io/rcx/California-Healthcare.framer/'	
# NAMING
textLayer = sketch.input_on
baseTextLayer = sketch.input_off
textLayer.html = "<input id='segmentName' name='segmentName' type='text' value=''>"
textInput = textLayer.querySelector("#segmentName")
#textInput.style["border"] = "1px solid #d9dee2"
textInput.style["background-color"] = "rgba(255,255,255,0)"
textInput.style["border-radius"] = "3px"
textInput.style["padding"] = "10px"
textInput.style["font"] = "Apex New"
textInput.style["font-size"] = "14px"
textInput.style["color"] = "#303b3e"
textInput.style["width"] = "470px"
textInput.style["outline"] = "none" 
textLayer.opacity = 0

textLayer.onClick ->
	textLayer.opacity = 1
	
# BELL & WHISTLES
industryRowClosed.onMouseOver ->
	#some fancy animation
require 'LuaScripts/anlnodes'

function CreateAccelKeyText(accelKey, accelQual)
	local accelKeyText = Text:new()
	accelKeyText:SetStyle("EditorMenuText", cache:GetResource("XMLFile", "UI/DefaultStyle.xml"))
	accelKeyText.textAlignment = HA_RIGHT
	
	local text
	if accelKey == KEY_DELETE then text = "Del"
	elseif accelKey == KEY_SPACE then text = "Space"
	elseif accelKey == KEY_F1 then text = "F1"
	elseif accelKey == KEY_F2 then text = "F2"
	elseif accelKey == KEY_F3 then text = "F3"
	elseif accelKey == KEY_F4 then text = "F4"
	elseif accelKey == KEY_F5 then text = "F5"
	elseif accelKey == KEY_F6 then text = "F6"
	elseif accelKey == KEY_F7 then text = "F7"
	elseif accelKey == KEY_F8 then text = "F8"
	elseif accelKey == KEY_F9 then text = "F9"
	elseif accelKey == KEY_F10 then text = "F10"
	elseif accelKey == KEY_F11 then text = "F11"
	elseif accelKey == KEY_F12 then text = "F12"
	elseif accelKey == -1 then text = ">"
	else text:AppendUTF8(accelKey)
	end
	accelKeyText.text=text
	return accelKeyText
end

function CreateMenuItem(title, accelKey)
	local menu=Menu:new(title)
	menu:SetStyleAuto(cache:GetResource("XMLFile", "UI/DefaultStyle.xml"))
	menu:SetLayout(LM_HORIZONTAL, 0, IntRect(8,2,8,2))
	
	local text=menu:CreateChild("Text", "Text")
	text:SetStyle("EditorMenuText", cache:GetResource("XMLFile", "UI/DefaultStyle.xml"))
	text.text=title
	
	if accelKey ~= 0 then
		local spacer=UIElement:new()
		spacer.minWidth = text.indentSpacing
		spacer.height = text.height
		menu:AddChild(spacer)
		menu:AddChild(CreateAccelKeyText(accelKey, nil))
	end
	
	return menu
end

function CreatePopup(baseMenu)
	local popup=Window:new()
	popup:SetStyleAuto(cache:GetResource("XMLFile", "UI/DefaultStyle.xml"))
	popup:SetLayout(LM_VERTICAL, 1, IntRect(2,6,2,6))
	baseMenu.popup=popup
	baseMenu.popupOffset = IntVector2(baseMenu.width,0)
	return popup
end

function CreateMenu(title)
	local menu=CreateMenuItem(title)
	
	CreatePopup(menu)
	return menu
end

NodeGraphUI=ScriptObject()

function NodeGraphUI:Start()
	--self.createnodemenu=ui:LoadLayout(cache:GetResource("XMLFile", "UI/CreateNodeMenu.xml"))
	--self.pane:AddChild(self.createnodemenu)
	
	self.pane=ui.root:CreateChild("UIElement")
	self.pane:SetSize(graphics.width, graphics.height)
	
	self.createmenu=self:CreateNodeCreateMenu(self.pane)
	self.createmenu:SetPosition(100,100)
	self.createmenu.visible=false

	
	self:Activate(self:CreateNodeGroup())
	self.cursortarget=cursor:CreateChild("NodeGraphLinkDest")
	
end

function NodeGraphUI:CreateNodeCreateMenu(parent)
	local menu=ui:LoadLayout(cache:GetResource("XMLFile", "UI/CreateNodeButton.xml"))
	local mn=menu:GetChild("Menu",true)
	
	local pop=CreatePopup(mn)
	local i,c
	for i,c in pairs(nodecategories) do
		local mi=CreateMenuItem(i,-1)
		pop:AddChild(mi)
		
		local childpop=CreatePopup(mi)
		local e,f
		for e,f in ipairs(c) do
			local ni=CreateMenuItem(f,0)
			childpop:AddChild(ni)
			--self:SubscribeToEvent(ni, "MenuSelected", "NodeGraphUI:HandleMenuSelected")
		end
	end
	
	self:SubscribeToEvent("MenuSelected", "NodeGraphUI:HandleMenuSelected")
	
	parent:AddChild(menu)
	return menu
		
end

function NodeGraphUI:CreateNodeGroup()
	local nodegroup=
	{
		nodes={}
	}
	nodegroup.pane=self.pane:CreateChild("Window")
	nodegroup.pane.size=IntVector2(graphics.width*2, graphics.height*2)
	nodegroup.pane.position=IntVector2(-graphics.width/2, -graphics.height/2)
	nodegroup.pane:SetImageRect(IntRect(208,0,223,15))
	nodegroup.pane:SetImageBorder(IntRect(4,4,4,4))
	nodegroup.pane:SetTexture(cache:GetResource("Texture2D", "Textures/UI.png"))
	nodegroup.pane.opacity=1
	nodegroup.pane.bringToFront=true
	nodegroup.pane.movable=true
	nodegroup.pane.clipChildren=false
	nodegroup.pane:SetDefaultStyle(cache:GetResource("XMLFile", "UI/NodeStyle.xml"))
	
	nodegroup.linkpane=nodegroup.pane:CreateChild("NodeGraphLinkPane")
	nodegroup.linkpane.size=IntVector2(graphics.width*2, graphics.height*2)
	nodegroup.linkpane.visible=true
	nodegroup.linkpane.texture=cache:GetResource("Texture2D", "Data/Textures/UI.png")
	
	nodegroup.previewtex=Texture2D:new()
	nodegroup.previewimg=Image()
	nodegroup.previewimg:SetSize(256,256,3)
	nodegroup.previewimg:Clear(Color(0,0,0))
	nodegroup.previewtex:SetData(nodegroup.previewimg,false)
	
	nodegroup.histotex=Texture2D:new()
	nodegroup.histoimg=Image()
	nodegroup.histoimg:SetSize(256,64,3)
	nodegroup.histoimg:Clear(Color(0,0,0))
	nodegroup.histotex:SetData(nodegroup.histoimg,false)
	
	nodegroup.output=self:OutputNode(nodegroup)
	nodegroup.output.position=IntVector2(-nodegroup.pane.position.x + graphics.width-nodegroup.output.width, -nodegroup.pane.position.y + graphics.height/4)
	
	nodegroup.output:GetChild("Preview",true).texture=nodegroup.previewtex
	nodegroup.output:GetChild("Histogram",true).texture=nodegroup.histotex
	
	self:SubscribeToEvent(nodegroup.output:GetChild("Grayscale",true),"Pressed","NodeGraphUI:HandleGrayscale")
	self:SubscribeToEvent(nodegroup.output:GetChild("RGBA",true),"Pressed","NodeGraphUI:HandleRGBA")
	self:SubscribeToEvent(nodegroup.output:GetChild("Volume",true),"Pressed","NodeGraphUI:HandleVolume")
	self:SubscribeToEvent(nodegroup.output:GetChild("Store",true),"Pressed","NodeGraphUI:HandleStore")
	nodegroup.pane.visible=false
	return nodegroup
end

function NodeGraphUI:Activate(nodegroup)
	if self.nodegroup then
		nodegroup.pane.visible=false
		nodegroup.pane.focus=false
		
	end
	self.nodegroup=nodegroup
	nodegroup.pane.visible=true
	nodegroup.pane.focus=true
	
	self.createmenu.visible=true
	nodegroup.pane:AddChild(self.createmenu)
	self.createmenu.position=IntVector2(-self.nodegroup.pane.position.x+100, -self.nodegroup.pane.position.y+100)
end

function NodeGraphUI:Deactivate()
	if self.nodegroup then
		self.nodegroup.pane.visible=false
		self.nodegroup.pane.focus=false
		if self.closetext then self.closetext:Remove() self.closetext=nil end
	end
end


function NodeGraphUI:HandleCloseCreateNodeMenu(eventType, eventData)
	--self.createnodemenu.visible=false
end

function NodeGraphUI:HandleCreateNode(eventType, eventData)
	if not self.nodegroup then return end
	local e=eventData["Element"]:GetPtr("UIElement")
	if not e then return end
	local n

	n=self:BuildNode(self.nodegroup, e.name)
	if not n then return end
	
	n.position=IntVector2(-self.nodegroup.pane.position.x + graphics.width/2, -self.nodegroup.pane.position.y + graphics.height/2)
	table.insert(self.nodegroup.nodes, n)
end

function NodeGraphUI:SubscribeLinkPoints(e,numinputs)
	local output=e:GetChild("Output0", true)
	if(output) then
		self:SubscribeToEvent(output, "DragBegin", "NodeGraphUI:HandleOutputDragBegin")
		self:SubscribeToEvent(output, "DragEnd", "NodeGraphUI:HandleDragEnd")
		output:SetRoot(e)
	end
	
	local c
	for c=0,numinputs-1,1 do
		local input=e:GetChild("Input"..c, true)
		if(input) then
			self:SubscribeToEvent(input, "DragBegin", "NodeGraphUI:HandleInputDragBegin")
			self:SubscribeToEvent(input, "DragEnd", "NodeGraphUI:HandleDragEnd")
		end
	end
end

function NodeGraphUI:OutputNode(nodegroup)
	local e=ui:LoadLayout(cache:GetResource("XMLFile", "UI/OutputNode.xml"))
	e.visible=true
	self:SubscribeLinkPoints(e,1)
	
	nodegroup.pane:AddChild(e)
	return e
end

function NodeGraphUI:BuildNode(nodegroup, type)
	local e=CreateNodeType(nodegroup.pane, type)
	local d=GetNodeTypeDesc(type) --nodetypes[type]
	if not d then return end
	
	if e then
		self:SubscribeLinkPoints(e,#d.inputs)
	end
	
	return e
end



function NodeGraphUI:HandleOutputDragBegin(eventType, eventData)
	if not self.nodegroup then return end
	local element=eventData["Element"]:GetPtr("NodeGraphLinkSource")
	self.link=self.nodegroup.linkpane:CreateLink(element,self.cursortarget)
	self.link:SetImageRect(IntRect(193,81,207,95))
	
end

function NodeGraphUI:HandleDragEnd(eventType, eventData)
	if not self.link then return end
	if not self.nodegroup then return end
	
	local at=ui:GetElementAt(cursor.position)
	if at then
		if string.sub(at.name, 1, 5)=="Input" then
			local thislink=at:GetLink()
			if thislink then
				at:ClearLink()
				local src=thislink:GetSource()
				if src then src:RemoveLink(thislink) end
				self.nodegroup.linkpane:RemoveLink(thislink)
			end
			self.link:SetTarget(at)
			return
		end
	end
	
	-- Destroy the link if not dropped on a valid target
	local source=self.link:GetSource()
	if(source) then source:RemoveLink(self.link) end
	self.nodegroup.linkpane:RemoveLink(self.link)
	self.link=nil
end

function NodeGraphUI:HandleInputDragBegin(eventType, eventData)
	local element=eventData["Element"]:GetPtr("NodeGraphLinkDest")
	if element then
		local link=element:GetLink()
		if link then
			self.link=link
			link:SetTarget(self.cursortarget)
			element:ClearLink()
		else
			self.link=nil
		end
	end
end

function NodeGraphUI:HandleGrayscale(eventType, eventData)
	if not self.nodegroup then return end
	local kernel=BuildANLFunction(self.nodegroup.output)
	local sx=self.nodegroup.output:GetChild("SeamlessXCheck",true).checked
	local sy=self.nodegroup.output:GetChild("SeamlessYCheck",true).checked
	local sz=self.nodegroup.output:GetChild("SeamlessZCheck",true).checked
	local usez=self.nodegroup.output:GetChild("UseZValue",true).checked
	local zval=tonumber(self.nodegroup.output:GetChild("ZValue",true).text)
	local seamlessmode=SEAMLESS_NONE
	if sx then
		if sy then
			if sz then
				seamlessmode=SEAMLESS_XYZ
			else
				seamlessmode=SEAMLESS_XY
			end
		elseif sz then
			seamlessmode=SEAMLESS_XZ
		else
			seamlessmode=SEAMLESS_X
		end
	elseif sy then
		if sz then
			seamlessmode=SEAMLESS_YZ
		else
			seamlessmode=SEAMLESS_Y
		end
	elseif sz then
		seamlessmode=SEAMLESS_Z
	end
	
	local minmax=RenderANLKernelToImage(self.nodegroup.previewimg,kernel,0,1,self.nodegroup.histoimg,seamlessmode,usez,zval)
	self.nodegroup.previewtex:SetData(self.nodegroup.previewimg)
	self.nodegroup.output:GetChild("LowValue",true).text=string.format("%.4f",minmax.x)
	self.nodegroup.output:GetChild("HighValue",true).text=string.format("%.4f",minmax.y)
	self.nodegroup.histotex:SetData(self.nodegroup.histoimg,false)
	self.nodegroup.previewimg:SavePNG("prev.png")
end

function NodeGraphUI:HandleRGBA(eventType, eventData)
	if not self.nodegroup then return end
	local kernel=BuildANLFunction(self.nodegroup.output)
	
	local sx=self.nodegroup.output:GetChild("SeamlessXCheck",true).checked
	local sy=self.nodegroup.output:GetChild("SeamlessYCheck",true).checked
	local sz=self.nodegroup.output:GetChild("SeamlessZCheck",true).checked
	local usez=self.nodegroup.output:GetChild("UseZValue",true).checked
	local zval=tonumber(self.nodegroup.output:GetChild("ZValue",true).text)
	local seamlessmode=SEAMLESS_NONE
	if sx then
		if sy then
			if sz then
				seamlessmode=SEAMLESS_XYZ
			else
				seamlessmode=SEAMLESS_XY
			end
		elseif sz then
			seamlessmode=SEAMLESS_XZ
		else
			seamlessmode=SEAMLESS_X
		end
	elseif sy then
		if sz then
			seamlessmode=SEAMLESS_YZ
		else
			seamlessmode=SEAMLESS_Y
		end
	elseif sz then
		seamlessmode=SEAMLESS_Z
	end
	
	RenderANLKernelToImageRGBA(self.nodegroup.previewimg,kernel,seamlessmode,usez,zval)
	self.nodegroup.previewtex:SetData(self.nodegroup.previewimg)
	self.nodegroup.previewimg:SavePNG("prev.png")
end

function NodeGraphUI:HandleVolume(eventType, eventData)
	if not self.nodegroup then return end
	local kernel=BuildANLFunction(self.nodegroup.output)
	local minmax=RenderANLKernelToImage(self.nodegroup.previewimg,kernel,0,1,self.nodegroup.histoimg)
	self.nodegroup.previewtex:SetData(self.nodegroup.previewimg)
	self.nodegroup.output:GetChild("LowValue",true).text=string.format("%.4f",minmax.x)
	self.nodegroup.output:GetChild("HighValue",true).text=string.format("%.4f",minmax.y)
	self.nodegroup.histotex:SetData(self.nodegroup.histoimg,false)
end

function NodeGraphUI:HandleStore(eventType, eventData)
	local st,nodefunc=CreateLibraryDesc(self.nodegroup.output)
	local name=self.nodegroup.output:GetChild("StoreName",true).text
	print(st)
	local dothing=table.show(nodefunc, "nodetypes.user."..name)
	print(dothing)
	local chunk=loadstring(dothing)
	chunk()
	local ct
	local found=false
	for _,ct in pairs(nodecategories.user) do
		if ct==name then found=true end
	end
	if not found then
		table.insert(nodecategories.user, name)
	end
	self.createmenu:Remove()
	self.createmenu=nil
	self.createmenu=self:CreateNodeCreateMenu(self.pane)
	self.createmenu:SetPosition(100,100)
end


function NodeGraphUI:HandleMenuSelected(eventType, eventData)
	local menu = eventData["Element"]:GetPtr("Menu")
	if not menu then print("no menu") return end
	
	local t=menu:GetChild("Text",true)
	if t then
		print(t.text)
		self.createmenu:GetChild("Menu",true).showPopup=false
		
		if not self.nodegroup then return end
		local n

		n=self:BuildNode(self.nodegroup, t.text)
		if not n then return end
	
		n.position=IntVector2(-self.nodegroup.pane.position.x + graphics.width/2, -self.nodegroup.pane.position.y + graphics.height/2)
		table.insert(self.nodegroup.nodes, n)
	else
		print("no text")
	end
    
end
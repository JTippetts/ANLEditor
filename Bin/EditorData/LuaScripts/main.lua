-- Terrain editing prototype
-- Water example.
-- This sample demonstrates:
--     - Creating a large plane to represent a water body for rendering
--     - Setting up a second camera to render reflections on the water surface

require "LuaScripts/Utilities/Sample"
require "LuaScripts/nodegraphui"

uiStyle = cache:GetResource("XMLFile", "UI/DefaultStyle.xml")
ui.root.defaultStyle = uiStyle;
iconStyle = cache:GetResource("XMLFile", "UI/EditorIcons.xml");

function CreateCursor()
    cursor = Cursor:new("Cursor")
    cursor:SetStyleAuto(uiStyle)
    cursor:SetPosition(graphics.width / 2, graphics.height / 2)
    ui.cursor = cursor
	cursor.visible=true

end


function Start()
    
    SampleStart()
    CreateScene()
    SubscribeToEvents()
	
end

function Stop()
	
end

function CreateScene()
    scene_ = Scene()
	CreateCursor()
	
    scene_:CreateComponent("Octree")
    nodeui=scene_:CreateScriptObject("NodeGraphUI")
	
end

function CreateInstructions()
    
end

function SubscribeToEvents()
    SubscribeToEvent("Update", "HandleUpdate")
end

function HandleUpdate(eventType, eventData)
    -- Take the frame time step, which is stored as a float
    local timeStep = eventData["TimeStep"]:GetFloat()
	
	
	if input:GetKeyPress(KEY_PRINTSCREEN) then
		local img=Image(context)
		graphics:TakeScreenShot(img)
		local t=os.date("*t")
		local filename="screen-"..tostring(t.year).."-"..tostring(t.month).."-"..tostring(t.day).."-"..tostring(t.hour).."-"..tostring(t.min).."-"..tostring(t.sec)..".png"
		img:SavePNG(filename)
	end
	
end

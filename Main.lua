local Fernando = game.CoreGui:FindFirstChild("Fernando")
if Fernando then
    return  
end

local Fernando = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local Cuadro1 = Instance.new("Frame")
local Cuadro2 = Instance.new("Frame")
local Barra1 = Instance.new("ScrollingFrame")
local Barra2 = Instance.new("ScrollingFrame")
local Siguiente = Instance.new("TextButton")
local Mix = Instance.new("TextButton")
local Borde1 = Instance.new("UIStroke")
local Borde2 = Instance.new("UIStroke")
local lplr = game.Players.LocalPlayer
local data = game.ReplicatedStorage:WaitForChild("Datas"):WaitForChild(lplr.UserId)

Fernando.Name = "Fernando"
Fernando.Parent = game.CoreGui


Frame.Parent = Fernando
Frame.BackgroundTransparency = 1
Frame.Position = UDim2.new(0.5, -150, 0.4, -130)
Frame.Size = UDim2.new(0, 410, 0, 30)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.Text = "Granja Automatico☠️"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 14
TextLabel.TextStrokeTransparency = 1
TextLabel.TextScaled = true

Cuadro1.Parent = TextLabel
Cuadro1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Cuadro1.Position = UDim2.new(0, 0, 1, 0)
Cuadro1.Size = UDim2.new(0, 410, 0, 400)
Cuadro1.Visible = false  -- Comienza oculto

Cuadro2.Parent = TextLabel
Cuadro2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Cuadro2.Position = UDim2.new(0, 0, 1, 0)
Cuadro2.Size = UDim2.new(0, 410, 0, 400)
Cuadro2.Visible = false  -- Comienza oculto

Barra1.Parent = Cuadro1
Barra1.Size = UDim2.new(1, 0, 1, 0)
Barra1.CanvasSize = UDim2.new(0, 0, 2, 0)
Barra1.ScrollBarThickness = 10
Barra1.BackgroundTransparency = 1
Barra1.ScrollingDirection = Enum.ScrollingDirection.Y 

Barra2.Parent = Cuadro2
Barra2.Size = UDim2.new(1, 0, 1, 0)
Barra2.CanvasSize = UDim2.new(0, 0, 2, 0)
Barra2.ScrollBarThickness = 10
Barra2.BackgroundTransparency = 1
Barra2.ScrollingDirection = Enum.ScrollingDirection.Y 

Siguiente.Parent = Frame
Siguiente.BackgroundTransparency = 1
Siguiente.Position = UDim2.new(1, -60, 0, 0)
Siguiente.Size = UDim2.new(0, 30, 0, 30)
Siguiente.Text = ">"
Siguiente.TextColor3 = Color3.fromRGB(255, 255, 255)
Siguiente.TextSize = 20

Mix.Parent = Frame
Mix.BackgroundTransparency = 1
Mix.Position = UDim2.new(1, -90, 0, 0)
Mix.Size = UDim2.new(0, 30, 0, 30)
Mix.Text = "+"
Mix.TextColor3 = Color3.fromRGB(255, 255, 255)
Mix.TextSize = 20

--incio Borde color\/
Borde1.Parent = Cuadro1
Borde1.Thickness = 2
Borde1.Color = Color3.fromRGB(255, 0, 0) 

Borde2.Parent = Cuadro2
Borde2.Thickness = 2
Borde2.Color = Color3.fromRGB(255, 0, 0) 
--parte 2 de color Borde\/

--Cuadro para txt para ir ah Bills \/
local textBox = Instance.new("TextBox", Cuadro2)
textBox.Size = UDim2.new(0, 200, 0, 50)
textBox.Position = UDim2.new(0.5, -100, 0.5, -25)
textBox.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
textBox.BorderSizePixel = 6
textBox.BorderColor3 = Color3.fromRGB(0, 0, 255)
textBox.TextColor3 = Color3.fromRGB(0, 0, 0)
textBox.TextSize = 18
textBox.PlaceholderText = "Introduce un número (Ej. 100M, 1B)"
textBox.ClearTextOnFocus = true
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 12)

local function saveToJSON(fileName, data)
    writefile(fileName, game:GetService("HttpService"):JSONEncode(data))
end

local function loadFromJSON(fileName)
    if isfile(fileName) then
        return game:GetService("HttpService"):JSONDecode(readfile(fileName))
    end
    return nil
end

local savedData = loadFromJSON("TObills")
local minStrength = savedData and savedData.minStrength
if minStrength then textBox.Text = tostring(minStrength) end

textBox.FocusLost:Connect(function()
    local input = textBox.Text
    local number, suffix = input:match("^(%d+)([MmBb])$")
    if number then
        minStrength = tonumber(number) * (suffix == "M" and 1e6 or 1e9)
        saveToJSON("TObills", {minStrength = minStrength})
    else
        minStrength = nil
    end
end)
--Fin Ciclo de cuadro para ir Bills


task.spawn(function()
    local colors = {
        Color3.fromRGB(255, 0, 0), -- Rojo
        Color3.fromRGB(0, 255, 0), -- Verde
        Color3.fromRGB(0, 0, 255), -- Azul
        Color3.fromRGB(255, 255, 0) -- Amarillo
    }
    local index = 1

    while true do
        Borde1.Color = colors[index]
        Borde2.Color = colors[index]
        index = index + 1
        if index > #colors then
            index = 1
        end
        task.wait(1) 
    end
end)
--Fin color Borde/\

--incio de color txt\/
local textProperties = {
    {text = "Reb", position = UDim2.new(-0.155, 0, 0.115, 0), color = Color3.fromRGB(255, 0, 0)},
    
}

for _, props in pairs(textProperties) do
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = Barra1
    TextLabel.Size = UDim2.new(0, 200, 0, 36)
    TextLabel.Position = props.position
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextColor3 = props.color
    TextLabel.Text = props.text
    TextLabel.TextScaled = true
end
 --Fin del color txt/\
 
--Codeg Para Button Minimizar = Maximizar
local currentPanel = 1
local isMinimized = true  
Siguiente.MouseButton1Click:Connect(function()
    if not isMinimized then
        if currentPanel == 1 then
            Cuadro1.Visible = false
            currentPanel = 2
            Cuadro2.Visible = true
        else
            Cuadro2.Visible = false
            currentPanel = 1
            Cuadro1.Visible = true
        end
    end
end)

Mix.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        Cuadro1.Visible = false
        Cuadro2.Visible = false
        Mix.Text = "+"
    else
        if currentPanel == 1 then
            Cuadro1.Visible = true
        else
            Cuadro2.Visible = true
        end
        Mix.Text = "×"
    end
end)

--Aki ya es del interrutor <: \/
local function SaveSwitchState(isActive, switchName)
    writefile(switchName.."_SwitchState.json", game:GetService("HttpService"):JSONEncode({SwitchOn = isActive, LastModified = os.time()}))
end

local function LoadSwitchState(switchName)
    return isfile(switchName.."_SwitchState.json") and game:GetService("HttpService"):JSONDecode(readfile(switchName.."_SwitchState.json")).SwitchOn or false
end
local function createSwitch(parent, position, switchName, initialState)
    local switchButton = Instance.new("TextButton")
    switchButton.Parent = parent
    switchButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    switchButton.BorderSizePixel = 0
    switchButton.Position = position
    switchButton.Size = UDim2.new(0, 84, 0, 30)
    switchButton.Text = ""
    Instance.new("UICorner", switchButton).CornerRadius = UDim.new(0.4, 0)

    local switchBall = Instance.new("Frame")
    switchBall.Parent = switchButton
    switchBall.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    switchBall.Size = UDim2.new(0, 30, 0, 30)
    switchBall.Position = UDim2.new(0, 5, 0.5, -15)
    switchBall.BorderSizePixel = 0
    Instance.new("UICorner", switchBall).CornerRadius = UDim.new(0.5, 0)

    local isActive = initialState

    switchBall.Position, switchBall.BackgroundColor3 = 
        isActive and UDim2.new(1, -35, 0.5, -15) or UDim2.new(0, 5, 0.5, -15), 
        isActive and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    switchButton.MouseButton1Click:Connect(function()
        isActive = not isActive
        switchBall.Position, switchBall.BackgroundColor3 = 
            isActive and UDim2.new(1, -35, 0.5, -15) or UDim2.new(0, 5, 0.5, -15), 
            isActive and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)        
        SaveSwitchState(isActive, switchName)
    end)

    return function() return isActive end
end

local getIsActive1 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.120, 0), "Switch1", LoadSwitchState("Switch1"))--Farm

--Casi fin del interrutor /\

task.spawn(function()
pcall(function()
while not game:IsLoaded() do wait() end
while not game.Players.LocalPlayer do wait() end
local lplr = game.Players.LocalPlayer
while not lplr.Character do wait() end
local ldata = game.ReplicatedStorage:WaitForChild("Datas"):WaitForChild(lplr.UserId)

local r = math.random(1,2e9) -- This changes when you re-execute, so the gui doesn't stack
_G.AY = r
_G.Fast = false

local t = {"Rebirth","Strength","Speed","Defense","Energy","Zeni"}
for i,a in pairs(t) do
	while not ldata:FindFirstChild(a) do wait() end
end
local users = {""}

local corner = UDim.new(0,5)
-- Functions required for logs
local suffixes = {'','K','M','B','T','qd','Qn'}
function format(val)
	for i=1, #suffixes do
		if tonumber(val) < 10^(i*3) then
			return math.floor(val/((10^((i-1)*3))/100))/(100)..suffixes[i]
		end
	end
end

function format2(n)
	n = tostring(n)
	return n:reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end

local sts = {"Strength","Speed","Defense","Energy"}
function getloweststat(plr)
	local data = game.ReplicatedStorage.Datas:WaitForChild(plr.UserId)
	local l = math.huge
	for i,v in pairs(sts) do
		if not data:FindFirstChild(v) then return end
		local st = data[v]
		if st.Value < l then l = st.Value end
	end
	return l
end

local LocalPlayer = game:GetService("Players").LocalPlayer
--Player Info

local DName = game.Players.LocalPlayer.DisplayName  -- PlayerInfo Display Name
local Name = game.Players.LocalPlayer.Name -- Name
local Userid = game.Players.LocalPlayer.UserId -- UserId

-- Load the character in
if lplr.PlayerGui:FindFirstChild("Start") then
	game:GetService("ReplicatedStorage").Package.Events.Start:InvokeServer()
	if workspace.Others:FindFirstChild("Title") then
		workspace.Others.Title:Destroy();
	end;
	local cam = game.Workspace.CurrentCamera;
	cam.CameraType = Enum.CameraType.Custom;
	cam.CameraSubject = lplr.Character.Humanoid;
	_G.Ready = true
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true);
	lplr.PlayerGui:WaitForChild("Main").Enabled = true
	if lplr.PlayerGui:FindFirstChild("Start") then
		lplr.PlayerGui.Start:Destroy()
	end
    lplr.PlayerGui.Main.bruh.Enabled = false
    lplr.PlayerGui.Main.bruh.Enabled = true
end


-- Begin basic functions
local NPCs = workspace:WaitForChild("Others"):WaitForChild("NPCs")
c = nil
local rainbows = {} -- {Object, Color Property}
local rainbows2 = {}
spawn(function()
	while _G.AY == r do
		for i = 1,6 do 
			if i == 1 then c = Color3.new(1,0,0)
			elseif i == 2 then c = Color3.new(1,1,0)
			elseif i == 3 then c = Color3.new(0,1,0)
			elseif i == 4 then c = Color3.new(0,1,1)
			elseif i == 5 then c = Color3.new(0,0,1)
			elseif i == 6 then c = Color3.new(1,0,1)
			end
			for a,v in pairs(rainbows) do
				game:GetService("TweenService"):Create(v[1], TweenInfo.new(1), {[v[2]] = c}):Play()
			end
			wait(1)
		end
		wait()
	end
end)
spawn(function()
	while _G.AY == r do
		for a,v in pairs(rainbows2) do
			game:GetService("TweenService"):Create(v[1], TweenInfo.new(.1), {[v[2]] = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))}):Play()
			task.wait()
		end
		wait(.1)
	end
end)

--GUI
local vL = lplr.PlayerGui:WaitForChild("Main"):WaitForChild("Version") 
vL.Visible = false 

--local guilocation = game.CoreGui
local guilocation = game.Players.LocalPlayer.PlayerGui
if guilocation:FindFirstChild("StatsGUI") then guilocation.StatsGUI:Destroy() end
local scgui = Instance.new("ScreenGui")
scgui.Parent = game.CoreGui
scgui.DisplayOrder = math.huge
local espdirectory = Instance.new("Folder")
espdirectory.Name = "ESPs"
espdirectory.Parent = scgui
scgui.ResetOnSpawn = false
scgui.Name = "StatsGUI"
local colortheme = Color3.new(.1,.1,.1)

-- Frames
local fr = Instance.new("Frame") -- This holds the playerlist frame
fr.Parent = scgui
fr.Name = "fr"
fr.BackgroundColor3 = colortheme --Color3.new(.2,.2,.2)
fr.BackgroundTransparency = 1
fr.AnchorPoint = Vector2.new(1,0)
fr.Position = UDim2.new(1.16,-5,.05,0)
fr.Size = UDim2.new(.15,0,0,40*18)
fr.BorderSizePixel = 0

local fr12 = Instance.new("Frame") -- Playerlist goes here
fr12.Parent = fr
fr12.Name = "fr12"
fr12.BackgroundColor3 = Color3.new(1,1,1) --Color3.new(.2,.2,.2)
fr12.BorderSizePixel = 3
fr12.BackgroundTransparency = 0
local layout12 = Instance.new("UIGridLayout") -- Organizes the players
layout12.Parent = fr12
layout12.CellPadding = UDim2.new(0,0,0,5) --
layout12.SortOrder = Enum.SortOrder.LayoutOrder
local stroke1 = Instance.new("UIStroke")
stroke1.Parent = fr12
stroke1.Thickness = 2
local corner1 = Instance.new("UICorner")
corner1.Parent = fr12
corner1.CornerRadius = corner
local UIGradient = Instance.new("UIGradient")
UIGradient.Parent = fr12
UIGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(20,20,20)),
	ColorSequenceKeypoint.new(.5, Color3.fromRGB(50,50,50)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(20,20,20)),
}
--
local Grad = UIGradient
local frames = 60
local speed = 0.01

function colour_change(colour1, colour2, colour3)
	local originalColour1 = Grad.Color.Keypoints[1].Value
	local originalColour2 = Grad.Color.Keypoints[2].Value
	local originalColour3 = Grad.Color.Keypoints[3].Value

	for i=frames,0,-1 do
		wait(speed)

		local x = math.sqrt((i-frames)^2)/frames

		Grad.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0,originalColour1:Lerp(colour1, x)),
			ColorSequenceKeypoint.new(.5,originalColour2:Lerp(colour2, x)),
			ColorSequenceKeypoint.new(1,originalColour3:Lerp(colour3, x)),

		}


	end
end
-- pink blue purple 
task.spawn(function()
	while c == nil do wait() end
	while scgui do
		colour_change(Color3.new(.1,.1,.1), Color3.new(.7,0,0), Color3.new(.1,.1,.1))
		colour_change(Color3.new(.1,.1,.1), Color3.new(0,.7,0), Color3.new(.1,.1,.1))
		colour_change(Color3.new(.1,.1,.1), Color3.new(0,0,.7), Color3.new(.1,.1,.1))
        task.wait()
	end
end)
--

UIGradient.Rotation = 45

layout12.CellSize = UDim2.new(1,0,0,30)--1/(#fr12:GetChildren()-2),0)

local fr2fade = Instance.new("Frame")
fr2fade.Parent = scgui
fr2fade.Position = UDim2.new(.75,-5,.05,-4)
fr2fade.Size = UDim2.new(.1,0,.7,4)
fr2fade.BackgroundTransparency = 1
fr2fade.ClipsDescendants = true
fr2fade.Name = "fr2back"
local fr2 = Instance.new("Frame") -- Normal Buttons go here
fr2.Parent = fr2fade
fr2.Name = "fr2"
fr2.ZIndex = -2
fr2.BackgroundColor3 = colortheme--Color3.new(.2,.2,.2)
--fr2.AnchorPoint = Vector2.new(1,0)
fr2.Position = UDim2.new(1,4,0,4)
fr2.BorderSizePixel = 3
fr2.BackgroundTransparency = 0.1
fr2.Visible = true
fr2.ClipsDescendants = true
local layout2 = Instance.new("UIGridLayout") -- Organizes the players
layout2.Parent = fr2
layout2.CellPadding = UDim2.new(0,0,0,4)
layout2.CellSize = UDim2.new(1,0,0,20)

layout2.SortOrder = "LayoutOrder"
local stroke2 = Instance.new("UIStroke")
stroke2.Parent = fr2
stroke2.Thickness = 2
local corner2 = Instance.new("UICorner")
corner2.Parent = fr2
corner2.CornerRadius = corner

local fr3 = Instance.new("Frame") -- Third Frame, holds lplr buttons
fr3.Parent = scgui
fr3.Name = "fr3"
fr3.ZIndex = -4
fr3.BackgroundTransparency = 0
fr3.BorderSizePixel = 0
fr3.BackgroundColor3 = colortheme
fr3.Position = UDim2.new(.31,0,1,5)
--fr3.Visible = true
local layout3 = Instance.new("UIGridLayout")
layout3.Parent = fr3
layout3.SortOrder = "LayoutOrder"
layout3.CellPadding = UDim2.new(0,0,0,5)
layout3.CellSize = UDim2.new(1,0,0,20)
layout3.HorizontalAlignment = "Center"
local corner3 = Instance.new("UICorner")
corner3.Parent = fr3
corner3.CornerRadius = corner
local stroke3 = Instance.new("UIStroke")
stroke3.Parent = fr3
stroke3.ApplyStrokeMode = "Border"
stroke3.Thickness = 2

local fr32 = Instance.new("Frame", scgui) -- Holds teleports
fr32.Name = "fr32"
fr32.ZIndex = -4
fr32.BackgroundTransparency = 0
fr32.BorderSizePixel = 0
fr32.BackgroundColor3 = colortheme
fr32.Visible = false
local layout32 = Instance.new("UIGridLayout")
layout32.Parent = fr32
layout32.SortOrder = "LayoutOrder"
layout32.CellPadding = UDim2.new(0,0,0,5)
layout32.CellSize = UDim2.new(1,0,0,20)
layout32.HorizontalAlignment = "Center"
local corner32 = Instance.new("UICorner")
corner32.Parent = fr32
corner32.CornerRadius = corner
local stroke32 = Instance.new("UIStroke")
stroke32.Parent = fr32
stroke32.ApplyStrokeMode = "Border"
stroke32.Thickness = 2

local srvrs = Instance.new("TextButton")
srvrs.Parent = scgui

function rainbow(object, property, which)
	if not object:FindFirstChild(property.."_Rainbow") then
		local a = Instance.new("BoolValue")
		a.Parent = object
		a.Name = property.."_Rainbow"
		table.insert(which, {object, property})
	end
end

local buttons = { -- Frame, ButtonName, Class, BG Color, Txt Color
	-- "R" = Rainbow
	-- All buttons will become colortheme with an outline
	{2,"Display","TextLabel",},
	{2,"HP","TextLabel",},
	{2,"Formlbl","TextLabel",},
	{2,"Quest","TextLabel",},
	{2,"Fusion","TextLabel",},
	{2,"Zeni","TextLabel",},
	{2,"Copy Stats","TextButton", Color3.new(.15,.15,.15), Color3.new(1,1,1)},
	{2,"View","TextButton", Color3.new(.15,.15,.15),"R"},
	{2,"Teleport","TextButton", Color3.new(.15,.15,.15),"R"},
	{3,"Ping","TextLabel", nil,"R"},
	{3,"FlySpeed","TextBox", "R",Color3.new(1,1,1)},
	{3,"Suicide","TextButton", Color3.new(0,0,0), Color3.new(1,0,0)},
	{3,"Abbreviate","TextButton", Color3.new(.15,.15,.15)},
	{3,"ESPHighlight","TextButton", Color3.new(.15,.15,.15)},
	{3,"ESPLabels","TextButton", Color3.new(.15,.15,.15)},
	{3,"Stack","TextButton", Color3.new(.15,.15,.15)},
	{3,"Block","TextButton", Color3.new(.15,.15,.15)},
}

function addbutton(button)
	local lbl = Instance.new(button[3])
	lbl.TextScaled = false
	if button[1] == 2 then
		lbl.Parent = fr2
		lbl.TextSize = 15
	elseif button[1] == 3 then
		lbl.Parent = fr3
		lbl.TextSize = 15
	elseif button[1] == 4 then
		lbl.Parent = fr32
		lbl.TextXAlignment = "Left"
	end
	lbl.ZIndex = lbl.Parent.ZIndex + 1
	lbl.Name = button[2]
	lbl.BackgroundTransparency = .5
	if button[3] ~= "TextLabel" then
		lbl.Text = button[2]
	else 
		lbl.BackgroundTransparency = 1
	end
	lbl.Font = Enum.Font.Code
	lbl.BorderSizePixel = 0
	if button[4] then
		if button[4] == "R" then
			rainbow(lbl, "BackgroundColor3",rainbows)
		else
			lbl.BackgroundColor3 = button[4]
		end
	else
		lbl.BackgroundColor3 = colortheme
	end
	lbl.TextColor3 = Color3.new(1,1,1)
	if button[5] then
		if button[5] == "R" then
			rainbow(lbl, "TextColor3",rainbows)
		else 
			lbl.TextColor3 = button[5]
		end
	end
	lbl.LayoutOrder = i
	local corner = Instance.new("UICorner")
	corner.Parent = lbl
	--corner.CornerRadius = corner
	return lbl
end

for i,button in pairs(buttons) do
	addbutton(button)
end

local b = Instance.new("TextButton")--addbutton({4, "Beerus", "TextButton", Color3.new(.5,0,.5)})
b.Parent = scgui
b.Name = "TP_Beerus"
b.Size = UDim2.new(.017,0,0,30)
b.Position = UDim2.new(.95,0,-.1,0)
b.BackgroundColor3 = colortheme
b.BackgroundTransparency = .5
b.Font = Enum.Font.Gotham
b.TextStrokeTransparency = 1
b.TextSize = 30
local bcorner = Instance.new("UICorner")
bcorner.Parent = b
bcorner.CornerRadius = UDim.new(0,5)

srvrs.Size = UDim2.new(.017,0,0,30)
srvrs.Position = UDim2.new(.93,5,-.1,0)
srvrs.BackgroundColor3 = Color3.new(.1,.1,.1)
srvrs.BackgroundTransparency = .5
srvrs.TextColor3 = Color3.new(1,0,0)
srvrs.TextStrokeTransparency = 1
srvrs.BorderSizePixel = 0
srvrs.TextScaled = true
srvrs.Text = "S"
srvrs.Activated:Connect(function()
	pcall(function()
		game.CoreGui["ServerBrowser"]:Destroy()
	end)
	loadstring(game:HttpGet('https://gist.githubusercontent.com/JellyJrl/894aec3c4cbf7a698339515656be7af9/raw/serverlist'))()
end)
local scorner = Instance.new("UICorner")
scorner.Parent = srvrs
scorner.CornerRadius = UDim.new(0,5)

local job = Instance.new("TextLabel")--addbutton({4, "Beerus", "TextButton", Color3.new(.5,0,.5)})
job.Parent = scgui
job.Name = "JobId"
job.Size = UDim2.new(.1225,0,0,30)
job.Position = UDim2.new(.8,0,-.1,0)
job.BackgroundColor3 = colortheme
job.BackgroundTransparency = .5
job.Font = Enum.Font.Gotham
job.TextStrokeTransparency = 1
job.TextColor3 = Color3.new(1,1,1)
job.TextScaled = true
job.TextSize = 30
job.Text = game.JobId
local jobcorner = Instance.new("UICorner")
jobcorner.Parent = job
jobcorner.CornerRadius = UDim.new(0,5)

if game.Workspace.Others.NPCs:FindFirstChild("Kid Nohag") then
	b.Text = "B"
	b.TextColor3 = Color3.new(1,0,1)
	b.Activated:Connect(function()
		game.ReplicatedStorage.Package.Events.TP:InvokeServer("Vills Planet")
	end)
else 
	b.Text = "E"
	b.TextColor3 = Color3.new(0,1,0)
	b.Activated:Connect(function()
		game.ReplicatedStorage.Package.Events.TP:InvokeServer("Earth")
	end)
end

fr32.Size = UDim2.new(.1,0,0,25*(#fr32:GetChildren()-3)-5)


local display = fr2.Display
local hp = fr2.HP
local quest = fr2.Quest
local zeni = fr2.Zeni
local fusion = fr2.Fusion
local formlbl = fr2.Formlbl
local CopyStats = fr2["Copy Stats"]
local View = fr2.View
local Teleport = fr2.Teleport
local pingL = fr3.Ping
local espH = fr3.ESPHighlight
local espL = fr3.ESPLabels
local Block = fr3.Block
local Abbreviate = fr3.Abbreviate
local Suicide = fr3.Suicide
local SpeedBox = fr3.FlySpeed
local Stack = fr3.Stack

L2_Offset = layout2.CellSize.Y.Offset
L2_Cushion = layout2.CellPadding.Y.Offset
fr2.Size = UDim2.new(1,-4,0,((L2_Offset+L2_Cushion)*(#fr2:GetChildren()-3))-5)

fr3.Size = UDim2.new(.1,0,0,(25*(#fr3:GetChildren()-3))-5)
fr32.Position = UDim2.new(.75,0,1,(-25*(#fr32:GetChildren()-3)+5)) -- Starting position, slides down

formlbl.Text = "Not Fused"

local f3p = fr3.Position -- Original Position
fr3.MouseEnter:Connect(function()
	game:GetService("TweenService"):Create(fr3, TweenInfo.new(.2), {Position = f3p + UDim2.new(0,0,0,-(25*(#fr3:GetChildren()-3)))}):Play()
end)
fr3.MouseLeave:Connect(function()
	game:GetService("TweenService"):Create(fr3, TweenInfo.new(.2), {Position = UDim2.new(.31,0,1,-20)}):Play()
end)
-- rainbow(object, property which)
rainbow(stroke1, "Color", rainbows)
rainbow(stroke2, "Color", rainbows)
rainbow(stroke3, "Color", rainbows)
rainbow(stroke32, "Color", rainbows)

--[[Teleport.Activated:Connect(function()
    local targetp = targetval.Value
    if targetp ~= nil and targetp ~= lplr and targetp.Character then
        local targetc = targetp.Character
        if not (targetc and lplr.Character) then return end
        local hrp = lplr.Character:FindFirstChild("HumanoidRootPart")
        if targetc:FindFirstChild("Head") and hrp then
            hrp.CFrame = targetc.Head.CFrame * CFrame.new(0,3,0)
            hrp.Velocity = Vector3.new(0,0,0)
            lplr.Character.Humanoid:ChangeState(14)
        end
    end
end)]]

Stack.MouseButton1Up:Connect(function()
	local form = lplr.Status:WaitForChild("Transformation").Value
	if form ~= "None" then
		game:GetService("ReplicatedStorage").Package.Events.equipskill:InvokeServer(form)
		game:GetService("ReplicatedStorage").Package.Events.ta:InvokeServer()
		-- unform
	end
	lplr.Character:BreakJoints()
	task.wait(5)

	game:GetService("ReplicatedStorage").Package.Events.equipskill:InvokeServer("Godly SSJ2")
	game:GetService("ReplicatedStorage").Package.Events.ta:InvokeServer()
	
	if ldata.Allignment.Value == "Evil" then
		game:GetService("ReplicatedStorage").Package.Events.equipskill:InvokeServer("Ultra Ego")
	else
		game:GetService("ReplicatedStorage").Package.Events.equipskill:InvokeServer("SSJBUI")
	end
	game:GetService("ReplicatedStorage").Package.Events.ta:InvokeServer()
end)

--Flyspeed
SpeedBox.FocusLost:Connect(function()
	if tonumber(SpeedBox.Text) then
		while tonumber(SpeedBox.Text) and _G.AY == r and task.wait() do
			while not lplr.Character:FindFirstChild("HumanoidRootPart") do wait() end
			local s = tonumber(SpeedBox.Text)
			if _G.Fast == true then
				lplr.Character.HumanoidRootPart.Anchored = false
				if s < 1e6 then -- If number is below 1M do that sps, otherwise do that stat speed
					getrenv()._G.FlightSpeed = s
					lplr.Character.Humanoid.WalkSpeed = s/1.5
				else
					getrenv()._G.FlightSpeed = 150 + (s^.2)
					lplr.Character.Humanoid.WalkSpeed = 150 + ((s^.2)/1.5)
				end
			end
		end
	else
		SpeedBox.Text = "FlySpeed"
	end
end)


CopyStats.Activated:Connect(function()
    local plr = game.Players:FindFirstChild(targetval.Value.Name)
    if plr then
        local data = game.ReplicatedStorage.Datas:WaitForChild(plr.UserId)
        local nam = "("..plr.Name..", "..plr.DisplayName..")"
        if plr.Name == plr.DisplayName then
            nam = "("..plr.Name..")"
        end
        local strength = format(data.Strength.Value)
        local zeni = format(data.Zeni.Value)
        local rebs = data.Rebirth.Value
        local rebst = rebs
        local stats = (data.Strength.Value + data.Speed.Value + data.Defense.Value + data.Energy.Value) / 4
        local statFormatted = format(stats)
        local health = format(plr.Character:WaitForChild("Humanoid").Health)
        
        local maxMastery = 332526
        local maxedTransformations = {}
        local transformations = { 
            'Divine Rose Prominence', 'Astral Instinct', 'Ultra Ego', 'SSJB4', 'True God of Creation', 
            'True God of Destruction', 'Super Broly', 'LSSJG', 'LSSJ4', 'SSJG4', 'LSSJ3', 'Mystic Kaioken', 
            'LSSJ Kaioken', 'SSJR3', 'SSJB3', 'God Of Destruction', 'God Of Creation', 'Jiren Ultra Instinct', 
            'Mastered Ultra Instinct', 'Godly SSJ2', 'Ultra Instinct Omen', 'Evil SSJ', 'Blue Evolution', 
            'Dark Rose', 'Kefla SSJ2', 'SSJ Berserker', 'True Rose', 'SSJB Kaioken', 'SSJ Rose', 
            'SSJ Blue', 'Corrupt SSJ', 'SSJ Rage', 'SSJG', 'SSJ4', 'Mystic', 'LSSJ', 'SSJ3', 
            'Spirit SSJ', 'SSJ2 Majin', 'SSJ2', 'SSJ Kaioken', 'SSJ', 'FSSJ', 'Kaioken'
        }

        for _, transformation in ipairs(transformations) do
            if data:FindFirstChild(transformation) and data[transformation].Value == maxMastery then
                table.insert(maxedTransformations, transformation)
            end
        end

        local transformationsText = ""
        if #maxedTransformations > 0 then
            transformationsText = " | Maxed: " .. table.concat(maxedTransformations, ", ")
        end

        local txt = "["..strength.."] ["..zeni.."] | "..nam..", Rebirths: "..rebst.." Stats: "..statFormatted.." ["..health.."]"..transformationsText
        setclipboard(txt)
    end
end)

_G.Down = nil
Teleport.MouseButton1Down:Connect(function()
	_G.Down = "One"
end)
Teleport.MouseButton1Up:Connect(function()
	_G.Down = nil
end)

function Mel()
local lplr = game.Players.LocalPlayer

local moves = { 
    "Super Dragon Fist", "God Slicer", "Spirit Barrage", "Mach Kick", "Wolf Fang Fist", 
    "High Power Rush", "Meteor Strike", "Meteor Charge", "Spirit Breaking Cannon", 
    "Vital Strike", "Flash Kick", "Vanish Strike", "Uppercut", "Sledgehammer", "Rock Impact" 
}

for _, move in ipairs(moves) do
    if not lplr:FindFirstChild("Status"):FindFirstChild(move) then
        game:GetService("ReplicatedStorage").Package.Events.mel:InvokeServer(move, "Blacknwhite27")
        game.ReplicatedStorage.Package.Events.voleys:InvokeServer("Energy Volley", {FaceMouse = false, MouseHit = CFrame.new()}, "Blacknwhite27")               
        game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer("Blacknwhite27")            
    end
end
end

spawn(function()
	while _G.AY == r do
		task.spawn(function()
			if _G.Down then
				local targetp = targetval.Value -- Player value
				if targetp ~= nil and targetp ~= lplr then
					local data = game.ReplicatedStorage:WaitForChild("Datas"):WaitForChild(targetp.UserId)
					local targetc = targetp.Character
					if not (targetc and lplr.Character) then task.wait() return end
					local hrp = lplr.Character:FindFirstChild("HumanoidRootPart")
					--task.spawn(function()
						if ldata.Quest.Value ~= data.Quest.Value and data.Quest.Value ~= "" then
							game:GetService("ReplicatedStorage").Package.Events.Qaction:InvokeServer(game.Workspace.Others.NPCs[data.Quest.Value])
							lplr.PlayerGui.Main.MainFrame.Frames.Quest.Visible = false
						end
					--end)
					task.spawn(function()
						if targetc:FindFirstChild("HumanoidRootPart") and hrp then
							if _G.Down == "One" then
								hrp.CFrame = targetc.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
								Mel()
							end
							hrp.Velocity = Vector3.new(0,0,0)
							lplr.Character.Humanoid:ChangeState(14)
						end
					end)
				end
			end
		end)
		task.wait()
	end
end)

local togglescgui = scgui.Parent:FindFirstChild("togglescgui") or Instance.new("ScreenGui")
togglescgui.Parent = scgui.Parent
togglescgui.Name = "togglescgui"
local ToggleGuiButton = scgui.Parent:FindFirstChild("ToggleGuiButton") or Instance.new("TextButton")--addbutton({4, "Beerus", "TextButton", Color3.new(.5,0,.5)})
ToggleGuiButton.Parent = togglescgui
ToggleGuiButton.Name = "ToggleGuiButton"
ToggleGuiButton.Size = UDim2.new(.05,0,0,30)
ToggleGuiButton.Position = UDim2.new(.2,0,0,-31)
ToggleGuiButton.BackgroundColor3 = colortheme
ToggleGuiButton.BackgroundTransparency = .5
ToggleGuiButton.Font = Enum.Font.Gotham
ToggleGuiButton.TextStrokeTransparency = 1
ToggleGuiButton.TextColor3 = Color3.new(1,1,1)
ToggleGuiButton.TextScaled = true
ToggleGuiButton.TextSize = 30
ToggleGuiButton.Text = "Hide GUI"
ToggleGuiButton.TextColor3 = Color3.new(1,1,1)
local toggleguicorner = Instance.new("UICorner")
toggleguicorner.Parent = ToggleGuiButton
toggleguicorner.CornerRadius = UDim.new(0,5)

ToggleGuiButton.Activated:Connect(function()
	if scgui.Enabled == true then  -- If visible, and want to hide
		pcall(function()
			find_iy().Enabled = false
		end)
		scgui.Enabled = false
		vL.Visible = true
		ToggleGuiButton.Text = "Show GUI"
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,true)
		game.CoreGui.Fernando.Enabled = false
		game.Players.LocalPlayer.PlayerGui:WaitForChild("Main").Enabled = true
	elseif scgui.Enabled == false then -- If hiding, and want to show
		scgui.Enabled = true		
		pcall(function()
			find_iy().Enabled = true
		end)
		vL.Visible = false
		ToggleGuiButton.Text = "Hide GUI"		
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)
		game.CoreGui.Fernando.Enabled = true
		game.Players.LocalPlayer.PlayerGui:WaitForChild("Main").Enabled = false
	end
end)

Suicide.MouseButton1Up:Connect(function()
    lplr.Character.UpperTorso:Destroy()
end)

local Viewing = Instance.new("ObjectValue")
Viewing.Parent = scgui
Viewing.Changed:Connect(function(val)
	if val == nil then return end
	local tplr = val
	while Viewing.Value == tplr and task.wait() and _G.AY == r do
		if s == lplr then Viewing.Value = nil return end
		while not tplr.Character do wait() end
		game.Workspace.CurrentCamera.CameraSubject = tplr.Character:WaitForChild("Humanoid")
	end
	if lplr.Status.Fused.Value == "None" then
		game.Workspace.CurrentCamera.CameraSubject = lplr.Character:WaitForChild("Humanoid")
	else
		game.Workspace.CurrentCamera.CameraSubject = game.Players[lplr.Status.Fused.Value].Character:WaitForChild("Humanoid")
	end
end)

View.Activated:Connect(function()
	local tplr = targetval.Value
	local v = Viewing.Value
	if Viewing.Value ~= tplr and tplr ~= lplr then -- If not viewing plr, and isn't lplr
		Viewing.Value = tplr
		View.Text = "UnView"
	elseif Viewing.Value == tplr and tplr ~= lplr then -- If alr viewing plr, and isnt lplr
		Viewing.Value = nil
		View.Text = "View"
	elseif Viewing.Value ~= tplr and tplr == lplr then -- If not viewing yourself
		Viewing.Value = nil
		View.Text = "Viewing Yourself"
	elseif Viewing.Value == tplr and tplr == lplr then -- You're already viewing yourself
	end
end)

function getchr(plr)
	return plr.Character
end

-- ESPh
_G.esph = false
if _G.esph == true then
	espH.Text = "Disable ESPH"
else
	espH.Text = "Enable ESPH"
end

function ESPH()
	if _G.esph == true then
		_G.esph = false
		espH.Text = "Enable ESPH"
		for i,gui in pairs(espdirectory:GetChildren()) do
			--gui.Enabled = false
			gui.Highlight.Enabled = false
		end
	elseif _G.esph == false then
		_G.esph = true
		espH.Text = "Disable ESPH"
		for i,gui in pairs(espdirectory:GetChildren()) do
			--gui.Enabled = true
			gui.Highlight.Enabled = true
		end
	end
end
espH.MouseButton1Up:Connect(function()
	ESPH()
end)

-- ESPh
_G.espl = true
if _G.esp == true then
	espL.Text = "Disable ESPL"
else
	espL.Text = "Enable ESPL"
end

function ESPL()
	if _G.espl == true then
		_G.espl = false
		espL.Text = "Enable ESPL"
		for i,gui in pairs(espdirectory:GetChildren()) do
			gui.Enabled = false
			--gui.Highlight.Enabled = false
		end
	elseif _G.espl == false then
		_G.espl = true
		espL.Text = "Disable ESPL"
		for i,gui in pairs(espdirectory:GetChildren()) do
			gui.Enabled = true
			--gui.Highlight.Enabled = true
		end
	end
end
espL.MouseButton1Up:Connect(function()
	ESPL()
end)

--Stat abbreviations
_G.Abv = false
if _G.Abv == true then
	Abbreviate.Text = "UnAbbreviate"
else 
	Abbreviate.Text = "Abbreviate"
end
function abv()
	if _G.Abv == false then
		_G.Abv = true
		Abbreviate.Text = "UnAbbreviate"
	else 
		_G.Abv = false
		Abbreviate.Text = "Abbreviate"
	end
end
Abbreviate.MouseButton1Up:Connect(function()
	abv()
end)

--Block
function block()
	if not (lplr.Character and lplr.Status:FindFirstChild("Blocking")) then return end
	game:GetService("ReplicatedStorage").Package.Events.block:InvokeServer(true)
end
Block.MouseButton1Up:Connect(function()
	block()
end)

targetval = Instance.new("ObjectValue")-- This will change when you click on a player's label, and open frame 2
targetval.Changed:Connect(function()
	if _G.AY ~= r then return end
	if targetval.Value ~= nil then
		if Viewing.Value ~= targetval.Value and targetval.Value ~= lplr then
			View.Text = "View"
		elseif Viewing.Value == targetval.Value and targetval.Value ~= lplr then
			View.Text = "UnView"
		elseif Viewing.Value == nil and targetval.Value == lplr then
			View.Text = "Viewing Yourself"
		elseif Viewing.Value ~= targetval.Value and targetval.Value == lplr then
			View.Text = "View Yourself"
		end
	end
	local target = targetval.Value
	local plr = target
	if target ~= nil then
		game:GetService("TweenService"):Create(fr2, TweenInfo.new(.3), {Position = UDim2.new(0,2,0,4)}):Play()
		local data = game.ReplicatedStorage.Datas:WaitForChild(target.UserId)
		while target == targetval.Value and game.Players:FindFirstChild(target.Name) and _G.AY == r do
			if not target.Character then
				for i,plr in pairs(game.Players:GetChildren()) do -- Looks for all characters that exist 
					-- If this is a plr chr, and has fusion value, 
					if plr:WaitForChild("Status"):FindFirstChild("Fused") then
						if plr.Status.Fused.Value == target.Name then
							hp.Text = "Fused with "..plr.Name
							fusion.Text = "Fused with "..plr.Name
						end 
					end 
				end 
			elseif target.Character and target.Character:FindFirstChild("HumanoidRootPart") and target.Character:FindFirstChild("Humanoid") then
				local st = plr:FindFirstChild("Status")
				if st then
					local fused = st.Fused.Value
					if fused ~= "None" and workspace.Living:FindFirstChild(fused) then -- If not unfused, and this value is a string
						hp.Text = "Fused with "..fused
					else
						hp.Text = "HP: "..format(target.Character.Humanoid.Health).."/"..format(target.Character.Humanoid.MaxHealth)
					end
					if fused ~= "None" then
						fusion.Text = "Fused with "..fused
					else
						fusion.Text = "Not Fused"
					end
					local form = plr.Status:WaitForChild("Transformation").Value
					if form ~= "None" then
						formlbl.Text = form
					else 
						formlbl.Text = "No Form"
					end
				else
					hp.Text = "HP: "..format(target.Character.Humanoid.Health).."/"..format(target.Character.Humanoid.MaxHealth)
					fusion.Text = "Not loaded"
					formlbl.Text = "Not loaded"
				end
			end
			--"<b><font color='rgb(0,0,0)'>", "</font></b>"
			display.RichText = true
			display.Text = target.Name
			display.TextColor3 = Color3.new(1,0,0)
			if data.Allignment.Value == "Good" then
				display.TextColor3 = Color3.fromRGB(150,150,255)
			end
			zeni.Text = "Zeni: "..format(data.Zeni.Value)
			local qval = data.Quest.Value
			if qval == "" then
				quest.Text = "No Quest"
			else
				quest.Text = "Quest: "..qval
			end
			task.wait()
		end
	else 
		game:GetService("TweenService"):Create(fr2, TweenInfo.new(.3), {Position = UDim2.new(1,4,0,4)}):Play()
		wait(.3)
	end
end)

local numplrs = Instance.new("TextLabel")
numplrs.Parent = scgui
numplrs.Size = UDim2.new(.4,0,0,36)
numplrs.Position = UDim2.new(.3,0,-.1,0)
numplrs.BackgroundTransparency = 1
numplrs.Font = Enum.Font.Gotham
numplrs.TextColor3 = Color3.new(1,1,1)
numplrs.TextStrokeColor3 = Color3.new(.2,.2,.2)
numplrs.TextStrokeTransparency = 0
numplrs.TextSize = 30

local formmastery = Instance.new("TextLabel")
formmastery.Parent = scgui
formmastery.Size = UDim2.new(.04,0,0,36)
formmastery.Position = UDim2.new(.55,0,-.1,0)
formmastery.BackgroundTransparency = 1
formmastery.Font = Enum.Font.Gotham
formmastery.TextColor3 = Color3.new(1,1,1)
formmastery.TextStrokeColor3 = Color3.new(.2,.2,.2)
formmastery.TextStrokeTransparency = 0
formmastery.TextSize = 15

function find_iy()
	for i,v in pairs(game.CoreGui:GetDescendants()) do
		if v:FindFirstChild("SettingsButton") then
			return v:FindFirstAncestorOfClass("ScreenGui")
		end
	end
end

-- Key Inputs
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(key)
	if _G.AY ~= r then return end
	if key.KeyCode == Enum.KeyCode.KeypadOne then -- Disable ESP and the gui
		if scgui.Enabled == true then 
			pcall(function()
				find_iy().Enabled = false
			end)
			scgui.Enabled = false
			vL.Visible = true
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,true)
		elseif scgui.Enabled == false then 
			scgui.Enabled = true
			pcall(function()
				find_iy().Enabled = true
			end)
			vL.Visible = false
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)
		end
	end
	if key.KeyCode == Enum.KeyCode.KeypadTwo then block() end -- Block
	if key.KeyCode == Enum.KeyCode.KeypadSeven then abv() end -- Abbreviate
	if key.KeyCode == Enum.KeyCode.KeypadEight then ESPL()  end -- ESP Labels
	if key.KeyCode == Enum.KeyCode.KeypadNine then ESPH()  end -- ESP Highlights
	if key.KeyCode == Enum.KeyCode.LeftShift then _G.Fast = true  end -- Fast Fly
	if key.KeyCode == Enum.KeyCode.X then
		if lplr.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame:WaitForChild("ChatBar"):IsFocused() then return end
		charging = true
		while charging and _G.AY == r do game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer("Blacknwhite27") task.wait() end
	end
end)

game:GetService("UserInputService").InputEnded:Connect(function(key)
	if _G.AY ~= r then return end
	if key.KeyCode == Enum.KeyCode.LeftShift then -- Stop fast fly
		_G.Fast = false
	end
	if key.KeyCode == Enum.KeyCode.X then
		if not table.find(alts, lplr.Name) then return end
		if lplr.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame:WaitForChild("ChatBar"):IsFocused() then return end
		charging = false
	end
end)


local rebcolors = { -- >Rebs, Textcolor
	{50000,Color3.fromRGB(255,255,255), "<i><font color='rgb(255,255,255)'>", "</font></i>"}, -- Italic 
	{33333,Color3.fromRGB(0,0,0), "<b><font color='rgb(0,0,0)'>", "</font></b>"}, -- Bold Black
	{20000,Color3.fromRGB(255,255,255), "<i><b><font color='rgb(255,255,255)'>", "</font></b></i>"}, -- Bold Italic White with fast rainbow outline
	{10000,Color3.fromRGB(0,0,0), "<i><b><font color='rgb(0,0,0)'>", "</font></b></i>"}, -- Bold Italic Black with slow rainbow outline
	{5000,Color3.fromRGB(0,255,255), "<b><font color='rgb(0,255,255)'>", "</font></b>"}, -- Bolded Teal
	{2500,Color3.fromRGB(255,0,0), "<b><font color='rgb(255,0,0)'>", "</font></b>"}, -- Bolded Red
	{1000,Color3.fromRGB(255,200,0), "<b><font color='rgb(255,200,0)'>", "</font></b>"}, -- Bolded Orange
	{100,Color3.fromRGB(255,255,255), "<font color='rgb(255,255,255)'>", "</font>"}, -- White
	{3,Color3.fromRGB(0,150,0), "<font color='rgb(0,200,0)'>", "</font>"}, -- Forest Green
	{0,Color3.fromRGB(100,100,100), "<font color='rgb(100,100,100)'>", "</font>"}, -- Gray
}
local statcolors = {
	{1e16,Color3.fromRGB(255,0,255), "<i><b><font color='rgb(255,0,255)'>", "</font></b></i>"}, -- 10qd+ Purple with thin black outline
	{1e15,Color3.fromRGB(255,255,255), "<i><b><font color='rgb(255,255,255)'>", "</font></b></i>"}, -- 1qd+ White with fast rainbow outline
	{1e14,Color3.fromRGB(0,0,0), "<i><b><font color='rgb(0,0,0)'>", "</font></b></i>"}, --- 100T - 1qd Black with slow rainbow outline
	{1e13,Color3.fromRGB(0,255,255), "<i><b><font color='rgb(0,255,255)'>", "</font></b></i>"}, -- 10T - 100T Cyan
	{1e12,Color3.fromRGB(255,0,0), "<i><b><font color='rgb(255,0,0)'>", "</font></b></i>"}, -- 1T - 10T Red
	{1e11,Color3.fromRGB(75,75,255), "<b><font color='rgb(75,75,255)'>", "</font></b>"}, -- 100B - 1T Blue
	{1e9,Color3.fromRGB(250,255,0), "<b><font color='rgb(255,255,0)'>", "</font></b>"}, -- 1B - 100B Yellow
	{1e8,Color3.fromRGB(255,255,255), "<font color='rgb(255,255,255)'>", "</font>"}, -- 100M - 1B White
	{1e6,Color3.fromRGB(0,150,0), "<font color='rgb(0,200,0)'>", "</font>"}, -- 1M - 100M Green
	{0,Color3.fromRGB(100,100,100), "<font color='rgb(100,100,100)'>", "</font>"},-- 0 - 1M gray
}


local labels = { -- Name, XSize, XPos
	{"Rebs",.2,0},
	{"PlrName",.6,.2},
	{"Stats",.2,.79},
}

local function esp(plr)
	if _G.AY ~= r then return end
	while not (plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.MaxHealth ~= 413) do
		if _G.AY ~= r then return end
		wait()
	end
	local sgui = espdirectory:FindFirstChild("ESP_"..plr.Name)
	if not (sgui and sgui:FindFirstChild("Lbl")) then
		local chr = plr.Character
		local espgui = Instance.new("BillboardGui")
		espgui.Parent = espdirectory
		local sgui = espdirectory:FindFirstChild("ESP_"..plr.Name)
		if sgui then 
			espgui:Destroy() 
			espgui = sgui
		end
		espgui.Name = "ESP_"..plr.Name
		espgui.Adornee = chr:WaitForChild("Head")
		espgui.MaxDistance = math.huge
		espgui.Size = UDim2.new(0,100,0,150)
		espgui.ZIndexBehavior = "Global"
		espgui.StudsOffset = Vector3.new(0,3,0)
		espgui.ResetOnSpawn = false
		espgui.AlwaysOnTop = true
		local Lbl = Instance.new("TextLabel")
		if _G.espl == false then
			espgui.Enabled = false
		end
		Lbl.Parent = espgui
		Lbl.Name = "Lbl"
		Lbl.Position = UDim2.new(0,-150,0,-50)
		Lbl.Size = UDim2.new(0,400,0,100)
		Lbl.TextSize = 20
		Lbl.BackgroundTransparency = 1
		Lbl.TextStrokeTransparency = 1
		Lbl.Font = Enum.Font.Gotham
		Lbl.RichText = true
		Lbl.ZIndex = 10
		Lbl.TextYAlignment = "Bottom"
		local hi = Instance.new("Highlight")
		if _G.esph == false then
			hi.Enabled = false
		end
		hi.Parent = espgui
		hi.FillTransparency = .6 
		hi.OutlineTransparency = 0
		--hpbar
		local hpbar = Instance.new("Frame")
		hpbar.Parent = espgui
		hpbar.Name = "green"
		hpbar.Size = UDim2.new(0,100,0,2)
		hpbar.Position = UDim2.new(0,0,0,60)
		hpbar.BackgroundColor3 = Color3.new(1,0,0)
		hpbar.BorderSizePixel = 0
		local green = Instance.new("Frame")
		green.Parent = hpbar
		green.Name = "bar"
		green.Size = UDim2.new(1,0,0,2)
		green.Position = UDim2.new(0,0,0,0)
		green.BackgroundColor3 = Color3.new(0,1,0)
		green.BorderSizePixel = 0
		--kibar
		local kibar = Instance.new("Frame")
		kibar.Parent = espgui
		kibar.Name = "blue"
		kibar.Size = UDim2.new(0,100,0,2)
		kibar.Position = UDim2.new(0,0,0,65)
		kibar.BackgroundColor3 = Color3.new(.15,.15,.15)
		kibar.BorderSizePixel = 0
		local blue = Instance.new("Frame")
		blue.Parent = kibar
		blue.Name = "bar"
		blue.Size = UDim2.new(1,0,0,2)
		blue.Position = UDim2.new(0,0,0,0)
		blue.BackgroundColor3 = Color3.new(0,.5,1)
		blue.BorderSizePixel = 0
	end
	task.wait()
	local sgui = espdirectory:FindFirstChild("ESP_"..plr.Name)
	pcall(function()
		sgui.Adornee = plr.Character:WaitForChild("Head")
	end)
	local hi = sgui.Highlight
	hi.Adornee = plr.Character
	if _G.esph == true then 
		hi.Enabled = true 
	else 
		hi.Enabled = false 
	end
	local Lbl = sgui.Lbl
	local data = plr.Character:WaitForChild("Stats")
	local function avg()
		return (data.Strength.Value + data.Speed.Value + data.Defense.Value + data.Energy.Value) / 4
	end
	local function rebs()
		return data.Rebirth.Value
	end
	local function statcolor()
		for i,v in pairs(statcolors) do
			if avg() >= v[1] then
				return {v[3],v[4],v[2]}
			end
		end
	end
	local function rebcolor()
		for i,v in pairs(rebcolors) do
			if rebs() >= v[1] then
				return {v[3],v[4],v[2]}
			end
		end
	end
	local function getname()
		if plr.Name == plr.DisplayName then
			return "("..plr.Name..")"
		else
			return "("..plr.Name..", "..plr.DisplayName..")"
		end
	end
	local rc = rebcolor()
	local sc = statcolor()
	local nam = getname()
	local hum = plr.Character:WaitForChild("Humanoid")

	if rebs() >= 100000 then
		Lbl.Font = Enum.Font.SpecialElite
		Lbl.TextSize = 20

		Lbl.TextColor3 = Color3.new(1,1,1)
		local grad = Lbl:FindFirstChild("UIGradient") or Instance.new("UIGradient",Lbl)
		grad.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Color3.new(.5,.5,1)),
			ColorSequenceKeypoint.new(.5, Color3.new(0,0,1)),
			ColorSequenceKeypoint.new(1, Color3.new(.5,.5,1)),
		}
		if Lbl.TextStrokeTransparency ~= 0 then
			Lbl.TextStrokeTransparency = 0
			rainbow(Lbl, "TextStrokeColor3", rainbows)
		end
	elseif rebs() >= 50000 then
		hi.FillTransparency = 0
		hi.FillColor = Color3.new(.5,.5,.5)
		hi.OutlineColor = Color3.new(1,0,1)
		Lbl.TextStrokeTransparency = .5
		Lbl.TextTransparency = 0
		Lbl.TextColor3 = Color3.new(1,1,1)
		Lbl.TextStrokeColor3 = Color3.new(1,0,1)
		Lbl.Font = Enum.Font.GothamBold
		Lbl.TextSize = 20
		local grad = Lbl:FindFirstChild("UIGradient") or Instance.new("UIGradient",Lbl)
		grad.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Color3.new(1,1,1)),
			ColorSequenceKeypoint.new(.5, Color3.new(1,0,1)),
			ColorSequenceKeypoint.new(1, Color3.new(.3,.3,.3)),
		}

		grad.Rotation = 0
        rc = {"<i>","</i>",Color3.new(1,0,1)} -- Fill
		sc = {"<i>","</i>",Color3.new(0,0,0)} -- Outline
	elseif rebs() >= 33333 then
		hi.FillTransparency = 0
		hi.FillColor = Color3.new(0,0,0)
		hi.OutlineColor = Color3.new(1,1,1)
		Lbl.TextStrokeTransparency = 0
		Lbl.TextTransparency = 0
		Lbl.TextStrokeColor3 = Color3.new(1,1,1)
		rc = {"<b>","</b>",Color3.new(0,0,0)} -- Fill
		sc = {"<b>","</b>",Color3.new(1,1,1)} -- Outline
	elseif avg() >= 1e15 then
		if Lbl.TextStrokeTransparency ~= 0 then 
			Lbl.TextStrokeTransparency = 0
			spawn(function()
				while avg() >= 1e15 and task.wait(.1) and _G.AY == r do
					game:GetService("TweenService"):Create(Lbl, TweenInfo.new(.1), {TextStrokeColor3 = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))}):Play()
					game:GetService("TweenService"):Create(hi, TweenInfo.new(.1), {OutlineColor = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))}):Play()
				end
				Lbl.TextStrokeTransparency = 1
			end)
		end
	elseif avg() >= 1e14 then
		if Lbl.TextStrokeTransparency ~= 0 then
			Lbl.TextStrokeTransparency = 0
			spawn(function()
				while avg() >= 1e14 and task.wait(.5) and _G.AY == r do 
					game:GetService("TweenService"):Create(Lbl, TweenInfo.new(.5), {TextStrokeColor3 = c}):Play()
					game:GetService("TweenService"):Create(hi, TweenInfo.new(.5), {OutlineColor = c}):Play()
				end
				Lbl.TextStrokeTransparency = 1
			end)
		end
	else 
		if rebs() < 10000 then
			Lbl.TextStrokeTransparency = 1
		end
		hi.OutlineColor = sc[3]
	end
	if rebs() >= 33333 then
	elseif rebs() >= 20000 then 
		if math.floor(hi.FillTransparency*10)/10 ~= .4 then
			hi.FillTransparency = .4
			Lbl.TextStrokeTransparency = 0
			task.spawn(function()
				while rebs() < 33333 and task.wait(.1) and _G.AY == r do 
					game:GetService("TweenService"):Create(Lbl, TweenInfo.new(.1), {TextStrokeColor3 = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))}):Play()
					game:GetService("TweenService"):Create(hi, TweenInfo.new(.1), {FillColor = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))}):Play()
				end
				hi.FillTransparency = 1
				Lbl.TextStrokeTransparency = 1
			end)
		end
	elseif rebs() >= 10000 then
		if math.floor(hi.FillTransparency*10)/10 ~= .5 then
			task.spawn(function()
				while rebs() < 20000 and task.wait(.5) and _G.AY == r do 
					hi.FillTransparency = .5
					Lbl.TextStrokeTransparency = 0
					game:GetService("TweenService"):Create(Lbl, TweenInfo.new(.5), {TextStrokeColor3 = c}):Play()
					game:GetService("TweenService"):Create(hi, TweenInfo.new(.5), {FillColor = c}):Play()
				end 
				hi.FillTransparency = 1
				Lbl.TextStrokeTransparency = 1
			end)
		end
	else
		hi.FillColor = rc[3]
	end
	Lbl.Text = rc[1]..format2(data.Rebirth.Value).." "..plr.DisplayName.." | "..rc[2]..sc[1]..format(avg()).." | "..format(hum.Health).."/"..format(hum.MaxHealth)..sc[2]
end

function iterPageItems(pages)
	return coroutine.wrap(function()
		local pagenum = 1
		while true do
			for _, item in ipairs(pages:GetCurrentPage()) do
				coroutine.yield(item, pagenum)
			end
			if pages.IsFinished then
				break
			end
			pages:AdvanceToNextPageAsync()
			pagenum = pagenum + 1
		end
	end)
end
local friendPages = game.Players:GetFriendsAsync(lplr.UserId)
local usernames = {}
for item, pageNo in iterPageItems(friendPages) do
	table.insert(usernames, item.Username)
end

-- Add a player
function addplr(plr)
	while not game.ReplicatedStorage.Datas:FindFirstChild(plr.UserId) do wait() end
	-- If target is hidden and plr not bypassed then hide
	local data = game.ReplicatedStorage.Datas:WaitForChild(plr.UserId)
	while not (
		data:FindFirstChild("Strength") and
			data:FindFirstChild("Rebirth") and
			data:FindFirstChild("Zeni")) do 
		wait() 
	end
	local avg = (data.Strength.Value + data.Speed.Value + data.Defense.Value + data.Energy.Value) / 4

	local button = Instance.new("TextButton")
	button.Parent = fr12
	local bcorner = Instance.new("UICorner")
	bcorner.Parent = button
	bcorner.CornerRadius = corner
	button.BorderSizePixel = 0
	button.Visible = true
	

	button.Size = UDim2.new(.9,0,1/18,0)
	button.Name = plr.Name
	button.TextScaled = false
	button.TextSize = 10
	button.RichText = true
	button.BackgroundColor3 = colortheme--Color3.new(0,0,0)

	button.Font = Enum.Font.Gotham
	button.BorderSizePixel = 0
	button.BackgroundTransparency = .5
	button.TextTransparency = 1
	button.Activated:Connect(function()
		if targetval.Value == plr then 
			targetval.Value = nil
		else
			targetval.Value = plr
		end
	end)
	button.MouseButton2Up:Connect(function()
		button.Visible = false
		wait(8)
		if button then button.Visible = true end
	end)

    local hpbar = Instance.new("Frame",button)
    hpbar.Size = UDim2.new(1,-2,0,2)
    hpbar.BackgroundColor3 = Color3.new(0,1,0)
    hpbar.BackgroundTransparency = .5
    hpbar.BorderSizePixel = 0
    hpbar.Position = UDim2.new(0,.5,0,0)
    hpbar.ZIndex = 1
    local hpcorner = Instance.new("UICorner",hpbar)
    hpcorner.CornerRadius = corner

	local avgval = Instance.new("NumberValue")
	avgval.Parent = button
	avgval.Name = "Avg"
	avgval.Value = (data.Strength.Value + data.Speed.Value + data.Defense.Value + data.Energy.Value) / 4
	local rebsval = Instance.new("NumberValue")
	rebsval.Parent = button
	rebsval.Name = "Rebs"
	rebsval.Value = data.Rebirth.Value

	task.spawn(function()esp(plr)end)
	local function addchr(chr)
		if _G.AY ~= r then return end
		local sgui = espdirectory:WaitForChild("ESP_"..plr.Name)
		local greenbar = sgui.green.bar
		local bluebar = sgui.blue.bar
		local Ki = chr:WaitForChild("Stats"):WaitForChild("Ki")
		local hum = chr:WaitForChild("Humanoid")
		if data.Allignment.Value == "Good" then
			bluebar.BackgroundColor3 = Color3.new(0,.5,1)
		else
			bluebar.BackgroundColor3 = Color3.new(1,0,1)
		end
		sgui.Adornee = chr.Head
		sgui.Highlight.Adornee = chr
		if plr == lplr then
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)
		end
		esp(plr)
		game:GetService("TweenService"):Create(greenbar , TweenInfo.new(1), {Size = UDim2.new(0,100/(hum.MaxHealth/hum.Health),0,2)}):Play()
		game:GetService("TweenService"):Create(bluebar , TweenInfo.new(1), {Size = UDim2.new(0,100*(Ki.Value/Ki.MaxValue),0,2)}):Play()
        game:GetService("TweenService"):Create(hpbar, TweenInfo.new(1), {Size = UDim2.new(hum.Health/hum.MaxHealth,-1,0,2)}):Play()
		pcall(function()
			Ki.Changed:Connect(function()
				if _G.AY ~= r then return end
				game:GetService("TweenService"):Create(bluebar , TweenInfo.new(1), {Size = UDim2.new(0,100*(Ki.Value/Ki.MaxValue),0,2)}):Play()
			end)
		end)
		hum.HealthChanged:Connect(function()
			if _G.AY ~= r then return end
			game:GetService("TweenService"):Create(greenbar , TweenInfo.new(1), {Size = UDim2.new(0,100/(hum.MaxHealth/hum.Health),0,2)}):Play()
			game:GetService("TweenService"):Create(bluebar , TweenInfo.new(1), {Size = UDim2.new(0,100*(Ki.Value/Ki.MaxValue),0,2)}):Play()
            game:GetService("TweenService"):Create(hpbar, TweenInfo.new(1), {Size = UDim2.new(hum.Health/hum.MaxHealth,-1,0,2)}):Play()
			esp(plr) 
		end)
	end
    plr.CharacterAdded:Connect(function(chr)
        if _G.AY == r then
            if plr == lplr then
                game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)
            end
            addchr(chr)
        end
    end)

	if plr.Character then
		task.spawn(function()addchr(plr.Character)end)
	end

	for i,lblval in pairs(labels) do
		local l = Instance.new("TextLabel")
		l.Parent = button
		l.Name = lblval[1]
		l.Size = UDim2.new(lblval[2],0,1,0)
		l.Position = UDim2.new(lblval[3],0,0,0)
		l.TextColor3 = Color3.new(.1,.1,.1)
		l.BackgroundTransparency = 1
		l.TextScaled = false 
		l.TextSize = 15
		l.RichText = true
		l.Font = Enum.Font.Gotham
		l.BorderSizePixel = 0
		l.TextStrokeTransparency = 1

		if lblval[1] == "Rebs" then
			local t1 = tick()
			l.TextXAlignment = "Left"
			l.TextSize = 18
			function update()
				if _G.AY ~= r then return end
				spawn(function() esp(plr) end)
				local rebs = data.Rebirth.Value
				rebsval.Value = rebs
				if rebs >= 1000 then
					l.Text = "<b>"..format2(rebs).."</b>"
				else
					l.Text = rebs
				end
                if rebs >= 100000 then
                    l.Text = rebs
                    l.Font = Enum.Font.SpecialElite
                    l.TextSize = 20
                    l.TextColor3 = Color3.new(1,1,1)
                    local grad = Instance.new("UIGradient",l)
                    grad.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.new(.5,.5,1)),
                        ColorSequenceKeypoint.new(.5, Color3.new(0,0,1)),
                        ColorSequenceKeypoint.new(1, Color3.new(.5,.5,1)),
                    }
                    if l.TextStrokeTransparency ~= 0 then
                        l.TextStrokeTransparency = 0
                        rainbow(l, "TextStrokeColor3", rainbows)
                    end
                elseif rebs >= 50000 then
                    l.Font = Enum.Font.GothamBold
                    l.TextSize = 20
                    l.TextColor3 = Color3.new(1,1,1)
                    if l.TextStrokeTransparency ~= 0 then
                        l.TextStrokeTransparency = 0 
                        local grad = Instance.new("UIGradient",l)
                        grad.Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.new(1,1,1)),
                            ColorSequenceKeypoint.new(.5, Color3.new(1,0,1)),
                            ColorSequenceKeypoint.new(1, Color3.new(0,0,0)),
                        }
                        grad.Rotation = -85
                    end
                elseif rebs >= 33333 then
                    l.TextStrokeTransparency = 0 
                    l.TextColor3 = Color3.new(0,0,0)
                    l.TextStrokeColor3 = Color3.new(1,1,1)
                elseif rebs >= 20000 then
                    if l.TextStrokeTransparency ~= 0 then
                        l.TextStrokeTransparency = 0
                        spawn(function()
                            while data:WaitForChild("Rebirth").Value < 33333 and task.wait(.1) do
                                game:GetService("TweenService"):Create(l, TweenInfo.new(.1), {TextStrokeColor3 = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))}):Play()
                            end
                            l.TextStrokeTransparency = 1
                        end)
                    end
                elseif rebs >= 10000  then
                    if l.TextStrokeTransparency ~= 0 then
                        l.TextStrokeTransparency = 0
                        spawn(function()
                            while data.Rebirth.Value < 20000 and task.wait(.5) do
                                game:GetService("TweenService"):Create(l, TweenInfo.new(.5), {TextStrokeColor3 = c}):Play()
                            end
                            l.TextStrokeTransparency = 1
                        end)
                    end
                elseif rebs < 10000 then
                    l.TextStrokeTransparency = 1
                end
                if rebs < 33333 then
                    for i,v in pairs(rebcolors) do
                        if rebs >= v[1] then
                            l.TextColor3 = v[2]
                            break
                        end
                    end
                end
			end
			while not data:FindFirstChild("Rebirth") do wait() end
			data:WaitForChild("Rebirth").Changed:Connect(update)
			update()
		elseif lblval[1] == "PlrName" then
			l.TextXAlignment = "Center"
		elseif lblval[1] == "Stats" then
			l.TextXAlignment = "Right"
			local plrnamelbl = button.PlrName
			l.TextSize = 15
			function update()
				if _G.AY ~= r then return end
				local avg = (data.Strength.Value + data.Speed.Value + data.Defense.Value + data.Energy.Value) / 4
				avgval.Value = avg
				if plr.Character and espdirectory then
					spawn(function() esp(plr) end)
				end
				button.LayoutOrder = -(math.sqrt(avg))
                if data.Rebirth.Value >= 33333 and data.Rebirth.Value < 50000 then
                    l.TextColor3 = Color3.new(0,0,0)
                    l.TextStrokeColor3 = Color3.new(1,1,1)
                    l.TextStrokeTransparency = 0
                    plrnamelbl.TextColor3 = Color3.new(0,0,0)
                    plrnamelbl.TextStrokeColor3 = Color3.new(1,1,1)
                    plrnamelbl.TextStrokeTransparency = 0
                elseif avg >= 1e16 or data.Rebirth.Value >= 33333 then
                else
                    for i,v in pairs(statcolors) do
                        if avg >= v[1] then
                            l.TextColor3 = v[2]
                            plrnamelbl.TextColor3 = v[2]
                            break
                        end
                    end
                end
				local friend = ""
				if table.find(usernames, plr.Name) then friend = " 😎 " end
				if data.Rebirth.Value >= 100000 then
					l.Font = Enum.Font.SpecialElite
					l.TextSize = 15
					l.Text = format(avg)
					l.TextColor3 = Color3.new(1,1,1)
					plrnamelbl.Font = Enum.Font.SpecialElite
					plrnamelbl.TextSize = 20
					plrnamelbl.Text = plr.Name
					plrnamelbl.TextColor3 = Color3.new(1,1,1)
					local grad = l:FindFirstChild("UIGradient") or Instance.new("UIGradient",l)
					grad.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.new(.5,.5,1)),
						ColorSequenceKeypoint.new(.5, Color3.new(0,0,1)),
						ColorSequenceKeypoint.new(1, Color3.new(.5,.5,1)),
					}
					if l.TextStrokeTransparency ~= 0.1 then
						l.TextStrokeTransparency = 0.1
						rainbow(l, "TextStrokeColor3", rainbows)
					end
					local grad = plrnamelbl:FindFirstChild("UIGradient") or Instance.new("UIGradient",plrnamelbl)
					grad.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.new(.5,.5,1)),
						ColorSequenceKeypoint.new(.5, Color3.new(0,0,1)),
						ColorSequenceKeypoint.new(1, Color3.new(.5,.5,1)),
					}
					if plrnamelbl.TextStrokeTransparency ~= 0.1 then
						plrnamelbl.TextStrokeTransparency = 0.1
						rainbow(plrnamelbl, "TextStrokeColor3", rainbows)
					end
				elseif avg >= 1e16 then
					if l.TextStrokeTransparency ~= 0 then
						l.TextColor3 = Color3.new(1,1,1)
						l.TextStrokeTransparency = 0 
						l.TextSize = 20
						l.Font = Enum.Font.GothamBold
						l.Text = format(avg)
						local grad = Instance.new("UIGradient",l)
						grad.Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.new(1,1,1)),
							ColorSequenceKeypoint.new(.5, Color3.new(1,0,1)),
							ColorSequenceKeypoint.new(1, Color3.new(0,0,0)),
						}
						grad.Rotation = 85
						plrnamelbl.TextColor3 = Color3.new(1,1,1)
						plrnamelbl.TextStrokeTransparency = 0
						plrnamelbl.Font = Enum.Font.GothamBold
						plrnamelbl.Text = plr.DisplayName
						plrnamelbl.TextSize = 20
						local grad = Instance.new("UIGradient",plrnamelbl)
						grad.Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.new(1,1,1)),
							ColorSequenceKeypoint.new(.5, Color3.new(1,0,1)),
							ColorSequenceKeypoint.new(1, Color3.new(0,0,0)),
						}
						grad.Rotation = 85
					end
                elseif avg >= 1e12 then
					if plr.Name == plr.DisplayName then
						plrnamelbl.Text = "<b><i>"..friend..""..plr.Name..friend.."</i></b>"
					else
						plrnamelbl.Text = "<b><i>"..friend..plr.DisplayName..friend.."\n<font size='10'>@"..plr.Name.."</font></i></b>"
					end
					l.Text = "<b><i>"..format(avg).."</i></b>"
					if data.Rebirth.Value < 33333 then
						if avg >= 1e15  then
							l.TextStrokeTransparency = 0
							plrnamelbl.TextStrokeTransparency = 0
							rainbow(l, "TextStrokeColor3", rainbows2)
							rainbow(plrnamelbl, "TextStrokeColor3", rainbows2)
						elseif avg >= 1e14 then
							l.TextStrokeTransparency = 0
							plrnamelbl.TextStrokeTransparency = 0
							rainbow(l, "TextStrokeColor3", rainbows)
							rainbow(plrnamelbl, "TextStrokeColor3", rainbows)
						else
							l.TextStrokeTransparency = 1
							plrnamelbl.TextStrokeTransparency = 1
						end

					end
				elseif avg >= 1e9 then
					if plr.Name == plr.DisplayName then
						plrnamelbl.Text = "<b>"..friend..""..plr.Name..friend.."</b>"
					else
						plrnamelbl.Text = "<b>"..friend..plr.DisplayName..friend.."\n<font size='10'>@"..plr.Name.."</font></b>"
					end
					l.Text = "<b>"..format(avg).."</b>"
				else
					l.Text = format(avg)
					if plr.Name == plr.DisplayName then
						plrnamelbl.Text = friend..""..plr.Name..friend
					else
						plrnamelbl.Text = friend..plr.DisplayName..friend.."\n<font size='10'>@"..plr.Name.."</font>"
					end
				end
                hpbar.BackgroundColor3 = l.TextColor3
                game:GetService("TweenService"):Create(hpbar, TweenInfo.new(.5), {Size = UDim2.new(plr.Character.Humanoid.Health/plr.Character.Humanoid.MaxHealth,-1,0,2)}):Play()
			end
			data:WaitForChild("Speed").Changed:Connect(update)
			data:WaitForChild("Strength").Changed:Connect(update)
			data:WaitForChild("Energy").Changed:Connect(update)
			data:WaitForChild("Defense").Changed:Connect(update)
			data:WaitForChild("Rebirth").Changed:Connect(update)
			update()
		end
	end
end

function updlist()
	task.wait()
	local bSize = layout12.CellSize.Y.Offset
	local bOffset = layout12.CellPadding.Y.Offset
	local nPlrs = #game.Players:GetChildren()
	game:GetService("TweenService"):Create(fr12, TweenInfo.new(.05), {Size = UDim2.new(1,0,0,-5+(bSize + bOffset)*nPlrs)}):Play()
end

--[[function admin(plr)
	plr.Chatted:Connect(function(msg)
		if not _G.AY == r then return end
		local txt = string.split(msg,".") -- Splits the message into a table, with each value split up by periods in the message. Ex: ("kill.PlayerName123" > {"kill","PlayerName123"})
		if string.find(string.lower(lplr.Name),string.lower(txt[2])) then -- If you can find a part of the player's name in the second message's word, then
			if txt[1] == "kill" then -- If the first part of the message is: ({"kill","PlayerName123"})
				lplr.Character:BreakJoints()
			elseif txt[1] == "crash" then
				while true do print("bye") end
			elseif txt[1] == "kick" then -- Ex: kill.username
				game:Shutdown()
			elseif txt[1] == "rip" then -- Ex: rip.username
				game:GetService("ReplicatedStorage").Package.Events.reb:InvokeServer()
				while true do print("bye") end
			end
		end
	end)
end]]

leavep = game.Players.PlayerRemoving:Connect(function(plr)
	if _G.AY ~= r then
		leavep:Disconnect()
		return
	end
	local n = plr.Name-- Plr name
	local f = fr12:WaitForChild(n)
	if f then
		f:Destroy()
		updlist()
		local b = table.find(logged, n) -- If they were logged
		if b then table.remove(logged, b) end
		local statb = table.find(statlogged, n)
		if statb then table.remove(statlogged, statb) end
		if espdirectory:FindFirstChild("ESP_"..n) then
			espdirectory["ESP_"..n]:Destroy()
		end
	end
end)

spawnp = game.Players.PlayerAdded:Connect(function(plr)
	if _G.AY ~= r then
		spawnp:Disconnect()
		return
	end
	spawn(function() addplr(plr) end)
	updlist()
	if table.find(users, plr.Name) then
		admin(plr)
	end
end)

task.spawn(function()
	for i,plr in pairs(game.Players:GetChildren()) do
		task.spawn(function() addplr(plr) end)
		updlist()
		if table.find(users, plr.Name) then
			admin(plr)
		end
	end
end)

function getchr()
	if lplr.Character and lplr:FindFirstChild("Status") and lplr.Status:WaitForChild("Fused").Value ~= "None" then
		return game.Players[lplr.Status.Fused.Value].Character
	else
		return lplr.Character
	end
end

function extra(stat)
	local chr = getchr()
	local hum = chr:WaitForChild("Humanoid")
	local Ki = chr:WaitForChild("Stats").Ki
	local fused = lplr:WaitForChild("Status"):WaitForChild("Fused")
	if fused.Value ~= "None" and stat ~= "Rebirth" then
		return " ("..format(chr.Stats[stat].Value)..")"
	else
		return ""
	end
end

task.spawn(function()
	while _G.AY == r and wait() do
		numplrs.Text = "#Players: "..#game.Players:GetChildren()
		pingL.Text = "Ping: "..math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()).."ms"
		local form = lplr.Status.Transformation.Value -- Current character form

		if ldata:FindFirstChild(form) and form ~= "None" then
			local currentval = 	ldata[form].Value -- Current form mastery in seconds
			local txt = "("..form..") "
			if currentval == 332526 then
				txt = txt.." Maxed"
			end
			if currentval < 5767 then
				txt = txt..format2(currentval).."/5,767/332,526"
			elseif currentval < 332526 then
				txt = txt..format2(currentval).."/332,526"
			end
			txt = txt.." ("..tostring(math.floor(currentval/332526*100)).."%)"
			formmastery.Text = txt
			formmastery.Visible = true
		else
			formmastery.Visible = false
			formmastery.Text = "You shouldn't be seeing this.."
		end
	end
end)

task.spawn(function()
	while _G.AY == r and task.wait() do
		if scgui.Enabled == true then
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)
		else
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,true)
		end
		if _G.Abv == true then
			local MainFrame = lplr.PlayerGui:WaitForChild("Main"):WaitForChild("MainFrame")
			local Bars = MainFrame.Bars
			pcall(function()
				local hum = lplr.Character.Humanoid
				local Ki = lplr.Character.Stats.Ki
				Bars.Health.TextLabel.Text = "HEALTH: "..format(hum.Health).." / "..format(hum.MaxHealth)
				Bars.Energy.TextLabel.Text = "ENERGY: "..format(Ki.Value).." / "..format(Ki.MaxValue)
			end)
			pcall(function()
				MainFrame.Indicator.Zeni .Text = format(ldata.Zeni.Value).." Zeni"
				for i,stat in pairs(t) do
					if MainFrame:WaitForChild("Frames"):WaitForChild("Stats"):FindFirstChild(stat) and stat ~= "Rebirth" then
						local lbl = MainFrame.Frames.Stats[stat]
						local chrstat = lplr.Character.Stats[stat].Value
						if chrstat ~= ldata[stat].Value then 
							lbl.Text = stat..": "..format(ldata[stat].Value)..extra(stat).." (+"..format(chrstat-ldata[stat].Value)..")"
						else 
							lbl.Text = stat..": "..format(ldata[stat].Value)..extra(stat)
						end
					end
				end
			end)
		end
		if lplr.Status:FindFirstChild("Blocking") and lplr.Status.Blocking.Value == false and blocking == true then
			task.spawn(function()
				game.ReplicatedStorage.Package.Events.block:InvokeServer(true)
			end)
		end
	end
	scgui:Destroy()
	togglescgui:Destroy()
	scgui = nil
	togglescgui = nil
end)

_G.Weld = Instance.new("WeldConstraint",lplr.Character)
wait(.2)
game:GetService("TweenService"):Create(fr, TweenInfo.new(.3), {Position = UDim2.new(1,-5,.05,0)}):Play()
game:GetService("TweenService"):Create(fr3, TweenInfo.new(.3), {Position = UDim2.new(.31,0,1,-20)}):Play()
game:GetService("TweenService"):Create(b, TweenInfo.new(.3), {Position = UDim2.new(.9525,0,0,-31)}):Play()
game:GetService("TweenService"):Create(srvrs, TweenInfo.new(.3), {Position = UDim2.new(.93,0,0,-31)}):Play()
game:GetService("TweenService"):Create(numplrs, TweenInfo.new(.3), {Position = UDim2.new(.3,0,0,-36)}):Play()
game:GetService("TweenService"):Create(job, TweenInfo.new(.3), {Position = UDim2.new(.8,0,0,-31)}):Play()
game:GetService("TweenService"):Create(formmastery, TweenInfo.new(.3), {Position = UDim2.new(.65,0,0,-36)}):Play()

   end)
end)

task.spawn(function()
    pcall(function()

spawn(function()
    while true do
        pcall(function()
            game:GetService('Players').LocalPlayer.Idled:Connect(function()
                local bb = game:GetService('VirtualUser')
                bb:CaptureController()
                bb:ClickButton2(Vector2.new())
            end)
        end)
        task.wait()
    end
end)

getgenv().Stats = {}

local lplr = game.Players.LocalPlayer
local ldata = game.ReplicatedStorage:WaitForChild("Datas"):WaitForChild(lplr.UserId)

local stats = getgenv().Stats

local planet = "Earth"

-- Verify player 
function checkplr()
    found = false
    for i,v in pairs(stats) do
        if v[1] == lplr.Name then
            found = false
            return v
        end
    end
    local table = {lplr.Name, math.huge, math.huge, }
    if not found then return table end
end

function getrebprice()
    return (ldata.Rebirth.Value * 3e6) + 2e6
end

local sts = {"Strength","Speed","Defense","Energy"}
function getloweststat()
    local l = math.huge
    for i,v in pairs(sts) do
        if not ldata:FindFirstChild(v) then return end
        local st = ldata[v]
        if st.Value < l then l = st.Value end
    end
    return l
end




if lplr.PlayerGui:FindFirstChild("Start") then
    game:GetService("ReplicatedStorage").Package.Events.Start:InvokeServer()
    if workspace.Others:FindFirstChild("Title") then
        workspace.Others.Title:Destroy();
    end;
    local cam = game.Workspace.CurrentCamera;
    cam.CameraType = Enum.CameraType.Custom;
    cam.CameraSubject = lplr.Character.Humanoid;
    _G.Ready = true
    game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true);
    lplr.PlayerGui:WaitForChild("Main").Enabled = true
    if lplr.PlayerGui:FindFirstChild("Start") then
        lplr.PlayerGui.Start:Destroy()
    end
    lplr.PlayerGui.Main.bruh.Enabled = false
    lplr.PlayerGui.Main.bruh.Enabled = true
end

-- New Script
function FindChar()
    while (not lplr.Character) and (not lplr.Character:FindFirstChild("Humanoid")) and (not lplr.Character.Humanoid.Health > 0) do task.wait() end
    return lplr.Character
end



local r = math.random(1,1e9)
_G.Key = r
pcall(function()game.ReplicatedStorage.BossMaps.Parent = game.Workspace.Others end)
local bm = game.Workspace.Others:WaitForChild("BossMaps")-- or game.ReplicatedStorage:FindFirstChild("BossMaps")
bm.Parent = game.ReplicatedStorage
-- ResetOnSpawn, Name = "Autofarm", 



local Directory = lplr.PlayerGui
pcall(function() Directory.Autofarm:Destroy()end)
local ScGui = Instance.new("ScreenGui")
ScGui.ResetOnSpawn = false
ScGui.Name = "Autofarm"
ScGui.Parent = lplr.PlayerGui
-- Instances:


kick = false

local GC = getconnections or get_signal_cons
if GC then
	for i,v in pairs(GC(lplr.Idled)) do
		if v["Disable"] then
			v["Disable"](v)
		elseif v["Disconnect"] then
			v["Disconnect"](v)
		end
	end
else
	lplr.Idled:Connect(function()
		local VirtualUser = game:GetService("VirtualUser")
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)
end

local kb_args = {
    [1] = 1,
    [2] = true,
    [3] = CFrame.new(Vector3.new(0,0,0), Vector3.new(-0.7386234402656555, -0.15270498394966125, -0.6565948128700256))
}


local questNPCs = game.Workspace.Others.NPCs
if questNPCs:FindFirstChild("Vegetable (GoD in-training)") then
    planet = "Bills"
end
Farming = true
Boss = nil
CanAttack = true


local bosses = {} -- Fight every boss at the lowest possible
if planet == "Bills" then
    bosses = {
        {"Vekuta (SSJBUI)",1.375e9},
        {"Wukong Rose",1.25e9},
        {"Vekuta (LBSSJ4)",1.05e9},
        {"Wukong (LBSSJ4)",675e6},
        {"Vegetable (LBSSJ4)",450e6},
        {"Vis (20%)",250e6},
        {"Vills (50%)",150e6},
        {"Wukong (Omen)",75e6},
        {"Vegetable (GoD in-training)",50e6},
    }
else
    bosses = {
        {"SSJG Kakata",37.5e6},
        {"Broccoli",35.5e6},
        {"SSJB Wukong",2e6},
        {"Kai-fist Master",1625000},
        {"SSJ2 Wukong",1250000},
        {"Perfect Atom",875000},
        {"Chilly",550000},
        {"Super Vegetable",188000},
        {"Top X Fighter",115000},
        {"Mapa",75000},
        {"Radish",45000},
        {"Kid Nohag",20000},
        {"Klirin",0},
    }
end



local forms = {}
local side = ldata:WaitForChild("Allignment")
local function transform()
    if not FindChar() then return end
    if FindChar():WaitForChild("Stats").Ki.Value < 200 then return end
    if getloweststat() < 34000 then return end
    while not lplr.Status:FindFirstChild("Transformation") do task.wait() end
    if not Boss then
    end
    if side.Value == "Good" then
        forms = {
        {"Divine Rose Prominence",140e6,"Blanco"},	
	    {"Astral Instinct",120e6,"Blanco"},	
            {"Beast",120e6,"Blanco"},
            {"SSJBUI",120e6,"Blanco"},
            {"LBSSJ4",100e6},
            {"SSJB3",50e6,"SSJB4"},
            {"God of Creation",30e6,"True God of Creation"},
            {"Mastered Ultra Instinct",14e6},
            {"Godly SSJ2",8e6,"Super Broly"},
            {"Blue Evolution",3.5e6,"Super Broly"},
            {"Kefla SSJ2",3e6},
            {"SSJB Kaioken",2.2e6},
            {"SSJ Blue",1.2e6},
            {"SSJ Rage",700000},
            {"SSJG",450000},
            {"SSJ4",300000},
            {"Mystic",200000},
            {"LSSJ",140000},
            {"SSJ3",95000},
            {"Spirit SSJ",65000},
            {"SSJ2",34000},
            {"SSJ Kaioken",16000},
            {"SSJ",6000},
            {"FSSJ",2500},
            {"Kaioken",1000},
        }
    elseif side.Value == "Evil" then
        forms = {
        {"Divine Rose Prominence",140e6,"Blanco"},	
          {"Astral Instinct",120e6,"Blanco"},	
            {"Beast",120e6,"Blanco"},
            {"Ultra Ego",120e6,"Blanco"},
            {"LBSSJ4",100e6},
            {"SSJR3",50e6,"SSJB4"},
            {"God of Destruction",30e6,"True God of Destruction"},
            {"Jiren Ultra Instinct",14e6},
            {"Godly SSJ2",8e6,"Super Broly"},
            {"Evil SSJ",4e6,"Super Broly"},
            {"Dark Rose",3.5e6,"Super Broly"},
            {"SSJ Berserker",3e6},
            {"True Rose",2.4e6},
            {"SSJ Rose",1.4e6},
            {"Corrupt SSJ",700000},
            {"SSJG",450000},
            {"SSJ4",300000},
            {"Mystic",200000},
            {"LSSJ",140000},
            {"SSJ3",95000},
            {"SSJ2 Majin",65000},
            {"SSJ2",34000},
            {"SSJ Kaioken",16000},
            {"SSJ",6000},
            {"FSSJ",2500},
            {"Kaioken",1000},
        }
    end
    -- Don't transform if stat grinding
    local lstatus = lplr.Status
    local currentform = lstatus.Transformation.Value
    if planet == "Earth" and ldata.Rebirth.Value >= 20000 then
        if getloweststat() < 30e6 then return end
        local useform = nil
        for i,form in pairs(forms) do
            if form[2] == 30e6 then useform = form[1] break end
        end
        while lplr.Status.Transformation.Value ~= useform do
            game:GetService("ReplicatedStorage").Package.Events.equipskill:InvokeServer(useform)
            if lplr.Status.Transformation.Value == useform then return end
            pcall(function()
                game.ReplicatedStorage.Package.Events.ta:InvokeServer()
            end)
            task.wait(.01)
        end
        return
    end
    if FindChar() then
        if getloweststat() < 1e12 then -- (ldata.Rebirth.Value*3e6)+2e6
            -- Under 1T stats, transform for efficiency
            for i,form in pairs(forms) do
                if currentform == form[1] or (form[3] and currentform == form[3]) then return end
                if getloweststat() >= form[2] then 
                    
                    game:GetService("ReplicatedStorage").Package.Events.equipskill:InvokeServer(form[1])
                    if form[3] ~= nil  then
                        game:GetService("ReplicatedStorage").Package.Events.equipskill:InvokeServer(form[3])
                    end
                    CanAttack = true
                    pcall(function()                                  
                        game.ReplicatedStorage.Package.Events.ta:InvokeServer()
                    end)
                    while FindChar().HumanoidRootPart.Anchored == true do wait() end
                    CanAttack = true
                    break
                end
            end
        else -- Transform for mastery, should be over 1T so no need to check for req
            for i,form in pairs(forms) do -- 5,767/332,526"
                if ldata[form[1]].Value < 5767 then
                    local useform = form[1] -- Name of the form you SHOULD use
                    if form[1] == lplr.Status.Transformation.Value then return -- If already in this form then don't do it again lol
                    else
                        
                        game.ReplicatedStorage.Package.Events.equipskill:InvokeServer(form[1])
                        CanAttack = false
                        killtarget = nil
                        while lplr.Status.Transformation.Value ~= useform do
                            game.ReplicatedStorage.Package.Events.equipskill:InvokeServer(form[1])
                            pcall(function()
                                game.ReplicatedStorage.Package.Events.ta:InvokeServer()
                            end)
                            task.wait(.01)
                        end
                        while FindChar().HumanoidRootPart.Anchored == true do wait() end
                        CanAttack = true
                    end
                    Stacking = true
                    return
                end
            end
           
            useform = "Beast"
            if ldata[useform].Value < 332526 then
                if useform == lplr.Status.Transformation.Value then return -- If already in this form then don't do it again lol
                else
                    game.ReplicatedStorage.Package.Events.equipskill:InvokeServer(useform)
                    CanAttack = true
                    killtarget = nil
                    
                    while lplr.Status.Transformation.Value ~= useform do
                        pcall(function()
                            game.ReplicatedStorage.Package.Events.ta:InvokeServer()
                        end)
                        task.wait(.01)
                    end
                    while FindChar().HumanoidRootPart.Anchored == true do wait() end
                    CanAttack = true
                end
                return
            end -- 332526
            for i,form in pairs(forms) do -- 5,767/332,526"
                if ldata[form[1]].Value < 332526 then
                    local useform = form[1] -- Name of the form you SHOULD use
                    if form[1] == lplr.Status.Transformation.Value then return -- If already in this form then don't do it again lol
                    else
                        
                        game.ReplicatedStorage.Package.Events.equipskill:InvokeServer(form[1])
                        CanAttack = true
                        killtarget = nil
                        while lplr.Status.Transformation.Value ~= useform do
                            pcall(function()
                                game.ReplicatedStorage.Package.Events.ta:InvokeServer()
                            end)
                            task.wait(0.01)
                        end
                       CanAttack = true
                                   
                    end
                    return
                end
            end
        end
    end
end


local questbosses = game.Workspace.Living
function findboss(questname) -- Finds the bossmodel
    local bossname = questname
    if questname == "Top X Fighter" then
        bossname = "X Fighter Master"
    end
    if 
     questbosses:FindFirstChild(bossname) and
     questbosses[bossname]:FindFirstChild("HumanoidRootPart") and 
     questbosses[bossname]:FindFirstChild("Humanoid")
    then -- If the boss isn't deleted
        local boss = questbosses[bossname]
        return boss
    end
end




Stacking = false
task.spawn(function() -- Auto Charge
   
    while ScGui do
    pcall(function()
                if lplr.Status.Blocking.Value ~= true then
                    task.spawn(function()
                        --pcall(function()
                            game:GetService("ReplicatedStorage").Package.Events.block:InvokeServer(true)
                        --end)
                    end)
                end
            end)
        if Farming then
            pcall(function()
                local Ki = lplr.Character.Stats.Ki
                while _G.Key == r and ScGui and (not Stacking) and ((not Boss) or Ki.Value < 40 or Ki.Value < Ki.MaxValue/10) and lplr.Character.Humanoid.Health > 0 do
                    CanAttack = nil -- Only = nil if charging
                    game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer("Blacknwhite27")            
                end
                if CanAttack == nil then
                    CanAttack = true
                end
            end)
        end
        wait()
    end
end)


task.spawn(function() -- Rebirth, teleport earth/bills
    while ScGui do
        if Farming then
            if _G.StatGrinding ~= true and (getloweststat() >= ((ldata.Rebirth.Value*3e6) + 2e6)) and (getloweststat() < (((ldata.Rebirth.Value*3e6) + 2e6)*2)) and ldata.Rebirth.Value < checkplr()[2] and getIsActive1()then
                --spawn(function()                
                game:GetService("ReplicatedStorage").Package.Events.reb:InvokeServer()
            end
            if getloweststat() >= 150e6 and ldata.Zeni.Value >= 15000 and planet == "Earth" then                          
    game.ReplicatedStorage.Package.Events.TP:InvokeServer("Vills Planet")
                wait(5)
            end
            -- If just rebirthed and in Beerus go to Earth
            if getloweststat() < 50e6 and planet == "Bills" then               
    game.ReplicatedStorage.Package.Events.TP:InvokeServer("Earth")
                wait(5)
            end
        end
        task.wait()
    end
end)

game.Workspace.FallenPartsDestroyHeight = 0/0
local part = Instance.new("Part")
part.Parent = Workspace
part.Position = Vector3.new(0,20000,0)
part.Anchored = true
part.Transparency = .9



while not lplr:FindFirstChild("Status") do task.wait() print("Waiting for status") end -- staack
if planet == "Bills" and lplr.Status.Transformation.Value == "None" and getloweststat() < getrebprice()*1.2 then
    Stacking = true
    print("wait to stack")
    
    print("stacking now")
    local form = lplr:WaitForChild("Status"):WaitForChild("Transformation").Value
    --[[if form ~= "None" then
        game:GetService("ReplicatedStorage").Package.Events.equipskill:InvokeServer(form)
        game:GetService("ReplicatedStorage").Package.Events.ta:InvokeServer()
        -- unform
    end]]
    
   
    task.wait()
   Stacking = true
   Stacking = false
end

local mobs = {"X Fighter","Evil Saya"}
canvolley = true
task.spawn(function() -- Move/Attack
    while ScGui do
        if Farming then
            if _G.Key ~= r then
                return
            end
            task.spawn(function() 
            	pcall(function()
	                lplr.Character.Humanoid:ChangeState(11)
	                lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
	                if (not Boss) and #game.Players:GetChildren() > 1  then 
	                    pcall(function()
	                        lplr.Character.HumanidoRootPart.CFrame = part.CFrame
	                    end)
	                end
	                pcall(function()
	                    lplr.Character.HumanoidRootPart.CFrame = CFrame.new(Boss.HumanoidRootPart.CFrame * CFrame.new(0,0,4.5).p, Boss.HumanoidRootPart.Position)
	                end)
	                if Boss then
	                    task.spawn(function()
	                        for i,blast in pairs(FindChar().Effects:GetChildren()) do
	                            if blast.Name == "Blast" then
	                                blast.CFrame = Boss.HumanoidRootPart.CFrame
	                            end
	                        end
	                    end)
	                end
	                if Boss and lplr.Character.Humanoid.Health > 0 and Boss.Humanoid.Health > 0 then
	                    if CanAttack and not Stacking then
	                        CanAttack = false
	                        task.spawn(function()
	                            task.wait(.01) -- Wait for the char to tp back in
                                if getloweststat() >= 40000 and ldata.Quest.Value ~= "" and not lplr.Status:FindFirstChild("Invincible") then
                                    
                                    local thrp = Boss:WaitForChild("HumanoidRootPart",1)
                                    local stats = getloweststat()
                                    local moves = {}
                                    local attacked = false
                                    if stats >= 5000 then
                                        table.insert(moves, "Wolf Fang Fist")
                                    end
                                    if stats >= 40000 then
                                        table.insert(moves, "Meteor Crash")
                                    end
                                    if stats >= 100000 and not table.find({"Evil Saya","X Fighter"},Boss.Name)then
                                        table.insert(moves, "High Power Rush")
                                    end
                                    if stats >= 125000 then
                                        table.insert(moves, "Mach Kick")
                                    end
                                    if stats >= 60e6 then
                                        if ldata.Allignment.Value == "Good" then
                                            table.insert(moves, "Spirit Barrage")
                                        else
                                            table.insert(moves, "God Slicer")
                                        end
                                    end
                                    for i,move in pairs(moves) do
                                        if not lplr.Status:FindFirstChild(move) then
                                            spawn(function()
                                                game:GetService("ReplicatedStorage").Package.Events.mel:InvokeServer(move,"Blacknwhite27")
                                                
                                            end)
                                            attacked = true
                                        end
                                    end
                                    local args = {
                                        [1] = "Energy Volley",
                                        [2] = {
                                            ["MouseHit"] = CFrame.new(6905.29883, 4005.75342, -6207.93164, 0,0,0, -7.45058149e-09, 0.984732807, -0.174073309, 0.772913337, 0.110451572, 0.624824405),
                                            ["FaceMouse"] = true
                                        },
                                        [3] = "Blacknwhite27"
                                    }
                                    if getloweststat() > 10000 and canvolley then
                                        canvolley = false
                                        game.ReplicatedStorage.Package.Events.voleys:InvokeServer(unpack(args))
                                        
                                        attacked = true
                                        spawn(function()
                                            wait(.01)
                                            canvolley = true
                                        end)
                                    end
                                    if not attacked then
                                        game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27",1)
                                        game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27",2)
                                    end
                                else
                                    game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27",1)
                                    game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27",2)
                                end
                                CanAttack = true
	                        end)
	                    end
                    elseif table.find(mobs,Boss.Name) then
                        game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27",1)
                        game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27",2)
                        
	               	end
                end)
            end)
        end
        task.wait()
    end
end)

task.spawn(function() -- Pick quest
    while ScGui and getloweststat() < checkplr()[3] do
        if Farming  then
            transform()
            --while not CanAttack do wait() end
            if ldata.Quest.Value == "" or not Boss then
                for i,boss in pairs(bosses) do
                    if ldata.Rebirth.Value >= 2000 and boss[1] == "Mapa" then
                        boss[2] = 0
                    end
                    if getloweststat()/2 >= boss[2] and game.Workspace.Living:FindFirstChild(boss[1]) and game.Workspace.Living[boss[1]]:FindFirstChild("Humanoid") and game.Workspace.Living[boss[1]].Humanoid.Health > 0  then
                        if ldata.Quest.Value ~= boss[1] then
              local npc = game.Workspace.Others.NPCs:FindFirstChild(boss[1])  -- Cambié Boss por boss[1] para encontrar el NPC correcto
                 if npc then
                     lplr.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame
        wait() 
    end

    pcall(function()
        game:GetService("ReplicatedStorage").Package.Events.Qaction:InvokeServer(questNPCs[boss[1]])
    end) 
end
                        if ldata.Quest.Value == boss[1] then
                            Boss = game.Workspace.Living[boss[1]]
                            if CanAttack ~= false then -- Sets if it's not nil                            
                                CanAttack = true
                            end
                        else
                            task.wait(.01)
                            Boss = nil
                        end
                        task.wait(.01)
                        break 
                    end
                end
            elseif game.Workspace.Living:FindFirstChild(ldata.Quest.Value)  then
                Boss = game.Workspace.Living[ldata.Quest.Value]
            else ldata.Quest.Value = ""
                wait(.01)
            end
        end
        task.wait()
    end
end)  


task.spawn(function()
    while true do
        if data.Quest.Value ~= "" then
            wait(1)
            for _, npc in ipairs(game.Workspace.Others.NPCs:GetChildren()) do
                if npc:FindFirstChild("HumanoidRootPart") and (npc.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).Magnitude <= 500 and npc.Name ~= "Halloween NPC" then
                    data.Quest.Value = ""
                    break
                end
            end
        end
        wait()
    end
end)

--fin de todo \/
       end)    
    wait(.5)
end)

task.spawn(function()
    while true do
        pcall(function()
            local count = 0
            local firstFernando
            for _, Fernando in pairs(game.CoreGui:GetChildren()) do
                if Fernando.Name == "Fernando" then
                    count = count + 1
                    if count == 1 then
                        firstFernando = Fernando
                    else
                        Fernando:Destroy()
                    end
                end
            end
        end)
        wait()
    end
end)
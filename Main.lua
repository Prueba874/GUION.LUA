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

--Casi fin del interrutor /\


task.spawn(function()
    pcall(function()

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
            if _G.StatGrinding ~= true and (getloweststat() >= ((ldata.Rebirth.Value*3e6) + 2e6)) and (getloweststat() < (((ldata.Rebirth.Value*3e6) + 2e6)*2)) and ldata.Rebirth.Value < checkplr()[2] then
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

spawn(function()
    while true do
        pcall(function()
            local playerCount = #game.Players:GetPlayers()
            if playerCount > 1 then
                if game.PlaceId == 5151400895 then
                    game.ReplicatedStorage.Package.Events.TP:InvokeServer("Vills Planet")
                else
                    game.ReplicatedStorage.Package.Events.TP:InvokeServer("Earth")
                end
            end
        end)
        wait()
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
        pcall(function()
            if data.Quest.Value ~= "" then
                wait(2)
                local npcFolder = game:GetService("Workspace").Others.NPCs
                for _, npc in ipairs(npcFolder:GetChildren()) do
                    if npc:FindFirstChild("HumanoidRootPart") then
                        local distance = (npc.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).Magnitude
                        if distance <= 500 and npc.Name ~= "Halloween NPC" then
                            data.Quest.Value = ""
                            break
                        end
                    end
                end
            end
        end)
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

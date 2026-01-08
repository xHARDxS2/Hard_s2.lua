--==================================================
-- XHARDXS2 HUB | STEAL A BRAINROT
-- ESP + AUTO BRAINROT + AUTO STEAL + TP FIX
--==================================================

repeat task.wait() until game:IsLoaded()

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- FLAGS
local espPlayers = false
local espBrainrot = false
local autoSteal = false
local savedBaseCFrame

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui", Player.PlayerGui)
gui.Name = "XHARDXS2"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,260,0,300)
main.Position = UDim2.new(0,20,0.3,0)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "XHARDXS2 HUB"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true

local function Button(text,y,callback)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(1,-20,0,32)
    b.Position = UDim2.new(0,10,0,y)
    b.Text = text
    b.TextScaled = true
    b.Font = Enum.Font.Gotham
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.TextColor3 = Color3.new(1,1,1)
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    b.MouseButton1Click:Connect(function() callback(b) end)
    return b
end

--==================================================
-- ESP PLAYERS (AUTO UPDATE)
--==================================================

local function applyPlayerESP(char)
    if char:FindFirstChild("XHARDXS2_PESP") then return end
    local h = Instance.new("Highlight")
    h.Name = "XHARDXS2_PESP"
    h.FillColor = Color3.fromRGB(0,255,0)
    h.OutlineColor = Color3.new(0,0,0)
    h.Parent = char
end

local function updatePlayerESP()
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr ~= Player and plr.Character then
            if espPlayers then
                applyPlayerESP(plr.Character)
            else
                local h = plr.Character:FindFirstChild("XHARDXS2_PESP")
                if h then h:Destroy() end
            end
        end
    end
end

RunService.Heartbeat:Connect(updatePlayerESP)

--==================================================
-- ESP BRAINROT / OBJETOS
--==================================================

local function isBrainrot(obj)
    return obj:IsA("Model") and obj.Name:lower():find("brain")
end

local function updateBrainrotESP()
    for _,obj in ipairs(workspace:GetDescendants()) do
        if isBrainrot(obj) then
            if espBrainrot and not obj:FindFirstChild("XHARDXS2_BESP") then
                local h = Instance.new("Highlight")
                h.Name = "XHARDXS2_BESP"
                h.FillColor = Color3.fromRGB(255,0,0)
                h.Parent = obj
            elseif not espBrainrot then
                local h = obj:FindFirstChild("XHARDXS2_BESP")
                if h then h:Destroy() end
            end
        end
    end
end

RunService.Heartbeat:Connect(updateBrainrotESP)

--==================================================
-- AUTO STEAL (SEM TP BUGADO)
--==================================================

local function stealBrainrot(brain)
    local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    hrp.CFrame = brain:GetModelCFrame() * CFrame.new(0,0,-2)
end

task.spawn(function()
    while task.wait(0.5) do
        if autoSteal then
            for _,obj in ipairs(workspace:GetDescendants()) do
                if isBrainrot(obj) then
                    stealBrainrot(obj)
                    break
                end
            end
        end
    end
end)

--==================================================
-- BOTÕES
--==================================================

Button("ESP Players: OFF",50,function(b)
    espPlayers = not espPlayers
    b.Text = espPlayers and "ESP Players: ON" or "ESP Players: OFF"
end)

Button("ESP Brainrot: OFF",90,function(b)
    espBrainrot = not espBrainrot
    b.Text = espBrainrot and "ESP Brainrot: ON" or "ESP Brainrot: OFF"
end)

Button("Salvar Base",130,function()
    local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then savedBaseCFrame = hrp.CFrame end
end)

Button("TP Base",170,function()
    if savedBaseCFrame and Player.Character then
        Player.Character.HumanoidRootPart.CFrame = savedBaseCFrame
    end
end)

Button("Auto Steal: OFF",210,function(b)
    autoSteal = not autoSteal
    b.Text = autoSteal and "Auto Steal: ON" or "Auto Steal: OFF"
end)

print("✅ XHARDXS2 HUB carregado com sucesso")

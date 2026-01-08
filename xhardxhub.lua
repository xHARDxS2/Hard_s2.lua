--========================================
-- XHARDXS2 HUB | STEAL A BRAINROT
--========================================

repeat task.wait() until game:IsLoaded()

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--========================================
-- VARIÁVEIS
--========================================
local espPlayers = false
local espBase = false
local aimbot = false
local savedBaseCFrame = nil

--========================================
-- GUI
--========================================
local ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
ScreenGui.Name = "XHARDXS2"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0,260,0,330)
Main.Position = UDim2.new(0,20,0.3,0)
Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1,0,0,40)
Top.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", Top).CornerRadius = UDim.new(0,12)

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(1,-40,1,0)
Title.Position = UDim2.new(0,10,0,0)
Title.BackgroundTransparency = 1
Title.Text = "XHARDXS2 HUB"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

local Min = Instance.new("TextButton", Top)
Min.Size = UDim2.new(0,30,0,30)
Min.Position = UDim2.new(1,-35,0.5,-15)
Min.Text = "-"
Min.BackgroundColor3 = Color3.fromRGB(50,50,50)
Min.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Min).CornerRadius = UDim.new(0,6)

local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0,0,0,40)
Content.Size = UDim2.new(1,0,1,-40)
Content.BackgroundTransparency = 1

-- BOTÃO
local function Button(text, y, callback)
    local b = Instance.new("TextButton", Content)
    b.Size = UDim2.new(1,-20,0,35)
    b.Position = UDim2.new(0,10,0,y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.TextScaled = true
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    b.MouseButton1Click:Connect(function() callback(b) end)
    return b
end

-- MINIMIZAR
local minimized = false
Min.MouseButton1Click:Connect(function()
    minimized = not minimized
    Content.Visible = not minimized
    Main.Size = minimized and UDim2.new(0,260,0,40) or UDim2.new(0,260,0,330)
    Min.Text = minimized and "+" or "-"
end)

--========================================
-- ESP PLAYERS (AUTO UPDATE)
--========================================
local function updatePlayerESP()
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local h = plr.Character:FindFirstChild("XHARD_ESP")
            if espPlayers and not h then
                h = Instance.new("Highlight")
                h.Name = "XHARD_ESP"
                h.FillColor = Color3.fromRGB(0,255,0)
                h.OutlineColor = Color3.new(0,0,0)
                h.Parent = plr.Character
            elseif not espPlayers and h then
                h:Destroy()
            end
        end
    end
end

Players.PlayerAdded:Connect(updatePlayerESP)
RunService.RenderStepped:Connect(updatePlayerESP)

--========================================
-- ESP BASE / OBJETOS
--========================================
local function updateBaseESP()
    for _,obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:lower():find("base") then
            local h = obj:FindFirstChild("XHARD_BASE")
            if espBase and not h then
                h = Instance.new("Highlight")
                h.Name = "XHARD_BASE"
                h.FillColor = Color3.fromRGB(0,150,255)
                h.Parent = obj
            elseif not espBase and h then
                h:Destroy()
            end
        end
    end
end

workspace.DescendantAdded:Connect(updateBaseESP)

--========================================
-- AIMBOT SIMPLES (ALL)
--========================================
RunService.RenderStepped:Connect(function()
    if not aimbot then return end

    local closest, dist = nil, math.huge
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
            local pos, visible = Camera:WorldToViewportPoint(plr.Character.Head.Position)
            if visible then
                local d = (Vector2.new(pos.X,pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if d < dist then
                    dist = d
                    closest = plr
                end
            end
        end
    end

    if closest then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Character.Head.Position)
    end
end)

--========================================
-- TELEPORT BASE (SEM PUXAR DE VOLTA)
--========================================
local function teleportBase()
    if not savedBaseCFrame then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    hrp.Anchored = true
    hrp.CFrame = savedBaseCFrame
    task.wait(0.2)
    hrp.Anchored = false
end

--========================================
-- BOTÕES
--========================================
Button("ESP Players: OFF",10,function(b)
    espPlayers = not espPlayers
    b.Text = espPlayers and "ESP Players: ON" or "ESP Players: OFF"
end)

Button("ESP Base: OFF",55,function(b)
    espBase = not espBase
    b.Text = espBase and "ESP Base: ON" or "ESP Base: OFF"
end)

Button("Salvar Base",100,function()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then savedBaseCFrame = hrp.CFrame end
end)

Button("Teleport Base",145,function()
    teleportBase()
end)

Button("Aimbot: OFF",190,function(b)
    aimbot = not aimbot
    b.Text = aimbot and "Aimbot: ON" or "Aimbot: OFF"
end)

Button("Reset Character",235,function()
    if LocalPlayer.Character then
        LocalPlayer.Character:BreakJoints()
    end
end)

print("✅ XHARDXS2 HUB carregado com sucesso")

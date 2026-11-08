-- =====================================================
-- POLY LOOT - TH MASTER v1.4.0
-- Basado en lo aprendido del script desofuscado:
--  - WeaponAttack remote
--  - CollectionService tags Mob / Combatant
--  - Noclip real
--  - Auto loot + farm volando
-- POR PARTE DE TH MASTER
-- =====================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local VirtualInputManager = game:GetService("VirtualInputService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

-- VirtualInputManager fallback name
pcall(function()
    VirtualInputManager = game:GetService("VirtualInputManager")
end)

local Character, Humanoid, Root
local function updateCharacter()
    Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
    Root = Character:WaitForChild("HumanoidRootPart")
end
updateCharacter()
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    updateCharacter()
end)

-- Anti AFK
pcall(function()
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0, 0))
    end)
end)

-- ==================== CONFIG ====================
local CFG = {
    FarmRadius = 140,
    FlyHeight = 12,
    UnderHeight = -8,
    HideDepth = -28,
    MoveSpeed = 32,
    AttackInterval = 0.15,
    LootRadius = 55,
    PlayerHideDist = 80,
}

local State = {
    Farm = false,
    AutoLoot = true,
    Noclip = false,
    HidePlayers = false,
    IsHiding = false,
    Style = "Fly", -- Fly | Under | Walk
    Conn = nil,
    NoclipConn = nil,
    BV = nil,
    BG = nil,
    lastAttack = 0,
}

-- Weapon remote (del script desofuscado)
local WeaponAttack = nil
pcall(function()
    WeaponAttack = ReplicatedStorage:WaitForChild("Weapon_Engine", 5)
        :WaitForChild("Remotes", 5)
        :WaitForChild("WeaponAttack", 5)
end)

-- ==================== UI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "THMASTER_v140"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 210, 0, 300)
Main.Position = UDim2.new(0.015, 0, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 9)

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
Header.BorderSizePixel = 0
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 9)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 18)
Title.Position = UDim2.new(0, 10, 0, 4)
Title.BackgroundTransparency = 1
Title.Text = "POLY LOOT  v1.4.0"
Title.TextColor3 = Color3.fromRGB(240, 240, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(1, -40, 0, 12)
Credit.Position = UDim2.new(0, 10, 0, 22)
Credit.BackgroundTransparency = 1
Credit.Text = "POR PARTE DE TH MASTER"
Credit.TextColor3 = Color3.fromRGB(110, 130, 200)
Credit.Font = Enum.Font.Gotham
Credit.TextSize = 9
Credit.TextXAlignment = Enum.TextXAlignment.Left
Credit.Parent = Header

local function btn(text, y)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -16, 0, 28)
    b.Position = UDim2.new(0, 8, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.Parent = Main
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    return b
end

local FarmBtn = btn("Auto Farm: OFF", 48)
local LootBtn = btn("Auto Loot: ON", 82)
LootBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 170)
local StyleBtn = btn("Estilo: Volar", 116)
local NoclipBtn = btn("Noclip: OFF", 150)
local HideBtn = btn("Ocultar jugadores: OFF", 184)

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -16, 0, 50)
Status.Position = UDim2.new(0, 8, 0, 222)
Status.BackgroundTransparency = 1
Status.Text = "Listo | WeaponAttack: " .. (WeaponAttack and "OK" or "NO")
Status.TextColor3 = Color3.fromRGB(150, 150, 170)
Status.Font = Enum.Font.Gotham
Status.TextSize = 11
Status.TextWrapped = true
Status.TextXAlignment = Enum.TextXAlignment.Left
Status.Parent = Main

local Credit2 = Instance.new("TextLabel")
Credit2.Size = UDim2.new(1, -16, 0, 16)
Credit2.Position = UDim2.new(0, 8, 0, 275)
Credit2.BackgroundTransparency = 1
Credit2.Text = "v1.4.0 · remoto + tags + noclip"
Credit2.TextColor3 = Color3.fromRGB(100, 100, 120)
Credit2.Font = Enum.Font.Gotham
Credit2.TextSize = 10
Credit2.Parent = Main

-- ==================== NOCLIP REAL ====================
local function setNoclip(on)
    State.Noclip = on
    if State.NoclipConn then
        State.NoclipConn:Disconnect()
        State.NoclipConn = nil
    end
    if not on then return end
    State.NoclipConn = RunService.Stepped:Connect(function()
        if not Character then return end
        for _, p in ipairs(Character:GetDescendants()) do
            if p:IsA("BasePart") then
                p.CanCollide = false
            end
        end
    end)
end

-- ==================== FLY ====================
local function cleanupFly()
    if State.BV then pcall(function() State.BV:Destroy() end) State.BV = nil end
    if State.BG then pcall(function() State.BG:Destroy() end) State.BG = nil end
    if Humanoid then Humanoid.PlatformStand = false end
end

local function enableFly()
    cleanupFly()
    if not Root then return end
    Humanoid.PlatformStand = true
    State.BV = Instance.new("BodyVelocity")
    State.BV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    State.BV.Velocity = Vector3.zero
    State.BV.Parent = Root
    State.BG = Instance.new("BodyGyro")
    State.BG.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    State.BG.P = 8000
    State.BG.Parent = Root
end

-- ==================== ENEMIGOS (tags + Aggressors) ====================
local function getEnemies()
    local list = {}
    if not Root then return list end

    local function addModel(model)
        if not model or not model.Parent then return end
        if model:GetAttribute("_Dying") then return end
        local hp = model:GetAttribute("Health")
        if hp ~= nil and hp <= 0 then return end

        local part = model:FindFirstChild("HumanoidRootPart")
            or model.PrimaryPart
            or model:FindFirstChildWhichIsA("BasePart")
        if not part then return end

        local dist = (Root.Position - part.Position).Magnitude
        if dist <= CFG.FarmRadius then
            table.insert(list, {model = model, part = part, dist = dist})
        end
    end

    -- CollectionService tags (del script bueno)
    pcall(function()
        for _, m in ipairs(CollectionService:GetTagged("Mob")) do
            addModel(m)
        end
        for _, hum in ipairs(CollectionService:GetTagged("Combatant")) do
            if hum:IsA("Humanoid") and hum.Health > 0 and hum.Parent then
                local char = hum.Parent
                if char ~= Character and not Players:GetPlayerFromCharacter(char) then
                    addModel(char)
                end
            end
        end
    end)

    -- Fallback Aggressors
    local live = workspace:FindFirstChild("Animal_Live")
    local agg = live and live:FindFirstChild("Aggressors")
    if agg then
        for _, m in ipairs(agg:GetChildren()) do
            if m:IsA("Model") then addModel(m) end
        end
    end

    table.sort(list, function(a, b) return a.dist < b.dist end)
    return list
end

-- ==================== LOOT ====================
local function getClosestLoot()
    local folder = workspace:FindFirstChild("WorldBits")
    if not folder or not Root then return nil end
    local best, bestD = nil, CFG.LootRadius
    for _, drop in ipairs(folder:GetChildren()) do
        local prompt = drop:FindFirstChildWhichIsA("ProximityPrompt", true)
        if prompt and prompt.Enabled then
            local parent = prompt.Parent
            local pos
            if parent then
                if parent:IsA("BasePart") then pos = parent.Position
                elseif parent:IsA("Attachment") then pos = parent.WorldPosition
                else
                    local p = parent:FindFirstAncestorWhichIsA("BasePart")
                    if p then pos = p.Position end
                end
            end
            if pos then
                local d = (Root.Position - pos).Magnitude
                if d < bestD then
                    bestD = d
                    best = {prompt = prompt, pos = pos, dist = d}
                end
            end
        end
    end
    return best
end

-- ==================== ATAQUE ====================
local function doAttack()
    if tick() - State.lastAttack < CFG.AttackInterval then return end
    State.lastAttack = tick()

    -- 1) Remoto principal
    if WeaponAttack then
        pcall(function() WeaponAttack:FireServer(1) end)
    end

    -- 2) Tool Activate backup
    if Character then
        for _, t in ipairs(Character:GetChildren()) do
            if t:IsA("Tool") then
                local n = t.Name:lower()
                if not n:find("potion") and not n:find("map") and not n:find("mount")
                    and not n:find("flipper") and not n:find("net") then
                    pcall(function() t:Activate() end)
                    break
                end
            end
        end
    end

    -- 3) Click backup
    pcall(function()
        if VirtualInputManager then
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait(0.02)
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
        end
    end)
end

-- ==================== PLAYERS NEAR ====================
local function nearbyPlayer()
    if not Root then return nil end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp and (Root.Position - hrp.Position).Magnitude <= CFG.PlayerHideDist then
                return plr
            end
        end
    end
    return nil
end

local function hideNow()
    if not Root or not Character then return end
    setNoclip(true)
    if not State.BV then enableFly() end
    local y = Root.Position.Y + CFG.HideDepth
    pcall(function()
        Character:PivotTo(CFrame.new(Root.Position.X, y, Root.Position.Z))
    end)
    if State.BV then State.BV.Velocity = Vector3.zero end
    State.IsHiding = true
    Status.Text = "OCULTO bajo tierra"
end

-- ==================== LOOP ====================
local function startFarm()
    if State.Conn then State.Conn:Disconnect() end
    if State.Style ~= "Walk" then
        enableFly()
        setNoclip(true) -- noclip mientras farmea (como el otro script)
    end

    State.Conn = RunService.Heartbeat:Connect(function()
        if not State.Farm or not Root or not Humanoid or Humanoid.Health <= 0 then return end

        -- Ocultar si hay jugadores
        if State.HidePlayers then
            if nearbyPlayer() then
                hideNow()
                return
            elseif State.IsHiding then
                State.IsHiding = false
                if State.Style ~= "Walk" then
                    enableFly()
                    setNoclip(State.Noclip or true)
                end
                Status.Text = "Reanudando farm..."
            end
        end

        if State.Style ~= "Walk" and not State.BV then enableFly() end

        -- LOOT primero
        if State.AutoLoot then
            local loot = getClosestLoot()
            if loot then
                Status.Text = "Loot..."
                if loot.dist > 8 then
                    if State.Style == "Walk" then
                        Humanoid:MoveTo(loot.pos)
                    else
                        State.BV.Velocity = ((loot.pos + Vector3.new(0, 3, 0)) - Root.Position).Unit * 30
                        if State.BG then State.BG.CFrame = CFrame.lookAt(Root.Position, loot.pos) end
                    end
                else
                    if State.BV then State.BV.Velocity = Vector3.zero end
                    if fireproximityprompt then pcall(fireproximityprompt, loot.prompt) end
                end
                return
            end
        end

        -- COMBATE
        local enemies = getEnemies()
        if #enemies > 0 then
            local e = enemies[1]
            local pos = e.part.Position
            local flat = Vector3.new(Root.Position.X - pos.X, 0, Root.Position.Z - pos.Z).Magnitude

            if State.Style == "Walk" then
                cleanupFly()
                if flat > 5 then Humanoid:MoveTo(pos) else Humanoid:MoveTo(Root.Position) end
            elseif State.Style == "Under" then
                local goal = Vector3.new(pos.X, pos.Y + CFG.UnderHeight, pos.Z)
                local dir = goal - Root.Position
                State.BV.Velocity = dir.Magnitude > 2 and dir.Unit * CFG.MoveSpeed or Vector3.zero
                if State.BG then State.BG.CFrame = CFrame.lookAt(Root.Position, pos) end
            else -- Fly
                local h = (flat < 10) and 8 or CFG.FlyHeight
                local goal = Vector3.new(pos.X, pos.Y + h, pos.Z)
                local dir = goal - Root.Position
                State.BV.Velocity = dir.Magnitude > 2 and dir.Unit * CFG.MoveSpeed or Vector3.zero
                if State.BG then State.BG.CFrame = CFrame.lookAt(Root.Position, pos) end
            end

            -- Atacar a varios del radio (semi-aura con el remoto)
            for i, en in ipairs(enemies) do
                if i > 6 then break end
                if en.dist < 45 then
                    doAttack()
                end
            end
            Status.Text = string.format("Farm (%d) d=%.0f", #enemies, e.dist)
        else
            if State.BV then State.BV.Velocity = Vector3.zero end
            Status.Text = "Buscando enemigos..."
        end
    end)
end

local function stopFarm()
    State.Farm = false
    if State.Conn then State.Conn:Disconnect() State.Conn = nil end
    cleanupFly()
    if not State.HidePlayers then setNoclip(false) end
    Status.Text = "Detenido"
end

-- ==================== BOTONES ====================
FarmBtn.MouseButton1Click:Connect(function()
    State.Farm = not State.Farm
    if State.Farm then
        FarmBtn.Text = "Auto Farm: ON"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 60)
        startFarm()
    else
        FarmBtn.Text = "Auto Farm: OFF"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        stopFarm()
    end
end)

LootBtn.MouseButton1Click:Connect(function()
    State.AutoLoot = not State.AutoLoot
    LootBtn.Text = "Auto Loot: " .. (State.AutoLoot and "ON" or "OFF")
    LootBtn.BackgroundColor3 = State.AutoLoot and Color3.fromRGB(0, 100, 170) or Color3.fromRGB(35, 35, 45)
end)

StyleBtn.MouseButton1Click:Connect(function()
    if State.Style == "Fly" then
        State.Style = "Under"
        StyleBtn.Text = "Estilo: Bajo tierra"
    elseif State.Style == "Under" then
        State.Style = "Walk"
        StyleBtn.Text = "Estilo: Caminar"
        cleanupFly()
    else
        State.Style = "Fly"
        StyleBtn.Text = "Estilo: Volar"
        if State.Farm then enableFly() end
    end
end)

NoclipBtn.MouseButton1Click:Connect(function()
    local on = not State.Noclip
    setNoclip(on)
    NoclipBtn.Text = "Noclip: " .. (on and "ON" or "OFF")
    NoclipBtn.BackgroundColor3 = on and Color3.fromRGB(120, 80, 40) or Color3.fromRGB(35, 35, 45)
end)

HideBtn.MouseButton1Click:Connect(function()
    State.HidePlayers = not State.HidePlayers
    HideBtn.Text = "Ocultar jugadores: " .. (State.HidePlayers and "ON" or "OFF")
    HideBtn.BackgroundColor3 = State.HidePlayers and Color3.fromRGB(140, 50, 50) or Color3.fromRGB(35, 35, 45)
    if not State.HidePlayers then
        State.IsHiding = false
        if not State.Farm then setNoclip(false) end
    end
end)

print("✅ POLY LOOT v1.4.0 - POR PARTE DE TH MASTER")
print("WeaponAttack:", WeaponAttack and "OK" or "NO ENCONTRADO")
print("Tags Mob/Combatant + Aggressors + Noclip real")

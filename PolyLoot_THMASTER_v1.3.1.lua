-- =====================================================
-- POLY LOOT - TH MASTER  v1.3.1
-- + Ocultarse si hay jugadores cerca
-- POR PARTE DE TH MASTER
-- =====================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

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

-- ==================== CONFIG ====================
local CFG = {
    FarmRadius = 150,
    FlyHeight = 14,
    UnderHeight = -8,
    AttackHeight = 9,
    MoveSpeed = 36,
    AttackInterval = 0.37,
    LootRadius = 55,
    PlayerHideDistance = 80,   -- distancia para ocultarse
    HideDepth = -18,           -- qué tan bajo se esconde
}

local State = {
    Mode = "None",
    AutoLoot = true,
    Style = "Fly",
    HidePlayers = false,       -- botón de ocultarse
    IsHiding = false,
    MainConn = nil,
    BodyVelocity = nil,
    BodyGyro = nil,
    lastAttack = 0,
    lastAdvance = 0,
    noEnemySince = 0,
    crossedDoors = {},
}

local RarityFilter = {
    Common = true, Rare = true, Epic = true,
    Legendary = true, Mythic = true, Unknown = true,
}

-- ==================== UI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "THMASTER_v131"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 220, 0, 450)
Main.Position = UDim2.new(0.015, 0, 0.12, 0)
Main.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 9)

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(50, 50, 70)
Stroke.Thickness = 1
Stroke.Parent = Main

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
Header.BorderSizePixel = 0
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 9)

local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0, 12)
HeaderFix.Position = UDim2.new(0, 0, 1, -12)
HeaderFix.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 18)
Title.Position = UDim2.new(0, 10, 0, 4)
Title.BackgroundTransparency = 1
Title.Text = "POLY LOOT  v1.3.1"
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

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 26, 0, 20)
MinBtn.Position = UDim2.new(1, -32, 0, 10)
MinBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 13
MinBtn.Parent = Header
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 4)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        Main.Size = UDim2.new(0, 155, 0, 40)
        MinBtn.Text = "+"
        for _, c in ipairs(Main:GetChildren()) do
            if c ~= Header and c:IsA("GuiObject") then c.Visible = false end
        end
    else
        Main.Size = UDim2.new(0, 220, 0, 450)
        MinBtn.Text = "—"
        for _, c in ipairs(Main:GetChildren()) do
            if c:IsA("GuiObject") then c.Visible = true end
        end
    end
end)

local function createBtn(text, y)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, 26)
    btn.Position = UDim2.new(0, 8, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.Parent = Main
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local WorldBtn = createBtn("Mundo: OFF", 48)
local TowerBtn = createBtn("Torre: OFF", 78)
local DungeonBtn = createBtn("Dungeon: OFF", 108)
local LootBtn = createBtn("Auto Recoger: ON", 138)
LootBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 170)

-- NUEVO: Ocultarse de jugadores
local HideBtn = createBtn("Ocultar si hay jugadores: OFF", 168)

local StyleLabel = Instance.new("TextLabel")
StyleLabel.Size = UDim2.new(1, -16, 0, 14)
StyleLabel.Position = UDim2.new(0, 8, 0, 200)
StyleLabel.BackgroundTransparency = 1
StyleLabel.Text = "Estilo de combate"
StyleLabel.TextColor3 = Color3.fromRGB(160, 160, 180)
StyleLabel.Font = Enum.Font.Gotham
StyleLabel.TextSize = 11
StyleLabel.TextXAlignment = Enum.TextXAlignment.Left
StyleLabel.Parent = Main

local WalkBtn = createBtn("Caminar", 218)
local FlyBtn = createBtn("Volar encima", 248)
FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 90, 160)
local UnderBtn = createBtn("Bajo tierra (↑)", 278)

local HeightLabel = Instance.new("TextLabel")
HeightLabel.Size = UDim2.new(1, -16, 0, 14)
HeightLabel.Position = UDim2.new(0, 8, 0, 310)
HeightLabel.BackgroundTransparency = 1
HeightLabel.Text = "Altura Volar: 14  |  Bajo: -8"
HeightLabel.TextColor3 = Color3.fromRGB(160, 160, 180)
HeightLabel.Font = Enum.Font.Gotham
HeightLabel.TextSize = 11
HeightLabel.TextXAlignment = Enum.TextXAlignment.Left
HeightLabel.Parent = Main

local function createSmall(text, x, y)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 48, 0, 22)
    btn.Position = UDim2.new(0, x, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.Parent = Main
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    return btn
end

local FlyMinus = createSmall("Volar -", 8, 328)
local FlyPlus = createSmall("Volar +", 60, 328)
local UnderMinus = createSmall("Bajo -", 112, 328)
local UnderPlus = createSmall("Bajo +", 164, 328)

local RarityLabel = Instance.new("TextLabel")
RarityLabel.Size = UDim2.new(1, -16, 0, 14)
RarityLabel.Position = UDim2.new(0, 8, 0, 358)
RarityLabel.BackgroundTransparency = 1
RarityLabel.Text = "Filtro Rareza"
RarityLabel.TextColor3 = Color3.fromRGB(160, 160, 180)
RarityLabel.Font = Enum.Font.Gotham
RarityLabel.TextSize = 11
RarityLabel.TextXAlignment = Enum.TextXAlignment.Left
RarityLabel.Parent = Main

local function createRarity(name, key, x, y)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 62, 0, 20)
    btn.Position = UDim2.new(0, x, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(0, 110, 55)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 10
    btn.Parent = Main
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    btn.MouseButton1Click:Connect(function()
        RarityFilter[key] = not RarityFilter[key]
        btn.BackgroundColor3 = RarityFilter[key] and Color3.fromRGB(0, 110, 55) or Color3.fromRGB(70, 40, 40)
    end)
end

createRarity("Común", "Common", 8, 376)
createRarity("Raro", "Rare", 74, 376)
createRarity("Épico", "Epic", 140, 376)
createRarity("Legend", "Legendary", 8, 400)
createRarity("Mítico", "Mythic", 74, 400)

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -16, 0, 22)
StatusLabel.Position = UDim2.new(0, 8, 0, 424)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Listo"
StatusLabel.TextColor3 = Color3.fromRGB(140, 140, 160)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 11
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = Main

local function updateHeightLabel()
    HeightLabel.Text = string.format("Altura Volar: %d  |  Bajo: %d", CFG.FlyHeight, CFG.UnderHeight)
end

FlyMinus.MouseButton1Click:Connect(function()
    CFG.FlyHeight = math.max(4, CFG.FlyHeight - 1)
    updateHeightLabel()
end)
FlyPlus.MouseButton1Click:Connect(function()
    CFG.FlyHeight = math.min(30, CFG.FlyHeight + 1)
    updateHeightLabel()
end)
UnderMinus.MouseButton1Click:Connect(function()
    CFG.UnderHeight = math.max(-20, CFG.UnderHeight - 1)
    updateHeightLabel()
end)
UnderPlus.MouseButton1Click:Connect(function()
    CFG.UnderHeight = math.min(-2, CFG.UnderHeight + 1)
    updateHeightLabel()
end)

-- ==================== LÓGICA ====================

local function cleanupFly()
    if State.BodyVelocity then pcall(function() State.BodyVelocity:Destroy() end) State.BodyVelocity = nil end
    if State.BodyGyro then pcall(function() State.BodyGyro:Destroy() end) State.BodyGyro = nil end
    if Humanoid then Humanoid.PlatformStand = false end
end

local function enableFly()
    cleanupFly()
    if not Root then return end
    Humanoid.PlatformStand = true
    State.BodyVelocity = Instance.new("BodyVelocity")
    State.BodyVelocity.MaxForce = Vector3.new(180000, 180000, 180000)
    State.BodyVelocity.Velocity = Vector3.zero
    State.BodyVelocity.Parent = Root
    State.BodyGyro = Instance.new("BodyGyro")
    State.BodyGyro.MaxTorque = Vector3.new(180000, 180000, 180000)
    State.BodyGyro.P = 7000
    State.BodyGyro.Parent = Root
end

-- Detectar jugadores cercanos
local function getNearbyPlayer()
    if not Root then return nil end
    local closest, shortest = nil, CFG.PlayerHideDistance
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local dist = (Root.Position - hrp.Position).Magnitude
                if dist < shortest then
                    shortest = dist
                    closest = {player = plr, distance = dist}
                end
            end
        end
    end
    return closest
end

local function hideUnderground()
    if not Root then return end
    if not State.BodyVelocity then enableFly() end
    -- Bajar y quedarse quieto
    local hidePos = Vector3.new(Root.Position.X, Root.Position.Y + CFG.HideDepth, Root.Position.Z)
    -- Si ya estamos bajos, solo quieto
    if Root.Position.Y > (Root.Position.Y + CFG.HideDepth) + 3 then
        State.BodyVelocity.Velocity = Vector3.new(0, -40, 0)
    else
        State.BodyVelocity.Velocity = Vector3.zero
    end
    State.IsHiding = true
    StatusLabel.Text = "OCULTO - jugador cerca"
end

local function getClosestEnemy()
    if not Root then return nil end
    local folder = workspace:FindFirstChild("Animal_Live")
    if not folder then return nil end
    local agg = folder:FindFirstChild("Aggressors")
    if not agg then return nil end
    local closest, shortest = nil, CFG.FarmRadius
    for _, enemy in ipairs(agg:GetChildren()) do
        if enemy:IsA("Model") then
            local part = enemy:FindFirstChild("HumanoidRootPart") or enemy:FindFirstChild("Torso") or enemy.PrimaryPart or enemy:FindFirstChildWhichIsA("BasePart")
            if part then
                local dist = (Root.Position - part.Position).Magnitude
                if dist < shortest then
                    shortest = dist
                    closest = {part = part, distance = dist}
                end
            end
        end
    end
    return closest
end

local function countEnemies()
    local folder = workspace:FindFirstChild("Animal_Live")
    if not folder then return 0 end
    local agg = folder:FindFirstChild("Aggressors")
    if not agg then return 0 end
    local c = 0
    for _, obj in ipairs(agg:GetChildren()) do
        if obj:IsA("Model") then c += 1 end
    end
    return c
end

local function getRarity(drop)
    local r = drop:GetAttribute("Rarity") or drop:GetAttribute("rarity") or drop:GetAttribute("Tier")
    if typeof(r) == "string" then
        r = r:lower()
        if r:find("myth") then return "Mythic" end
        if r:find("legend") then return "Legendary" end
        if r:find("epic") then return "Epic" end
        if r:find("rare") then return "Rare" end
        if r:find("common") then return "Common" end
    end
    return "Unknown"
end

local function getClosestLoot()
    local folder = workspace:FindFirstChild("WorldBits")
    if not folder or not Root then return nil end
    local closest, shortest = nil, CFG.LootRadius
    for _, drop in ipairs(folder:GetChildren()) do
        local prompt = drop:FindFirstChildWhichIsA("ProximityPrompt", true)
        if prompt and prompt.Enabled then
            local rarity = getRarity(drop)
            if RarityFilter[rarity] then
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
                    if d < shortest then
                        shortest = d
                        closest = {prompt = prompt, pos = pos, dist = d}
                    end
                end
            end
        end
    end
    return closest
end

local function getWeapon()
    if not Character then return nil end
    for _, tool in ipairs(Character:GetChildren()) do
        if tool:IsA("Tool") then
            local n = tool.Name:lower()
            if not n:find("halloween") and not n:find("ghostnet") and not n:find("net") and not n:find("potion") then
                return tool
            end
        end
    end
end

local function doAttack()
    if tick() - State.lastAttack < CFG.AttackInterval then return end
    State.lastAttack = tick()
    local tool = getWeapon()
    if tool then pcall(function() tool:Activate() end) end
    pcall(function()
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
        task.wait(0.03)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
    end)
end

local function tryAdvanceTower()
    if tick() - State.lastAdvance < 2 then return end
    local keys = {"next floor", "nextfloor", "next", "siguiente", "ascend", "continue"}
    for _, gui in ipairs(PlayerGui:GetDescendants()) do
        if gui:IsA("TextButton") or gui:IsA("ImageButton") then
            local text = (gui.Text or ""):lower()
            local name = (gui.Name or ""):lower()
            for _, k in ipairs(keys) do
                if text:find(k) or name:find(k) then
                    pcall(function()
                        pcall(function() firesignal(gui.MouseButton1Click) end)
                        local p = gui.AbsolutePosition + gui.AbsoluteSize / 2
                        VirtualInputManager:SendMouseButtonEvent(p.X, p.Y, 0, true, game, 1)
                        task.wait(0.05)
                        VirtualInputManager:SendMouseButtonEvent(p.X, p.Y, 0, false, game, 1)
                    end)
                    State.lastAdvance = tick()
                    StatusLabel.Text = "Next Floor..."
                    return
                end
            end
        end
    end
end

local function getBestDoor()
    if not Root then return nil end
    local runs = workspace:FindFirstChild("DungeonRuns")
    if not runs then return nil end
    local candidates = {}
    for _, obj in ipairs(runs:GetDescendants()) do
        local name = obj.Name:lower()
        if (name == "door" or name == "exit") and not string.find(obj:GetFullName():lower(), "fake") then
            local id = obj:GetFullName()
            if not State.crossedDoors[id] then
                local part = obj:IsA("BasePart") and obj or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                if part then
                    local dist = (Root.Position - part.Position).Magnitude
                    if dist < 110 and dist > 3 then
                        table.insert(candidates, {part = part, dist = dist, id = id})
                    end
                end
            end
        end
    end
    table.sort(candidates, function(a, b) return a.dist < b.dist end)
    return candidates[1]
end

local function goThroughDoor(data)
    if not data or not Root then return end
    local door = data.part
    local dir = (door.Position - Root.Position)
    local flat = Vector3.new(dir.X, 0, dir.Z)
    if flat.Magnitude < 0.1 then flat = Root.CFrame.LookVector end
    flat = flat.Unit
    local deep = door.Position + flat * 15 + Vector3.new(0, 4, 0)

    if State.Style == "Walk" then
        if Humanoid then Humanoid:MoveTo(deep) end
        if (Root.Position - deep).Magnitude < 8 then
            pcall(function() Character:PivotTo(CFrame.new(deep)) end)
            State.crossedDoors[data.id] = true
        end
    else
        if not State.BodyVelocity then enableFly() end
        local dist = (Root.Position - deep).Magnitude
        if dist > 5 then
            State.BodyVelocity.Velocity = (deep - Root.Position).Unit * (CFG.MoveSpeed + 8)
            if State.BodyGyro then State.BodyGyro.CFrame = CFrame.lookAt(Root.Position, deep) end
        else
            State.BodyVelocity.Velocity = Vector3.zero
            pcall(function() Character:PivotTo(CFrame.new(deep)) end)
            State.crossedDoors[data.id] = true
        end
    end
    StatusLabel.Text = "Entrando a sala..."
end

local function setStyle(style)
    State.Style = style
    WalkBtn.BackgroundColor3 = style == "Walk" and Color3.fromRGB(0, 90, 160) or Color3.fromRGB(35, 35, 45)
    FlyBtn.BackgroundColor3 = style == "Fly" and Color3.fromRGB(0, 90, 160) or Color3.fromRGB(35, 35, 45)
    UnderBtn.BackgroundColor3 = style == "Under" and Color3.fromRGB(0, 90, 160) or Color3.fromRGB(35, 35, 45)
    if State.Mode ~= "None" and not State.IsHiding then
        if style == "Walk" then cleanupFly() else enableFly() end
    end
    StatusLabel.Text = "Estilo: " .. style
end

WalkBtn.MouseButton1Click:Connect(function() setStyle("Walk") end)
FlyBtn.MouseButton1Click:Connect(function() setStyle("Fly") end)
UnderBtn.MouseButton1Click:Connect(function() setStyle("Under") end)

-- ========== LOOP ==========
local function startLoop()
    if State.MainConn then State.MainConn:Disconnect() end
    if State.Mode == "None" then
        cleanupFly()
        State.IsHiding = false
        StatusLabel.Text = "Detenido"
        return
    end
    if State.Style ~= "Walk" then enableFly() end
    State.noEnemySince = tick()
    if State.Mode == "Dungeon" then State.crossedDoors = {} end

    State.MainConn = RunService.Heartbeat:Connect(function()
        if not Root or not Humanoid or Humanoid.Health <= 0 then return end
        if State.Mode == "None" then return end

        -- ========== PRIORIDAD: OCULTARSE DE JUGADORES ==========
        if State.HidePlayers then
            local nearby = getNearbyPlayer()
            if nearby then
                hideUnderground()
                return   -- No farmear mientras hay jugadores
            else
                if State.IsHiding then
                    State.IsHiding = false
                    StatusLabel.Text = "Jugador se fue - reanudando..."
                    if State.Style ~= "Walk" then enableFly() end
                end
            end
        end

        if State.Style ~= "Walk" and not State.BodyVelocity then enableFly() end

        -- LOOT
        if State.AutoLoot then
            local loot = getClosestLoot()
            if loot then
                StatusLabel.Text = "Recogiendo item..."
                if loot.dist > 7 then
                    if State.Style == "Walk" then
                        Humanoid:MoveTo(loot.pos)
                    else
                        State.BodyVelocity.Velocity = ((loot.pos + Vector3.new(0, 4, 0)) - Root.Position).Unit * 32
                        if State.BodyGyro then State.BodyGyro.CFrame = CFrame.lookAt(Root.Position, loot.pos) end
                    end
                else
                    if State.BodyVelocity then State.BodyVelocity.Velocity = Vector3.zero end
                    if fireproximityprompt then pcall(fireproximityprompt, loot.prompt) end
                end
                return
            end
        end

        local enemy = getClosestEnemy()
        local count = countEnemies()

        if enemy and count > 0 then
            State.noEnemySince = tick()
            local pos = enemy.part.Position
            local horizontal = Vector3.new(Root.Position.X - pos.X, 0, Root.Position.Z - pos.Z).Magnitude

            if State.Style == "Walk" then
                cleanupFly()
                if horizontal > 6 then Humanoid:MoveTo(pos) else Humanoid:MoveTo(Root.Position) end
            elseif State.Style == "Fly" then
                local h = (horizontal < 8) and CFG.AttackHeight or CFG.FlyHeight
                local goal = Vector3.new(pos.X, pos.Y + h, pos.Z)
                local dir = goal - Root.Position
                if dir.Magnitude > 1.5 then
                    State.BodyVelocity.Velocity = dir.Unit * CFG.MoveSpeed
                else
                    State.BodyVelocity.Velocity = Vector3.zero
                end
                if State.BodyGyro then State.BodyGyro.CFrame = CFrame.lookAt(Root.Position, pos) end
            else -- Under
                local goal = Vector3.new(pos.X, pos.Y + CFG.UnderHeight, pos.Z)
                local dir = goal - Root.Position
                if dir.Magnitude > 1.5 then
                    State.BodyVelocity.Velocity = dir.Unit * CFG.MoveSpeed
                else
                    State.BodyVelocity.Velocity = Vector3.zero
                end
                if State.BodyGyro then State.BodyGyro.CFrame = CFrame.lookAt(Root.Position, pos) end
            end

            if horizontal < 13 then
                doAttack()
                StatusLabel.Text = "Atacando (" .. count .. ")"
            else
                StatusLabel.Text = "Yendo (" .. count .. ")"
            end
        else
            if State.BodyVelocity then State.BodyVelocity.Velocity = Vector3.zero end
            local t = tick() - State.noEnemySince

            if State.Mode == "Tower" and t > 1.0 then
                tryAdvanceTower()
                StatusLabel.Text = "Buscando Next Floor..."
            elseif State.Mode == "Dungeon" and t > 0.8 then
                local door = getBestDoor()
                if door then goThroughDoor(door)
                else StatusLabel.Text = "Esperando puerta..." end
            else
                StatusLabel.Text = "Buscando enemigos..."
            end
        end
    end)
end

local function setMode(mode)
    State.Mode = mode
    WorldBtn.Text = "Mundo: " .. (mode == "World" and "ON" or "OFF")
    WorldBtn.BackgroundColor3 = mode == "World" and Color3.fromRGB(0, 120, 60) or Color3.fromRGB(35, 35, 45)
    TowerBtn.Text = "Torre: " .. (mode == "Tower" and "ON" or "OFF")
    TowerBtn.BackgroundColor3 = mode == "Tower" and Color3.fromRGB(0, 120, 60) or Color3.fromRGB(35, 35, 45)
    DungeonBtn.Text = "Dungeon: " .. (mode == "Dungeon" and "ON" or "OFF")
    DungeonBtn.BackgroundColor3 = mode == "Dungeon" and Color3.fromRGB(0, 120, 60) or Color3.fromRGB(35, 35, 45)
    startLoop()
end

WorldBtn.MouseButton1Click:Connect(function()
    setMode(State.Mode == "World" and "None" or "World")
end)
TowerBtn.MouseButton1Click:Connect(function()
    setMode(State.Mode == "Tower" and "None" or "Tower")
end)
DungeonBtn.MouseButton1Click:Connect(function()
    setMode(State.Mode == "Dungeon" and "None" or "Dungeon")
end)

LootBtn.MouseButton1Click:Connect(function()
    State.AutoLoot = not State.AutoLoot
    LootBtn.Text = "Auto Recoger: " .. (State.AutoLoot and "ON" or "OFF")
    LootBtn.BackgroundColor3 = State.AutoLoot and Color3.fromRGB(0, 100, 170) or Color3.fromRGB(35, 35, 45)
end)

HideBtn.MouseButton1Click:Connect(function()
    State.HidePlayers = not State.HidePlayers
    HideBtn.Text = "Ocultar si hay jugadores: " .. (State.HidePlayers and "ON" or "OFF")
    HideBtn.BackgroundColor3 = State.HidePlayers and Color3.fromRGB(140, 60, 40) or Color3.fromRGB(35, 35, 45)
    if not State.HidePlayers then
        State.IsHiding = false
    end
end)

print("✅ POLY LOOT v1.3.1 - POR PARTE DE TH MASTER")
print("Nuevo: Ocultarse si hay jugadores cerca")

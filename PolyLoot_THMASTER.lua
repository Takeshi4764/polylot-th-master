-- =====================================================
-- POLY LOOT - TH MASTER
-- Mundo + Torre + Dungeon + Loot + Posiciones + Estilos
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
    SafeHeight = 14,
    AttackHeight = 9,
    UnderHeight = -6,
    MoveSpeed = 36,
    AttackInterval = 0.37,
    LootRadius = 55,
}

local State = {
    WorldOn = false,
    TowerOn = false,
    DungeonOn = false,
    AutoLoot = true,
    CombatStyle = "Fly",
    MainConn = nil,
    BodyVelocity = nil,
    BodyGyro = nil,
    lastAttack = 0,
    lastAdvance = 0,
    noEnemySince = 0,
    crossedDoors = {},
    SavedPositions = {},
    FarmAllEnemies = true,   -- por defecto todos
    AllowedEnemies = {},     -- nombres específicos si se desactiva "Todos"
}

local RarityFilter = {
    All = true,              -- Todos los ítems (por defecto)
    Common = true,
    Rare = true,
    Epic = true,
    Legendary = true,
    Mythic = true,
    Unknown = true,
}

-- ==================== UI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "THMASTER_PolyLoot"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 290, 0, 400)
Main.Position = UDim2.new(0.02, 0, 0.18, 0)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(55, 55, 75)
Stroke.Thickness = 1.2
Stroke.Parent = Main

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 38)
Header.BackgroundColor3 = Color3.fromRGB(26, 26, 36)
Header.BorderSizePixel = 0
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0, 14)
HeaderFix.Position = UDim2.new(0, 0, 1, -14)
HeaderFix.BackgroundColor3 = Color3.fromRGB(26, 26, 36)
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -70, 0, 20)
Title.Position = UDim2.new(0, 12, 0, 3)
Title.BackgroundTransparency = 1
Title.Text = "POLY LOOT"
Title.TextColor3 = Color3.fromRGB(240, 240, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(1, -70, 0, 14)
Credit.Position = UDim2.new(0, 12, 0, 21)
Credit.BackgroundTransparency = 1
Credit.Text = "POR PARTE DE TH MASTER"
Credit.TextColor3 = Color3.fromRGB(110, 130, 200)
Credit.Font = Enum.Font.Gotham
Credit.TextSize = 9
Credit.TextXAlignment = Enum.TextXAlignment.Left
Credit.Parent = Header

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 28, 0, 22)
MinBtn.Position = UDim2.new(1, -36, 0, 8)
MinBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 14
MinBtn.Parent = Header
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

-- Tabs
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -16, 0, 28)
TabBar.Position = UDim2.new(0, 8, 0, 44)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Main

local Tabs = {"Farm", "Loot", "Estilo", "Enemigos", "Posiciones"}
local TabButtons = {}
local Pages = {}
local CurrentTab = "Farm"

local function createTab(name, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1/#Tabs, -3, 1, 0)
    btn.Position = UDim2.new((order-1)/#Tabs, 1, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(170, 170, 190)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.Parent = TabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    TabButtons[name] = btn

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -16, 1, -95)
    page.Position = UDim2.new(0, 8, 0, 78)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = (name == "Farm")
    page.Parent = Main
    Pages[name] = page
    return btn
end

for i, name in ipairs(Tabs) do
    createTab(name, i)
end

local function switchTab(name)
    CurrentTab = name
    for n, page in pairs(Pages) do
        page.Visible = (n == name)
        TabButtons[n].BackgroundColor3 = (n == name) and Color3.fromRGB(65, 85, 160) or Color3.fromRGB(35, 35, 48)
        TabButtons[n].TextColor3 = (n == name) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(170, 170, 190)
    end
end

for name, btn in pairs(TabButtons) do
    btn.MouseButton1Click:Connect(function() switchTab(name) end)
end
switchTab("Farm")

-- Status
local StatusBar = Instance.new("TextLabel")
StatusBar.Size = UDim2.new(1, -16, 0, 18)
StatusBar.Position = UDim2.new(0, 8, 1, -26)
StatusBar.BackgroundTransparency = 1
StatusBar.Text = "Listo"
StatusBar.TextColor3 = Color3.fromRGB(130, 130, 155)
StatusBar.Font = Enum.Font.Gotham
StatusBar.TextSize = 11
StatusBar.TextXAlignment = Enum.TextXAlignment.Left
StatusBar.Parent = Main

-- Minimize
local minimized = false
local fullSize = UDim2.new(0, 290, 0, 400)
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        Main.Size = UDim2.new(0, 165, 0, 38)
        MinBtn.Text = "+"
        for _, c in ipairs(Main:GetChildren()) do
            if c ~= Header and c:IsA("GuiObject") then c.Visible = false end
        end
    else
        Main.Size = fullSize
        MinBtn.Text = "—"
        for _, c in ipairs(Main:GetChildren()) do
            if c:IsA("GuiObject") then c.Visible = true end
        end
        switchTab(CurrentTab)
    end
end)

-- ========== UI HELPERS ==========
local function makeToggle(parent, text, y, default, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 28)
    btn.Position = UDim2.new(0, 0, 0, y)
    btn.BackgroundColor3 = default and Color3.fromRGB(0, 115, 70) or Color3.fromRGB(40, 40, 52)
    btn.Text = text .. (default and ": ON" or ": OFF")
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local on = default
    btn.MouseButton1Click:Connect(function()
        on = not on
        btn.Text = text .. (on and ": ON" or ": OFF")
        btn.BackgroundColor3 = on and Color3.fromRGB(0, 115, 70) or Color3.fromRGB(40, 40, 52)
        callback(on, btn)
    end)
    return btn
end

local function makeLabel(parent, text, y)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 16)
    lbl.Position = UDim2.new(0, 0, 0, y)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(150, 150, 170)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = parent
    return lbl
end

-- ========== PÁGINA FARM ==========
local FarmPage = Pages["Farm"]
makeLabel(FarmPage, "Modos de farmeo (solo uno)", 0)

local function exclusiveFarm(which)
    State.WorldOn = (which == "World")
    State.TowerOn = (which == "Tower")
    State.DungeonOn = (which == "Dungeon")
    if which == "Dungeon" then State.crossedDoors = {} end
    restartLoop()
end

makeToggle(FarmPage, "Mundo", 20, false, function(v)
    if v then exclusiveFarm("World") else State.WorldOn = false; restartLoop() end
end)
makeToggle(FarmPage, "Torre", 52, false, function(v)
    if v then exclusiveFarm("Tower") else State.TowerOn = false; restartLoop() end
end)
makeToggle(FarmPage, "Dungeon", 84, false, function(v)
    if v then exclusiveFarm("Dungeon") else State.DungeonOn = false; restartLoop() end
end)

-- ========== PÁGINA LOOT ==========
local LootPage = Pages["Loot"]
makeLabel(LootPage, "Recolección", 0)
makeToggle(LootPage, "Auto Recoger", 18, true, function(v) State.AutoLoot = v end)

makeLabel(LootPage, "Filtro de rareza", 54)

-- Todos los ítems (por defecto)
local AllItemsBtn = makeToggle(LootPage, "Todos los ítems", 72, true, function(v)
    RarityFilter.All = v
    if v then
        RarityFilter.Common = true
        RarityFilter.Rare = true
        RarityFilter.Epic = true
        RarityFilter.Legendary = true
        RarityFilter.Mythic = true
        RarityFilter.Unknown = true
    end
end)

makeToggle(LootPage, "Común", 104, true, function(v) RarityFilter.Common = v; if not v then RarityFilter.All = false end end)
makeToggle(LootPage, "Raro", 134, true, function(v) RarityFilter.Rare = v; if not v then RarityFilter.All = false end end)
makeToggle(LootPage, "Épico", 164, true, function(v) RarityFilter.Epic = v; if not v then RarityFilter.All = false end end)
makeToggle(LootPage, "Legendario", 194, true, function(v) RarityFilter.Legendary = v; if not v then RarityFilter.All = false end end)
makeToggle(LootPage, "Mítico", 224, true, function(v) RarityFilter.Mythic = v; if not v then RarityFilter.All = false end end)

makeLabel(LootPage, "Si activas \"Todos\", acepta cualquier rareza nueva", 258)

-- ========== PÁGINA ESTILO ==========
local StylePage = Pages["Estilo"]
makeLabel(StylePage, "Estilo de combate", 0)

local function setStyle(style, btn)
    State.CombatStyle = style
    for _, b in pairs(StylePage:GetChildren()) do
        if b:IsA("TextButton") and b.Name:find("Style_") then
            b.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
        end
    end
    btn.BackgroundColor3 = Color3.fromRGB(65, 95, 175)
    StatusBar.Text = "Estilo: " .. style
end

local function makeStyleBtn(text, style, y)
    local btn = Instance.new("TextButton")
    btn.Name = "Style_" .. style
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, y)
    btn.BackgroundColor3 = (State.CombatStyle == style) and Color3.fromRGB(65, 95, 175) or Color3.fromRGB(40, 40, 52)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.Parent = StylePage
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function() setStyle(style, btn) end)
end

makeStyleBtn("Caminar (suelo)", "Walk", 20)
makeStyleBtn("Volar encima (recomendado)", "Fly", 54)
makeStyleBtn("Bajo tierra (mirando arriba)", "Under", 88)

makeLabel(StylePage, "Fly = altura segura sin recibir daño", 128)
makeLabel(StylePage, "Under = debajo del enemigo mirando arriba", 146)

-- ========== PÁGINA ENEMIGOS ==========
local EnemyPage = Pages["Enemigos"]
makeLabel(EnemyPage, "Filtro de enemigos", 0)

makeToggle(EnemyPage, "Todos los enemigos", 20, true, function(v)
    State.FarmAllEnemies = v
    StatusBar.Text = v and "Farmeando todos" or "Filtro activo"
end)

makeLabel(EnemyPage, "Por ahora los enemigos usan IDs (UUID).", 56)
makeLabel(EnemyPage, "La opción \"Todos\" es la más estable.", 74)
makeLabel(EnemyPage, "Si más adelante el juego usa nombres", 92)
makeLabel(EnemyPage, "reales, se puede expandir esta pestaña.", 110)

-- ========== PÁGINA POSICIONES ==========
local PosPage = Pages["Posiciones"]
makeLabel(PosPage, "Guardar / Teletransportar", 0)

local NameBox = Instance.new("TextBox")
NameBox.Size = UDim2.new(1, 0, 0, 28)
NameBox.Position = UDim2.new(0, 0, 0, 20)
NameBox.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
NameBox.Text = ""
NameBox.PlaceholderText = "Nombre de la posición..."
NameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
NameBox.PlaceholderColor3 = Color3.fromRGB(110, 110, 130)
NameBox.Font = Enum.Font.Gotham
NameBox.TextSize = 12
NameBox.ClearTextOnFocus = false
NameBox.Parent = PosPage
Instance.new("UICorner", NameBox).CornerRadius = UDim.new(0, 6)

local SaveBtn = Instance.new("TextButton")
SaveBtn.Size = UDim2.new(1, 0, 0, 28)
SaveBtn.Position = UDim2.new(0, 0, 0, 54)
SaveBtn.BackgroundColor3 = Color3.fromRGB(0, 105, 85)
SaveBtn.Text = "Guardar posición actual"
SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveBtn.Font = Enum.Font.GothamBold
SaveBtn.TextSize = 12
SaveBtn.Parent = PosPage
Instance.new("UICorner", SaveBtn).CornerRadius = UDim.new(0, 6)

local PosScroll = Instance.new("ScrollingFrame")
PosScroll.Size = UDim2.new(1, 0, 1, -95)
PosScroll.Position = UDim2.new(0, 0, 0, 90)
PosScroll.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
PosScroll.BorderSizePixel = 0
PosScroll.ScrollBarThickness = 3
PosScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
PosScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
PosScroll.Parent = PosPage
Instance.new("UICorner", PosScroll).CornerRadius = UDim.new(0, 6)

local PosList = Instance.new("UIListLayout")
PosList.Padding = UDim.new(0, 4)
PosList.Parent = PosScroll

local function refreshPosList()
    for _, c in ipairs(PosScroll:GetChildren()) do
        if c:IsA("Frame") then c:Destroy() end
    end
    for name, cf in pairs(State.SavedPositions) do
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, -6, 0, 28)
        row.BackgroundColor3 = Color3.fromRGB(36, 36, 50)
        row.Parent = PosScroll
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 5)

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -70, 1, 0)
        lbl.Position = UDim2.new(0, 8, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = name
        lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
        lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = row

        local tp = Instance.new("TextButton")
        tp.Size = UDim2.new(0, 30, 0, 20)
        tp.Position = UDim2.new(1, -62, 0.5, -10)
        tp.BackgroundColor3 = Color3.fromRGB(0, 95, 170)
        tp.Text = "TP"
        tp.TextColor3 = Color3.fromRGB(255, 255, 255)
        tp.Font = Enum.Font.GothamBold
        tp.TextSize = 11
        tp.Parent = row
        Instance.new("UICorner", tp).CornerRadius = UDim.new(0, 4)
        tp.MouseButton1Click:Connect(function()
            if Character and Root then
                Character:PivotTo(cf)
                StatusBar.Text = "TP → " .. name
            end
        end)

        local del = Instance.new("TextButton")
        del.Size = UDim2.new(0, 26, 0, 20)
        del.Position = UDim2.new(1, -28, 0.5, -10)
        del.BackgroundColor3 = Color3.fromRGB(130, 40, 40)
        del.Text = "X"
        del.TextColor3 = Color3.fromRGB(255, 255, 255)
        del.Font = Enum.Font.GothamBold
        del.TextSize = 11
        del.Parent = row
        Instance.new("UICorner", del).CornerRadius = UDim.new(0, 4)
        del.MouseButton1Click:Connect(function()
            State.SavedPositions[name] = nil
            refreshPosList()
        end)
    end
end

SaveBtn.MouseButton1Click:Connect(function()
    local name = NameBox.Text
    if name == "" then name = "Pos_" .. tostring(math.random(100,999)) end
    if Root then
        State.SavedPositions[name] = Root.CFrame
        NameBox.Text = ""
        refreshPosList()
        StatusBar.Text = "Guardado: " .. name
    end
end)

-- ==================== LÓGICA ====================

local function cleanupFly()
    if State.BodyVelocity then pcall(function() State.BodyVelocity:Destroy() end) State.BodyVelocity = nil end
    if State.BodyGyro then pcall(function() State.BodyGyro:Destroy() end) State.BodyGyro = nil end
    if Humanoid then Humanoid.PlatformStand = false end
end

local function enableFly()
    cleanupFly()
    if not Root or State.CombatStyle == "Walk" then return end
    Humanoid.PlatformStand = true
    State.BodyVelocity = Instance.new("BodyVelocity")
    State.BodyVelocity.MaxForce = Vector3.new(200000, 200000, 200000)
    State.BodyVelocity.Velocity = Vector3.zero
    State.BodyVelocity.Parent = Root
    State.BodyGyro = Instance.new("BodyGyro")
    State.BodyGyro.MaxTorque = Vector3.new(200000, 200000, 200000)
    State.BodyGyro.P = 8000
    State.BodyGyro.Parent = Root
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
            if State.FarmAllEnemies or State.AllowedEnemies[enemy.Name] then
                local part = enemy:FindFirstChild("HumanoidRootPart") or enemy:FindFirstChild("Torso") or enemy.PrimaryPart or enemy:FindFirstChildWhichIsA("BasePart")
                if part then
                    local dist = (Root.Position - part.Position).Magnitude
                    if dist < shortest then
                        shortest = dist
                        closest = {part = part, distance = dist, name = enemy.Name}
                    end
                end
            end
        end
    end
    return closest
end

local function getRarity(drop)
    if RarityFilter.All then return "All" end
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
            if RarityFilter.All or RarityFilter[rarity] then
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
            if not n:find("halloween") and not n:find("ghostnet") and not n:find("net") then
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

local function moveTo(pos, lookAt)
    if not Root then return end
    local style = State.CombatStyle
    if style == "Walk" then
        cleanupFly()
        if Humanoid then Humanoid:MoveTo(pos) end
        if (Root.Position - pos).Magnitude > 22 then
            Character:PivotTo(CFrame.new(pos + Vector3.new(0, 3, 0)))
        end
    else
        if not State.BodyVelocity then enableFly() end
        local height = (style == "Under") and CFG.UnderHeight or CFG.SafeHeight
        local goal = Vector3.new(pos.X, pos.Y + height, pos.Z)
        local dir = goal - Root.Position
        if dir.Magnitude > 1.5 then
            State.BodyVelocity.Velocity = dir.Unit * CFG.MoveSpeed
        else
            State.BodyVelocity.Velocity = Vector3.zero
        end
        if State.BodyGyro and lookAt then
            State.BodyGyro.CFrame = CFrame.lookAt(Root.Position, lookAt)
        end
    end
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
                        local p = gui.AbsolutePosition + gui.AbsoluteSize/2
                        VirtualInputManager:SendMouseButtonEvent(p.X, p.Y, 0, true, game, 1)
                        task.wait(0.05)
                        VirtualInputManager:SendMouseButtonEvent(p.X, p.Y, 0, false, game, 1)
                    end)
                    State.lastAdvance = tick()
                    StatusBar.Text = "Next Floor..."
                    return
                end
            end
        end
    end
end

local function getNextDoor()
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
                    if dist < 120 and dist > 4 then
                        table.insert(candidates, {part = part, dist = dist, id = id})
                    end
                end
            end
        end
    end
    table.sort(candidates, function(a,b) return a.dist < b.dist end)
    return candidates[1]
end

local function goThroughDoor(doorData)
    if not doorData or not Root then return end
    local door = doorData.part
    local dir = (door.Position - Root.Position)
    local flat = Vector3.new(dir.X, 0, dir.Z)
    if flat.Magnitude < 0.1 then flat = Root.CFrame.LookVector end
    flat = flat.Unit
    local deep = door.Position + flat * 16 + Vector3.new(0, 4, 0)
    local dist = (Root.Position - deep).Magnitude
    if dist > 6 then
        moveTo(deep, door.Position)
        StatusBar.Text = "Entrando a sala..."
    else
        pcall(function() Character:PivotTo(CFrame.new(deep)) end)
        State.crossedDoors[doorData.id] = true
        StatusBar.Text = "Sala nueva"
        if State.BodyVelocity then State.BodyVelocity.Velocity = Vector3.zero end
    end
end

function restartLoop()
    if State.MainConn then State.MainConn:Disconnect() end
    if not (State.WorldOn or State.TowerOn or State.DungeonOn) then
        cleanupFly()
        StatusBar.Text = "Detenido"
        return
    end
    if State.CombatStyle ~= "Walk" then enableFly() end
    State.noEnemySince = tick()

    State.MainConn = RunService.Heartbeat:Connect(function()
        if not Root or not Humanoid or Humanoid.Health <= 0 then return end
        if not (State.WorldOn or State.TowerOn or State.DungeonOn) then return end

        -- PRIORIDAD 1: LOOT
        if State.AutoLoot then
            local loot = getClosestLoot()
            if loot then
                StatusBar.Text = "Recogiendo item..."
                if loot.dist > 7 then
                    moveTo(loot.pos + Vector3.new(0, 3, 0), loot.pos)
                else
                    if State.BodyVelocity then State.BodyVelocity.Velocity = Vector3.zero end
                    if fireproximityprompt then pcall(fireproximityprompt, loot.prompt) end
                end
                return
            end
        end

        -- PRIORIDAD 2: COMBATE
        local enemy = getClosestEnemy()
        if enemy then
            State.noEnemySince = tick()
            local pos = enemy.part.Position
            local horizontal = Vector3.new(Root.Position.X - pos.X, 0, Root.Position.Z - pos.Z).Magnitude

            if State.CombatStyle == "Fly" then
                local h = (horizontal < 8) and CFG.AttackHeight or CFG.SafeHeight
                moveTo(Vector3.new(pos.X, pos.Y + h, pos.Z), pos)
            elseif State.CombatStyle == "Under" then
                moveTo(Vector3.new(pos.X, pos.Y + CFG.UnderHeight, pos.Z), pos)
            else
                moveTo(pos, pos)
            end

            if horizontal < 13 then
                doAttack()
                StatusBar.Text = "Atacando"
            else
                StatusBar.Text = "Yendo al enemigo"
            end
        else
            if State.BodyVelocity then State.BodyVelocity.Velocity = Vector3.zero end
            local t = tick() - State.noEnemySince

            if State.TowerOn and t > 1.0 then
                tryAdvanceTower()
                StatusBar.Text = "Buscando Next Floor..."
            elseif State.DungeonOn and t > 0.8 then
                local door = getNextDoor()
                if door then goThroughDoor(door)
                else StatusBar.Text = "Esperando puerta..." end
            elseif State.WorldOn then
                StatusBar.Text = "Buscando enemigos..."
            end
        end
    end)
end

print("✅ POLY LOOT - POR PARTE DE TH MASTER")
print("Pestañas: Farm | Loot | Estilo | Enemigos | Posiciones")

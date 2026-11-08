-- =====================================================
-- POLY LOOT - TH MASTER v1.6.2
-- Modos: Caminar / Volar / Subterraneo
-- Novedades: Autocura, Zona de farmeo (circulo azul),
-- Camara libre, Auto-retorno bajo tierra, UI minimizable
-- POR PARTE DE TH MASTER
-- =====================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

local VIM
pcall(function() VIM = game:GetService("VirtualInputManager") end)

-- ============ PERSONAJE ============
local Character, Humanoid, Root
local Ready = false
local function updateCharacter()
    Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid", 10)
    Root = Character:WaitForChild("HumanoidRootPart", 10)
end
updateCharacter()
Ready = true

pcall(function()
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

-- ============ BUSCAR WeaponAttack ============
local WeaponAttack = nil
local function findWeaponAttack()
    local candidates = {}
    pcall(function()
        local we = ReplicatedStorage:FindFirstChild("Weapon_Engine")
        if we then
            local rem = we:FindFirstChild("Remotes") or we:FindFirstChild("Remote") or we
            local atk = rem:FindFirstChild("WeaponAttack") or rem:FindFirstChild("Attack") or rem:FindFirstChild("Weapon_Attack")
            if atk then table.insert(candidates, atk) end
        end
    end)
    pcall(function()
        for _, d in ipairs(ReplicatedStorage:GetDescendants()) do
            if d:IsA("RemoteEvent") or d:IsA("UnreliableRemoteEvent") then
                local n = d.Name:lower()
                if n:find("weaponattack") or n == "attack" or n:find("weapon_attack") or n:find("swing") then
                    table.insert(candidates, d)
                end
            end
        end
    end)
    return candidates[1]
end
WeaponAttack = findWeaponAttack()

-- ============ CONFIG ============
local RADIUS = 70            -- radio de busqueda si NO hay zona fijada
local HEIGHT = 8             -- altura (volar) / profundidad (subterraneo)
local SPEED = 30             -- velocidad al farmear
local ATK_CD = 0.12
local RETURN_SPEED = 45      -- velocidad del auto-retorno bajo tierra (moderada)
local RETURN_DEPTH = 45      -- cuanto se hunde bajo el suelo al regresar (mas = menos visible)
local MELEE_RANGE = 10     -- modo CAMINAR: distancia maxima al enemigo para empezar a atacar
local HEAL_CD = 1.5          -- espera minima entre curaciones
local HEAL_USE_TIME = 0.6    -- tiempo que se mantiene el item equipado al comer

local MODES = {"CAMINAR", "VOLAR", "SUBTERRANEO"}
local Mode = 2

-- ============ ESTADO ============
local Running = true
local FarmOn = false
local LootOn = true
local NoclipOn = true
local HealOn = false
local HealPct = 50
local ReturnOn = true
local FreeCamOn = false

local ZoneOn = false
local ZoneCenter, ZoneGroundY
local ZoneRadius = 60
local LastFarmPos

local Returning = false
local ReturnPhase = 1
local ReturnDepthY = 0
local ReturnDropAt = 0

local Healing = false
local lastHeal = 0
local lastAtk = 0

local Conn, NoclipConn
local BV, BG
local conns = {}

local camYaw, camPitch, camDist = 0, -0.4, 25
local camDrag = false

-- ============ UI ============
local function getGuiParent()
    local ok, p = pcall(function() return (gethui and gethui()) or game:GetService("CoreGui") end)
    if ok and p then return p end
    return LocalPlayer:WaitForChild("PlayerGui")
end
local GuiParent = getGuiParent()
for _, n in ipairs({"THMASTER15", "THMASTER16"}) do
    local old = GuiParent:FindFirstChild(n)
    if old then old:Destroy() end
end

local C = {
    off = Color3.fromRGB(40, 40, 52),
    on = Color3.fromRGB(0, 130, 60),
    blue = Color3.fromRGB(0, 90, 150),
    brown = Color3.fromRGB(120, 80, 30),
    purple = Color3.fromRGB(90, 50, 140),
    zone = Color3.fromRGB(0, 110, 200),
    heal = Color3.fromRGB(190, 60, 90),
    cam = Color3.fromRGB(30, 120, 120),
    ret = Color3.fromRGB(150, 100, 20),
    text = Color3.fromRGB(230, 230, 240),
}

local Gui = Instance.new("ScreenGui")
Gui.Name = "THMASTER16"
Gui.ResetOnSpawn = false
Gui.DisplayOrder = 999
Gui.Parent = GuiParent

local FULL_W, FULL_H, MIN_W, HEADER_H = 224, 420, 150, 30

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(FULL_W, FULL_H)
Main.Position = UDim2.new(0.02, 0, 0.12, 0)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Main.BorderSizePixel = 0
Main.Active = true
Main.Parent = Gui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, HEADER_H)
Header.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
Header.BorderSizePixel = 0
Header.Active = true
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -66, 1, 0)
Title.Position = UDim2.new(0, 8, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "TH MASTER v1.6.2"
Title.TextColor3 = C.text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local function headerBtn(text, xOffset, color)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(24, 22)
    b.Position = UDim2.new(1, xOffset, 0, 4)
    b.BackgroundColor3 = color
    b.Text = text
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.Parent = Header
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
    return b
end
local MinBtn = headerBtn("-", -58, Color3.fromRGB(70, 70, 90))
local CloseBtn = headerBtn("X", -30, Color3.fromRGB(170, 50, 50))

local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, 0, 1, -HEADER_H - 2)
Content.Position = UDim2.new(0, 0, 0, HEADER_H + 2)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.Parent = Main

local layout = Instance.new("UIListLayout")
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 5)
layout.Parent = Content

local pad = Instance.new("UIPadding")
pad.PaddingLeft = UDim.new(0, 8)
pad.PaddingRight = UDim.new(0, 10)
pad.PaddingTop = UDim.new(0, 4)
pad.PaddingBottom = UDim.new(0, 8)
pad.Parent = Content

local order = 0
local function nextOrder() order = order + 1 return order end

local function mkLabel(text, height, color, font)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 0, height or 16)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = color or C.text
    l.Font = font or Enum.Font.Gotham
    l.TextSize = 12
    l.TextWrapped = true
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextYAlignment = Enum.TextYAlignment.Top
    l.LayoutOrder = nextOrder()
    l.Parent = Content
    return l
end

local function mkSection(text)
    return mkLabel(text, 14, Color3.fromRGB(120, 140, 200), Enum.Font.GothamBold)
end

local function styleBtn(b, color)
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
end

local function mkBtn(text, color)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 28)
    b.Text = text
    b.TextTruncate = Enum.TextTruncate.AtEnd
    b.LayoutOrder = nextOrder()
    b.Parent = Content
    styleBtn(b, color or C.off)
    return b
end

local function mkStepper()
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 28)
    row.BackgroundTransparency = 1
    row.LayoutOrder = nextOrder()
    row.Parent = Content

    local minus = Instance.new("TextButton")
    minus.Size = UDim2.new(0, 40, 1, 0)
    minus.Text = "-"
    minus.Parent = row
    styleBtn(minus, C.off)

    local plus = Instance.new("TextButton")
    plus.Size = UDim2.new(0, 40, 1, 0)
    plus.Position = UDim2.new(1, -40, 0, 0)
    plus.Text = "+"
    plus.Parent = row
    styleBtn(plus, C.off)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -88, 1, 0)
    lbl.Position = UDim2.new(0, 44, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = C.text
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.Parent = row
    return lbl, minus, plus
end

local function setToggle(btn, name, state, onColor)
    btn.Text = name .. ": " .. (state and "ON" or "OFF")
    btn.BackgroundColor3 = state and onColor or C.off
end

-- Estado + remoto
local Status = mkLabel("Listo", 40, Color3.fromRGB(160, 160, 180))
local RemoteLbl = mkLabel(WeaponAttack and ("Remoto: " .. WeaponAttack.Name) or "Remoto: NO encontrado", 14,
    WeaponAttack and Color3.fromRGB(100, 220, 120) or Color3.fromRGB(255, 120, 120))

-- Farm + zona (justo debajo del farm)
local FarmBtn = mkBtn("FARM: OFF")
local SetZoneBtn = mkBtn("FIJAR ZONA AQUI", C.zone)
local ZoneBtn = mkBtn("ZONA: OFF")
local ZoneLbl, ZoneMinus, ZonePlus = mkStepper()

mkSection("GENERAL")
local LootBtn = mkBtn("LOOT: ON", C.blue)
local NoclipBtn = mkBtn("NOCLIP: ON", C.brown)
local ModeBtn = mkBtn("MODO: VOLAR", C.purple)
local HeightLbl, HeightMinus, HeightPlus = mkStepper()

mkSection("AUTOCURA")
local HealBtn = mkBtn("AUTOCURA: OFF")
local HealItemBtn = mkBtn("ITEM: Galleta", C.heal)
local HealLbl, HealMinus, HealPlus = mkStepper()

mkSection("CAMARA / RETORNO")
local CamBtn = mkBtn("CAMARA LIBRE: OFF")
local CamLbl, CamMinus, CamPlus = mkStepper()
local RetBtn = mkBtn("AUTO-RETORNO: ON", C.ret)

local function refreshHeightLbl() HeightLbl.Text = (Mode == 3 and "Prof: " or "Alt: ") .. HEIGHT end
local function refreshZoneLbl() ZoneLbl.Text = "Radio zona: " .. ZoneRadius end
local function refreshHealLbl() HealLbl.Text = "Curar si vida <= " .. HealPct .. "%" end
local function refreshCamLbl() CamLbl.Text = "Dist camara: " .. camDist end
refreshHeightLbl(); refreshZoneLbl(); refreshHealLbl(); refreshCamLbl()
setToggle(RetBtn, "AUTO-RETORNO", ReturnOn, C.ret)

-- Arrastrar ventana (mouse y tactil)
local dragging, dragStart, startPos = false, nil, nil
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
table.insert(conns, UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end))

-- Minimizar
local Minimized = false
local function updateTitle()
    Title.Text = Minimized and "TH v1.6.2" or "TH MASTER v1.6.2"
    Title.TextColor3 = FarmOn and Color3.fromRGB(100, 255, 140) or C.text
end
MinBtn.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    Content.Visible = not Minimized
    Main.Size = Minimized and UDim2.fromOffset(MIN_W, HEADER_H) or UDim2.fromOffset(FULL_W, FULL_H)
    MinBtn.Text = Minimized and "+" or "-"
    updateTitle()
end)

-- ============ NOCLIP ============
local function startNoclip()
    if NoclipConn then return end
    NoclipConn = RunService.Stepped:Connect(function()
        if not Character then return end
        for _, p in ipairs(Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end)
end

local function stopNoclip()
    if NoclipConn then NoclipConn:Disconnect() NoclipConn = nil end
end

-- El noclip solo se usa volando/bajo tierra (caminando con noclip te caerias del mapa)
local function refreshNoclip()
    local need = (Returning and ReturnPhase < 5) or (FarmOn and Mode ~= 1 and (Mode == 3 or NoclipOn))
    if need then startNoclip() else stopNoclip() end
end

-- ============ FLY ============
local function stopFly()
    if BV then pcall(function() BV:Destroy() end) BV = nil end
    if BG then pcall(function() BG:Destroy() end) BG = nil end
    if Humanoid and Humanoid.Parent then Humanoid.PlatformStand = false end
end

local function startFly()
    stopFly()
    if not Root or not Humanoid then return end
    Humanoid.PlatformStand = true
    BV = Instance.new("BodyVelocity")
    BV.MaxForce = Vector3.new(9e4, 9e4, 9e4)
    BV.Velocity = Vector3.zero
    BV.Parent = Root
    BG = Instance.new("BodyGyro")
    BG.MaxTorque = Vector3.new(9e5, 9e5, 9e5)
    BG.P = 15000
    BG.D = 500
    BG.CFrame = Root.CFrame
    BG.Parent = Root
end

local function applyMode()
    if not FarmOn then return end
    if Mode == 1 then stopFly() else startFly() end
    refreshNoclip()
end

-- ============ ZONA DE FARMEO (circulo azul) ============
local MarkerFolder
local function clearMarker()
    if MarkerFolder then MarkerFolder:Destroy() MarkerFolder = nil end
end

local function newMarkerPart(parent)
    local p = Instance.new("Part")
    p.Anchored = true
    p.CanCollide = false
    p.CanQuery = false
    p.CanTouch = false
    p.CastShadow = false
    p.Material = Enum.Material.Neon
    p.Color = Color3.fromRGB(0, 140, 255)
    p.Parent = parent
    return p
end

local function updateMarker()
    clearMarker()
    if not (ZoneOn and ZoneCenter) then return end
    MarkerFolder = Instance.new("Folder")
    MarkerFolder.Name = "THMASTER_Zone"
    MarkerFolder.Parent = workspace

    local cx, cy, cz = ZoneCenter.X, ZoneGroundY or ZoneCenter.Y, ZoneCenter.Z

    -- Disco translucido
    local disk = newMarkerPart(MarkerFolder)
    disk.Shape = Enum.PartType.Cylinder
    disk.Size = Vector3.new(0.2, ZoneRadius * 2, ZoneRadius * 2)
    disk.CFrame = CFrame.new(cx, cy + 0.1, cz) * CFrame.Angles(0, 0, math.pi / 2)
    disk.Transparency = 0.8

    -- Borde brillante
    local N = 64
    local segLen = (2 * math.pi * ZoneRadius / N) * 1.15
    for i = 0, N - 1 do
        local a = (i / N) * 2 * math.pi
        local pos = Vector3.new(cx + ZoneRadius * math.cos(a), cy + 0.3, cz + ZoneRadius * math.sin(a))
        local seg = newMarkerPart(MarkerFolder)
        seg.Size = Vector3.new(segLen, 0.6, 1)
        seg.CFrame = CFrame.new(pos) * CFrame.Angles(0, -a - math.pi / 2, 0)
        seg.Transparency = 0.1
    end
end

-- ============ AUTOCURA ============
local HealPresets = {
    {label = "Galleta", keys = {"galleta", "cookie"}},
    {label = "Manzana de oro", keys = {"manzana de oro", "golden apple", "goldenapple", "gold apple"}},
    {label = "Cualquiera de las 2", keys = {"galleta", "cookie", "manzana de oro", "golden apple", "goldenapple", "gold apple"}},
}
local HealSel = HealPresets[1]

local function getBackpack()
    return LocalPlayer:FindFirstChildOfClass("Backpack")
end

local function getHealOptions()
    local opts = {}
    for _, p in ipairs(HealPresets) do table.insert(opts, p) end
    local seen = {}
    local function add(container)
        if not container then return end
        for _, t in ipairs(container:GetChildren()) do
            if t:IsA("Tool") and not seen[t.Name] then
                seen[t.Name] = true
                table.insert(opts, {label = t.Name, exact = t.Name})
            end
        end
    end
    add(getBackpack())
    add(Character)
    return opts
end

local function matchTool(tool)
    if not tool:IsA("Tool") then return false end
    if HealSel.exact then return tool.Name == HealSel.exact end
    local n = tool.Name:lower()
    for _, k in ipairs(HealSel.keys) do
        if n:find(k, 1, true) then return true end
    end
    return false
end

local function findHealTool()
    local bp = getBackpack()
    if bp then
        for _, t in ipairs(bp:GetChildren()) do
            if matchTool(t) then return t end
        end
    end
    if Character then
        for _, t in ipairs(Character:GetChildren()) do
            if matchTool(t) then return t end
        end
    end
    return nil
end

local function healthPct()
    if Character then
        local h = Character:GetAttribute("Health")
        local m = Character:GetAttribute("MaxHealth")
        if typeof(h) == "number" and typeof(m) == "number" and m > 0 then
            return h / m * 100
        end
    end
    if Humanoid and Humanoid.MaxHealth > 0 then
        return Humanoid.Health / Humanoid.MaxHealth * 100
    end
    return nil
end

local function clickOnce()
    if not VIM then return end
    pcall(function()
        VIM:SendMouseButtonEvent(0, 0, 0, true, game, 1)
        task.wait(0.015)
        VIM:SendMouseButtonEvent(0, 0, 0, false, game, 1)
    end)
end

local function tryHeal()
    if Healing or not Humanoid or not Character then return end
    if tick() - lastHeal < HEAL_CD then return end
    lastHeal = tick()

    local tool = findHealTool()
    if not tool then
        Status.Text = "Autocura: no encuentro '" .. HealSel.label .. "' en tu mochila"
        return
    end

    Healing = true
    task.spawn(function()
        local prev = Character and Character:FindFirstChildOfClass("Tool")
        if prev == tool then prev = nil end

        pcall(function() Humanoid:EquipTool(tool) end)
        task.wait(0.12)
        pcall(function() tool:Activate() end)
        task.spawn(clickOnce)
        task.wait(HEAL_USE_TIME)

        -- volver a equipar el arma
        local bp = getBackpack()
        if prev and bp and prev.Parent == bp and Humanoid and Humanoid.Parent then
            pcall(function() Humanoid:EquipTool(prev) end)
        end
        Healing = false
    end)
end

-- ============ ENEMIGOS ============
local function enemiesInRange(center, radius)
    local out = {}

    local function consider(model)
        if not model or not model.Parent then return end
        if model:GetAttribute("_Dying") then return end
        local hp = model:GetAttribute("Health")
        if typeof(hp) == "number" and hp <= 0 then return end

        local part = model.PrimaryPart
            or model:FindFirstChild("HumanoidRootPart")
            or model:FindFirstChild("RootPart")
            or model:FindFirstChildWhichIsA("BasePart")
        local pos
        if part then
            pos = part.Position
        else
            local ok, piv = pcall(function() return model:GetPivot() end)
            if ok and piv then pos = piv.Position end
        end
        if not pos then return end
        local dist = Vector3.new(pos.X - center.X, 0, pos.Z - center.Z).Magnitude
        if dist <= radius then
            table.insert(out, {pos = pos, dist = dist, model = model})
        end
    end

    pcall(function()
        for _, m in ipairs(CollectionService:GetTagged("Mob")) do
            consider(m)
        end
        for _, obj in ipairs(CollectionService:GetTagged("Combatant")) do
            if obj:IsA("Humanoid") and obj.Health > 0 and obj.Parent then
                local model = obj.Parent
                if model ~= Character and not Players:GetPlayerFromCharacter(model) then
                    consider(model)
                end
            elseif obj:IsA("Model") then
                consider(obj)
            end
        end
    end)

    pcall(function()
        local live = workspace:FindFirstChild("Animal_Live")
        local agg = live and live:FindFirstChild("Aggressors")
        if agg then
            for _, m in ipairs(agg:GetChildren()) do
                if m:IsA("Model") then consider(m) end
            end
        end
    end)

    -- ordenar por cercania a MI personaje
    local me = Root and Root.Position or center
    for _, e in ipairs(out) do
        e.dist = Vector3.new(e.pos.X - me.X, 0, e.pos.Z - me.Z).Magnitude
    end
    table.sort(out, function(a, b) return a.dist < b.dist end)
    return out
end

-- ============ LOOT ============
local function closestLoot()
    local folder = workspace:FindFirstChild("WorldBits")
    if not folder or not Root then return nil end
    local best, bd = nil, 50
    for _, d in ipairs(folder:GetChildren()) do
        local pr = d:FindFirstChildWhichIsA("ProximityPrompt", true)
        if pr and pr.Enabled then
            local par = pr.Parent
            local pos
            if par then
                if par:IsA("BasePart") then pos = par.Position
                elseif par:IsA("Attachment") then pos = par.WorldPosition
                else
                    local bp = par:FindFirstAncestorWhichIsA("BasePart")
                    if bp then pos = bp.Position end
                end
            end
            if pos then
                local inZone = true
                if ZoneOn and ZoneCenter then
                    local zd = Vector3.new(pos.X - ZoneCenter.X, 0, pos.Z - ZoneCenter.Z).Magnitude
                    inZone = zd <= ZoneRadius
                end
                if inZone then
                    local dist = (Root.Position - pos).Magnitude
                    if dist < bd then bd = dist best = {prompt = pr, pos = pos, dist = dist} end
                end
            end
        end
    end
    return best
end

-- ============ MOVIMIENTO ============
-- mirada 3D segura (evita el caso degenerado cuando miras recto arriba/abajo)
local function lookCF(from, to)
    local d = to - from
    if d.Magnitude < 0.1 then return nil end
    if math.abs(d.Unit.Y) > 0.99 then
        return CFrame.lookAt(from, to, Vector3.new(0, 0, -1))
    end
    return CFrame.lookAt(from, to)
end

local function moveTo(goal, lookPos, stopDist)
    local dir = goal - Root.Position
    if Mode == 1 then
        if dir.Magnitude > (stopDist or 3) then
            Humanoid:MoveTo(goal)
        else
            Humanoid:MoveTo(Root.Position)
            local flat = Vector3.new(lookPos.X, Root.Position.Y, lookPos.Z)
            if (flat - Root.Position).Magnitude > 0.1 then
                Root.CFrame = CFrame.lookAt(Root.Position, flat)
            end
        end
    else
        if not BV or not BG then startFly() end
        if dir.Magnitude > (stopDist or 2) then
            BV.Velocity = dir.Unit * SPEED
        else
            BV.Velocity = Vector3.zero
        end
        local cf = lookCF(Root.Position, lookPos)
        if cf then BG.CFrame = cf end
    end
end

local function idle()
    if Mode == 1 then
        if Humanoid and Root then Humanoid:MoveTo(Root.Position) end
    elseif BV then
        BV.Velocity = Vector3.zero
    end
end

-- ============ ATAQUE ============
local function attack()
    if Healing then return end
    if tick() - lastAtk < ATK_CD then return end
    lastAtk = tick()

    if WeaponAttack then
        pcall(function() WeaponAttack:FireServer(1) end)
        pcall(function() WeaponAttack:FireServer() end)
    end

    if Character then
        local tool = Character:FindFirstChildOfClass("Tool")
        if tool then pcall(function() tool:Activate() end) end
    end

    task.spawn(clickOnce)
end

-- ============ AUTO-RETORNO ============
local function getAnchor()
    if ZoneOn and ZoneCenter then return ZoneCenter end
    return LastFarmPos
end

local function beginReturn()
    local anchor = getAnchor()
    if not anchor or not Root then return false end
    local floorY = workspace.FallenPartsDestroyHeight + 40
    ReturnDepthY = math.max(math.min(Root.Position.Y, anchor.Y) - RETURN_DEPTH, floorY)
    ReturnPhase = 1
    Returning = true
    startFly()
    refreshNoclip()
    return true
end

local function handleReturn()
    local anchor = getAnchor()
    if not anchor then
        Returning = false
        applyMode()
        return
    end
    local p = Root.Position
    if ReturnPhase < 5 then
        if not BV or not BG then startFly() end
        startNoclip()
    end
    local flatVec = Vector3.new(anchor.X - p.X, 0, anchor.Z - p.Z)
    local flat = flatVec.Magnitude

    -- Fase 1: hundirse bajo el suelo
    if ReturnPhase == 1 then
        if p.Y <= ReturnDepthY + 1.5 then
            ReturnPhase = 2
        else
            BV.Velocity = Vector3.new(0, -RETURN_SPEED, 0)
            local cf = lookCF(p, p + Vector3.new(0, -5, 0))
            if cf then BG.CFrame = cf end
            Status.Text = "Retorno: hundiendose..."
            return
        end
    end

    -- Fase 2: viajar bajo tierra hasta debajo del punto de farmeo
    if ReturnPhase == 2 then
        if flat <= 4 then
            ReturnPhase = 3
        else
            local vy = math.clamp((ReturnDepthY - p.Y) * 3, -RETURN_SPEED, RETURN_SPEED)
            BV.Velocity = flatVec.Unit * RETURN_SPEED + Vector3.new(0, vy, 0)
            local cf = lookCF(p, p + flatVec.Unit * 5)
            if cf then BG.CFrame = cf end
            Status.Text = string.format("Retorno bajo tierra: %.0f studs", flat)
            return
        end
    end

    -- Fase 3: subir al punto de farmeo
    if ReturnPhase == 3 then
        local toAnchor = anchor - p
        if toAnchor.Magnitude <= 4 then
            if Mode == 1 then
                ReturnPhase = 4
            else
                Returning = false
                BV.Velocity = Vector3.zero
                applyMode()
                Status.Text = "Retorno completo, farmeando"
                return
            end
        else
            BV.Velocity = toAnchor.Unit * RETURN_SPEED
            local cf = lookCF(p, anchor)
            if cf then BG.CFrame = cf end
            Status.Text = "Retorno: emergiendo..."
            return
        end
    end

    -- Fase 4 (solo Caminar): seguir subiendo hasta quedar bien por encima del suelo
    if ReturnPhase == 4 then
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        local ignore = {Character}
        if MarkerFolder then table.insert(ignore, MarkerFolder) end
        params.FilterDescendantsInstances = ignore
        params.RespectCanCollide = true

        local hit = workspace:Raycast(Vector3.new(anchor.X, anchor.Y + 60, anchor.Z), Vector3.new(0, -400, 0), params)
        local groundY = hit and hit.Position.Y or (anchor.Y - 3)
        local targetY = math.clamp(groundY, anchor.Y - 6, anchor.Y + 12) + 6

        if p.Y < targetY then
            local hx = math.clamp((anchor.X - p.X) * 2, -RETURN_SPEED, RETURN_SPEED)
            local hz = math.clamp((anchor.Z - p.Z) * 2, -RETURN_SPEED, RETURN_SPEED)
            BV.Velocity = Vector3.new(hx, RETURN_SPEED, hz)
            local cf = lookCF(p, p + Vector3.new(0, 5, 0))
            if cf then BG.CFrame = cf end
            Status.Text = "Retorno: subiendo sobre el suelo..."
            return
        end

        -- Ya esta sobre el suelo: soltar y dejar caer
        stopFly()
        stopNoclip()
        pcall(function() Root.AssemblyLinearVelocity = Vector3.zero end)
        ReturnPhase = 5
        ReturnDropAt = tick()
        Status.Text = "Retorno: cayendo al suelo..."
        return
    end

    -- Fase 5: esperar a tocar el suelo y empezar a farmear
    if ReturnPhase == 5 then
        local grounded = Humanoid.FloorMaterial ~= Enum.Material.Air
        if grounded or tick() - ReturnDropAt > 4 then
            Returning = false
            applyMode()
            Status.Text = "Retorno completo, farmeando"
        else
            Status.Text = "Retorno: cayendo al suelo..."
        end
    end
end

-- ============ CAMARA LIBRE ============
local function setFreeCam(on)
    FreeCamOn = on
    pcall(function() RunService:UnbindFromRenderStep("THMASTER_Cam") end)
    local cam = workspace.CurrentCamera
    if on then
        local look = cam.CFrame.LookVector
        camYaw = math.atan2(-look.X, -look.Z)
        camPitch = math.clamp(math.asin(math.clamp(look.Y, -1, 1)), -1.45, 1.45)
        RunService:BindToRenderStep("THMASTER_Cam", Enum.RenderPriority.Camera.Value + 1, function()
            if not FreeCamOn or not Root or not Root.Parent then return end
            local c = workspace.CurrentCamera
            c.CameraType = Enum.CameraType.Scriptable
            local pivot = Root.Position + Vector3.new(0, 2, 0)
            c.CFrame = CFrame.new(pivot)
                * CFrame.Angles(0, camYaw, 0)
                * CFrame.Angles(camPitch, 0, 0)
                * CFrame.new(0, 0, camDist)
        end)
    else
        cam.CameraType = Enum.CameraType.Custom
        if Humanoid and Humanoid.Parent then cam.CameraSubject = Humanoid end
    end
end

-- Controles de camara: click derecho + arrastrar (PC), un dedo arrastrando (movil), rueda = zoom
table.insert(conns, UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then camDrag = true end
end))
table.insert(conns, UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then camDrag = false end
end))
table.insert(conns, UserInputService.InputChanged:Connect(function(input, gp)
    if not FreeCamOn then return end
    local t = input.UserInputType
    if t == Enum.UserInputType.MouseMovement and camDrag then
        camYaw = camYaw - input.Delta.X * 0.005
        camPitch = math.clamp(camPitch - input.Delta.Y * 0.005, -1.45, 1.45)
    elseif t == Enum.UserInputType.Touch and not gp and not dragging then
        camYaw = camYaw - input.Delta.X * 0.006
        camPitch = math.clamp(camPitch - input.Delta.Y * 0.006, -1.45, 1.45)
    elseif t == Enum.UserInputType.MouseWheel then
        camDist = math.clamp(camDist - input.Position.Z * 3, 5, 100)
        refreshCamLbl()
    end
end))

-- ============ LOOP DE FARMEO ============
local function farmStep()
    if not FarmOn or not Ready or not Root or not Root.Parent or not Humanoid or Humanoid.Health <= 0 then return end

    if Returning then
        handleReturn()
        return
    end

    if Mode ~= 1 and not BV then startFly() end
    LastFarmPos = Root.Position

    if Healing then
        idle()
        Status.Text = "Curando..."
        return
    end

    -- Loot
    if LootOn then
        local loot = closestLoot()
        if loot then
            Status.Text = "Loot dist " .. math.floor(loot.dist)
            if loot.dist > 7 then
                moveTo(loot.pos + Vector3.new(0, Mode == 1 and 0 or 3, 0), loot.pos, 3)
            else
                idle()
                if fireproximityprompt then
                    pcall(fireproximityprompt, loot.prompt)
                else
                    pcall(function()
                        loot.prompt:InputHoldBegin()
                        task.wait(0.1)
                        loot.prompt:InputHoldEnd()
                    end)
                end
            end
            return
        end
    end

    -- Enemigos (dentro de la zona si esta activa)
    local hasZone = ZoneOn and ZoneCenter
    local center = hasZone and ZoneCenter or Root.Position
    local radius = hasZone and ZoneRadius or RADIUS
    local list = enemiesInRange(center, radius)

    if #list == 0 then
        if hasZone then
            local d = Vector3.new(Root.Position.X - ZoneCenter.X, 0, Root.Position.Z - ZoneCenter.Z).Magnitude
            if d > ZoneRadius then
                moveTo(ZoneCenter, ZoneCenter, 3)
                Status.Text = "Volviendo a la zona..."
                return
            end
        end
        idle()
        Status.Text = "Sin enemigos (" .. radius .. ")"
        return
    end

    local target = list[1]
    local pos = target.pos
    local goal
    if Mode == 1 then
        goal = pos
    elseif Mode == 2 then
        goal = Vector3.new(pos.X, pos.Y + HEIGHT, pos.Z)
    else
        goal = Vector3.new(pos.X, pos.Y - HEIGHT, pos.Z)
    end

    moveTo(goal, pos, Mode == 1 and 6 or 2)

    -- Caminar: solo ataca cuando ya esta cerca del enemigo
    local realDist = (Root.Position - pos).Magnitude
    if Mode ~= 1 or realDist <= MELEE_RANGE then
        attack()
        Status.Text = string.format("[%s] Atacando x%d | %.0f studs", MODES[Mode], #list, realDist)
    else
        Status.Text = string.format("[%s] Acercandome | %.0f studs", MODES[Mode], realDist)
    end
end

local function start()
    if Conn then Conn:Disconnect() end
    Returning = false
    applyMode()
    if not WeaponAttack then
        WeaponAttack = findWeaponAttack()
        RemoteLbl.Text = WeaponAttack and ("Remoto: " .. WeaponAttack.Name) or "Remoto: NO"
        RemoteLbl.TextColor3 = WeaponAttack and Color3.fromRGB(100, 220, 120) or Color3.fromRGB(255, 120, 120)
    end
    Conn = RunService.Heartbeat:Connect(farmStep)
end

local function stop()
    FarmOn = false
    Returning = false
    if Conn then Conn:Disconnect() Conn = nil end
    stopFly()
    refreshNoclip()
    Status.Text = "OFF"
    updateTitle()
end

-- ============ LOOP DE AUTOCURA (independiente del farm) ============
task.spawn(function()
    while Running do
        task.wait(0.2)
        if HealOn and Ready and Humanoid and Humanoid.Parent and not Returning then
            local pct = healthPct()
            if pct and pct > 0 and pct <= HealPct then
                tryHeal()
            end
        end
    end
end)

-- ============ MUERTE / RESPAWN ============
table.insert(conns, LocalPlayer.CharacterRemoving:Connect(function()
    Ready = false
    Returning = false
    Healing = false
    BV, BG = nil, nil
end))

table.insert(conns, LocalPlayer.CharacterAdded:Connect(function()
    Ready = false
    BV, BG = nil, nil
    task.wait(1)
    updateCharacter()
    Ready = true
    if FreeCamOn then setFreeCam(true) end
    if FarmOn then
        if ReturnOn and beginReturn() then
            Status.Text = "Reaparecido: regresando a la zona..."
        else
            applyMode()
        end
    end
end))

-- ============ BOTONES ============
FarmBtn.MouseButton1Click:Connect(function()
    FarmOn = not FarmOn
    if FarmOn then
        FarmBtn.Text = "FARM: ON"
        FarmBtn.BackgroundColor3 = C.on
        if Root then LastFarmPos = Root.Position end
        start()
    else
        FarmBtn.Text = "FARM: OFF"
        FarmBtn.BackgroundColor3 = C.off
        stop()
    end
    updateTitle()
end)

SetZoneBtn.MouseButton1Click:Connect(function()
    if not Root then return end
    ZoneCenter = Root.Position
    ZoneGroundY = Root.Position.Y - 3
    ZoneOn = true
    setToggle(ZoneBtn, "ZONA", true, C.zone)
    updateMarker()
    Status.Text = "Zona fijada aqui (radio " .. ZoneRadius .. ")"
end)

ZoneBtn.MouseButton1Click:Connect(function()
    if not ZoneCenter then
        Status.Text = "Primero pulsa FIJAR ZONA AQUI"
        return
    end
    ZoneOn = not ZoneOn
    setToggle(ZoneBtn, "ZONA", ZoneOn, C.zone)
    updateMarker()
end)
setToggle(ZoneBtn, "ZONA", false, C.zone)

ZoneMinus.MouseButton1Click:Connect(function()
    ZoneRadius = math.max(10, ZoneRadius - 10)
    refreshZoneLbl()
    updateMarker()
end)
ZonePlus.MouseButton1Click:Connect(function()
    ZoneRadius = math.min(300, ZoneRadius + 10)
    refreshZoneLbl()
    updateMarker()
end)

LootBtn.MouseButton1Click:Connect(function()
    LootOn = not LootOn
    setToggle(LootBtn, "LOOT", LootOn, C.blue)
end)

NoclipBtn.MouseButton1Click:Connect(function()
    NoclipOn = not NoclipOn
    setToggle(NoclipBtn, "NOCLIP", NoclipOn, C.brown)
    refreshNoclip()
end)

ModeBtn.MouseButton1Click:Connect(function()
    Mode = Mode % #MODES + 1
    ModeBtn.Text = "MODO: " .. MODES[Mode]
    refreshHeightLbl()
    applyMode()
end)

HeightMinus.MouseButton1Click:Connect(function()
    HEIGHT = math.max(1, HEIGHT - 1)
    refreshHeightLbl()
end)
HeightPlus.MouseButton1Click:Connect(function()
    HEIGHT = math.min(25, HEIGHT + 1)
    refreshHeightLbl()
end)

HealBtn.MouseButton1Click:Connect(function()
    HealOn = not HealOn
    setToggle(HealBtn, "AUTOCURA", HealOn, C.heal)
end)

HealItemBtn.MouseButton1Click:Connect(function()
    local opts = getHealOptions()
    local idx = 0
    for i, o in ipairs(opts) do
        if o.label == HealSel.label then idx = i break end
    end
    HealSel = opts[idx % #opts + 1]
    HealItemBtn.Text = "ITEM: " .. HealSel.label
end)

HealMinus.MouseButton1Click:Connect(function()
    HealPct = math.max(5, HealPct - 5)
    refreshHealLbl()
end)
HealPlus.MouseButton1Click:Connect(function()
    HealPct = math.min(95, HealPct + 5)
    refreshHealLbl()
end)

CamBtn.MouseButton1Click:Connect(function()
    setFreeCam(not FreeCamOn)
    setToggle(CamBtn, "CAMARA LIBRE", FreeCamOn, C.cam)
end)
CamMinus.MouseButton1Click:Connect(function()
    camDist = math.max(5, camDist - 5)
    refreshCamLbl()
end)
CamPlus.MouseButton1Click:Connect(function()
    camDist = math.min(100, camDist + 5)
    refreshCamLbl()
end)

RetBtn.MouseButton1Click:Connect(function()
    ReturnOn = not ReturnOn
    setToggle(RetBtn, "AUTO-RETORNO", ReturnOn, C.ret)
end)

-- Cerrar: limpia todo
CloseBtn.MouseButton1Click:Connect(function()
    Running = false
    stop()
    setFreeCam(false)
    clearMarker()
    for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
    Gui:Destroy()
end)

print("[TH MASTER 1.6.2] WeaponAttack =", WeaponAttack)
if WeaponAttack then
    print("Path:", WeaponAttack:GetFullName())
end

-- =====================================================
-- POLY LOOT - TH ANALYZER v1.0
-- Registra datos del juego en tiempo real SIN repetirlos.
-- Captura: remotes (envia/recibe), botones y textos en pantalla,
-- clics y teclas, armas (equipar, atributos), atributos/valores,
-- enemigos por tipo, objetos de torre, modulos de configuracion.
-- POR PARTE DE TH MASTER
-- =====================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

-- ============ NUCLEO DEL LOG ============
local Lines, Seen, Counts = {}, {}, {}
local SeenCount = 0
local Active = false
local Running = true
local Dirty = false
local t0 = os.clock()
local LastFloorText = ""
local MarkN = 0
local copiedUpTo = 0
local filePos = 0
local FILE_NAME = "THMaster_Analizador.txt"
local conns = {}

local function track(c) table.insert(conns, c) return c end

local function add(tag, text)
    Lines[#Lines + 1] = string.format("[%06.1f] [%s] %s", os.clock() - t0, tag, text)
    Dirty = true
end

-- registra solo la primera vez que aparece "key"
local function once(key, tag, text)
    if not Active then return false end
    if Seen[key] then return false end
    Seen[key] = true
    SeenCount = SeenCount + 1
    add(tag, text)
    return true
end

-- igual, pero con un limite de entradas distintas por grupo (evita inundar el log)
local function onceCap(key, group, limit, tag, text)
    if not Active then return false end
    if Seen[key] then return false end
    local c = Counts[group] or 0
    if c >= limit then
        if not Seen["cap:" .. group] then
            Seen["cap:" .. group] = true
            add("LIMITE", group .. " alcanzo " .. limit .. " valores distintos, ya no se registran mas de este grupo")
        end
        return false
    end
    Counts[group] = c + 1
    Seen[key] = true
    SeenCount = SeenCount + 1
    add(tag, text)
    return true
end

-- ============ UTILIDADES ============
local HEX32 = string.rep("%x", 32)
local GUID = string.rep("%x", 8) .. "%-" .. string.rep("%x", 4) .. "%-" .. string.rep("%x", 4) .. "%-" .. string.rep("%x", 4) .. "%-" .. string.rep("%x", 12)

local function normPath(s)
    s = s:gsub(GUID, "<GUID>")
    s = s:gsub(HEX32, "<ID>")
    return s
end

local function fullName(inst)
    local ok, n = pcall(function() return inst:GetFullName() end)
    return ok and normPath(n) or tostring(inst)
end

local function isHexId(s)
    return #s == 32 and s:match("^%x+$") ~= nil
end

local function sortedKeys(t)
    local ks = {}
    for k in pairs(t) do ks[#ks + 1] = k end
    table.sort(ks, function(a, b) return tostring(a) < tostring(b) end)
    return ks
end

-- serializador; mask=true enmascara numeros que cambian (decimales/grandes) para deduplicar
local function ser(v, depth, mask)
    depth = depth or 0
    local t = typeof(v)
    if t == "string" then
        if #v > 80 then v = v:sub(1, 80) .. "..." end
        return '"' .. v .. '"'
    elseif t == "number" then
        if mask and (v % 1 ~= 0 or math.abs(v) > 50) then return "#" end
        return tostring(v)
    elseif t == "boolean" or t == "nil" then
        return tostring(v)
    elseif t == "Instance" then
        return "<" .. v.ClassName .. ":" .. fullName(v) .. ">"
    elseif t == "table" then
        if depth >= 3 then return "{...}" end
        local parts, n = {}, 0
        for _, k in ipairs(sortedKeys(v)) do
            n = n + 1
            if n > 12 then parts[#parts + 1] = "..." break end
            parts[#parts + 1] = "[" .. ser(k, depth + 1, mask) .. "]=" .. ser(v[k], depth + 1, mask)
        end
        return "{" .. table.concat(parts, ", ") .. "}"
    elseif mask and (t == "Vector3" or t == "CFrame" or t == "Vector2" or t == "UDim2") then
        return t
    end
    return tostring(v)
end

local function argsStr(mask, args)
    local out = {}
    for i = 1, args.n do out[i] = ser(args[i], 0, mask) end
    return table.concat(out, ", ")
end

-- serializador profundo y legible para tablas de modulos
local function deepSer(v, indent, depth, budget)
    local t = typeof(v)
    if t == "table" then
        if depth > 5 then return "{...}" end
        local ks = sortedKeys(v)
        if #ks == 0 then return "{}" end
        local pad = string.rep("  ", indent + 1)
        local out = {"{"}
        local n = 0
        for _, k in ipairs(ks) do
            n = n + 1
            if n > 60 then out[#out + 1] = pad .. "..." break end
            if budget.left <= 0 then out[#out + 1] = pad .. "...(truncado)" break end
            local line = pad .. tostring(k) .. " = " .. deepSer(v[k], indent + 1, depth + 1, budget)
            budget.left = budget.left - #line
            out[#out + 1] = line
        end
        out[#out + 1] = string.rep("  ", indent) .. "}"
        return table.concat(out, "\n")
    elseif t == "function" then
        return "<function>"
    end
    return ser(v, 3, false)
end

local function hasKey(s, keys)
    s = s:lower()
    for _, k in ipairs(keys) do
        if s:find(k, 1, true) then return true end
    end
    return false
end

local function cleanText(s)
    s = tostring(s or "")
    s = s:gsub("<[^>]+>", "")
    s = s:gsub("%s+", " ")
    if #s > 120 then s = s:sub(1, 120) .. "..." end
    return s
end

local TEXT_KEYS = {"floor", "piso", "wave", "oleada", "ronda", "round", "tower", "torre", "stage", "nivel",
    "bonus", "bono", "bonif", "buff", "debuff", "damage", "dano", "da\u{00F1}o", "multiplier", "multiplicador", "reduc",
    "sword", "espada", "axe", "hacha", "dagger", "daga", "bow", "arco", "spear", "lanza", "mace", "maza",
    "hammer", "martillo", "staff", "baston", "weapon", "arma", "next", "siguiente", "continue", "continuar",
    "reward", "recompensa", "victory", "victoria", "complete", "boss", "jefe"}
local FLOOR_KEYS = {"floor", "piso", "wave", "oleada", "ronda", "round", "stage", "nivel"}
local PANEL_KEYS = {"menu", "select", "weapon", "arma", "hotbar", "slot", "floor", "piso", "next", "siguiente",
    "tower", "torre", "wave", "reward", "victory", "complete", "inventory", "loadout", "quick"}
local WS_KEYS = {"tower", "torre", "floor", "piso", "wave", "oleada", "dungeon", "mazmorra", "boss"}
local MOD_KEYS = {"tower", "torre", "floor", "piso", "wave", "oleada", "weapon", "arma", "modifier", "bonus",
    "buff", "mult", "affix", "stat"}

local function interestingText(s)
    if s == "" or #s > 200 then return false end
    if hasKey(s, TEXT_KEYS) then return true end
    if s:find("%d+%s*%%") or s:find("[xX]%s*%d") then return true end
    return false
end

-- ============ REMOTES ============
local Hooked = false
local HookState = "no instalado"

local function logRemote(dir, remote, args)
    if not Active then return end
    local path = fullName(remote)
    local group = dir .. ":" .. path
    if (Counts[group] or 0) >= 40 then
        if not Seen["cap:" .. group] then
            Seen["cap:" .. group] = true
            add("LIMITE", group .. " alcanzo 40 variantes, ya no se registran mas")
        end
        return
    end
    local okK, key = pcall(argsStr, true, args)
    if not okK then return end
    local full = group .. "|" .. key
    if Seen[full] then return end
    local okR, real = pcall(argsStr, false, args)
    Seen[full] = true
    SeenCount = SeenCount + 1
    Counts[group] = (Counts[group] or 0) + 1
    add(dir == "ENVIA" and "REMOTE>" or "REMOTE<", path .. "(" .. (okR and real or key) .. ")")
end

local function installHook()
    if Hooked then return end
    if not (hookmetamethod and getnamecallmethod) then
        HookState = "NO disponible"
        add("SCAN", "Tu executor no tiene hookmetamethod: no se pueden registrar los envios (FireServer). Solo se registran los datos recibidos.")
        return
    end
    local old
    local function handler(self, ...)
        local method = getnamecallmethod()
        if Active and (method == "FireServer" or method == "InvokeServer") then
            local isMine = checkcaller and checkcaller()
            if not isMine then
                local ok, cn = pcall(function() return typeof(self) == "Instance" and self.ClassName or nil end)
                if ok and (cn == "RemoteEvent" or cn == "RemoteFunction" or cn == "UnreliableRemoteEvent") then
                    pcall(logRemote, "ENVIA", self, table.pack(...))
                end
            end
        end
        return old(self, ...)
    end
    if newcclosure then handler = newcclosure(handler) end
    local ok, res = pcall(function() return hookmetamethod(game, "__namecall", handler) end)
    if ok and res then
        old = res
        Hooked = true
        HookState = "OK"
    else
        HookState = "fallo"
        add("SCAN", "No se pudo instalar el hook de remotes.")
    end
end

local WatchedRemotes = {}
local function watchRemote(r)
    if not (r:IsA("RemoteEvent") or r:IsA("UnreliableRemoteEvent") or r:IsA("RemoteFunction")) then return end
    once("REMOTO:" .. fullName(r), "REMOTO", r.ClassName .. " " .. fullName(r))
    if WatchedRemotes[r] then return end
    WatchedRemotes[r] = true
    if r:IsA("RemoteEvent") or r:IsA("UnreliableRemoteEvent") then
        track(r.OnClientEvent:Connect(function(...)
            pcall(logRemote, "RECIBE", r, table.pack(...))
        end))
    end
end

-- ============ ATRIBUTOS / VALORES ============
local function dumpAttrs(inst)
    local t = {}
    local ok, attrs = pcall(function() return inst:GetAttributes() end)
    if ok then
        for k, v in pairs(attrs) do t[#t + 1] = k .. "=" .. ser(v, 1, false) end
    end
    table.sort(t)
    return table.concat(t, ", ")
end

local function watchAttrs(inst, label)
    local function logAttr(k)
        local v = inst:GetAttribute(k)
        onceCap("ATTR:" .. label .. "." .. k .. "=" .. ser(v, 0, true), "ATTR:" .. label .. "." .. k, 30,
            "ATTR", label .. "." .. k .. " = " .. ser(v, 0, false))
    end
    for k in pairs(inst:GetAttributes()) do logAttr(k) end
    track(inst.AttributeChanged:Connect(function(k)
        if Active then logAttr(k) end
    end))
end

local WatchedVals = {}
local function watchValue(v)
    if WatchedVals[v] then return end
    WatchedVals[v] = true
    local path = fullName(v)
    local function logv()
        onceCap("VAL:" .. path .. "=" .. ser(v.Value, 0, true), "VAL:" .. path, 30,
            "VALOR", path .. " = " .. ser(v.Value, 0, false))
    end
    logv()
    track(v.Changed:Connect(function()
        if Active then logv() end
    end))
end

-- ============ ARMAS ============
local function dumpTool(tool)
    local parts = {}
    local a = dumpAttrs(tool)
    if a ~= "" then parts[#parts + 1] = "attrs{" .. a .. "}" end
    local ch, n = {}, 0
    for _, c in ipairs(tool:GetChildren()) do
        n = n + 1
        if n > 15 then ch[#ch + 1] = "..." break end
        if c:IsA("ValueBase") then
            ch[#ch + 1] = c.Name .. "=" .. ser(c.Value, 1, false)
        elseif not c:IsA("BasePart") then
            ch[#ch + 1] = c.ClassName .. ":" .. c.Name
        end
    end
    if #ch > 0 then parts[#parts + 1] = "hijos{" .. table.concat(ch, ", ") .. "}" end
    local tags = CollectionService:GetTags(tool)
    if #tags > 0 then parts[#parts + 1] = "tags{" .. table.concat(tags, ",") .. "}" end
    if tool.ToolTip ~= "" then parts[#parts + 1] = "tooltip=" .. ser(tool.ToolTip, 1, false) end
    return table.concat(parts, " ")
end

local WatchedTools = {}
local function handleTool(tool, where)
    if not tool:IsA("Tool") then return end
    once("TOOL:" .. tool.Name, "ARMA", string.format('"%s" [%s] %s', tool.Name, where, dumpTool(tool)))
    if not WatchedTools[tool] then
        WatchedTools[tool] = true
        track(tool.AttributeChanged:Connect(function(attr)
            if not Active then return end
            local v = tool:GetAttribute(attr)
            onceCap("TA:" .. tool.Name .. "." .. attr .. "=" .. ser(v, 0, true), "TA:" .. tool.Name .. "." .. attr, 20,
                "ARMA-ATTR", tool.Name .. "." .. attr .. " = " .. ser(v, 0, false))
        end))
    end
end

local function logEquip(tool)
    once("EQUIP:" .. tool.Name .. "|" .. LastFloorText, "EQUIPA",
        string.format('"%s" | contexto: %s', tool.Name, LastFloorText ~= "" and LastFloorText or "(sin piso/oleada detectado)"))
end

local function watchTools(container, where)
    if not container then return end
    for _, t in ipairs(container:GetChildren()) do
        if t:IsA("Tool") then
            handleTool(t, where)
            if where == "equipada" then logEquip(t) end
        end
    end
    track(container.ChildAdded:Connect(function(c)
        if Active and c:IsA("Tool") then
            handleTool(c, where)
            if where == "equipada" then logEquip(c) end
        end
    end))
end

local function onCharacter(char)
    watchTools(char, "equipada")
    watchAttrs(char, "Character")
end

-- ============ ENEMIGOS ============
local function analyzeEnemy(m)
    if not Active or not m or not m.Parent then return end
    if m:IsA("Humanoid") then m = m.Parent end
    if not m or not m:IsA("Model") then return end
    if m == LP.Character or Players:GetPlayerFromCharacter(m) then return end

    local names = {}
    for _, c in ipairs(m:GetChildren()) do names[#names + 1] = c.Name end
    table.sort(names)
    while #names > 15 do table.remove(names) end

    local attrs = m:GetAttributes()
    local keys, strVals = {}, {}
    for _, k in ipairs(sortedKeys(attrs)) do
        keys[#keys + 1] = k
        if type(attrs[k]) == "string" then strVals[#strVals + 1] = k .. "=" .. attrs[k] end
    end

    local shown = m.Name
    if isHexId(shown) then
        shown = tostring(m:GetAttribute("Name") or m:GetAttribute("AnimalType") or m:GetAttribute("Type")
            or m:GetAttribute("EnemyType") or m:GetAttribute("MobType") or "<ID>")
    end

    local size = ""
    pcall(function()
        local s = m:GetExtentsSize()
        size = string.format("%d,%d,%d", s.X, s.Y, s.Z)
    end)

    local parentPath = m.Parent and fullName(m.Parent) or ""
    local sig = table.concat(names, ",") .. "|" .. table.concat(keys, ",") .. "|" .. table.concat(strVals, ",") .. "|" .. size
    local tags = CollectionService:GetTags(m)
    once("ENEMY:" .. parentPath .. "|" .. shown .. "|" .. sig, "ENEMIGO",
        string.format('"%s" en %s | partes{%s} | attrs{%s} | tags{%s} | tamano=%s',
            shown, parentPath, table.concat(names, ","), dumpAttrs(m), table.concat(tags, ","), size))
end

-- ============ GUI ============
local function isShown(g)
    local cur = g
    while cur and cur ~= PlayerGui do
        if cur:IsA("GuiObject") then
            if not cur.Visible then return false end
        elseif cur:IsA("LayerCollector") then
            if not cur.Enabled then return false end
        end
        cur = cur.Parent
    end
    return true
end

local function guiText(g)
    if g:IsA("TextButton") or g:IsA("TextLabel") or g:IsA("TextBox") then
        return cleanText(g.Text)
    end
    for _, d in ipairs(g:GetDescendants()) do
        if d:IsA("TextLabel") or d:IsA("TextButton") then
            local t = cleanText(d.Text)
            if t ~= "" then return t end
        end
    end
    return ""
end

local function scanGui()
    for _, sg in ipairs(PlayerGui:GetChildren()) do
        if sg:IsA("ScreenGui") and sg.Enabled then
            once("SG:" .. sg.Name, "GUI-PANTALLA", sg.Name)
        end
    end
    local i = 0
    for _, d in ipairs(PlayerGui:GetDescendants()) do
        i = i + 1
        if i % 250 == 0 then task.wait() end
        if not Active then return end
        if d:IsA("GuiObject") then
            if d:IsA("GuiButton") then
                if isShown(d) and d.AbsoluteSize.X > 0 then
                    local path = fullName(d)
                    local txt = guiText(d)
                    once("BTN:" .. path .. "|" .. txt, "GUI-BOTON", string.format('%s "%s" (%s)', path, txt, d.ClassName))
                end
            elseif d:IsA("TextLabel") then
                if isShown(d) then
                    local txt = cleanText(d.Text)
                    if interestingText(txt) then
                        local path = fullName(d)
                        if hasKey(txt, FLOOR_KEYS) then LastFloorText = txt end
                        onceCap("TXT:" .. path .. "|" .. txt, "TXT:" .. path, 30, "TEXTO", path .. ' = "' .. txt .. '"')
                    end
                end
            elseif d:IsA("Frame") or d:IsA("ScrollingFrame") or d:IsA("ImageLabel") then
                if hasKey(d.Name, PANEL_KEYS) and isShown(d) and d.AbsoluteSize.X > 0 then
                    local path = fullName(d)
                    once("PNL:" .. path, "GUI-PANEL", path .. " (" .. d.ClassName .. ")")
                end
            end
        end
    end
end

-- ============ MODULOS (configuracion del juego) ============
local function scanModules()
    local roots = {ReplicatedStorage}
    local ps = LP:FindFirstChild("PlayerScripts")
    if ps then table.insert(roots, ps) end
    add("SCAN", "Escaneando modulos de configuracion (torre/arma/bonus)...")
    local found = 0
    for _, root in ipairs(roots) do
        for _, m in ipairs(root:GetDescendants()) do
            if not Running then return end
            if m:IsA("ModuleScript") then
                local path = fullName(m)
                if hasKey(path, MOD_KEYS) and not Seen["MOD:" .. path] then
                    Seen["MOD:" .. path] = true
                    SeenCount = SeenCount + 1
                    found = found + 1
                    local done, ok, res = false, false, nil
                    task.spawn(function()
                        ok, res = pcall(require, m)
                        done = true
                    end)
                    local tw = os.clock()
                    while not done and os.clock() - tw < 2 do task.wait(0.05) end
                    if done and ok and type(res) == "table" then
                        local budget = {left = 8000}
                        add("MODULO", path .. " =\n" .. deepSer(res, 0, 0, budget))
                    elseif done and ok then
                        add("MODULO", path .. " devuelve " .. typeof(res))
                    else
                        add("MODULO", path .. " (no se pudo leer)")
                    end
                    task.wait()
                end
            end
        end
    end
    add("SCAN", "Modulos revisados: " .. found)
end

-- ============ ESCANEO INICIAL ============
local function scanStructure()
    once("PLACE", "SCAN", "PlaceId=" .. game.PlaceId .. " GameId=" .. game.GameId)
    for _, c in ipairs(ReplicatedStorage:GetChildren()) do
        once("RS:" .. c.Name, "SCAN", "ReplicatedStorage." .. c.Name .. " (" .. c.ClassName .. ")")
    end
    for _, c in ipairs(workspace:GetChildren()) do
        if hasKey(c.Name, WS_KEYS) then
            local kids, n = {}, 0
            for _, k in ipairs(c:GetChildren()) do
                n = n + 1
                if n > 40 then kids[#kids + 1] = "..." break end
                kids[#kids + 1] = k.ClassName .. ":" .. normPath(k.Name)
            end
            once("WSTOP:" .. c.Name, "TORRE", "workspace." .. c.Name .. " (" .. c.ClassName .. ") hijos{" .. table.concat(kids, ", ") .. "} attrs{" .. dumpAttrs(c) .. "}")
            pcall(watchAttrs, c, "workspace." .. c.Name)
        end
    end
    for _, tag in ipairs(CollectionService:GetAllTags()) do
        once("TAG:" .. tag, "TAG", tag)
    end
end

-- ============ INSTALACION DE WATCHERS ============
local Installed = false
local Main -- se define en la UI

local function inOurGui(pos)
    if not Main then return false end
    local ap, as = Main.AbsolutePosition, Main.AbsoluteSize
    local inset = GuiService:GetGuiInset()
    for _, dy in ipairs({0, inset.Y}) do
        if pos.X >= ap.X and pos.X <= ap.X + as.X and pos.Y + dy >= ap.Y and pos.Y + dy <= ap.Y + as.Y then
            return true
        end
    end
    return false
end

local function install()
    if Installed then return end
    Installed = true

    installHook()

    -- remotes
    for _, d in ipairs(ReplicatedStorage:GetDescendants()) do watchRemote(d) end
    track(ReplicatedStorage.DescendantAdded:Connect(function(d)
        if Active then watchRemote(d) end
    end))

    -- armas y personaje
    if LP.Character then onCharacter(LP.Character) end
    track(LP.CharacterAdded:Connect(onCharacter))
    watchTools(LP:FindFirstChildOfClass("Backpack"), "mochila")
    track(LP.ChildAdded:Connect(function(c)
        if c:IsA("Backpack") then watchTools(c, "mochila") end
    end))

    -- atributos / valores del jugador
    watchAttrs(LP, "Player")
    for _, d in ipairs(LP:GetDescendants()) do
        if d:IsA("ValueBase") then watchValue(d) end
    end
    track(LP.DescendantAdded:Connect(function(d)
        if Active and d:IsA("ValueBase") then watchValue(d) end
    end))

    -- enemigos (carpeta Aggressors y tags)
    local live = workspace:FindFirstChild("Animal_Live")
    local agg = live and live:FindFirstChild("Aggressors")
    if agg then
        for _, m in ipairs(agg:GetChildren()) do task.spawn(analyzeEnemy, m) end
        track(agg.ChildAdded:Connect(function(m) task.delay(0.5, analyzeEnemy, m) end))
    end
    for _, tag in ipairs({"Mob", "Combatant"}) do
        for _, i in ipairs(CollectionService:GetTagged(tag)) do task.spawn(analyzeEnemy, i) end
        track(CollectionService:GetInstanceAddedSignal(tag):Connect(function(i)
            task.delay(0.5, analyzeEnemy, i)
        end))
    end

    -- objetos de torre / mazmorra en workspace
    track(workspace.DescendantAdded:Connect(function(d)
        if not Active then return end
        local c = d.ClassName
        if c == "Model" or c == "Folder" or c == "ProximityPrompt" or c == "ClickDetector"
            or c == "Configuration" or d:IsA("ValueBase") then
            local p = fullName(d)
            if hasKey(p, WS_KEYS) then
                onceCap("WS:" .. p, "WS", 500, "TORRE", c .. " " .. p .. " attrs{" .. dumpAttrs(d) .. "}")
            end
        end
    end))
    track(workspace.ChildAdded:Connect(function(c)
        if Active and hasKey(c.Name, WS_KEYS) then
            pcall(watchAttrs, c, "workspace." .. c.Name)
        end
    end))

    -- proximity prompts (por si "siguiente piso" es un prompt)
    track(ProximityPromptService.PromptShown:Connect(function(p)
        once("PSHOW:" .. fullName(p), "PROMPT-VISIBLE",
            string.format('%s | accion="%s" objeto="%s"', fullName(p), p.ActionText, p.ObjectText))
    end))
    track(ProximityPromptService.PromptTriggered:Connect(function(p)
        once("PTRIG:" .. fullName(p), "PROMPT-USADO",
            string.format('%s | accion="%s" objeto="%s"', fullName(p), p.ActionText, p.ObjectText))
    end))

    -- teclas y clics
    track(UserInputService.InputBegan:Connect(function(input, gp)
        if not Active then return end
        local t = input.UserInputType
        if t == Enum.UserInputType.Keyboard then
            if UserInputService:GetFocusedTextBox() then return end
            once("KEY:" .. input.KeyCode.Name, "TECLA", input.KeyCode.Name)
        elseif t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
            local pos = input.Position
            if inOurGui(pos) then return end
            local objs = PlayerGui:GetGuiObjectsAtPosition(pos.X, pos.Y)
            if #objs == 0 then
                local inset = GuiService:GetGuiInset()
                objs = PlayerGui:GetGuiObjectsAtPosition(pos.X, pos.Y - inset.Y)
            end
            local logged = 0
            for _, o in ipairs(objs) do
                if logged >= 3 then break end
                if o:IsA("GuiButton") or o:IsA("TextLabel") then
                    local txt = guiText(o)
                    if o:IsA("GuiButton") or txt ~= "" then
                        local path = fullName(o)
                        if once("CLICK:" .. path .. "|" .. txt, "CLIC", string.format('%s "%s" (%s)', path, txt, o.ClassName)) then
                            logged = logged + 1
                        end
                    end
                end
            end
        end
    end))

    -- bucle de escaneo de GUI
    task.spawn(function()
        while Running do
            if Active then pcall(scanGui) end
            task.wait(1.5)
        end
    end)

    -- guardado automatico a archivo
    task.spawn(function()
        while Running do
            task.wait(8)
            if writefile and #Lines > filePos then
                local chunk = table.concat(Lines, "\n", filePos + 1, #Lines) .. "\n"
                local ok = false
                if filePos > 0 and appendfile then
                    ok = pcall(appendfile, FILE_NAME, chunk)
                end
                if not ok then
                    ok = pcall(writefile, FILE_NAME, table.concat(Lines, "\n") .. "\n")
                end
                if ok then filePos = #Lines end
            end
        end
    end)
end

-- ============ UI ============
local function getGuiParent()
    local ok, p = pcall(function() return (gethui and gethui()) or game:GetService("CoreGui") end)
    if ok and p then return p end
    return PlayerGui
end
local GuiParent = getGuiParent()
local old = GuiParent:FindFirstChild("THANALYZER")
if old then old:Destroy() end

local Gui = Instance.new("ScreenGui")
Gui.Name = "THANALYZER"
Gui.ResetOnSpawn = false
Gui.DisplayOrder = 999
Gui.Parent = GuiParent

local FULL_W, FULL_H, MIN_W, HEADER_H = 290, 420, 160, 30
Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(FULL_W, FULL_H)
Main.Position = UDim2.new(0.02, 0, 0.1, 0)
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
Title.Text = "TH ANALYZER v1.0"
Title.TextColor3 = Color3.fromRGB(230, 230, 240)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local function styleBtn(b, color)
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
end

local function headerBtn(text, xOffset, color)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(24, 22)
    b.Position = UDim2.new(1, xOffset, 0, 4)
    b.Text = text
    b.Parent = Header
    styleBtn(b, color)
    b.TextSize = 14
    return b
end
local MinBtn = headerBtn("-", -58, Color3.fromRGB(70, 70, 90))
local CloseBtn = headerBtn("X", -30, Color3.fromRGB(170, 50, 50))

local Body = Instance.new("Frame")
Body.Size = UDim2.new(1, 0, 1, -HEADER_H)
Body.Position = UDim2.new(0, 0, 0, HEADER_H)
Body.BackgroundTransparency = 1
Body.Parent = Main

local Controls = Instance.new("Frame")
Controls.Size = UDim2.new(1, -12, 0, 150)
Controls.Position = UDim2.new(0, 6, 0, 6)
Controls.BackgroundTransparency = 1
Controls.Parent = Body
local cl = Instance.new("UIListLayout")
cl.SortOrder = Enum.SortOrder.LayoutOrder
cl.Padding = UDim.new(0, 4)
cl.Parent = Controls

local rowOrder = 0
local function mkRow(textA, colA, textB, colB)
    rowOrder = rowOrder + 1
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 28)
    row.BackgroundTransparency = 1
    row.LayoutOrder = rowOrder
    row.Parent = Controls
    local a = Instance.new("TextButton")
    a.Size = UDim2.new(0.5, -2, 1, 0)
    a.Text = textA
    a.Parent = row
    styleBtn(a, colA)
    local b
    if textB then
        b = Instance.new("TextButton")
        b.Size = UDim2.new(0.5, -2, 1, 0)
        b.Position = UDim2.new(0.5, 2, 0, 0)
        b.Text = textB
        b.Parent = row
        styleBtn(b, colB)
    else
        a.Size = UDim2.new(1, 0, 1, 0)
    end
    return a, b
end

local OFF = Color3.fromRGB(40, 40, 52)
local StartBtn, MarkBtn = mkRow("INICIAR", Color3.fromRGB(0, 120, 60), "MARCAR", Color3.fromRGB(120, 80, 30))
local CopyAllBtn, CopyNewBtn = mkRow("COPIAR TODO", Color3.fromRGB(0, 90, 150), "COPIAR NUEVO", Color3.fromRGB(0, 110, 170))
local ModBtn, ClearBtn = mkRow("ESCANEAR MODULOS", Color3.fromRGB(90, 50, 140), "LIMPIAR", Color3.fromRGB(150, 40, 40))

local StatusLbl = Instance.new("TextLabel")
StatusLbl.Size = UDim2.new(1, 0, 0, 30)
StatusLbl.BackgroundTransparency = 1
StatusLbl.TextColor3 = Color3.fromRGB(160, 160, 180)
StatusLbl.Font = Enum.Font.Gotham
StatusLbl.TextSize = 11
StatusLbl.TextWrapped = true
StatusLbl.TextXAlignment = Enum.TextXAlignment.Left
StatusLbl.TextYAlignment = Enum.TextYAlignment.Top
StatusLbl.LayoutOrder = 99
StatusLbl.Text = "Pulsa INICIAR y juega normal."
StatusLbl.Parent = Controls

local LogScroll = Instance.new("ScrollingFrame")
LogScroll.Size = UDim2.new(1, -12, 1, -170)
LogScroll.Position = UDim2.new(0, 6, 0, 162)
LogScroll.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
LogScroll.BorderSizePixel = 0
LogScroll.ScrollBarThickness = 4
LogScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
LogScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
LogScroll.Parent = Body
Instance.new("UICorner", LogScroll).CornerRadius = UDim.new(0, 6)

local LogLbl = Instance.new("TextLabel")
LogLbl.Size = UDim2.new(1, -8, 0, 0)
LogLbl.Position = UDim2.new(0, 4, 0, 2)
LogLbl.AutomaticSize = Enum.AutomaticSize.Y
LogLbl.BackgroundTransparency = 1
LogLbl.TextColor3 = Color3.fromRGB(150, 230, 170)
LogLbl.Font = Enum.Font.Code
LogLbl.TextSize = 10
LogLbl.TextWrapped = true
LogLbl.TextXAlignment = Enum.TextXAlignment.Left
LogLbl.TextYAlignment = Enum.TextYAlignment.Top
LogLbl.Text = ""
LogLbl.Parent = LogScroll

-- Caja de copia manual (si el executor no tiene portapapeles)
local CopyFrame = Instance.new("Frame")
CopyFrame.Size = UDim2.fromOffset(320, 240)
CopyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
CopyFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
CopyFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
CopyFrame.Visible = false
CopyFrame.Parent = Gui
Instance.new("UICorner", CopyFrame).CornerRadius = UDim.new(0, 8)
local CopyBox = Instance.new("TextBox")
CopyBox.Size = UDim2.new(1, -12, 1, -42)
CopyBox.Position = UDim2.new(0, 6, 0, 6)
CopyBox.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
CopyBox.TextColor3 = Color3.new(1, 1, 1)
CopyBox.Font = Enum.Font.Code
CopyBox.TextSize = 10
CopyBox.MultiLine = true
CopyBox.ClearTextOnFocus = false
CopyBox.TextWrapped = true
CopyBox.TextXAlignment = Enum.TextXAlignment.Left
CopyBox.TextYAlignment = Enum.TextYAlignment.Top
CopyBox.Parent = CopyFrame
local CopyClose = Instance.new("TextButton")
CopyClose.Size = UDim2.new(1, -12, 0, 26)
CopyClose.Position = UDim2.new(0, 6, 1, -32)
CopyClose.Text = "CERRAR (selecciona todo el texto y copialo antes)"
CopyClose.Parent = CopyFrame
styleBtn(CopyClose, Color3.fromRGB(70, 70, 90))
CopyClose.MouseButton1Click:Connect(function() CopyFrame.Visible = false end)

-- arrastrar ventana
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
track(UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end))

-- minimizar
local Minimized = false
MinBtn.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    Body.Visible = not Minimized
    Main.Size = Minimized and UDim2.fromOffset(MIN_W, HEADER_H) or UDim2.fromOffset(FULL_W, FULL_H)
    MinBtn.Text = Minimized and "+" or "-"
    Title.Text = Minimized and "TH ANALYZER" or "TH ANALYZER v1.0"
end)

-- notas temporales
local NoteText, NoteUntil = "", 0
local function note(t, secs)
    NoteText = t
    NoteUntil = os.clock() + (secs or 3)
end

local function copyOut(text, label)
    local fn = setclipboard or toclipboard
    if fn then
        local ok = pcall(fn, text)
        if ok then
            note("Copiado: " .. label)
            return
        end
    end
    -- sin portapapeles: caja de texto manual
    CopyBox.Text = #text > 15000 and text:sub(-15000) or text
    CopyFrame.Visible = true
    note("Sin portapapeles: copia desde la caja", 5)
end

-- ============ BOTONES ============
StartBtn.MouseButton1Click:Connect(function()
    Active = not Active
    if Active then
        StartBtn.Text = "PAUSAR"
        StartBtn.BackgroundColor3 = Color3.fromRGB(170, 120, 20)
        add("SCAN", "===== ANALISIS INICIADO =====")
        install()
        task.spawn(function()
            scanStructure()
            scanModules()
        end)
    else
        StartBtn.Text = "INICIAR"
        StartBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 60)
        add("SCAN", "===== PAUSADO =====")
    end
end)

MarkBtn.MouseButton1Click:Connect(function()
    MarkN = MarkN + 1
    add("MARCA", string.format("#%d | contexto: %s", MarkN, LastFloorText ~= "" and LastFloorText or "(ninguno)"))
    note("Marca #" .. MarkN .. " agregada")
end)

CopyAllBtn.MouseButton1Click:Connect(function()
    if #Lines == 0 then note("No hay datos todavia") return end
    copyOut(table.concat(Lines, "\n"), #Lines .. " lineas")
    copiedUpTo = #Lines
end)

CopyNewBtn.MouseButton1Click:Connect(function()
    if copiedUpTo >= #Lines then note("Nada nuevo desde la ultima copia") return end
    local n = #Lines - copiedUpTo
    copyOut(table.concat(Lines, "\n", copiedUpTo + 1, #Lines), n .. " lineas nuevas")
    copiedUpTo = #Lines
end)

ModBtn.MouseButton1Click:Connect(function()
    if not Active then note("Pulsa INICIAR primero") return end
    task.spawn(scanModules)
    note("Escaneando modulos...")
end)

ClearBtn.MouseButton1Click:Connect(function()
    Lines, Seen, Counts = {}, {}, {}
    SeenCount, copiedUpTo, filePos = 0, 0, 0
    Dirty = true
    if writefile then pcall(writefile, FILE_NAME, "") end
    note("Log y memoria de duplicados borrados")
end)

CloseBtn.MouseButton1Click:Connect(function()
    Running = false
    Active = false
    for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
    Gui:Destroy()
end)

-- refresco de pantalla
task.spawn(function()
    while Running do
        task.wait(0.5)
        local status
        if os.clock() < NoteUntil then
            status = NoteText
        else
            status = string.format("%s | Lineas: %d | Unicos: %d | Hook: %s",
                Active and "GRABANDO" or "PAUSA", #Lines, SeenCount, HookState)
        end
        StatusLbl.Text = status
        if Dirty then
            Dirty = false
            local parts, total = {}, 0
            for i = #Lines, 1, -1 do
                local l = Lines[i]
                if #l > 400 then l = l:sub(1, 400) .. "..." end
                total = total + #l + 1
                if total > 9000 then break end
                table.insert(parts, 1, l)
            end
            LogLbl.Text = table.concat(parts, "\n")
            task.defer(function()
                LogScroll.CanvasPosition = Vector2.new(0, 1e6)
            end)
        end
    end
end)

print("[TH ANALYZER 1.0] listo")

local w=(loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua")))()do
  local Y=w.Notify w.Notify=function
    (w, K)
    if(getgenv()).NotifyEnabled==false then
      return
    end
    return Y(w, K)
  end
end
local Y=game:GetService("Players")
local K=game:GetService("RunService")
local F=game:GetService("UserInputService")
local I=game:GetService("HttpService")
local m=game:GetService("ReplicatedStorage")
local M=game:GetService("CollectionService")
local x=Y.LocalPlayer
local S=workspace.CurrentCamera do
  local w="BottomLeft"
  local Y, F=pcall(function
    ()
    local Y=game:GetService("VirtualUser")
    local F=game:GetService("CoreGui")x.Idled:Connect(function
      ()pcall(function
        ()Y:CaptureController()Y:ClickButton2(Vector2.new(0, 0))
      end
      )
    end
    )
    local I={["TopLeft"]={Vector2.new(0, 0);UDim2.new(0, 8, 0, 8)},["TopRight"]={Vector2.new(1, 0), UDim2.new(1,-8, 0, 8)},["BottomLeft"]={Vector2.new(0, 1), UDim2.new(0, 8, 1,-8)},["BottomRight"]={Vector2.new(1, 1), UDim2.new(1,-8, 1,-8)}}
    local m=I[w]or I.BottomLeft
    local M=Instance.new("ScreenGui")M.Name="kw_hud" M.ResetOnSpawn=false M.IgnoreGuiInset=true M.DisplayOrder=999 pcall(function
      ()
      if syn and syn.protect_gui then
        syn.protect_gui(M)
      end
    end
    )pcall(function
      ()M.Parent=(gethui and gethui())or F
    end
    )
    if not M.Parent then
      M.Parent=x:WaitForChild("PlayerGui")
    end
    local S=Instance.new("Frame")S.AnchorPoint=m[1]S.Position=m[2]S.AutomaticSize=Enum.AutomaticSize["XY"]S.Size=UDim2.new(0, 0, 0, 0)S.BackgroundColor3=Color3.new(0, 0, 0)S.BackgroundTransparency=.55 S.BorderSizePixel=0 S.Active=false S.Parent=M
    local N=Instance.new("UICorner")N.CornerRadius=UDim.new(0, 6)N.Parent=S
    local T=Instance.new("UIPadding")T.PaddingLeft=UDim.new(0, 8)T.PaddingRight=UDim.new(0, 8)T.PaddingTop=UDim.new(0, 4)T.PaddingBottom=UDim.new(0, 4)T.Parent=S
    local v=Instance.new("TextLabel")v.AutomaticSize=Enum.AutomaticSize["XY"]v.Size=UDim2.new(0, 0, 0, 0)v.BackgroundTransparency=1 v.Font=Enum.Font["Code"]v.TextSize=13 v.TextColor3=Color3.new(1, 1, 1)v.TextTransparency=.1 v.Text="AFK 00:00:00  |  -- FPS" v.Parent=S
    local L=os.clock()
    local G, i=0, 0 K.Heartbeat:Connect(function
      (w)G=G+1 i=i+w
      if i>=.5 then
        local w=math.floor(G/i+.5)G, i=0, 0
        local Y=math.floor(os.clock()-L)v.Text=string.format("AFK %02d:%02d:%02d  |  %d FPS", math.floor(Y/3600), math.floor(((Y%3600))/60), Y%60, w)
      end
    end
    )
  end
  )
  if not Y then
    warn("[kw] hud/afk error: "..tostring(F))
  end
end
local N=((m:WaitForChild("Weapon_Engine")):WaitForChild("Remotes")):WaitForChild("WeaponAttack")
local T="kw_free"
local v="kw_free/config.json"
local L={["FlyEnabled"]=false;["FlySpeed"]=40;["FlyBind"]="G";["FlyVert"]=6,["FlyBtns"]=(game:GetService("UserInputService")).TouchEnabled;["SpeedEnabled"]=false;["WalkSpeed"]=50;["SpeedBind"]="H";["AutoAttackEnabled"]=false,["AutoAttackBind"]="K";["AutoAttackRadius"]=15;["AutoAttackSync"]=true,["AutoCollectEnabled"]=false;["AutoCollectBind"]="L",["CollectAll"]=false;["CollectRadius"]=30,["CollectIgnoreRange"]=false;["CollectKinds"]={};["CollectArmorSets"]={};["CollectArmorPieces"]={};["CollectWalk"]=false;["CollectWalkRadius"]=40;["CollectItems"]={};["CollectKnown"]={};["AntiKnockbackEnabled"]=false,["AntiKnockbackDensity"]=100;["DFEnabled"]=false;["DFBind"]="B",["DFBossHeights"]=true;["DFHeight1"]=8;["DFHeight2"]=12,["DFHeight3"]=12;["DFHeight4"]=12,["DFHeightCrow"]=8,["DFHeightBat"]=10,["DFHeightMimic"]=6;["DFHeightWraith"]=10;["DFPrioCrow"]=1;["DFPrioBat"]=2;["DFPrioMimic"]=3,["DFPrioWraith"]=4;["DFRelTarget"]=false;["DFProne"]=true,["DFFace"]=true,["DFNoclip"]=true;["DFAutoRepeat"]=true;["DFRetryDefeat"]=false;["DFUnstick"]=true;["SweepEnabled"]=true,["SweepRadius"]=80,["SweepGrace"]=2;["SweepMaxTime"]=30,["DCEnabled"]=false;["DCBind"]="V",["VXEnabled"]=false,["VXBind"]="None";["VXHeight"]=10,["VXHeightAir"]=25;["VXSpeed"]=20;["VXSafe"]=true;["VXProne"]=true,["VXFace"]=true,["VXAutoRift"]=true;["DCDracula"]=true;["DCGolem"]=true;["DCHeightDracula"]=12;["DCHeightGolem"]=25;["DCRelTarget"]=false;["DCProne"]=true,["DCFace"]=true;["DCSpeedDracula"]=25;["DCSpeedGolem"]=10;["DCAutoAdvance"]=true;["DCAutoRepeat"]=true;["DCRetryDefeat"]=false,["DCPosEnabled"]=true;["DCDodge"]=true;["CSkipEnabled"]=false,["CSkipDracula"]=true,["CSkipVex"]=true,["CSkipPirate"]=true,["DCSavedPos"]={},["HealEnabled"]=false,["HealStart"]=50;["HealStop"]=90,["HealFood"]={},["HealOnlyRun"]=true,["DKEnabled"]=false;["DKBind"]="M",["DKSpeed"]=35;["DKHeightDog"]=8,["DKHeightSpider"]=8;["DKHeightHound"]=8,["DKHeightBoss"]=12,["DKHeightEffigy"]=3,["DKEffigy"]=true;["DKRelTarget"]=false,["DKProne"]=true;["DKFace"]=true;["DKNoclip"]=true;["DKAutoAdvance"]=true;["DKAutoRepeat"]=true;["DKRetryDefeat"]=false;["FishEnabled"]=false;["FishBind"]="Y",["FishAutoCast"]=true;["FishAutoHook"]=true;["FishAutoFight"]=true;["FishSkipCard"]=true;["FishHookDelay"]=10;["CPEnabled"]=false,["CPBind"]="None",["CPSpeed"]=20,["CPHeight"]=8;["CPProne"]=true;["CPFace"]=true;["HideNick"]=true,["FishSilent"]=true,["BSEnabled"]=false,["BSBind"]="None";["BSRadius"]=70,["BSKingChicken"]=true,["BSSpider"]=true;["BSCobra"]=true;["BSOwl"]=true;["BSSkullcrab"]=true,["BSHeightChicken"]=10;["BSHeightSpider"]=10;["BSHeightCobra"]=10;["BSHeightOwl"]=10,["BSHeightCrab"]=10;["BSSpeed"]=25,["BSSweepSpeed"]=12,["BSProne"]=true;["BSFace"]=true,["SHBoss"]={"King Chicken"};["SHMaxHops"]=15,["SHAutoFarm"]=true,["WFRegion"]="Grasslands";["WFMobPick"]={},["WFMobH"]={},["WFMobRadius"]=60;["WFMobSpeed"]=25;["WFMobMaxAlt"]=0,["WFMinAlt"]=4,["WFMobSmart"]=true,["MineMode"]="Fly";["WFMobTp"]=true;["WFMobHop"]=40,["WFMobTpDelay"]=.25;["MineRadius"]=40,["MineOres"]={},["MineSpeed"]=25;["MineTpDelay"]=.25;["MineWalkSpeed"]=24,["ChopMode"]="Fly",["ChopRadius"]=40,["ChopSpeed"]=25,["ChopTpDelay"]=.25;["ChopWalkSpeed"]=24;["MineTpHop"]=40;["ChopTpHop"]=40,["WFSmartMove"]=true;["MinePickup"]=true;["MineDropWait"]=.8,["ChopPickup"]=true,["ChopDropWait"]=.8,["CookRecipe"]="Cake";["CookCount"]=1,["CookWait"]=1,["InfJumpEnabled"]=false;["InfJumpBind"]="J",["NoclipEnabled"]=false;["NoclipBind"]="N";["AutoLootEnabled"]=false,["AutoCastEnabled"]=false,["AutoCastRadius"]=40;["ACDaily"]=false;["ACPlaytime"]=false,["ACInbox"]=false;["MerchBuyOn"]=false,["MerchBuyKeys"]={};["MerchPos"]={},["StaffWatch"]=true,["StaffNotify"]=true,["StaffLeave"]=false,["MenuBind"]="RightControl",["NotifyEnabled"]=true;["KeyWidget"]=true;["KeyWidgetX"]=.99,["KeyWidgetY"]=.35,["BossWidget"]=true,["BossWidgetX"]=.99,["BossWidgetY"]=.55,["StaffWidget"]=true;["StaffWidgetX"]=.99;["StaffWidgetY"]=.78,["BossSignPos"]={},["MenuW"]=0;["MenuH"]=0}
for w, Y in pairs(L)do
  if(getgenv())[w]==nil then
    (getgenv())[w]=Y
  end
end
local function
  G()
  if not isfolder(T)then
    makefolder(T)
  end
end
local i=false
local function
  o()
  if i then
    return
  end
  i=true task.defer(function
    ()G()
    local w={}
    for Y in pairs(L)do
      w[Y]=(getgenv())[Y]
    end
    pcall(function
      ()writefile(v, I:JSONEncode(w))
    end
    )task.wait(1)i=false
  end
  )
end
local function
  a()G()
  if not isfile(v)then
    return false
  end
  local w, Y=pcall(function
    ()
    return I:JSONDecode(readfile(v))
  end
  )
  if not w or type(Y)~="table" then
    return false
  end
  for w, K in pairs(L)do
    if Y[w]~=nil then
    (getgenv())[w]=Y[w]
    else
      (getgenv())[w]=K
    end
  end
  return true
end
a()
for w, Y in ipairs({"DFHeight1", "DFHeight2", "DFHeight3", "DFHeight4"})do
  (getgenv())[Y]=math.clamp(tonumber((getgenv())[Y])or 0,-10, 20)
end
;(getgenv()).DCHeightDracula=math.clamp(tonumber((getgenv()).DCHeightDracula)or 12, 0, 33);(getgenv()).DCHeightGolem=math.clamp(tonumber((getgenv()).DCHeightGolem)or 25, 20, 30);(getgenv()).VXHeight=math.clamp(tonumber((getgenv()).VXHeight)or 10, 0, 10);(getgenv()).HealStart=math.clamp(tonumber((getgenv()).HealStart)or 50, 5, 95);(getgenv()).HealStop=math.clamp(tonumber((getgenv()).HealStop)or 90, 10, 100)
for w, Y in ipairs({"DKHeightDog";"DKHeightSpider";"DKHeightHound";"DKHeightBoss";"DKHeightEffigy"})do
  (getgenv())[Y]=math.clamp(tonumber((getgenv())[Y])or 0,-10, 20)
end
;(getgenv()).BSRadius=math.clamp(tonumber((getgenv()).BSRadius)or 70, 10, 70);(getgenv()).BSSpeed=math.clamp(tonumber((getgenv()).BSSpeed)or 25, 5, 40);(getgenv()).BSSweepSpeed=math.clamp(tonumber((getgenv()).BSSweepSpeed)or 12, 3, 25);(getgenv()).SHMaxHops=math.clamp(tonumber((getgenv()).SHMaxHops)or 15, 3, 40)
for w, Y in ipairs({"BSHeightChicken", "BSHeightSpider";"BSHeightCobra";"BSHeightOwl";"BSHeightCrab"})do
  (getgenv())[Y]=math.clamp(tonumber((getgenv())[Y])or 10,-10, 20)
end
;(getgenv()).FlySpeed=math.clamp(tonumber((getgenv()).FlySpeed)or 40, 5, 40);(getgenv()).FlyVert=math.clamp(tonumber((getgenv()).FlyVert)or 6, 1, 11);(getgenv()).WalkSpeed=math.clamp(tonumber((getgenv()).WalkSpeed)or 50, 16, 70);(getgenv()).DKSpeed=math.clamp(tonumber((getgenv()).DKSpeed)or 35, 5, 40);(getgenv()).DCSpeedDracula=math.clamp(tonumber((getgenv()).DCSpeedDracula)or 25, 5, 25);(getgenv()).DCSpeedGolem=math.clamp(tonumber((getgenv()).DCSpeedGolem)or 10, 1, 15);(getgenv()).VXSpeed=math.clamp(tonumber((getgenv()).VXSpeed)or 20, 5, 20)
local l=setmetatable({},{["__index"]=function
  (w, Y)
  return(getgenv())[Y]
end
;["__newindex"]=function
  (w, Y, K)(getgenv())[Y]=K
end
})
local Q={}
local g={}
local function
  J(w, Y)
  local K=Q[w]
  if K then
    pcall(function
      ()
      if K.Set then
      K:Set(Y, false)
      elseif K.SetValue then
        K:SetValue(Y)
      end
    end
    )
  end
end
local function
  D(w)
  local K=x.Character
  local F=K and K:FindFirstChild("HumanoidRootPart")
  if not F then
    return false
  end
  local I=F.Position
  local function
    m(w)
    return(Vector3.new(w.X-I.X, 0, w.Z-I.Z)).Magnitude
  end
  for Y, K in ipairs(M:GetTagged("Mob"))do
    local F=K.PrimaryPart
    local I=F and F.Position
    if not I and K:IsA("Model")then
      I=(K:GetPivot()).Position
    end
    if I and(K.Parent and(((K:GetAttribute("Health")or 0))>0 and(not K:GetAttribute("_Dying")and m(I)<=w)))then
      return true
    end
  end
  for F, I in ipairs(M:GetTagged("Combatant"))do
    if I:IsA("Humanoid")and I.Health>0 then
      local F=I.Parent
      if F and(F~=K and not Y:GetPlayerFromCharacter(F))then
        local Y=F:FindFirstChild("HumanoidRootPart")or F.PrimaryPart
        if Y and m(Y.Position)<=w then
          return true
        end
      end
    end
  end
  return false
end
local function
  y(Y)l.AutoAttackEnabled=Y o()
  if Y and g.AtkInit then
    pcall(g.AtkInit, true)
  end
  w:Notify({["Title"]="Auto Attack",["Content"]=Y and "Activated (radius: %d)":format(tonumber(l.AutoAttackRadius)or 15)or "Deactivated";["Duration"]=2})
end
function
  g.AutoAttack(w)y(w)J("AutoAttackEnabled", w)
end
task.spawn(function
  ()
  while task.wait(.1)do
    if l.AutoAttackEnabled and not(getgenv()).kw_atk_on then
      pcall(function
        ()
        if not g._atkTried and g.AtkInit then
          g._atkTried=true pcall(g.AtkInit, true)
        end
        if D(tonumber(l.AutoAttackRadius)or 15)then
          N:FireServer(1)
        end
      end
      )
    end
  end
end
)
local E={}
local n, p, V, t, j, C, X, h, P do
  local w="WorldBits"
  local Y="wbId"
  local K="(no items seen yet)" n={{["id"]="HealthPotion",["name"]="Health Potion";["kind"]="Consumable";["rarity"]="Rare"};{["id"]="Apple",["name"]="Apple",["kind"]="Consumable",["rarity"]="Common"};{["id"]="GoldenApple";["name"]="Golden Apple";["kind"]="Consumable";["rarity"]="Epic"};{["id"]="Milk";["name"]="Milk",["kind"]="Consumable",["rarity"]="Common"},{["id"]="Egg";["name"]="Egg";["kind"]="Consumable";["rarity"]="Common"},{["id"]="ClothFabric";["name"]="Cloth Fabric",["kind"]="Material";["rarity"]="Common"},{["id"]="Bone";["name"]="Bone",["kind"]="Material";["rarity"]="Rare"},{["id"]="LegendaryShard",["name"]="Legendary Shard",["kind"]="Material",["rarity"]="Legendary"};{["id"]="GodlyShard";["name"]="Godly Shard";["kind"]="Material";["rarity"]="Godly"},{["id"]="Cobweb";["name"]="Cobweb";["kind"]="Material",["rarity"]="Rare"};{["id"]="RiftKey";["name"]="Rift Key",["kind"]="Material";["rarity"]="Legendary"},{["id"]="WeaponTierScroll";["name"]="Weapon Tier Scroll";["kind"]="Material";["rarity"]="Epic"},{["id"]="ArmourTierScroll";["name"]="Armor Tier Scroll",["kind"]="Material",["rarity"]="Epic"},{["id"]="MountTierScroll";["name"]="Mount Tier Scroll",["kind"]="Material",["rarity"]="Epic"},{["id"]="AbilityRune";["name"]="Ability Rune",["kind"]="Material";["rarity"]="Godly"},{["id"]="Poison1Book";["name"]="Poison I Enchant";["kind"]="Material";["rarity"]="Legendary"};{["id"]="Poison2Book";["name"]="Poison II Enchant";["kind"]="Material",["rarity"]="Godly"};{["id"]="StarfallBook";["name"]="Starfall Enchant";["kind"]="Material";["rarity"]="Godly"};{["id"]="VoodooHexBook",["name"]="Voodoo Hex Enchant",["kind"]="Material",["rarity"]="Godly"},{["id"]="ReapersTollBook",["name"]="Reaper's Toll Enchant",["kind"]="Material",["rarity"]="Secret"},{["id"]="Chicken Crown";["name"]="Chicken Crown",["kind"]="Armor";["rarity"]="Godly"},{["id"]="Leather Helmet";["name"]="Leather Helmet",["kind"]="Armor";["rarity"]="Common"};{["id"]="Leather Leggings",["name"]="Leather Leggings",["kind"]="Armor";["rarity"]="Common"},{["id"]="Leather Boots";["name"]="Leather Boots",["kind"]="Armor";["rarity"]="Common"},{["id"]="Leather ChestPlate",["name"]="Leather ChestPlate",["kind"]="Armor",["rarity"]="Common"};{["id"]="Iron Helmet",["name"]="Iron Helmet";["kind"]="Armor";["rarity"]="Rare"};{["id"]="Iron Leggings";["name"]="Iron Leggings";["kind"]="Armor";["rarity"]="Rare"};{["id"]="Iron Boots";["name"]="Iron Boots",["kind"]="Armor";["rarity"]="Rare"},{["id"]="Iron ChestPlate";["name"]="Iron ChestPlate",["kind"]="Armor",["rarity"]="Rare"},{["id"]="Gold Helmet",["name"]="Gold Helmet",["kind"]="Armor",["rarity"]="Rare"},{["id"]="Gold Leggings",["name"]="Gold Leggings";["kind"]="Armor";["rarity"]="Rare"};{["id"]="Gold Boots";["name"]="Gold Boots";["kind"]="Armor";["rarity"]="Rare"},{["id"]="Gold ChestPlate";["name"]="Gold ChestPlate";["kind"]="Armor",["rarity"]="Rare"},{["id"]="Rune Helmet";["name"]="Rune Helmet",["kind"]="Armor",["rarity"]="Epic"};{["id"]="Rune Leggings";["name"]="Rune Leggings";["kind"]="Armor",["rarity"]="Epic"};{["id"]="Rune Boots",["name"]="Rune Boots",["kind"]="Armor",["rarity"]="Epic"},{["id"]="Rune ChestPlate",["name"]="Rune ChestPlate",["kind"]="Armor",["rarity"]="Epic"};{["id"]="Spider ChestPlate",["name"]="Spider ChestPlate",["kind"]="Armor",["rarity"]="Legendary"},{["id"]="Spider Helmet",["name"]="Spider Helmet",["kind"]="Armor",["rarity"]="Legendary"},{["id"]="Spider Leggings",["name"]="Spider Leggings",["kind"]="Armor";["rarity"]="Legendary"};{["id"]="Spider Boots";["name"]="Spider Boots";["kind"]="Armor";["rarity"]="Legendary"};{["id"]="Jungle Helmet";["name"]="Jungle Helmet";["kind"]="Armor";["rarity"]="Epic"};{["id"]="Jungle ChestPlate",["name"]="Jungle ChestPlate";["kind"]="Armor",["rarity"]="Epic"},{["id"]="Jungle Leggings";["name"]="Jungle Leggings",["kind"]="Armor";["rarity"]="Epic"},{["id"]="Jungle Boots";["name"]="Jungle Boots",["kind"]="Armor";["rarity"]="Epic"};{["id"]="Cobra Helmet",["name"]="Cobra Helmet";["kind"]="Armor",["rarity"]="Legendary"},{["id"]="Cobra ChestPlate",["name"]="Cobra ChestPlate";["kind"]="Armor";["rarity"]="Legendary"},{["id"]="Cobra Leggings",["name"]="Cobra Leggings";["kind"]="Armor";["rarity"]="Legendary"};{["id"]="Cobra Boots";["name"]="Cobra Boots",["kind"]="Armor",["rarity"]="Legendary"};{["id"]="Soul Helmet",["name"]="Soul Helmet";["kind"]="Armor";["rarity"]="Legendary"},{["id"]="Soul ChestPlate",["name"]="Soul ChestPlate",["kind"]="Armor",["rarity"]="Legendary"},{["id"]="Soul Leggings",["name"]="Soul Leggings",["kind"]="Armor";["rarity"]="Legendary"};{["id"]="Soul Boots",["name"]="Soul Boots";["kind"]="Armor",["rarity"]="Legendary"};{["id"]="Emerald Helmet",["name"]="Emerald Helmet";["kind"]="Armor",["rarity"]="Rare"};{["id"]="Emerald ChestPlate",["name"]="Emerald ChestPlate",["kind"]="Armor";["rarity"]="Rare"};{["id"]="Emerald Leggings";["name"]="Emerald Leggings",["kind"]="Armor",["rarity"]="Rare"},{["id"]="Emerald Boots",["name"]="Emerald Boots";["kind"]="Armor";["rarity"]="Rare"},{["id"]="Cursed Helmet",["name"]="Cursed Helmet",["kind"]="Armor";["rarity"]="Legendary"},{["id"]="Cursed ChestPlate",["name"]="Cursed ChestPlate";["kind"]="Armor",["rarity"]="Legendary"};{["id"]="Cursed Leggings";["name"]="Cursed Leggings";["kind"]="Armor",["rarity"]="Legendary"},{["id"]="Cursed Boots",["name"]="Cursed Boots",["kind"]="Armor";["rarity"]="Legendary"},{["id"]="Dark Helmet",["name"]="Dark Helmet",["kind"]="Armor",["rarity"]="Epic"};{["id"]="Dark ChestPlate";["name"]="Dark ChestPlate";["kind"]="Armor";["rarity"]="Epic"};{["id"]="Dark Leggings";["name"]="Dark Leggings";["kind"]="Armor",["rarity"]="Epic"},{["id"]="Dark Boots",["name"]="Dark Boots";["kind"]="Armor",["rarity"]="Epic"};{["id"]="Diamond Helmet",["name"]="Diamond Helmet";["kind"]="Armor";["rarity"]="Rare"};{["id"]="Diamond ChestPlate";["name"]="Diamond ChestPlate",["kind"]="Armor",["rarity"]="Rare"};{["id"]="Diamond Leggings";["name"]="Diamond Leggings";["kind"]="Armor",["rarity"]="Rare"};{["id"]="Diamond Boots",["name"]="Diamond Boots";["kind"]="Armor";["rarity"]="Rare"},{["id"]="Vampire Bat Helmet",["name"]="Vampire Bat Helmet";["kind"]="Armor",["rarity"]="Godly"};{["id"]="Vampire Bat ChestPlate";["name"]="Vampire Bat ChestPlate",["kind"]="Armor";["rarity"]="Godly"};{["id"]="Vampire Bat Leggings";["name"]="Vampire Bat Leggings",["kind"]="Armor";["rarity"]="Godly"};{["id"]="Vampire Bat Boots";["name"]="Vampire Bat Boots";["kind"]="Armor",["rarity"]="Godly"};{["id"]="PumpkinChest";["name"]="Pumpkin Chest",["kind"]="Chest",["rarity"]="Godly"};{["id"]="Diamond Sword",["name"]="Diamond Sword",["kind"]="Weapon";["rarity"]="Rare",["wtype"]="Sword"};{["id"]="Jungle Great Sword";["name"]="Jungle Great Sword",["kind"]="Weapon",["rarity"]="Epic",["wtype"]="GreatSword"},{["id"]="Jungle Hammer";["name"]="Jungle Hammer";["kind"]="Weapon";["rarity"]="Epic",["wtype"]="Hammer"};{["id"]="Cobra Spear",["name"]="Cobra Spear",["kind"]="Weapon",["rarity"]="Legendary",["wtype"]="Spear"},{["id"]="Emerald Hammer";["name"]="Emerald Hammer",["kind"]="Weapon",["rarity"]="Rare",["wtype"]="Hammer"},{["id"]="Cursed Sword";["name"]="Cursed Sword",["kind"]="Weapon";["rarity"]="Legendary",["wtype"]="Sword"},{["id"]="Cursed Greataxe",["name"]="Cursed Greataxe",["kind"]="Weapon";["rarity"]="Legendary",["wtype"]="GreatAxe"},{["id"]="Dark Dagger",["name"]="Dark Dagger";["kind"]="Weapon";["rarity"]="Epic";["wtype"]="Dagger"},{["id"]="Dark Axe";["name"]="Dark Axe",["kind"]="Weapon",["rarity"]="Epic";["wtype"]="Axe"};{["id"]="Cobra Twinblade Axe",["name"]="Cobra Twinblade Axe";["kind"]="Weapon",["rarity"]="Godly";["wtype"]="TwinbladeAxe"};{["id"]="Basic Katana";["name"]="Basic Katana";["kind"]="Weapon",["rarity"]="Common",["wtype"]="Katana"},{["id"]="Basic Dagger";["name"]="Basic Dagger",["kind"]="Weapon";["rarity"]="Common",["wtype"]="Dagger"},{["id"]="Basic Axe";["name"]="Basic Axe",["kind"]="Weapon",["rarity"]="Common",["wtype"]="Axe"};{["id"]="Basic Great Axe",["name"]="Basic Great Axe",["kind"]="Weapon";["rarity"]="Common";["wtype"]="GreatAxe"};{["id"]="Basic Great Sword";["name"]="Basic Great Sword",["kind"]="Weapon";["rarity"]="Common";["wtype"]="GreatSword"},{["id"]="Basic Hammer";["name"]="Basic Hammer",["kind"]="Weapon";["rarity"]="Common";["wtype"]="Hammer"};{["id"]="Basic Scythe";["name"]="Basic Scythe",["kind"]="Weapon",["rarity"]="Common";["wtype"]="Scythe"};{["id"]="Basic Spear";["name"]="Basic Spear",["kind"]="Weapon";["rarity"]="Common",["wtype"]="Spear"},{["id"]="Basic Twinblade Axe",["name"]="Basic Twinblade Axe";["kind"]="Weapon";["rarity"]="Common";["wtype"]="TwinbladeAxe"};{["id"]="Rune Sword";["name"]="Rune Sword",["kind"]="Weapon",["rarity"]="Rare";["wtype"]="Sword"};{["id"]="Amethyst Sword",["name"]="Amethyst Sword";["kind"]="Weapon",["rarity"]="Legendary";["wtype"]="Sword"};{["id"]="Phantom Katana",["name"]="Phantom Katana",["kind"]="Weapon";["rarity"]="Epic",["wtype"]="Katana"};{["id"]="Rune Greatsword",["name"]="Rune Greatsword",["kind"]="Weapon",["rarity"]="Epic",["wtype"]="GreatSword"},{["id"]="Venom Dagger",["name"]="Venom Dagger";["kind"]="Weapon";["rarity"]="Epic",["wtype"]="Dagger"},{["id"]="Spider Dagger",["name"]="Spider Dagger",["kind"]="Weapon",["rarity"]="Legendary",["wtype"]="Dagger"};{["id"]="Primal Axe";["name"]="Primal Axe",["kind"]="Weapon",["rarity"]="Common";["wtype"]="Axe"},{["id"]="Royal Axe",["name"]="Royal Axe";["kind"]="Weapon";["rarity"]="Legendary";["wtype"]="GreatAxe"};{["id"]="Quartz Hammer",["name"]="Quartz Hammer",["kind"]="Weapon";["rarity"]="Rare",["wtype"]="Hammer"},{["id"]="Potion Spear";["name"]="Potion Spear",["kind"]="Weapon",["rarity"]="Epic";["wtype"]="Spear"},{["id"]="Hunter Spear",["name"]="Hunter Spear";["kind"]="Weapon",["rarity"]="Rare",["wtype"]="Spear"},{["id"]="Bat Greataxe",["name"]="Bat Greataxe";["kind"]="Weapon";["rarity"]="Godly",["wtype"]="GreatAxe"},{["id"]="Bat Bow",["name"]="Bat Bow",["kind"]="Weapon";["rarity"]="Secret",["wtype"]="Bow"},{["id"]="Bat Striker",["name"]="Bat Striker";["kind"]="Weapon",["rarity"]="Unknown",["wtype"]="Sword"},{["id"]="Soul Scythe",["name"]="Soul Scythe";["kind"]="Weapon";["rarity"]="Godly";["wtype"]="Scythe"},{["id"]="Shadow Katana";["name"]="Shadow Katana",["kind"]="Weapon";["rarity"]="Secret",["wtype"]="Katana"};{["id"]="Coffin Blade",["name"]="Coffin Blade";["kind"]="Weapon";["rarity"]="Godly",["wtype"]="GreatSword"},{["id"]="Release Helmet",["name"]="Release Helmet",["kind"]="Armor";["rarity"]="Secret"},{["id"]="Crystal Helmet",["name"]="Crystal Helmet";["kind"]="Armor";["rarity"]="Legendary"};{["id"]="Crystal ChestPlate",["name"]="Crystal ChestPlate",["kind"]="Armor",["rarity"]="Legendary"},{["id"]="Crystal Leggings";["name"]="Crystal Leggings",["kind"]="Armor";["rarity"]="Legendary"},{["id"]="Crystal Boots";["name"]="Crystal Boots",["kind"]="Armor",["rarity"]="Legendary"};{["id"]="Ruby Helmet";["name"]="Ruby Helmet",["kind"]="Armor",["rarity"]="Rare"},{["id"]="Ruby ChestPlate",["name"]="Ruby ChestPlate";["kind"]="Armor";["rarity"]="Rare"},{["id"]="Ruby Leggings",["name"]="Ruby Leggings";["kind"]="Armor",["rarity"]="Rare"};{["id"]="Ruby Boots",["name"]="Ruby Boots";["kind"]="Armor";["rarity"]="Rare"},{["id"]="Sea Helmet";["name"]="Sea Helmet",["kind"]="Armor";["rarity"]="Epic"};{["id"]="Sea ChestPlate",["name"]="Sea ChestPlate";["kind"]="Armor";["rarity"]="Epic"};{["id"]="Sea Leggings";["name"]="Sea Leggings";["kind"]="Armor",["rarity"]="Epic"};{["id"]="Sea Boots",["name"]="Sea Boots";["kind"]="Armor",["rarity"]="Epic"};{["id"]="Crab Helmet",["name"]="Crab Helmet",["kind"]="Armor",["rarity"]="Legendary"};{["id"]="Crab ChestPlate",["name"]="Crab ChestPlate";["kind"]="Armor",["rarity"]="Legendary"};{["id"]="Crab Leggings";["name"]="Crab Leggings";["kind"]="Armor",["rarity"]="Legendary"};{["id"]="Crab Boots",["name"]="Crab Boots";["kind"]="Armor";["rarity"]="Legendary"},{["id"]="Speed Boots",["name"]="Speed Boots",["kind"]="Armor";["rarity"]="Godly"},{["id"]="Nether Helmet",["name"]="Nether Helmet",["kind"]="Armor",["rarity"]="Secret"},{["id"]="Nether ChestPlate";["name"]="Nether ChestPlate";["kind"]="Armor";["rarity"]="Secret"},{["id"]="Nether Leggings",["name"]="Nether Leggings",["kind"]="Armor",["rarity"]="Secret"};{["id"]="Nether Boots",["name"]="Nether Boots",["kind"]="Armor",["rarity"]="Secret"};{["id"]="Halloween Helmet",["name"]="Pumpkin Reaper Helmet",["kind"]="Armor";["rarity"]="Secret"},{["id"]="Halloween ChestPlate",["name"]="Pumpkin Reaper ChestPlate",["kind"]="Armor";["rarity"]="Secret"},{["id"]="Halloween Leggings";["name"]="Pumpkin Reaper Leggings";["kind"]="Armor",["rarity"]="Secret"},{["id"]="Halloween Boots";["name"]="Pumpkin Reaper Boots",["kind"]="Armor",["rarity"]="Secret"},{["id"]="Scarecrow Helmet";["name"]="Scarecrow Helmet";["kind"]="Armor",["rarity"]="Legendary"},{["id"]="Scarecrow ChestPlate",["name"]="Scarecrow ChestPlate",["kind"]="Armor",["rarity"]="Legendary"};{["id"]="Scarecrow Leggings",["name"]="Scarecrow Leggings";["kind"]="Armor",["rarity"]="Legendary"};{["id"]="Scarecrow Boots";["name"]="Scarecrow Boots",["kind"]="Armor";["rarity"]="Legendary"};{["id"]="Ruby Sword";["name"]="Ruby Sword";["kind"]="Weapon";["rarity"]="Rare",["wtype"]="Sword"},{["id"]="Ruby Spear",["name"]="Ruby Spear",["kind"]="Weapon",["rarity"]="Rare";["wtype"]="Spear"};{["id"]="Ruby Twinblade Axe";["name"]="Ruby Twinblade Axe",["kind"]="Weapon",["rarity"]="Rare";["wtype"]="TwinbladeAxe"};{["id"]="Sea Spear",["name"]="Sea Spear";["kind"]="Weapon";["rarity"]="Epic",["wtype"]="Spear"};{["id"]="Sea Twinblade Axe",["name"]="Sea Twinblade Axe",["kind"]="Weapon",["rarity"]="Epic";["wtype"]="TwinbladeAxe"};{["id"]="Crab Katana",["name"]="Crab Katana",["kind"]="Weapon",["rarity"]="Legendary",["wtype"]="Katana"};{["id"]="Crab Spear";["name"]="Crab Spear",["kind"]="Weapon";["rarity"]="Legendary";["wtype"]="Spear"};{["id"]="Crab Hammer";["name"]="Crab Hammer",["kind"]="Weapon";["rarity"]="Godly",["wtype"]="Hammer"};{["id"]="Anchor Blade",["name"]="Anchor Blade",["kind"]="Weapon",["rarity"]="Godly",["wtype"]="GreatSword"},{["id"]="Coral Axe",["name"]="Coral Axe",["kind"]="Weapon",["rarity"]="Legendary";["wtype"]="GreatAxe"};{["id"]="Halloween Greatsword",["name"]="Halloween Greatsword",["kind"]="Weapon",["rarity"]="Secret",["wtype"]="GreatSword"};{["id"]="Halloween Twinblade Axe",["name"]="Halloween Twinblade Axe";["kind"]="Weapon";["rarity"]="Unknown",["wtype"]="TwinbladeAxe"};{["id"]="Candy Corn Dagger",["name"]="Candy Corn Dagger",["kind"]="Weapon",["rarity"]="Rare",["wtype"]="Dagger"};{["id"]="Bat Dagger",["name"]="Bat Dagger";["kind"]="Weapon";["rarity"]="Legendary";["wtype"]="Dagger"},{["id"]="Evil Axe";["name"]="Evil Axe",["kind"]="Weapon",["rarity"]="Epic",["wtype"]="Axe"};{["id"]="Toxic Bell Hammer";["name"]="Toxic Bell Hammer",["kind"]="Weapon",["rarity"]="Legendary",["wtype"]="Hammer"};{["id"]="Toxic Scythe",["name"]="Toxic Scythe";["kind"]="Weapon",["rarity"]="Godly";["wtype"]="Scythe"},{["id"]="Toxic Twinblade Axe",["name"]="Toxic Twinblade Axe";["kind"]="Weapon",["rarity"]="Secret",["wtype"]="TwinbladeAxe"};{["id"]="Jungle Bow",["name"]="Jungle Bow",["kind"]="Weapon",["rarity"]="Epic",["wtype"]="Bow"},{["id"]="InvincibilityPotion";["name"]="Invincibility Potion",["kind"]="Consumable";["rarity"]="Godly"};{["id"]="Coconut";["name"]="Coconut";["kind"]="Consumable";["rarity"]="Common"},{["id"]="String",["name"]="String";["kind"]="Material";["rarity"]="Common"},{["id"]="Wood",["name"]="Wood";["kind"]="Material";["rarity"]="Common"},{["id"]="JungleWood";["name"]="Jungle Wood";["kind"]="Material",["rarity"]="Rare"},{["id"]="DarkWood";["name"]="Dark Wood";["kind"]="Material",["rarity"]="Epic"},{["id"]="PalmWood";["name"]="Palm Wood",["kind"]="Material",["rarity"]="Legendary"},{["id"]="Glowcap";["name"]="Glowcap";["kind"]="Material",["rarity"]="Epic"},{["id"]="CandyCorn",["name"]="Candy Corn";["kind"]="Material",["rarity"]="Epic"};{["id"]="CommonShard",["name"]="Common Shard",["kind"]="Material",["rarity"]="Common"};{["id"]="RareShard";["name"]="Rare Shard";["kind"]="Material";["rarity"]="Rare"},{["id"]="EpicShard";["name"]="Epic Shard";["kind"]="Material",["rarity"]="Epic"};{["id"]="SecretShard";["name"]="Secret Shard";["kind"]="Material";["rarity"]="Secret"},{["id"]="UnknownShard";["name"]="Unknown Shard";["kind"]="Material",["rarity"]="Unknown"};{["id"]="ShardChest";["name"]="Shard Chest",["kind"]="Chest";["rarity"]="Godly"};{["id"]="LuckTotem";["name"]="Totem";["kind"]="Material";["rarity"]="Legendary"};{["id"]="SafeZoneTotem";["name"]="Totem";["kind"]="Material";["rarity"]="Legendary"};{["id"]="DamageTotem";["name"]="Totem",["kind"]="Material",["rarity"]="Legendary"};{["id"]="XpTotem";["name"]="Totem",["kind"]="Material",["rarity"]="Legendary"};{["id"]="CoinTotem",["name"]="Totem";["kind"]="Material";["rarity"]="Legendary"};{["id"]="Dirtbike";["name"]="Mount",["kind"]="Material";["rarity"]="Epic"};{["id"]="Chopper",["name"]="Mount",["kind"]="Material",["rarity"]="Epic"};{["id"]="SamuraiBike",["name"]="Mount";["kind"]="Material";["rarity"]="Godly"};{["id"]="SelaGorilla",["name"]="Mount";["kind"]="Material",["rarity"]="Legendary"},{["id"]="BoneDragon",["name"]="Mount",["kind"]="Material";["rarity"]="Godly"};{["id"]="ReaperSteed";["name"]="Mount",["kind"]="Material",["rarity"]="Legendary"},{["id"]="SkeletonHorse";["name"]="Mount";["kind"]="Material";["rarity"]="Legendary"};{["id"]="LivingPumpkin";["name"]="Mount";["kind"]="Material";["rarity"]="Godly"},{["id"]="RedshellCrab",["name"]="Mount",["kind"]="Material";["rarity"]="Legendary"};{["id"]="CapBreaker",["name"]="Upgrade",["kind"]="Material",["rarity"]="Secret"},{["id"]="GusLure",["name"]="Lure";["kind"]="Material";["rarity"]="Legendary"};{["id"]="KaiSurfboard",["name"]="Water Mount",["kind"]="Material",["rarity"]="Legendary"};{["id"]="CritDamage1Book";["name"]="Enchant",["kind"]="Material",["rarity"]="Epic"},{["id"]="Regen1Book",["name"]="Enchant";["kind"]="Material",["rarity"]="Epic"},{["id"]="Sharpness1Book";["name"]="Enchant";["kind"]="Material",["rarity"]="Rare"};{["id"]="Sharpness2Book",["name"]="Enchant";["kind"]="Material",["rarity"]="Epic"},{["id"]="Lifesteal1Book";["name"]="Enchant",["kind"]="Material",["rarity"]="Epic"},{["id"]="Executioner1Book",["name"]="Enchant";["kind"]="Material";["rarity"]="Epic"},{["id"]="Bossbane1Book";["name"]="Enchant";["kind"]="Material";["rarity"]="Epic"},{["id"]="Cleave1Book";["name"]="Enchant";["kind"]="Material",["rarity"]="Epic"};{["id"]="Frenzy1Book",["name"]="Enchant";["kind"]="Material",["rarity"]="Legendary"},{["id"]="Fortune1Book";["name"]="Enchant";["kind"]="Material",["rarity"]="Legendary"};{["id"]="Protection1Book",["name"]="Enchant";["kind"]="Material",["rarity"]="Rare"};{["id"]="Protection2Book";["name"]="Enchant";["kind"]="Material",["rarity"]="Epic"};{["id"]="Health1Book",["name"]="Enchant",["kind"]="Material";["rarity"]="Rare"},{["id"]="Health2Book",["name"]="Enchant";["kind"]="Material";["rarity"]="Epic"};{["id"]="SecondWind1Book";["name"]="Enchant",["kind"]="Material";["rarity"]="Epic"};{["id"]="Thorns1Book";["name"]="Enchant";["kind"]="Material";["rarity"]="Epic"};{["id"]="Steadfast1Book",["name"]="Enchant";["kind"]="Material";["rarity"]="Legendary"},{["id"]="PhantomBladeBook",["name"]="Enchant";["kind"]="Material",["rarity"]="Godly"};{["id"]="SoulHarvestBook",["name"]="Enchant";["kind"]="Material";["rarity"]="Godly"},{["id"]="UndyingBook",["name"]="Enchant";["kind"]="Material";["rarity"]="Godly"};{["id"]="JackLanternBook",["name"]="Enchant",["kind"]="Material",["rarity"]="Legendary"},{["id"]="HookedBook",["name"]="Enchant";["kind"]="Material",["rarity"]="Legendary"},{["id"]="BatSwarmBook";["name"]="Enchant";["kind"]="Material";["rarity"]="Godly"},{["id"]="HuntersMoonBook",["name"]="Enchant",["kind"]="Material",["rarity"]="Godly"};{["id"]="ResetPoint",["name"]="Reset Point";["kind"]="Material",["rarity"]="Epic"},{["id"]="BasicChest",["name"]="Weapon Chest 1";["kind"]="Chest",["rarity"]="Common"},{["id"]="Crate";["name"]="Item Crate 1";["kind"]="Chest",["rarity"]="Common"},{["id"]="PaidChest",["name"]="Paid Chest";["kind"]="Chest";["rarity"]="Unknown"};{["id"]="Coal Ore";["name"]="Coal Ore",["kind"]="Material";["rarity"]="Common"};{["id"]="Copper Ore";["name"]="Copper Ore";["kind"]="Material",["rarity"]="Common"};{["id"]="Iron Ore";["name"]="Iron Ore",["kind"]="Material";["rarity"]="Common"};{["id"]="Silver Ore",["name"]="Silver Ore";["kind"]="Material",["rarity"]="Rare"},{["id"]="Gold Ore",["name"]="Gold Ore",["kind"]="Material";["rarity"]="Rare"};{["id"]="Crystal Ore";["name"]="Crystal Ore";["kind"]="Material",["rarity"]="Legendary"},{["id"]="Obsidian Ore";["name"]="Obsidian Ore";["kind"]="Material",["rarity"]="Rare"};{["id"]="Sapphire Ore";["name"]="Sapphire Ore",["kind"]="Material";["rarity"]="Epic"};{["id"]="Emerald Ore";["name"]="Emerald Ore",["kind"]="Material";["rarity"]="Epic"},{["id"]="Ruby Ore",["name"]="Ruby Ore",["kind"]="Material",["rarity"]="Epic"};{["id"]="Uranium Ore";["name"]="Uranium Ore";["kind"]="Material",["rarity"]="Epic"},{["id"]="Platinum Ore";["name"]="Platinum Ore";["kind"]="Material";["rarity"]="Legendary"},{["id"]="Titanium Ore";["name"]="Titanium Ore";["kind"]="Material",["rarity"]="Legendary"};{["id"]="Diamond Ore",["name"]="Diamond Ore";["kind"]="Material";["rarity"]="Epic"};{["id"]="Void Ore";["name"]="Void Ore",["kind"]="Material";["rarity"]="Godly"}}do
    local w={}
    for Y, K in ipairs({"HealthPotion";"Apple", "GoldenApple", "Milk", "Egg", "ClothFabric", "Bone", "LegendaryShard";"GodlyShard";"Cobweb", "RiftKey";"WeaponTierScroll", "ArmourTierScroll";"MountTierScroll";"AbilityRune";"Poison1Book", "Poison2Book";"StarfallBook";"VoodooHexBook", "ReapersTollBook";"Chicken Crown";"Leather Helmet";"Leather Leggings";"Leather Boots";"Leather ChestPlate";"Iron Helmet", "Iron Leggings";"Iron Boots", "Iron ChestPlate";"Gold Helmet";"Gold Leggings";"Gold Boots";"Gold ChestPlate", "Rune Helmet", "Rune Leggings", "Rune Boots";"Rune ChestPlate";"Spider ChestPlate";"Spider Helmet";"Spider Leggings", "Spider Boots", "Jungle Helmet";"Jungle ChestPlate";"Jungle Leggings";"Jungle Boots";"Cobra Helmet";"Cobra ChestPlate";"Cobra Leggings";"Cobra Boots", "Soul Helmet", "Soul ChestPlate", "Soul Leggings";"Soul Boots";"Emerald Helmet", "Emerald ChestPlate";"Emerald Leggings";"Emerald Boots";"Cursed Helmet", "Cursed ChestPlate", "Cursed Leggings";"Cursed Boots";"Dark Helmet", "Dark ChestPlate", "Dark Leggings";"Dark Boots", "Diamond Helmet";"Diamond ChestPlate", "Diamond Leggings";"Diamond Boots";"Vampire Bat Helmet";"Vampire Bat ChestPlate";"Vampire Bat Leggings";"Vampire Bat Boots", "PumpkinChest";"Diamond Sword", "Jungle Great Sword", "Jungle Hammer";"Cobra Spear", "Emerald Hammer";"Cursed Sword";"Cursed Greataxe", "Dark Dagger";"Dark Axe", "Cobra Twinblade Axe", "Basic Katana", "Basic Dagger", "Basic Axe";"Basic Great Axe";"Basic Great Sword";"Basic Hammer", "Basic Scythe";"Basic Spear";"Basic Twinblade Axe", "Rune Sword";"Amethyst Sword", "Phantom Katana";"Rune Greatsword";"Venom Dagger";"Spider Dagger", "Primal Axe";"Royal Axe";"Quartz Hammer", "Potion Spear", "Hunter Spear";"Bat Greataxe", "Bat Bow", "Bat Striker", "Soul Scythe", "Shadow Katana";"Ruby Helmet", "Ruby ChestPlate";"Ruby Leggings", "Ruby Boots", "Sea Helmet", "Sea ChestPlate";"Sea Leggings";"Sea Boots";"Crab Helmet";"Crab ChestPlate", "Crab Leggings", "Crab Boots";"Ruby Sword", "Ruby Spear", "Ruby Twinblade Axe", "Sea Spear", "Sea Twinblade Axe";"Crab Katana";"Crab Spear";"Crab Hammer";"Anchor Blade", "Coral Axe";"Coconut", "Wood", "JungleWood", "DarkWood";"PalmWood", "Glowcap";"LivingPumpkin", "Coal Ore", "Copper Ore";"Iron Ore", "Silver Ore";"Gold Ore";"Crystal Ore", "Obsidian Ore", "Sapphire Ore";"Emerald Ore", "Ruby Ore", "Uranium Ore";"Platinum Ore";"Titanium Ore";"Diamond Ore";"Void Ore"})do
      w[K]=true
    end
    for Y=#n, 1,-1 do
      if not w[n[Y].id]then
        table.remove(n, Y)
      end
    end
    if type(l.CollectItems)=="table" then
      for Y=#l.CollectItems, 1,-1 do
        if not w[l.CollectItems[Y]]then
          table.remove(l.CollectItems, Y)
        end
      end
    end
  end
  local F, I, m, M={},{},{},{}
  for w, Y in ipairs(n)do
    F[Y.id]=Y I[Y.id:lower()]=Y.id I[Y.name:lower()]=Y.id m[Y.name]=Y.id M[Y.id]=Y.name
  end
  local S={["Helmet"]=true;["ChestPlate"]=true;["Leggings"]=true,["Boots"]=true}p, V, t={},{},{}
  for w, Y in ipairs(n)do
    if Y.kind=="Armor" then
      local w, K=Y.id:match("^(.*) (%S+)$")
      local F=Y.name:match("^(.*) %S+$")
      if w and S[K]then
      Y.set, Y.piece=w, K
      else
        w, F=Y.id, Y.name Y.set=w
      end
      if not V[w]then
        table.insert(p, w)V[w]=F or w t[F or w]=w
      end
    end
  end
  local function
    N(w)
    return I[(tostring(w)):lower()]or tostring(w)
  end
  function
    j(w)
    return M[w]or w
  end
  local function
    T(w)
    return m[w]or w
  end
  local function
    v(w)
    local K=w:GetAttribute(Y)
    if type(K)~="string" or K=="" then
      K=w.Name
    end
    return N(K)
  end
  local function
    L(w)
    local Y={}
    for w, K in ipairs(w or{})do
      Y[tostring(K)]=true
    end
    return Y
  end
  function
    C(w)
    local Y={}
    if type(w)=="table" then
      for w, F in pairs(w)do
        if type(F)=="table" then
          F=F.Title or F.Name or F.Value
        end
        if F~=nil and tostring(F)~=K then
          table.insert(Y, T(tostring(F)))
        end
      end
    elseif w~=nil and tostring(w)~=K then
      table.insert(Y, T(tostring(w)))
    end
    return Y
  end
  local function
    G(w, Y)
    local K=w.Parent
    if K and K:IsA("Attachment")then
      return K.WorldPosition
    end
    if K and K:IsA("BasePart")then
      return K.Position
    end
    return(Y:GetPivot()).Position
  end
  local function
    i()
    local Y=workspace:FindFirstChild(w)
    local K=x.Character
    local I=K and K:FindFirstChild("HumanoidRootPart")
    if not Y or not I then
      return{}
    end
    local m=L(l.CollectItems)
    local M=L(l.CollectKinds)
    local S=L(l.CollectArmorSets)
    local N=L(l.CollectArmorPieces)
    local T={}
    for w, Y in ipairs(Y:GetChildren())do
      if Y:IsA("Model")and Y:GetAttribute("ServerDropResting")==true then
        local w=v(Y)
        local K=F[w]
        local x=false
        if K and(K.kind=="Armor" and S[K.set])then
          x=(#l.CollectArmorPieces==0)or(K.piece~=nil and N[K.piece]==true)
        end
        if l.CollectAll or m[w]or(K and M[K.kind])or x then
          local w=Y:FindFirstChildWhichIsA("ProximityPrompt", true)
          if w and w.Enabled then
            local K=G(w, Y)table.insert(T,{["model"]=Y,["prompt"]=w,["pos"]=K,["dist"]=((K-I.Position)).Magnitude})
          end
        end
      end
    end
    table.sort(T, function
      (w, Y)
      return w.dist<Y.dist
    end
    )
    return T
  end
  local function
    o(w)
    if typeof(fireproximityprompt)=="function" then
    fireproximityprompt(w)
    else
      w:InputHoldBegin()task.wait(((w.HoldDuration or 0))+.05)w:InputHoldEnd()
    end
  end
  E.wantedDrops, E.pickup, E.dropItemId, E.toSet=i, o, v, L
  local a={["skip"]=setmetatable({},{["__mode"]="k"});["near"]=setmetatable({},{["__mode"]="k"});["clearAt"]=nil,["startedAt"]=nil}function
    X()a.clearAt, a.startedAt=nil, nil table.clear(a.skip)table.clear(a.near)
  end
  local function
    Q()
    return l.CollectAll or#((l.CollectKinds or{}))>0 or#((l.CollectItems or{}))>0 or#((l.CollectArmorSets or{}))>0
  end
  function
    h()
    if not l.SweepEnabled or not Q()then
      return nil
    end
    local w=os.clock()a.clearAt=a.clearAt or w a.startedAt=a.startedAt or w
    if w-a.startedAt>((tonumber(l.SweepMaxTime)or 30))then
      return nil
    end
    local Y=tonumber(l.SweepRadius)or 80
    for w, K in ipairs(i())do
      if not a.skip[K.model]and K.dist<=Y then
        return K
      end
    end
    if w-a.clearAt<((tonumber(l.SweepGrace)or 2))then
      return "wait"
    end
    return nil
  end
  function
    P(w)
    local Y=math.max(1,((w.prompt["MaxActivationDistance"]or 10))-1.5)
    if w.dist>Y then
      return
    end
    local K=os.clock()
    local F=a.near[w.model]
    if not F then
      F={["at"]=0;["tries"]=0}a.near[w.model]=F
    end
    if K-F.at>.7 then
      F.at=K F.tries=F.tries+1
      if F.tries>5 then
        a.skip[w.model]=true
        return
      end
      task.spawn(o, w.prompt)
    end
  end
end
local b="WorldBits"
local W, k, B, c=E.wantedDrops, E.pickup, E.dropItemId, E.toSet
local function
  u(w)
  local Y=c(l.CollectKnown)
  local K=0
  for w, F in ipairs(w)do
    if F~="" and not Y[F]then
      Y[F]=true K=K+1
    end
  end
  if K>0 then
    local w={}
    for Y in pairs(Y)do
      table.insert(w, Y)
    end
    table.sort(w)l.CollectKnown=w o()
  end
  return K
end
local function
  O()
  local w=workspace:FindFirstChild(b)
  if not w then
    return 0
  end
  local Y={}
  for w, K in ipairs(w:GetChildren())do
    if K:IsA("Model")then
      table.insert(Y, B(K))
    end
  end
  return u(Y)
end
local e=setmetatable({},{["__mode"]="k"})task.spawn(function
  ()
  while task.wait(.15)do
    if l.AutoCollectEnabled then
      pcall(function
        ()
        local w=os.clock()
        local Y=false
        local K=nil
        local F=tonumber(l.CollectWalkRadius)or 40
        local I=tonumber(l.CollectRadius)or 12
        for m, M in ipairs(W())do
          local x=I
          if not l.CollectIgnoreRange then
            x=math.min(I,((M.prompt["MaxActivationDistance"]or 10))-1)
          end
          x=math.max(1, x)
          if M.dist<=x then
            Y=true
            if w-((e[M.model]or 0))>.8 then
              e[M.model]=w task.spawn(k, M.prompt)
            end
          elseif not K and(l.CollectWalk and M.dist<=F)then
            K=M
          end
        end
        if K and(not Y and not l.FlyEnabled)then
          local w=x.Character
          local Y=w and w:FindFirstChildOfClass("Humanoid")
          if Y then
            Y:MoveTo(K.pos)
          end
        end
      end
      )
    end
  end
end
)
local function
  U(Y)l.AutoCollectEnabled=Y o()
  if Y then
    O()
  end
  w:Notify({["Title"]="Auto Collect",["Content"]=Y and "Activated" or "Deactivated",["Duration"]=2})
end
function
  g.AutoCollect(w)U(w)J("AutoCollectEnabled", w)
end
local R={}function
  R.locked()
  return x:GetAttribute("DungeonRun")~=nil or x:GetAttribute("HDRun")~=nil or x:GetAttribute("DraculaCastleRun")~=nil
end
function
  R.deny(Y, K)l[K]=false pcall(J, K, false)
  if os.clock()-((R.denyAt or 0))>3 then
    R.denyAt=os.clock()w:Notify({["Title"]=Y;["Content"]="Not available inside a dungeon (full version only)",["Duration"]=3})
  end
end
local function
  f()
  local w=x.Character
  if not w then
    return
  end
  local Y=w:FindFirstChild("HumanoidRootPart")
  if not Y then
    return
  end
  if l.AntiKnockbackEnabled and not R.locked()then
  local w=PhysicalProperties.new(l.AntiKnockbackDensity, .3, .5, 1, 1)Y.CustomPhysicalProperties=w
  else
    Y.CustomPhysicalProperties=nil
  end
end
local function
  q(Y)
  if Y and R.locked()then
    R.deny("Anti Knockback", "AntiKnockbackEnabled")Y=false
  end
  l.AntiKnockbackEnabled=Y o()f()
  if Y then
    if not R.ak then
      R.ak=K.Heartbeat:Connect(function
        ()
        local w=x.Character
        if w and w:FindFirstChild("HumanoidRootPart")then
          local Y=w.HumanoidRootPart
          for w, Y in pairs(Y:GetChildren())do
            if Y:IsA("BodyMover")or Y:IsA("BodyVelocity")or Y:IsA("BodyForce")or Y:IsA("VectorForce")or Y:IsA("LinearVelocity")then
              Y:Destroy()
            end
          end
        end
      end
      )
    end
  w:Notify({["Title"]="Anti Knockback";["Content"]="Activated",["Duration"]=2})
  else
    if R.ak then
      R.ak:Disconnect()R.ak=nil
    end
    w:Notify({["Title"]="Anti Knockback";["Content"]="Deactivated";["Duration"]=2})
  end
end
local function
  Z(Y)
  if R.inf then
    R.inf:Disconnect()R.inf=nil
  end
  l.InfJumpEnabled=Y o()
  if Y then
    R.inf=F.JumpRequest:Connect(function
      ()
      local w=x.Character
      local Y=w and w:FindFirstChildOfClass("Humanoid")
      if Y then
        Y:ChangeState(Enum.HumanoidStateType["Jumping"])
      end
    end
  )w:Notify({["Title"]="Inf Jump";["Content"]="Activated";["Duration"]=2})
  else
    w:Notify({["Title"]="Inf Jump",["Content"]="Deactivated",["Duration"]=2})
  end
end
function
  g.InfJump(w)Z(w)J("InfJumpEnabled", w)
end
local function
  A(Y, F)
  if R.noclip then
    R.noclip:Disconnect()R.noclip=nil
  end
  if Y and(not F and R.locked())then
    R.deny("Noclip", "NoclipEnabled")Y=false
  end
  l.NoclipEnabled=Y o()
  if Y then
    R.noclip=K.Stepped:Connect(function
      ()
      local w=x.Character
      if w then
        for w, Y in ipairs(w:GetDescendants())do
          if Y:IsA("BasePart")and Y.CanCollide then
            Y.CanCollide=false
          end
        end
      end
    end
  )w:Notify({["Title"]="Noclip";["Content"]="Activated",["Duration"]=2})
  else
    w:Notify({["Title"]="Noclip",["Content"]="Deactivated";["Duration"]=2})
  end
end
function
  g.Noclip(w)A(w)J("NoclipEnabled", l.NoclipEnabled)
end
task.spawn(function
  ()
  while task.wait(.25)do
    if R.locked()then
      if l.NoclipEnabled and not R.farm then
        pcall(A, false)pcall(J, "NoclipEnabled", false)
      end
      if l.AntiKnockbackEnabled then
        pcall(q, false)pcall(J, "AntiKnockbackEnabled", false)
      end
    end
  end
end
)
local H={["Active"]=false}
local s={["Active"]=false}
local d={["Active"]=false}
local z={["Active"]=false}
local r={["Active"]=false;["WF"]={["Active"]=false}}
local wL={["Active"]=false}
local YL={["active"]=false,["bg"]=nil;["bv"]=nil;["up"]=nil;["down"]=nil;["vertical"]=0,["btn"]=0,["gui"]=nil}
local function
  KL()
  if YL.gui then
    pcall(function
      ()YL.gui:Destroy()
    end
    )YL.gui=nil
  end
  YL.btn=0
  if YL.bg then
    pcall(function
      ()YL.bg:Destroy()
    end
    )YL.bg=nil
  end
  if YL.bv then
    pcall(function
      ()YL.bv:Destroy()
    end
    )YL.bv=nil
  end
  if YL.up then
    YL.up:Disconnect()YL.up=nil
  end
  if YL.down then
    YL.down:Disconnect()YL.down=nil
  end
  YL.vertical=0 YL.active=false YL.walking=false
end
function
  YL.mkButtons()
  if YL.gui then
    pcall(function
      ()YL.gui:Destroy()
    end
    )YL.gui=nil
  end
  YL.btn=0
  if not l.FlyBtns then
    return
  end
  local w=Instance.new("ScreenGui")w.Name="FlyBtns" w.ResetOnSpawn=false w.DisplayOrder=50 pcall(function
    ()w.Parent=(gethui and gethui())or game:GetService("CoreGui")
  end
  )
  if not w.Parent then
    w:Destroy()
    return
  end
  local function
    Y(Y, K, F)
    local I=Instance.new("TextButton")I.Size=UDim2.fromOffset(64, 64)I.Position=UDim2.new(1,-90, .5, K)I.BackgroundColor3=Color3.fromRGB(30, 30, 36)I.BackgroundTransparency=.25 I.TextColor3=Color3.new(1, 1, 1)I.TextSize=30 I.Font=Enum.Font["GothamBold"]I.Text=Y I.AutoButtonColor=true I.Parent=w
    local m=Instance.new("UICorner")m.CornerRadius=UDim.new(0, 14)m.Parent=I I.InputBegan:Connect(function
      (w)
      if w.UserInputType==Enum.UserInputType["Touch"]or w.UserInputType==Enum.UserInputType["MouseButton1"]then
        YL.btn=F
      end
    end
    )I.InputEnded:Connect(function
      (w)
      if((w.UserInputType==Enum.UserInputType["Touch"]or w.UserInputType==Enum.UserInputType["MouseButton1"]))and YL.btn==F then
        YL.btn=0
      end
    end
    )
  end
  Y("▲",-72, 1)Y("▼", 8,-1)YL.gui=w
end
local function
  FL()
  local Y=x.Character
  if not Y then
    return
  end
  local I=Y:FindFirstChild("HumanoidRootPart")
  local m=Y:FindFirstChildOfClass("Humanoid")
  if not I or not m then
    return
  end
  KL()YL.active=true pcall(function
    ()m.PlatformStand=true
  end
  )YL.bg=Instance.new("BodyGyro", I)YL.bg["P"]=90000 YL.bg["MaxTorque"]=Vector3.new(9000000000, 9000000000, 9000000000)YL.bg["CFrame"]=I.CFrame YL.bv=Instance.new("BodyVelocity", I)YL.bv["Velocity"]=Vector3.zero YL.bv["MaxForce"]=Vector3.new(9000000000, 9000000000, 9000000000)YL.mkButtons()YL.up=F.InputBegan:Connect(function
    (w, Y)
    if Y then
      return
    end
    if w.KeyCode==Enum.KeyCode["E"]then
      YL.vertical=1
    end
    if w.KeyCode==Enum.KeyCode["Q"]then
      YL.vertical=-1
    end
  end
  )YL.down=F.InputEnded:Connect(function
    (w)
    if w.KeyCode==Enum.KeyCode["E"]and YL.vertical==1 then
      YL.vertical=0
    end
    if w.KeyCode==Enum.KeyCode["Q"]and YL.vertical==-1 then
      YL.vertical=0
    end
  end
  )task.spawn(function
    ()
    while YL.active do
      K.RenderStepped:Wait()
      local w=x.Character
      local Y=w and w:FindFirstChild("HumanoidRootPart")
      if not Y then
        break
      end
      local I=math.clamp(tonumber(l.FlySpeed)or 40, 5, 40)
      local m=((((YL.vertical~=0 and YL.vertical or YL.btn))*I)*math.clamp(tonumber(l.FlyVert)or 6, 1, 11))/10
      local M=S.CFrame
      local N=Vector3.zero
      if not F:GetFocusedTextBox()then
        local w=F:IsKeyDown(Enum.KeyCode["W"])
        local Y=F:IsKeyDown(Enum.KeyCode["A"])
        local K=F:IsKeyDown(Enum.KeyCode["S"])
        local x=F:IsKeyDown(Enum.KeyCode["D"])
        local S=((x and 1 or 0))-((Y and 1 or 0))
        local T=((K and 1 or 0))-((w and 1 or 0))
        local v=Vector3.new(S, 0, T)
        if v.Magnitude>0 then
          v=v.Unit
        end
      local L=(M.RightVector*v.X)+(M.LookVector*-v.Z)N=L*I+Vector3.new(0, m, 0)
      else
        N=Vector3.new(0, m, 0)
      end
      if H.Active and H.Step then
        local w, K=H.Step(Y, I)
        if w then
          N=w
          if K then
            M=K
          end
        end
      elseif s.Active and s.Step then
        local w, K=s.Step(Y, I)
        if w then
          N=w
          if K then
            M=K
          end
        end
      elseif z.Active and z.Step then
        local w, K=z.Step(Y, I)
        if w then
          N=w
          if K then
            M=K
          end
        end
      elseif d.Active and d.Step then
        local w, K=d.Step(Y, I)
        if w then
          N=w
          if K then
            M=K
          end
        end
      elseif r.Active and r.Step then
        local w, K=r.Step(Y, I)
        if w then
          N=w
          if K then
            M=K
          end
        end
      elseif r.WF["Active"]and r.WF["Step"]then
        local w, K=r.WF["Step"](Y, I)
        if w then
          N=w
          if K then
            M=K
          end
        end
      elseif wL.Active and wL.Step then
        local w, K=wL.Step(Y, I)
        if w then
          N=w
          if K then
            M=K
          end
        end
      end
      local T=((s.Active and s.Walk))and true or false
      if T~=YL.walking then
        YL.walking=T pcall(function
          ()
          local Y=w:FindFirstChildOfClass("Humanoid")
          local K=T and Vector3.zero or Vector3.new(9000000000, 9000000000, 9000000000)YL.bv["MaxForce"]=K YL.bg["MaxTorque"]=K
          if Y then
            Y.PlatformStand=not T
          end
        end
        )
      end
      if not T then
        YL.bv["Velocity"]=N YL.bg["CFrame"]=M
      end
    end
  end
  )w:Notify({["Title"]="Fly",["Content"]="Activated (E=Up, Q=Down)";["Duration"]=2})
end
local function
  IL()KL()
  local Y=x.Character
  if Y then
    local w=Y:FindFirstChildOfClass("Humanoid")
    if w then
      pcall(function
        ()w.PlatformStand=false
      end
      )
    end
  end
  w:Notify({["Title"]="Fly";["Content"]="Deactivated";["Duration"]=2})
end
local function
  mL(w)l.FlyEnabled=w o()
  if w then
  FL()
  else
    IL()
  end
end
x.CharacterAdded:Connect(function
  (w)task.wait(.5)
  if l.FlyEnabled then
    FL()
  end
  if l.SpeedEnabled then
    local Y=w:WaitForChild("Humanoid", 5)
    if Y then
      Y.WalkSpeed=l.WalkSpeed
    end
  end
  if l.AntiKnockbackEnabled then
    f()
  end
end
)
local function
  ML(Y)
  if R.speed then
    R.speed:Disconnect()R.speed=nil
  end
  l.SpeedEnabled=Y o()
  local F=x.Character
  local I=F and F:FindFirstChildOfClass("Humanoid")
  if Y then
    if I then
      I.WalkSpeed=l.WalkSpeed
    end
    R.speed=K.Stepped:Connect(function
      ()
      local w=x.Character
      local Y=w and w:FindFirstChildOfClass("Humanoid")
      if Y and Y.WalkSpeed~=l.WalkSpeed then
        Y.WalkSpeed=l.WalkSpeed
      end
    end
  )w:Notify({["Title"]="Speed";["Content"]="Walk speed: %d":format(l.WalkSpeed);["Duration"]=2})
  else
    if I then
      I.WalkSpeed=16
    end
    w:Notify({["Title"]="Speed";["Content"]="Deactivated";["Duration"]=2})
  end
end
function
  g.Speed(w)ML(w)J("SpeedEnabled", w)
end
local function
  xL(w)
  return math.clamp(tonumber(w)or 0,-10, 20)
end
local SL={["flyByFarm"]=false;["noclipByUs"]=false}
local function
  NL()
  if not l.FlyEnabled then
    SL.flyByFarm=true mL(true)J("FlyEnabled", true)
  end
end
local function
  TL()
  if SL.flyByFarm and not((l.DFEnabled or l.DCEnabled or l.VXEnabled or l.DKEnabled or l.BSEnabled or l.CPEnabled))then
    SL.flyByFarm=false
    if l.FlyEnabled then
      mL(false)J("FlyEnabled", false)
    end
  end
end
local function
  vL(w)
  return math.clamp(tonumber(w)or 10, 0, 10)
end
local LL={["boss"]=nil,["airborne"]=false;["lastDir"]=nil,["lastLabel"]=nil,["lastLabelAt"]=0,["noBossAt"]=nil,["lastSummon"]=0,["busy"]=false,["weapon"]=nil}
local GL=Vector3.new(-480, 62, 320)
local function
  iL(w)
  local Y=os.clock()
  if w~=LL.lastLabel and Y-LL.lastLabelAt>2.5 then
    LL.lastLabel, LL.lastLabelAt=w, Y
  end
end
local function
  oL(w)
  return typeof(w)=="Instance" and(w:IsA("Model")and(w.Parent~=nil and(w:GetAttribute("CharacterId")=="MageBoss" and w:GetAttribute("_SharedBoss")==true)))
end
local function
  aL(w)
  local Y=w:FindFirstChildOfClass("Humanoid")
  if Y then
    return Y.Health>0
  end
  return((tonumber(w:GetAttribute("Health"))or 1))>0 and not w:GetAttribute("_Dying")
end
local function
  lL()
  if LL.boss and(oL(LL.boss)and aL(LL.boss))then
    return LL.boss
  end
  LL.boss=nil
  local w=workspace:FindFirstChild("Knight_Live")
  if w then
    for w, Y in ipairs(w:GetChildren())do
      if oL(Y)and aL(Y)then
        LL.boss=Y
        return Y
      end
    end
  end
  return nil
end
local function
  QL(w)
  return w and((w:FindFirstChild("HumanoidRootPart")or w.PrimaryPart))
end
d.sf={["on"]=false;["wards"]=nil,["center"]=nil;["startedAt"]=0;["channel"]=5;["wr"]=6.5;["retreat"]=false}task.spawn(function
  ()
  local w=m:WaitForChild("Quest_Engine", 30)
  local Y=w and w:WaitForChild("Remotes", 10)
  local K=Y and Y:WaitForChild("MageBossFX", 10)
  if not K then
    return
  end
  K.OnClientEvent:Connect(function
    (w, Y)pcall(function
      ()
      if w=="Starfall" and type(Y)=="table" then
        d.sf["on"]=true d.sf["retreat"]=false d.sf["startedAt"]=tonumber(Y.startedAt)or workspace:GetServerTimeNow()d.sf["channel"]=tonumber(Y.channel)or 5 d.sf["wr"]=tonumber(Y.wardRadius)or 6.5 d.sf["center"]=(typeof(Y.center)=="Vector3")and Y.center or nil
        local w={}
        if type(Y.wards)=="table" then
          for Y, K in pairs(Y.wards)do
            if typeof(K)=="Vector3" then
              table.insert(w, K)
            end
          end
        end
      d.sf["wards"]=w
      elseif w=="StarfallCancel" or w=="StarfallImpact" or w=="Cleanup" then
        d.sf["on"], d.sf["retreat"]=false, false
      end
    end
    )
  end
  )
end
)function
  d.Starfall()
  if not d.sf["on"]then
    return nil
  end
  local w=(d.sf["startedAt"]+d.sf["channel"])-workspace:GetServerTimeNow()
  if w<-0.4 then
    d.sf["on"], d.sf["retreat"]=false, false
    return nil
  end
  return w
end
local function
  gL(w, Y)
  local K=RaycastParams.new()K.FilterType=Enum.RaycastFilterType["Exclude"]
  local F={w}
  if x.Character then
    table.insert(F, x.Character)
  end
  for w, Y in ipairs({"Knight_Live", "Animal_Live"})do
    local K=workspace:FindFirstChild(Y)
    if K then
      table.insert(F, K)
    end
  end
  K.FilterDescendantsInstances=F
  local I=workspace:Raycast(Y.Position, Vector3.new(0,-400, 0), K)
  local m=I and(Y.Position["Y"]-I.Position["Y"])or 400
  if LL.airborne then
    if m<7 then
      LL.airborne=false
    end
  elseif m>10 then
    LL.airborne=true
  end
end
function
  d.Step(w, Y)
  local K=LL.boss
  local F=QL(K)
  if not F then
    return nil
  end
  Y=math.clamp(tonumber(l.VXSpeed)or 20, 5, 20)
  local I=w.Position
  local m=F.Position
  local M=d.Starfall()
  local x=m.Y+vL(l.VXHeight)
  local N=(Vector3.new(m.X-I.X, 0, m.Z-I.Z)).Magnitude
  local T=LL.lastDir
  local v=Vector3.new(m.X-I.X, 0, m.Z-I.Z)
  if v.Magnitude>1.5 then
    T=v.Unit
  end
  if not T then
    local w=S.CFrame["LookVector"]
    local Y=Vector3.new(w.X, 0, w.Z)T=Y.Magnitude>.01 and Y.Unit or Vector3.new(0, 0,-1)
  end
  LL.lastDir=T
  local L=nil
  if l.VXProne then
  L=CFrame.lookAt(I, I+T)*CFrame.Angles(-math.pi/2, 0, 0)
  elseif l.VXFace then
    L=CFrame.lookAt(I, I+T)
  end
  if M and(l.VXSafe and(d.sf["wards"]and#d.sf["wards"]>0))then
    local w, Y=nil, math.huge
    for K, F in ipairs(d.sf["wards"])do
      local m=(Vector3.new(F.X-I.X, 0, F.Z-I.Z)).Magnitude
      if m<Y then
        w, Y=F, m
      end
    end
    local K=w.Y+3
    local F=math.sqrt(Y*Y+((K-I.Y))^2)
    local m=math.max(0, F-d.sf["wr"]*.4)/20+.5
    if d.sf["retreat"]or M<=m then
      d.sf["retreat"]=true
      local F=Vector3.zero
      if Y>.6 then
        F=(Vector3.new(w.X-I.X, 0, w.Z-I.Z)).Unit*math.min(20,((Y-.5))*8)
      end
      local m=math.clamp(((K-I.Y))*6,-20, 20)
      local M=F+Vector3.new(0, m, 0)
      if M.Magnitude>20 then
        M=M.Unit*20
      end
      return M, L
    end
  end
  if LL.airborne then
    return Vector3.zero, L
  end
  local G=0 pcall(function
    ()G=math.clamp(F.AssemblyLinearVelocity["Y"],-30, 30)
  end
  )
  local i=math.clamp(((x-I.Y))*((M and 9 or 6))+G*.8,-Y, Y)
  local o=Vector3.zero
  if N>1.6 then
    o=(Vector3.new(m.X-I.X, 0, m.Z-I.Z)).Unit*math.min(Y,((N-1.5))*8)
  end
  local a=o+Vector3.new(0, i, 0)
  if a.Magnitude>Y then
    a=a.Unit*Y
  end
  return a, L
end
local function
  JL(w)
  if not w and l.FlyEnabled then
    mL(false)J("FlyEnabled", false)
  end
end
local function
  DL(w)
  if not((w and w:IsA("Tool")))then
    return false
  end
  local Y=((w.Name:lower()):gsub("[%s_]", ""))
  return Y=="riftkey" or Y:find("rift", 1, true)~=nil
end
local yL=nil
local function
  EL()
  if not yL then
    local w, Y=pcall(function
      ()
      local w=(game:GetService("StarterPlayer")):FindFirstChild("StarterPlayerScripts")
      local Y=w and w:FindFirstChild("Data_Client")
      local K=Y and Y:FindFirstChild("PlayerData")
      return K and require(K)
    end
    )
    if w and Y then
      yL=Y
    end
  end
  if not yL then
    return nil
  end
  local w, Y=pcall(function
    ()
    return yL:Get()
  end
  )
  return w and Y or nil
end
local function
  nL()
  local w=EL()
  local Y=w and w.Data
  if not Y then
    return nil
  end
  local K, F=Y.Hotbar, Y.Inventory
  if type(F)~="table" then
    return nil
  end
  local function
    I(w)
    if not w then
      return nil
    end
    for Y, K in pairs(F)do
      if type(K)=="table" and type(K[w])=="table" then
        return K[w]
      end
    end
    return nil
  end
  if type(K)=="table" then
    for w=1, 9, 1 do
      local Y=I(K[w])
      if Y and((tostring(Y.Id)):lower()):find("rift", 1, true)then
        return K[w]
      end
    end
  end
  for w, Y in pairs(F)do
    if type(Y)=="table" then
      for w, Y in pairs(Y)do
        if type(Y)=="table" and((tostring(Y.Id)):lower()):find("rift", 1, true)then
          return w
        end
      end
    end
  end
  return nil
end
local function
  pL()
  local w=m:FindFirstChild("Inventory_Engine")
  local Y=w and w:FindFirstChild("Remotes")
  return Y and Y:FindFirstChild("EquipRequest")
end
local function
  VL(w)
  if w:IsA("BasePart")then
    return w.Position
  end
  if w:IsA("Model")then
    return(w:GetPivot()).Position
  end
  return nil
end
local function
  tL(w, Y)
  local K, F=nil, Y or 70
  for Y, I in ipairs(M:GetTagged("MageRift"))do
    local m=I:GetAttribute("RiftState")
    if m and m~="closing" then
      local Y=VL(I)
      if Y then
        local I=(Vector3.new(Y.X-w.Position["X"], 0, Y.Z-w.Position["Z"])).Magnitude
        if I<=F then
          K, F=m, I
        end
      end
    end
  end
  return K
end
local function
  jL(w)
  local Y=workspace:FindFirstChild("MageBoss_Arena")
  local K=Y and Y:FindFirstChild("ArenaCenter")
  local F=((K and K:IsA("BasePart")))and K.Position or GL
  return((w.Position-F)).Magnitude<130
end
local function
  CL(Y)LL.lastLabel, LL.lastLabelAt=Y, os.clock()warn("[kw/vex] "..tostring(Y))
  local K=os.clock()
  if Y~=LL.noteLast or K-((LL.noteAt or 0))>4 then
    LL.noteLast, LL.noteAt=Y, K pcall(function
      ()w:Notify({["Title"]="Archmage Vex";["Content"]=tostring(Y),["Duration"]=5})
    end
    )
  end
end
task.spawn(function
  ()
  local w=m:WaitForChild("Quest_Engine", 30)
  local Y=w and w:WaitForChild("Remotes", 10)
  local K=Y and Y:WaitForChild("MageRift", 60)
  if not K then
    return
  end
  K.OnClientEvent:Connect(function
    (w, Y)
    if w~="summon" or type(Y)~="table" or Y.ok~=false then
      return
    end
    local K=tostring(Y.reason or "busy")
    local F={["room"]="Rift rejected: no flat open ground here (moving and retrying)";["town"]="Rift rejected: can't open a rift in town",["challenge"]="Rift rejected: can't open at the challenge grounds";["level"]="Rift rejected: level 100 needed";["open"]="Rift rejected: a rift is already open";["fight"]="Rift rejected: Vex is already fighting",["notheld"]="Rift rejected: key not in hands",["failed"]="Rift rejected: failed, key returned";["busy"]="Rift rejected: busy"}LL.reason, LL.reasonAt=K, os.clock()
    if K=="room" then
      LL.needMove=true
    end
    CL(F[K]or("Rift rejected: "..K))
  end
  )
end
)function
  d.held(w, Y)
  for w, K in ipairs(w:GetChildren())do
    if K:IsA("Tool")then
      if DL(K)then
        return K
      end
      if Y and K:GetAttribute("InventorySerial")==Y then
        return K
      end
      for w, Y in pairs(K:GetAttributes())do
        if type(Y)=="string" and(Y:lower()):find("rift", 1, true)then
          return K
        end
      end
    end
  end
  return nil
end
function
  d.snap(w)
  local Y={}
  for w, K in ipairs(w:GetChildren())do
    if K:IsA("Tool")then
      Y[K]=true
    end
  end
  return Y
end
function
  d.heldNew(w, Y, K)
  local F=d.held(w, Y)
  if F then
    return F
  end
  for w, Y in ipairs(w:GetChildren())do
    if Y:IsA("Tool")and(not K[Y]and(Y:GetAttribute("WeaponId")==nil and not Y:GetAttribute("IsConsumableTool")))then
      return Y
    end
  end
  return nil
end
function
  d.uiSlot()
  local w=nil pcall(function
    ()
    local Y=x:FindFirstChildOfClass("PlayerGui")
    local K=Y and Y:FindFirstChild("Hotbar")
    local F=K and K:FindFirstChild("Holder")
    if not F then
      return
    end
    for Y=1, 9, 1 do
      local K=F:FindFirstChild("Slot"..Y)
      local I=K and K:GetAttribute("ItemId")
      if type(I)=="string" and(I:lower()):find("rift", 1, true)then
        w=Y
        return
      end
    end
  end
  )
  return w
end
function
  d.slotOf(w)
  local Y=EL()
  local K=Y and(Y.Data and Y.Data["Hotbar"])
  if type(K)=="table" then
    for Y=1, 9, 1 do
      if K[Y]==w then
        return Y
      end
    end
  end
  return nil
end
function
  d.scan()d.scanPath=nil
  local w=EL()
  local Y=w and w.Data
  local K, F, I={},{},{}
  if type(Y)~="table" then
    return nil, K
  end
  local function
    m(w, Y, M, x)
    if M>6 or I[w]then
      return
    end
    I[w]=true
    for w, I in pairs(w)do
      local S=Y..("/"..tostring(w))
      if type(w)=="string" and(w:lower()):find("rift", 1, true)then
        K[#K+1]="KEY  "..(S..(" = "..type(I)))F[#F+1]={["serial"]=w,["path"]=S}
      end
      if type(I)=="string" then
        if(I:lower()):find("rift", 1, true)then
          K[#K+1]="VAL  "..(S..(" = "..I))
          if type(x)=="string" then
            F[#F+1]={["serial"]=x,["path"]=Y}
          end
        end
      elseif type(I)=="table" then
        m(I, S, M+1, w)
      end
    end
  end
  m(Y, "Data", 0, nil)
  local M=nil
  for w, Y in ipairs(F)do
    if Y.path:find("Inventory", 1, true)then
      M=Y break
    end
  end
  M=M or F[1]
  if M then
    d.scanPath=M.path
    return M.serial, K
  end
  return nil, K
end
function
  d.dump(w)
  local Y=EL()
  local K=Y and Y.Data
  local F={}
  if type(K)~="table" then
  F[1]="no player data (PlayerData module not found)"
  else
    for w, Y in pairs(K)do
      if type(Y)=="table" then
        local K=0
        for w in pairs(Y)do
          K=K+1
        end
      F[#F+1]="Data."..(tostring(w)..(" = table("..(K..")")))
      else
        F[#F+1]="Data."..(tostring(w)..(" = "..type(Y)))
      end
    end
    local w=K.Inventory
    if type(w)=="table" then
      for w, Y in pairs(w)do
        if type(Y)=="table" then
          local K, I={}, 0
          for w, Y in pairs(Y)do
            I=I+1
            if#K<8 then
              K[#K+1]=type(Y)=="table" and tostring(Y.Id)or(tostring(w)..("="..tostring(Y)))
            end
          end
          F[#F+1]="Inventory."..(tostring(w)..(" ("..(I..("): "..table.concat(K, ", ")))))
        end
      end
    end
    local Y=K.Hotbar
    if type(Y)=="table" then
      for w=1, 9, 1 do
        F[#F+1]="Hotbar["..(w..("] = "..tostring(Y[w])))
      end
    end
  end
  if w and#w>0 then
    F[#F+1]="-- 'rift' matches --"
    for w, Y in ipairs(w)do
      F[#F+1]=Y
    end
  else
    F[#F+1]="-- 'rift' matches: none --"
  end
  return table.concat(F, "\n")
end
function
  d.report(w)
  for w in((w.."\n")):gmatch("(.-)\n")do
    warn("[kw/vex dump] "..w)
  end
  pcall(function
    ()
    if setclipboard then
      setclipboard(w)
    end
  end
  )pcall(function
    ()
    if not isfolder("kw_free")then
      makefolder("kw_free")
    end
    writefile("kw_free/vexdump.txt", w)
  end
  )CL("Data dump copied to clipboard and saved to kw_free/vexdump.txt (also in console F9). Send it to the developer")
end
function
  d.freeSlot()
  local w=EL()
  local Y=w and(w.Data and w.Data["Hotbar"])
  if type(Y)~="table" then
    return nil
  end
  for w=2, 9, 1 do
    if type(Y[w])~="string" or Y[w]=="" then
      return w
    end
  end
  return nil
end
function
  d.press(w)pcall(function
    ()
    local Y={"One";"Two", "Three";"Four", "Five", "Six";"Seven";"Eight";"Nine"}
    local K=Enum.KeyCode[Y[w]]
    local F=game:GetService("VirtualInputManager")F:SendKeyEvent(true, K, false, game)task.wait(.06)F:SendKeyEvent(false, K, false, game)
  end
  )
end
function
  d.silentSlot(w)
  if not((getconnections and w))then
    return
  end
  pcall(function
    ()
    local Y={"One", "Two", "Three", "Four", "Five";"Six", "Seven";"Eight", "Nine"}
    local K=Enum.KeyCode[Y[w]]
    local F=game:GetService("UserInputService")
    local I=game:GetService("CoreGui")
    for w, Y in ipairs({"InputBegan";"InputEnded"})do
      for w, F in ipairs(getconnections(F[Y]))do
        local m=F.Function
        if type(m)=="function" then
          local w, F=pcall(function
            ()
            return(getfenv(m)).script
          end
          )
          if w and(typeof(F)=="Instance" and not F:IsDescendantOf(I))then
            local w={["UserInputType"]=Enum.UserInputType["Keyboard"];["KeyCode"]=K;["UserInputState"]=(Y=="InputBegan")and Enum.UserInputState["Begin"]or Enum.UserInputState["End"]}pcall(m, w, false)
          end
        end
      end
      task.wait(.06)
    end
  end
  )
end
local function
  XL()LL.busy=true LL.lastSummon=os.clock()task.spawn(function
    ()
    local w, Y=pcall(function
      ()
      local w=x.Character
      local Y=w and w:FindFirstChildOfClass("Humanoid")
      local K=w and w:FindFirstChild("HumanoidRootPart")
      if not Y or not K or Y.Health<=0 then
        return
      end
      JL(false)task.wait(.3)
      if LL.needMove then
        LL.needMove=false LL.moveN=(((LL.moveN or 0))%6)+1
        local w=math.rad(LL.moveN*63)
        local F=14+LL.moveN*4 Y:MoveTo(K.Position+Vector3.new(math.cos(w)*F, 0, math.sin(w)*F))
        local I=os.clock()
        while os.clock()-I<3 and Y.Parent do
          task.wait(.1)
        end
      end
      local F=os.clock()
      while Y.Parent and(Y.FloorMaterial==Enum.Material["Air"]and os.clock()-F<5)do
        task.wait(.1)
      end
      local I=pL()
      local M=nL()
      local S=nil
      if not M then
        M, S=d.scan()
        if M then
          CL("Rift Key found by deep scan: "..(tostring(M)..(" at "..tostring(d.scanPath))))
        end
      end
      local N=(not M)and d.uiSlot()or nil
      local T=d.held(w, M)
      if not T then
        if not M and not N then
          CL("Rift Key not found in your inventory data (no item with 'rift' in its Id)")
          if os.clock()-((LL.dumpAt or-999))>60 then
            LL.dumpAt=os.clock()d.report(d.dump(S))
          end
          return
        end
        if M and not I then
          CL("Inventory_Engine EquipRequest remote not found")
          return
        end
        if N then
          CL("Rift Key found in hotbar slot "..(N.." (UI mode)"))
        end
        local K=m:FindFirstChild("Inventory_Engine")
        local F=K and K:FindFirstChild("Remotes")
        local v=F and F:FindFirstChild("HotbarBindRequest")
        local L=nil
        local G={}
        for w, Y in ipairs({I;v})do
          if Y then
            G[#G+1]=Y.OnClientEvent:Connect(function
              (w)
              if type(w)=="string" then
                L=w
              end
            end
            )
          end
        end
        local i=N or d.slotOf(M)
        local o=os.clock()
        while w:GetAttribute("IsDrinking")and os.clock()-o<6 do
          task.wait(.1)
        end
        if not i then
          local Y=d.freeSlot()CL("Rift Key is not in the hotbar. Free slot: "..(tostring(Y)..(", bind remote: "..tostring(v~=nil))))
          if v then
            local K={function
              ()v:FireServer(M)
            end
            , function
              ()v:FireServer(M, Y)
            end
            , function
              ()v:FireServer(Y, M)
            end
            }
            for F=1,#K, 1 do
              if F>1 and not Y then
                break
              end
              pcall(K[F])
              local I=os.clock()
              while os.clock()-I<1.3 do
                task.wait(.1)i=d.slotOf(M)T=d.held(w, M)
                if i or T then
                  break
                end
              end
              if i or T then
                CL("Bound to hotbar slot "..(tostring(i)..(" (variant "..(F..")"))))break
              end
              if L=="full" then
                break
              end
            end
          end
          if not i and not T then
            CL(L=="full" and "Hotbar is full: free one slot (2-9) for Rift Key" or "Could not bind Rift Key to the hotbar (server ignored the request)")
          end
        end
        if not T then
          local K=d.snap(w)
          for F=1, 8, 1 do
            T=d.heldNew(w, M, K)
            if T then
              break
            end
            if Y.Health<=0 then
              return
            end
            local m=F%4
            if m==1 then
              if M and I then
                I:FireServer(M)
              end
            elseif m==2 and i then
            d.press(i)
            elseif m==3 and i then
            d.silentSlot(i)
            else
              local w=x:FindFirstChildOfClass("Backpack")
              if w then
                for w, K in ipairs(w:GetChildren())do
                  if K:IsA("Tool")and((DL(K)or K:GetAttribute("InventorySerial")==M))then
                    pcall(function
                      ()Y:EquipTool(K)
                    end
                    )break
                  end
                end
              end
            end
            local S=os.clock()
            while os.clock()-S<2 do
              task.wait(.1)T=d.heldNew(w, M, K)
              if T then
                break
              end
            end
            if T then
              break
            end
          end
        end
        for w, Y in ipairs(G)do
          Y:Disconnect()
        end
        if not T then
          local Y={}
          for w, K in ipairs(w:GetChildren())do
            if K:IsA("Tool")then
              Y[#Y+1]=K.Name
            end
          end
          CL(L=="full" and "Hotbar full (1 weapon + 8 items): free one slot for Rift Key" or L=="in_use" and "Rift Key: item is in use right now" or("Can't equip Rift Key (slot "..(tostring(i)..("), in hands: "..((#Y>0 and table.concat(Y, ", ")or "nothing"))))))
          return
        end
      end
      task.wait(.4)T:Activate()
      local v=os.clock()
      local L=false
      while os.clock()-v<5 do
        task.wait(.1)
        if tL(K, 70)then
          break
        end
        if T.Parent~=w and os.clock()-v>2 then
          break
        end
        if not L and os.clock()-v>2.2 then
          L=true
          local w=m:FindFirstChild("Quest_Engine")
          local Y=w and w:FindFirstChild("Remotes")
          local K=Y and Y:FindFirstChild("MageRiftSummon")
          if K then
            K:FireServer()
          end
        end
      end
      if tL(K, 70)then
      CL("Rift placed: stay in the circle")
      else
        CL("Rift did not open (see game message)")
      end
      JL(true)
      local G=LL.weaponSerial
      if G and I then
        local Y=false
        for w, K in ipairs(w:GetChildren())do
          if K:IsA("Tool")and K:GetAttribute("InventorySerial")==G then
            Y=true
          end
        end
        if not Y then
          I:FireServer(G)
        end
      end
    end
    )
    if not w then
      CL("Summon error: "..tostring(Y))
    end
    LL.busy=false
  end
  )
end
local function
  hL()
  local w=x.Character
  local Y=w and w:FindFirstChild("HumanoidRootPart")
  if not l.VXEnabled or not Y then
    d.Active, LL.airborne=false, false LL.lastLabel, LL.noBossAt, LL.riftWaitAt=nil, nil, nil LL.stillSince, LL.flyAt=nil, nil
    return
  end
  local K=w:FindFirstChildOfClass("Tool")
  if K and(not DL(K)and K:GetAttribute("WeaponId")~=nil)then
    local w=K:GetAttribute("InventorySerial")
    if type(w)=="string" then
      LL.weaponSerial=w
    end
  end
  local F=lL()
  local I=QL(F)
  if F and I then
    LL.noBossAt, LL.riftWaitAt=nil, nil LL.stillSince, LL.flyAt=nil, nil JL(true)gL(F, I)
    local w=d.Starfall()
    if w then
      LL.airborne=false
    end
    d.Active=true
    if w then
    iL(d.sf["retreat"]and "Starfall: flying to the safe zone" or "Starfall: hitting Vex to break the channel")
    elseif LL.airborne then
    iL("Vex is flying: waiting")
    else
      iL("Vex is on the ground: attacking")
    end
    return
  end
  d.Active, LL.airborne=false, false
  local m=os.clock()LL.noBossAt=LL.noBossAt or m
  if not l.VXAutoRift then
    iL("Waiting for Archmage Vex")
    return
  end
  if LL.busy or m-LL.noBossAt<5 then
    return
  end
  if jL(Y)then
    iL("Waiting for Archmage Vex")
    return
  end
  local M=tL(Y, 70)
  if M then
    LL.riftWaitAt=LL.riftWaitAt or m
    if m-LL.riftWaitAt<45 then
      JL(true)iL("Rift ("..(M.."): waiting"))
      return
    end
  else
    LL.riftWaitAt=nil
  end
  if m-LL.lastSummon<8 then
    return
  end
  XL()
end
task.spawn(function
  ()
  while task.wait(.1)do
    pcall(hL)
  end
end
)
local function
  PL(Y)l.VXEnabled=Y o()LL.lastLabel, LL.airborne, LL.noBossAt=nil, false, nil
  if Y then
    if not l.AutoAttackEnabled then
      y(true)J("AutoAttackEnabled", true)
    end
  else
    d.Active=false TL()
  end
  w:Notify({["Title"]="Archmage Vex";["Content"]=Y and "Activated (works while Vex is alive)" or "Deactivated";["Duration"]=2})
end
function
  g.Vex(w)PL(w)J("VXEnabled", w)
end
local bL={["root"]=nil,["boss"]=nil;["lastDir"]=nil;["lastLabel"]=nil,["labelAt"]=0;["noBossAt"]=nil}
local function
  WL(w)
  local Y=os.clock()
  if w==bL.lastLabel or Y-bL.labelAt<.5 then
    return
  end
  bL.lastLabel, bL.labelAt=w, Y
  local K=Q.CPStatus
  if K then
    pcall(function
      ()K:SetDesc(w)
    end
    )
  end
end
local function
  kL(w)
  if typeof(w)~="Instance" or not w:IsA("Model")or w.Parent==nil then
    return false
  end
  if w:GetAttribute("CharacterId")~="PirateCaptain" then
    return false
  end
  local Y=w:GetAttribute("_DuelOwner")
  return type(Y)~="number" or Y==x.UserId
end
local function
  BL(w)
  local Y=w:FindFirstChildOfClass("Humanoid")
  if Y then
    return Y.Health>0
  end
  return((tonumber(w:GetAttribute("Health"))or 1))>0 and not w:GetAttribute("_Dying")
end
local function
  cL()
  local w=bL.boss
  if w and(kL(w)and BL(w))then
    return w
  end
  bL.boss=nil
  local Y=workspace:FindFirstChild("Knight_Live")
  if Y then
    for w, Y in ipairs(Y:GetChildren())do
      if kL(Y)and BL(Y)then
        bL.boss=Y
        return Y
      end
    end
  end
  return nil
end
local function
  uL()wL.Active=false
  if SL.flyByFarm and not((l.DFEnabled or l.DCEnabled or l.VXEnabled or l.DKEnabled or l.BSEnabled or l.CPEnabled))then
    SL.flyByFarm=false
    if l.FlyEnabled then
      mL(false)J("FlyEnabled", false)
    end
  end
end
function
  wL.Step(w, Y)
  local K=bL.root
  if not K or not K.Parent then
    return nil
  end
  Y=math.clamp(tonumber(l.CPSpeed)or 20, 5, 30)
  local F, I=w.Position, K.Position
  local m=I.Y+math.clamp(tonumber(l.CPHeight)or 8, 0, 10)
  local M=Vector3.new(I.X-F.X, 0, I.Z-F.Z)
  local x=M.Magnitude
  local N=bL.lastDir
  if x>1.5 then
    N=M.Unit
  end
  if not N then
    local w=S.CFrame["LookVector"]
    local Y=Vector3.new(w.X, 0, w.Z)N=Y.Magnitude>.01 and Y.Unit or Vector3.new(0, 0,-1)
  end
  bL.lastDir=N
  local T=nil
  if l.CPProne then
  T=CFrame.lookAt(F, F+N)*CFrame.Angles(-math.pi/2, 0, 0)
  elseif l.CPFace then
    T=CFrame.lookAt(F, F+N)
  end
  local v=0 pcall(function
    ()v=math.clamp(K.AssemblyLinearVelocity["Y"],-30, 30)
  end
  )
  local L=math.clamp(((m-F.Y))*6+v*.8,-Y, Y)
  local G=Vector3.zero
  if x>1.6 then
    G=M.Unit*math.min(Y,((x-1.5))*8)
  end
  local i=G+Vector3.new(0, L, 0)
  if i.Magnitude>Y then
    i=i.Unit*Y
  end
  return i, T
end
local function
  OL()
  local w=x.Character
  local Y=w and w:FindFirstChild("HumanoidRootPart")
  if not l.CPEnabled or not Y then
    wL.Active, bL.root, bL.noBossAt=false, nil, nil
    return
  end
  local K=cL()
  local F=K and((K:FindFirstChild("HumanoidRootPart")or K.PrimaryPart))
  if K and F then
    bL.root, bL.noBossAt=F, nil NL()wL.Active=true
    local w, I=tonumber(K:GetAttribute("Health"))or 0, tonumber(K:GetAttribute("MaxHealth"))or 0
    local m=K:FindFirstChildOfClass("Humanoid")
    if m and m.MaxHealth>0 then
      w, I=m.Health, m.MaxHealth
    end
    local M=I>0 and math.floor((w/I)*100+.5)or 0
    local x=(Vector3.new(F.Position["X"]-Y.Position["X"], 0, F.Position["Z"]-Y.Position["Z"])).Magnitude WL("Fighting Captain Blackpowder | %d m | HP %d%%":format(math.floor(x+.5), M))
    return
  end
  wL.Active, bL.root=false, nil
  local I=os.clock()bL.noBossAt=bL.noBossAt or I
  if I-bL.noBossAt>3 then
    uL()
  end
  WL("Waiting for Captain Blackpowder (start the fight yourself)")
end
task.spawn(function
  ()
  while task.wait(.1)do
    pcall(OL)
  end
end
)
local function
  eL(Y)l.CPEnabled=Y o()bL.boss, bL.root, bL.lastLabel, bL.noBossAt=nil, nil, nil, nil
  if Y then
    if not l.AutoAttackEnabled then
      y(true)J("AutoAttackEnabled", true)
    end
  WL("Waiting for Captain Blackpowder (start the fight yourself)")
  else
    uL()WL("Disabled")
  end
  w:Notify({["Title"]="Captain Blackpowder";["Content"]=Y and "Activated (works while the boss is alive)" or "Deactivated",["Duration"]=2})
end
function
  g.Captain(w)eL(w)J("CPEnabled", w)
end
local UL={["run"]=false,["step"]=0;["last"]=0;["cache"]={}}
local function
  RL(w)
  local Y=w and w:GetAttribute("WeaponId")
  if type(Y)~="string" then
    return nil
  end
  local K=UL.cache[Y]
  if K~=nil then
    return K or nil
  end
  local F, I=pcall(function
    ()
    local K=game:GetService("ReplicatedStorage")
    local F=((K:WaitForChild("Weapon_Engine", 3)):WaitForChild("Modules", 3)):WaitForChild("WeaponConfig", 3)
    return(require(F)).Resolve(Y,{w, w:FindFirstChild("Anim")}, true)
  end
  )K=((F and type(I)=="table"))and I or false UL.cache[Y]=K
  return K or nil
end
local function
  fL(w)
  return((tonumber(w.DefaultAnimLen)or .8))/((tonumber(w.SwingSpeed)or 1))
end
local function
  qL(w, Y)
  local K=fL(w)
  if Y~=1 then
    local Y=w.Timing and(w.Timing["ComboCancel"]and w.Timing["ComboCancel"][1])
    return(((tonumber(Y)or .55))*K)*.75
  end
  return K*.7
end
local function
  ZL()
  if not D(tonumber(l.AutoAttackRadius)or 15)then
    UL.step=0
    return
  end
  local w=os.clock()
  local Y=x.Character
  local K=Y and Y:FindFirstChildOfClass("Tool")
  local F=(l.AutoAttackSync~=false)and RL(K)or nil
  if not F or F.AttackMode=="Projectile" or F.Type=="Pickaxe" then
    UL.step=0
    if w-UL.last>=.1 then
      UL.last=w N:FireServer(1)
    end
    return
  end
  local I=(F.Combo and tonumber(F.Combo["Count"]))or 1
  if I<1 then
    I=1
  end
  if w-UL.last>fL(F)*1.5 then
    UL.step=0
  end
  local m=UL.step+1
  if m>I then
    m=1
  end
  if w-UL.last>=qL(F, m)+.03 then
    UL.last=w UL.step=m N:FireServer(m)
  end
end
task.spawn(function
  ()
  while task.wait(.03)do
    if UL.run and l.AutoAttackEnabled then
      pcall(ZL)
    end
  end
end
)function
  g.AtkInit(w)UL.run=w~=false;(getgenv()).kw_atk_on=UL.run
end
local function
  AL(w)
  return math.clamp(tonumber(w)or 0,-10, 20)
end
local HL={}HL.KEY_OPEN=3.65 HL.SCAN=700 HL.HEIGHT={["dog"]="DKHeightDog",["spider"]="DKHeightSpider";["hound"]="DKHeightHound",["boss"]="DKHeightBoss"}HL.TITLE={["dog"]="Shadow Dog",["spider"]="Jumping Spider";["hound"]="Hellhound";["boss"]="Voodoo Doll"}
local sL={["goal"]=nil;["goalY"]=nil;["face"]=nil;["targetY"]=nil,["stop"]=0,["lastDir"]=nil,["lastLabel"]=nil;["lastLabelAt"]=0,["lock"]=nil,["openAt"]=nil;["reachedAt"]=nil,["wayOut"]=false,["wall"]=nil,["wallScanAt"]=0}
local function
  dL(w)
  local Y=os.clock()
  if w~=sL.lastLabel and Y-sL.lastLabelAt>1.5 then
    sL.lastLabel, sL.lastLabelAt=w, Y
  end
end
local function
  zL()sL.lock, sL.openAt, sL.reachedAt=nil, nil, nil sL.wayOut, sL.wall=false, nil X()
end
local function
  rL()
  return x:GetAttribute("DungeonRun")~=nil and(x:GetAttribute("HDRun")==nil and x:GetAttribute("DraculaCastleRun")==nil)
end
local function
  w1(w)
  local Y=((tostring(w:GetAttribute("Animal")or "")..(" "..w.Name))):lower()
  if Y:find("effigy", 1, true)then
    return "effigy"
  end
  if Y:find("voodoo", 1, true)then
    return "boss"
  end
  if Y:find("shadow", 1, true)then
    return "dog"
  end
  if Y:find("jumping", 1, true)then
    return "spider"
  end
  if Y:find("hellhound", 1, true)or Y:find("hell hound", 1, true)then
    return "hound"
  end
  return nil
end
local function
  Y1(w)
  local Y, K, F={},{},{}
  local function
    I(I)
    if F[I]then
      return
    end
    F[I]=true
    if not((I:IsA("Model")and I.Parent))then
      return
    end
    if((tonumber(I:GetAttribute("Health"))or 0))<=0 or I:GetAttribute("_Dying")then
      return
    end
    local m=w1(I)
    if not m then
      return
    end
    local M=(I:GetPivot()).Position
    if(Vector3.new(M.X-w.X, 0, M.Z-w.Z)).Magnitude>HL.SCAN then
      return
    end
    if m=="effigy" then
    table.insert(K,{["m"]=I,["p"]=M})
    else
      table.insert(Y,{["m"]=I;["kind"]=m,["p"]=M})
    end
  end
  local m=workspace:FindFirstChild("Animal_Live")
  local x=m and m:FindFirstChild("Aggressors")
  if x then
    for w, Y in ipairs(x:GetChildren())do
      I(Y)
    end
  end
  for w, Y in ipairs(M:GetTagged("Mob"))do
    I(Y)
  end
  return Y, K
end
local function
  K1(w, Y)
  local K=tonumber(w:GetAttribute("_GroundY"))
  if K then
    return K
  end
  local F=RaycastParams.new()F.FilterType=Enum.RaycastFilterType["Exclude"]
  local I={w}
  if x.Character then
    table.insert(I, x.Character)
  end
  local m=workspace:FindFirstChild("Animal_Live")
  if m then
    table.insert(I, m)
  end
  F.FilterDescendantsInstances=I
  local M=workspace:Raycast(Y+Vector3.new(0, 2, 0), Vector3.new(0,-300, 0), F)
  return M and M.Position["Y"]or Y.Y
end
local function
  F1(w)
  local Y=w:GetAttribute("Owner")
  if Y==nil then
    return true
  end
  local K=tostring(Y)
  return K==x.Name or K==x.DisplayName or K==tostring(x.UserId)
end
local function
  I1(w, Y)
  local K=x.Character
  if K then
    for w, Y in ipairs(M:GetTagged("CobraAttackVisual"))do
      if Y:IsA("BasePart")and(Y.Parent and Y:GetAttribute("CobraVFXKind")=="VoodooEffigy")then
        local w=Y:FindFirstChild("Target")
        if w and(w:IsA("ObjectValue")and w.Value==K)then
          local w=Y:FindFirstChild("Effigy")
          local K=w and(w:IsA("ObjectValue")and w.Value)or nil
          if K and K.Parent then
            local w=tonumber(K:GetAttribute("_HitsLeft"))or tonumber(Y:GetAttribute("Hits"))or 1
            if w>0 then
              return(K:GetPivot()).Position
            end
          else
            return Y.Position
          end
        end
      end
    end
  end
  for w, K in ipairs(w)do
    if F1(K.m)then
      local w=tonumber(K.m:GetAttribute("_HitsLeft"))
      if((w==nil or w>0))and((K.p-Y)).Magnitude<=150 then
        return K.p
      end
    end
  end
  return nil
end
local function
  m1(w)
  local Y=sL.wall
  if not((Y and Y.Parent))then
    Y=nil
    if os.clock()-sL.wallScanAt>2 then
      sL.wallScanAt=os.clock()Y=workspace:FindFirstChild("ExitWall", true)sL.wall=Y
    end
  end
  if not Y then
    return nil
  end
  local K
  if Y:IsA("BasePart")then
  K=Y.Position
  elseif Y:IsA("Model")then
    K=(Y:GetPivot()).Position
  end
  if K and((K-w)).Magnitude<=800 then
    return K
  end
  return nil
end
local function
  M1()
  local w=x.Character
  local Y=w and w:FindFirstChild("HumanoidRootPart")
  if not l.DKEnabled or not Y or not rL()then
    z.Active=false sL.lastLabel=nil
    return
  end
  z.Active=true sL.goal, sL.goalY, sL.face, sL.targetY, sL.stop=nil, nil, nil, nil, 0
  local K=Y.Position
  local F, I=Y1(K)
  if l.DKEffigy then
    local w=I1(I, K)
    if w then
      X()sL.goal=Vector3.new(w.X, 0, w.Z)sL.face=w sL.targetY=w.Y+AL(l.DKHeightEffigy)dL("Voodoo Effigy: breaking it")
      return
    end
  end
  local m, M, S=nil, nil, math.huge
  for w, Y in ipairs(F)do
    local F=(Vector3.new(Y.p["X"]-K.X, 0, Y.p["Z"]-K.Z)).Magnitude
    if Y.kind=="boss" then
      M=Y
    end
    if F<S then
      m, S=Y, F
    end
  end
  m=M or m
  if m then
    X()
    local w=AL(l[HL.HEIGHT[m.kind]])
    local Y=l.DKRelTarget and m.p["Y"]or K1(m.m, m.p)sL.targetY=Y+w sL.goal=Vector3.new(m.p["X"], 0, m.p["Z"])sL.face=m.p dL("%s: height %d":format(HL.TITLE[m.kind], w))
    return
  end
  local N=h()
  if type(N)=="table" then
    sL.goal=Vector3.new(N.pos["X"], 0, N.pos["Z"])sL.goalY=N.pos["Y"]+2 sL.stop=1 P(N)dL("Collecting drops")
  return
  elseif N=="wait" then
    sL.goalY=K.Y
    return
  end
  if sL.wayOut and l.DKAutoRepeat then
    sL.goalY=K.Y
    return
  end
  if sL.wayOut then
    local w=m1(K)
    if w then
      sL.goal=Vector3.new(w.X, 0, w.Z)sL.goalY=w.Y sL.stop=1 dL("Flying to the exit wall")
      return
    end
  end
  if l.DKAutoAdvance and(sL.lock and(sL.openAt and os.clock()>=sL.openAt))then
    local w=sL.lock
    local Y=(Vector3.new(w.X-K.X, 0, w.Z-K.Z)).Magnitude
    if not sL.reachedAt and Y<6 then
      sL.reachedAt=os.clock()
    end
    if sL.reachedAt then
    local Y=30+12*math.min(os.clock()-sL.reachedAt, 6)sL.goal=Vector3.new(w.X+Y, 0, w.Z)
    else
      sL.goal=Vector3.new(w.X-4, 0, w.Z)
    end
    sL.goalY=w.Y sL.stop=1 dL("Room cleared: flying to the next room")
    return
  end
  sL.goalY=K.Y
end
function
  z.Step(w, Y)Y=math.clamp(tonumber(l.DKSpeed)or 35, 5, 40)
  local K=w.Position
  local F=sL.goalY or sL.targetY
  if not F then
    return nil
  end
  local I=math.clamp(((F-K.Y))*6,-Y, Y)
  local m=Vector3.zero
  if sL.goal then
    local w=Vector3.new(sL.goal["X"]-K.X, 0, sL.goal["Z"]-K.Z)
    local F=w.Magnitude
    if F>sL.stop+.1 then
      m=w.Unit*math.min(Y,((F-sL.stop))*8)
    end
  end
  local M=sL.lastDir
  if sL.face then
    local w=Vector3.new(sL.face["X"]-K.X, 0, sL.face["Z"]-K.Z)
    if w.Magnitude>1.5 then
      M=w.Unit
    end
  elseif m.Magnitude>1 then
    M=m.Unit
  end
  if not M then
    local w=S.CFrame["LookVector"]
    local Y=Vector3.new(w.X, 0, w.Z)M=Y.Magnitude>.01 and Y.Unit or Vector3.new(0, 0,-1)
  end
  sL.lastDir=M
  local x=nil
  if sL.face and l.DKProne then
  x=CFrame.lookAt(K, K+M)*CFrame.Angles(-math.pi/2, 0, 0)
  elseif sL.face and l.DKFace then
    x=CFrame.lookAt(K, K+M)
  end
  local N=m+Vector3.new(0, I, 0)
  if N.Magnitude>Y then
    N=N.Unit*Y
  end
  return N, x
end
task.spawn(function
  ()
  while task.wait(.1)do
    pcall(M1)
  end
end
)
local x1=false
local function
  S1(Y)l.DKEnabled=Y o()sL.lastLabel=nil
  if Y then
    NL()
    if not l.AutoAttackEnabled then
      y(true)J("AutoAttackEnabled", true)
    end
  else
    z.Active=false
    if x1 and l.NoclipEnabled then
      A(false)J("NoclipEnabled", false)
    end
    x1=false R.farm=false TL()
  end
  w:Notify({["Title"]="Dark Dungeon",["Content"]=Y and "Activated (works inside the Dark Dungeon)" or "Deactivated",["Duration"]=2})
end
function
  g.DarkFarm(w)S1(w)J("DKEnabled", w)
end
task.spawn(function
  ()
  while task.wait(.2)do
    local w=l.DKEnabled and(l.DKNoclip and z.Active)
    if w and not l.NoclipEnabled then
    x1=true R.farm=true pcall(A, true, true)J("NoclipEnabled", true)
    elseif not w and x1 then
      x1=false R.farm=false
      if l.NoclipEnabled then
        pcall(A, false)J("NoclipEnabled", false)
      end
    end
  end
end
)task.spawn(function
  ()
  local w=m:WaitForChild("Dungeon_Engine", 30)
  local Y=w and w:WaitForChild("Remotes", 10)
  local K=Y and Y:WaitForChild("Scene", 10)
  if not K then
    return
  end
  K.OnClientEvent:Connect(function
    (w, Y)Y=type(Y)=="table" and Y or{}
    if w=="arrive" or w=="left" or w=="failed" or w=="exit" or w=="descend" then
    zL()
    elseif w=="room" then
    sL.lock, sL.openAt, sL.reachedAt=nil, nil, nil
    elseif w=="unlock" then
      if typeof(Y.lock)=="Vector3" then
        local w=workspace:GetServerTimeNow()
        local K=(math.max(0,((tonumber(Y.startsAt)or w))-w)+HL.KEY_OPEN)+.3 sL.lock=Y.lock sL.openAt=os.clock()+K sL.reachedAt=nil
        if Y.final then
          sL.wayOut=true
        end
      end
    elseif w=="wayout" then
      sL.wayOut=true
    end
  end
  )
end
)task.spawn(function
  ()
  local Y=m:WaitForChild("Dungeons_Engine", 30)
  local K=Y and Y:WaitForChild("Remotes", 10)
  local F=K and K:WaitForChild("Result", 10)
  local I=K and K:WaitForChild("Choice", 10)
  if not((F and I))then
    return
  end
  local M, x=0, false F.OnClientEvent:Connect(function
    (Y, K)
    if Y~="state" or type(K)~="table" then
      return
    end
    local F, m
    local S=l.DFEnabled and l.DFAutoRepeat
    local N=l.DCEnabled and l.DCAutoRepeat
    local T=l.DKEnabled and l.DKAutoRepeat
    if K.key=="DraculaCastle" then
    F, m=N, l.DCRetryDefeat
    elseif K.key=="Dark" then
    F, m=T, l.DKRetryDefeat
    elseif K.key~=nil then
    F, m=S, l.DFRetryDefeat
    else
      F, m=(S or N or T),(l.DFRetryDefeat or l.DCRetryDefeat or l.DKRetryDefeat)
    end
    if not F then
      return
    end
    if K.mine=="again" or K.state=="starting" then
      return
    end
    if K.outcome=="defeat" and not m then
      return
    end
    if K.cost and K.cost["ok"]==false then
      if not x then
        x=true w:Notify({["Title"]="Dungeon Farm";["Content"]="Auto repeat: not enough tickets/cost";["Duration"]=4})
      end
      return
    end
    x=false
    if K.session==nil or os.clock()-M<3 then
      return
    end
    M=os.clock()
    local v=K.session task.delay(1.5, function
      ()pcall(function
        ()I:FireServer("again", v)
      end
      )
    end
    )
  end
  )
end
)
local N1=((function
  ()
  local Y=tonumber(w.UIScale)or 1
  local K=(workspace.CurrentCamera and workspace.CurrentCamera["ViewportSize"])or Vector2.new(1280, 720)
  local F=math.max(300, math.floor(K.X/Y-20))
  local I=math.max(220, math.floor(K.Y/Y-60))
  return w:CreateWindow({["Title"]="kaw0ru FREE  v3.3.5";["Icon"]="box",["Theme"]="Dark";["Folder"]=T,["Size"]=UDim2.fromOffset((((tonumber(l.MenuW)or 0))>=300)and math.min(l.MenuW, F)or math.min(480, F),(((tonumber(l.MenuH)or 0))>=200)and math.min(l.MenuH, I)or math.min(420, I)),["MinSize"]=Vector2.new(math.min(340, F), 52),["MaxSize"]=Vector2.new(F, I),["OpenButton"]={["Title"]="Menu";["Enabled"]=true;["Draggable"]=true}})
end
))()g._folds={}function
  g.fold(w, Y)
  local K=g._folds[w]
  if K==nil then
    local F, I=pcall(function
      ()
      return N1:Section({["Title"]=w,["Icon"]=Y,["Opened"]=true})
    end
    )K=(F and I)or false g._folds[w]=K
  end
  return K or N1
end
N1:SetToggleKey(Enum.KeyCode[l.MenuBind]or Enum.KeyCode["RightControl"])task.spawn(function
  ()
  local w, Y
  while task.wait(2)do
    local K, F=pcall(function
      ()
      return N1.Size
    end
    )
    if K and typeof(F)=="UDim2" then
      local K, I=math.floor(F.X["Offset"]+.5), math.floor(F.Y["Offset"]+.5)
      if K==w and(I==Y and((K~=l.MenuW or I~=l.MenuH)))then
        l.MenuW, l.MenuH=K, I o()task.delay(1.2, o)
      end
      w, Y=K, I
    end
  end
end
)do
  ((function
    ()
    local w=N1:Tab({["Title"]="Home";["Icon"]="house"})
    local Y=w:Section({["Title"]="Free version";["Box"]=true;["BoxBorder"]=true,["Opened"]=true})Y:Paragraph({["Title"]="This is the FREE version of kaw0ru";["Desc"]="Included in this version:\n- Combat: Auto Attack (radius, match weapon speed), Auto Cast Q, Anti Knockback\n- Movement: Fly, Speed\n- Other: Infinite Jump, Noclip, Auto Loot, loot stats\n- Collect: Auto Collect with item filter\n- Heroes: Archmage Vex and Captain Blackpowder auto kill\n- Dungeon Dark: Dark Dungeon auto farm (auto repeat, Effigy)\n- Settings: menu key, notifications, keybind widget, save / reset config\nOther dungeon farms, Boss Farm, World Farm, Fishing, Auto Heal, Staff Watch and Server Search are available in the full version."})
    local K="Unknown" pcall(function
      ()
      if identifyexecutor then
        local w, Y=identifyexecutor()K=tostring(w)..((Y and(" "..tostring(Y))or ""))
      end
    end
    )
    local F="rbxthumb://type=AvatarHeadShot&id="..(tostring(x.UserId).."&w=150&h=150")
    local I=w:Section({["Title"]="Profile";["Box"]=true,["BoxBorder"]=true,["Opened"]=true})
    local m=string.rep("•", 7)
    local M=false
    local function
      S()
      local function
        w(w)
        local Y=utf8.offset(w, 2)
        return Y and w:sub(1, Y-1)or w
      end
      if M then
        return x.DisplayName, string.format("@%s  |  ID %d\nAccount age: %d days\nExecutor: %s", x.Name, x.UserId, x.AccountAge, K)
      end
      return w(x.DisplayName)..m, string.format("@%s  |  ID %s\nAccount age: %d days\nExecutor: %s", w(x.Name)..m, m, x.AccountAge, K)
    end
    local N=I:Paragraph({["Title"]=(S());["Desc"]=select(2, S());["Image"]="rbxasset://textures/ui/GuiImagePlaceholder.png";["ImageSize"]=56})I:Toggle({["Title"]="Show nickname, ID and avatar",["Value"]=false;["Callback"]=function
      (w)M=w
      local Y, K=S()pcall(function
        ()N:SetTitle(Y)N:SetDesc(K)N:SetImage(w and F or "rbxasset://textures/ui/GuiImagePlaceholder.png", 56)
      end
      )
    end
    })
    local T=w:Section({["Title"]="Privacy";["Box"]=true,["BoxBorder"]=true,["Opened"]=true})T:Toggle({["Title"]="Hide my nickname above my head (only on my screen)";["Value"]=l.HideNick,["Callback"]=function
      (w)l.HideNick=w o()
    end
    })
    local v={}
    local L=false task.spawn(function
      ()
      while task.wait(.7)do
        pcall(function
          ()
          local w=x.Character
          local Y=w and w:FindFirstChildOfClass("Humanoid")
          if l.HideNick and w then
            if Y and Y.DisplayDistanceType~=Enum.HumanoidDisplayDistanceType["None"]then
              Y.DisplayDistanceType=Enum.HumanoidDisplayDistanceType["None"]L=true
            end
            for w, Y in ipairs(w:GetDescendants())do
              if Y:IsA("BillboardGui")and Y.Enabled then
                for w, K in ipairs(Y:GetDescendants())do
                  if K:IsA("TextLabel")or K:IsA("TextButton")then
                    local w=K.Text
                    if w~="" and((w:find(x.Name, 1, true)or w:find(x.DisplayName, 1, true)))then
                      Y.Enabled=false v[#v+1]=Y break
                    end
                  end
                end
              end
            end
          else
            if L and Y then
              Y.DisplayDistanceType=Enum.HumanoidDisplayDistanceType["Viewer"]
            end
            L=false
            for w=#v, 1,-1 do
              local Y=v[w]
              if Y and Y.Parent then
                Y.Enabled=true
              end
              v[w]=nil
            end
          end
        end
        )
      end
    end
    )
  end
  ))()
end
task.wait()do
  ((function
    ()
    local w=N1:Tab({["Title"]="Combat",["Icon"]="swords"})
    local Y=w:Section({["Title"]="Auto Attack System";["Box"]=true,["BoxBorder"]=true;["Opened"]=true})
    local K=Y:Group({})Q.AutoAttackEnabled=K:Toggle({["Title"]="Enable Auto Attack",["Value"]=l.AutoAttackEnabled,["Callback"]=function
      (w)y(w)
    end
    })K:Space()K:Keybind({["Title"]="Auto Attack Key";["Value"]=l.AutoAttackBind;["Callback"]=function
      (w)l.AutoAttackBind=w o()
    end
    })Y:Slider({["Title"]="Attack Radius",["Step"]=1,["Value"]={["Min"]=3;["Max"]=60,["Default"]=l.AutoAttackRadius};["Callback"]=function
      (w)l.AutoAttackRadius=w o()
    end
    })do
      local w=Y:Group({})Q.AutoAttackSync=w:Toggle({["Title"]="Match weapon speed";["Desc"]="Hit rate follows the equipped weapon (combo steps). Off = old fixed rate.";["Value"]=l.AutoAttackSync~=false,["Callback"]=function
        (w)l.AutoAttackSync=w o()
      end
      })w:Space()Q.AutoCastEnabled=w:Toggle({["Title"]="Auto Cast Q (ability)";["Value"]=l.AutoCastEnabled;["Callback"]=function
        (w)l.AutoCastEnabled=w o()
      end
      })
    end
    Y:Slider({["Title"]="Cast Radius";["Step"]=1,["Value"]={["Min"]=5;["Max"]=80,["Default"]=l.AutoCastRadius};["Callback"]=function
      (w)l.AutoCastRadius=w o()
    end
    })task.spawn(function
      ()
      local w=0 pcall(function
        ()
        local Y=((m:WaitForChild("Ability_Engine", 30)):WaitForChild("Remotes", 30)):WaitForChild("AbilityCastResult", 30)Y.OnClientEvent:Connect(function
          (Y, K, F, I, m)
          local M=tonumber(m)or 0
          if F==true or M>0 then
          w=(os.clock()+M)+.15
          else
            w=os.clock()+1
          end
        end
        )
      end
      )
      local Y=game:GetService("VirtualInputManager")
      while task.wait(.25)do
        if l.AutoCastEnabled and os.clock()>=w then
          pcall(function
            ()
            local K=x:GetAttribute("EquippedAbility")
            if type(K)~="string" then
              return
            end
            if not D(tonumber(l.AutoCastRadius)or 40)then
              return
            end
            w=os.clock()+1 Y:SendKeyEvent(true, Enum.KeyCode["Q"], false, game)task.wait(.06)Y:SendKeyEvent(false, Enum.KeyCode["Q"], false, game)
          end
          )
        end
      end
    end
    )
    local F=w:Section({["Title"]="Anti Knockback",["Box"]=true,["BoxBorder"]=true;["Opened"]=true})Q.AntiKnockbackEnabled=F:Toggle({["Title"]="Enable Anti Knockback",["Value"]=l.AntiKnockbackEnabled,["Callback"]=function
      (w)q(w)
    end
    })F:Slider({["Title"]="Stiffness (Density)",["Step"]=10;["Value"]={["Min"]=10,["Max"]=1000;["Default"]=l.AntiKnockbackDensity};["Callback"]=function
      (w)l.AntiKnockbackDensity=w o()f()
    end
    })
  end
  ))()
end
task.wait()do
  ((function
    ()
    local w=N1:Tab({["Title"]="Movement";["Icon"]="wind"})
    local Y=w:Section({["Title"]="Fly System";["Box"]=true,["BoxBorder"]=true,["Opened"]=true})
    local K=Y:Group({})Q.FlyEnabled=K:Toggle({["Title"]="Enable Fly";["Value"]=l.FlyEnabled;["Callback"]=function
      (w)mL(w)
    end
    })K:Space()K:Keybind({["Title"]="Fly Key",["Value"]=l.FlyBind;["Callback"]=function
      (w)l.FlyBind=w o()
    end
    })Y:Slider({["Title"]="Fly Speed";["Step"]=5,["Value"]={["Min"]=5,["Max"]=40;["Default"]=l.FlySpeed},["Callback"]=function
      (w)l.FlySpeed=w o()
    end
    })Y:Slider({["Title"]="Vertical Speed";["Desc"]="Up/down speed (Q/E and buttons)";["Step"]=1,["Value"]={["Min"]=1;["Max"]=11,["Default"]=math.clamp(tonumber(l.FlyVert)or 6, 1, 11)},["Callback"]=function
      (w)l.FlyVert=w o()
    end
    })Q.FlyBtns=Y:Toggle({["Title"]="Up/Down buttons (mobile)";["Desc"]="On-screen ▲ ▼ while flying, instead of Q/E",["Value"]=l.FlyBtns;["Callback"]=function
      (w)l.FlyBtns=w o()
      if YL.active then
        YL.mkButtons()
      end
    end
    })
    local F=w:Section({["Title"]="Speed System";["Box"]=true;["BoxBorder"]=true;["Opened"]=true})
    local I=F:Group({})Q.SpeedEnabled=I:Toggle({["Title"]="Enable Speed";["Value"]=l.SpeedEnabled;["Callback"]=function
      (w)ML(w)
    end
    })I:Space()I:Keybind({["Title"]="Speed Key",["Value"]=l.SpeedBind;["Callback"]=function
      (w)l.SpeedBind=w o()
    end
    })F:Slider({["Title"]="Walk Speed";["Step"]=2;["Value"]={["Min"]=16,["Max"]=70,["Default"]=l.WalkSpeed};["Callback"]=function
      (w)l.WalkSpeed=w o()
      if l.SpeedEnabled then
        local Y=x.Character
        local K=Y and Y:FindFirstChildOfClass("Humanoid")
        if K then
          K.WalkSpeed=w
        end
      end
    end
    })
  end
  ))()
end
task.wait()do
  ((function
    ()
    local w=N1:Tab({["Title"]="Other";["Icon"]="box"})
    local Y=w:Section({["Title"]="Misc Features",["Box"]=true;["BoxBorder"]=true;["Opened"]=true})
    local K=Y:Group({})Q.InfJumpEnabled=K:Toggle({["Title"]="Enable Infinite Jump";["Value"]=l.InfJumpEnabled;["Callback"]=function
      (w)Z(w)
    end
    })K:Space()K:Keybind({["Title"]="Inf Jump Key";["Value"]=l.InfJumpBind,["Callback"]=function
      (w)l.InfJumpBind=w o()
    end
    })
    local F=Y:Group({})Q.NoclipEnabled=F:Toggle({["Title"]="Enable Noclip";["Value"]=l.NoclipEnabled;["Callback"]=function
      (w)A(w)
    end
    })F:Space()F:Keybind({["Title"]="Noclip Key";["Value"]=l.NoclipBind;["Callback"]=function
      (w)l.NoclipBind=w o()
    end
    })Q.AutoLootEnabled=Y:Toggle({["Title"]="Auto Loot";["Desc"]="Skip the reward screen",["Value"]=l.AutoLootEnabled;["Callback"]=function
      (w)l.AutoLootEnabled=w o()
    end
    })Y:Button({["Title"]="Reset Loot Stats",["Icon"]="rotate-ccw";["Justify"]="Center",["Callback"]=function
      ()(getgenv()).kw_loot={["coins"]=0;["xp"]=0;["items"]={}}
    end
    })
    local M=w:Section({["Title"]="Loot farmed";["Box"]=true,["BoxBorder"]=true;["Opened"]=true})Q.LootStatsPar=M:Paragraph({["Title"]="Total";["Desc"]="Nothing yet"})
    local S=1
    local function
      N(w, Y)
      local K=Q.LootStatsPar
      if Y~=S then
        local F, I=pcall(function
          ()
          return M:Paragraph({["Title"]="Total";["Desc"]=w})
        end
        )
        if F and I then
          if K then
            pcall(function
              ()K:Destroy()
            end
            )
          end
          Q.LootStatsPar=I S=Y
          return
        end
      end
      if K then
        pcall(function
          ()K:SetDesc(w)
        end
        )
      end
    end
    task.spawn(function
      ()
      local w=T.."/lootstats.json"
      local Y=getgenv()
      if type(Y.kw_loot)~="table" then
        Y.kw_loot={["coins"]=0,["xp"]=0;["items"]={}}pcall(function
          ()
          if isfile(w)then
            local K=I:JSONDecode(readfile(w))
            if type(K)=="table" and type(K.items)=="table" then
              Y.kw_loot={["coins"]=tonumber(K.coins)or 0,["xp"]=tonumber(K.xp)or 0;["items"]=K.items}
            end
          end
        end
        )
      end
      local K pcall(function
        ()K=require(((m:WaitForChild("Inventory_Engine", 30)):WaitForChild("Modules", 30)):WaitForChild("ItemRegistry", 30))
      end
      )
      local function
        F(w)
        local Y, F=pcall(function
          ()
          return K and(K[w]and K[w].Display)
        end
        )
        if Y and(type(F)=="string" and F~="")then
          return F
        end
        return tostring(w)
      end
      local function
        M(w)
        local Y=(((tostring(math.floor(tonumber(w)or 0))):reverse()):gsub("(%d%d%d)", "%1,")):reverse()
        return(Y:gsub("^,", ""))
      end
      local x=true
      local S, v={},{}
      local function
        L(w, Y, K)
        local F=w[Y]
        if F and(os.clock()-F.t<120 and F.n>0)then
          local w=math.min(F.n, K)F.n=F.n-w
          return w
        end
        return 0
      end
      local function
        G(w, Y, K)
        local F=w[Y]
        if not F or os.clock()-F.t>=120 then
          F={["n"]=0;["t"]=0}w[Y]=F
        end
        F.n=F.n+K F.t=os.clock()
      end
      local function
        i(w, K)
        local F=Y.kw_loot F.items[w]=((tonumber(F.items[w])or 0))+K x=true
      end
      pcall(function
        ()
        local w=((m:WaitForChild("Reward_Engine", 30)):WaitForChild("Remotes", 30)):WaitForChild("ShowRewardPopup", 30)w.OnClientEvent:Connect(function
          (w)
          if type(w)~="table" then
            return
          end
          for w, K in ipairs(w)do
            if type(K)=="table" then
              local w=Y.kw_loot
              local F=tonumber(K.Amount)or 1
              if K.Kind=="Coins" then
              w.coins=((tonumber(w.coins)or 0))+F x=true
              elseif K.Kind=="XP" then
              w.xp=((tonumber(w.xp)or 0))+math.max(F, tonumber(K.Boosted)or 0)x=true
              elseif((K.Kind=="Item" or K.Kind=="Weapon"))and K.Id then
                local w=tostring(K.Id)
                local Y=F-L(v, w, F)
                if Y>0 then
                  i(w, Y)G(S, w, Y)
                end
              end
            end
          end
        end
        )
      end
      )pcall(function
        ()
        local w=((m:WaitForChild("UI_Engine", 30)):WaitForChild("Remotes", 30)):WaitForChild("NewItemPickup", 30)w.OnClientEvent:Connect(function
          (w)
          if type(w)~="table" then
            return
          end
          if w.id then
            w={w}
          end
          for w, Y in ipairs(w)do
            if type(Y)=="table" and Y.id then
              local w=tostring(Y.id)
              local K=tonumber(Y.count)or 1
              local F=K-L(S, w, K)
              if F>0 then
                i(w, F)G(v, w, F)
              end
            end
          end
        end
        )
      end
      )
      local o, a=nil, 0
      while task.wait(1)do
        local K=Y.kw_loot
        if K~=o then
          o=K x=true
        end
        if x then
          x=false
          local Y={}
          if((tonumber(K.coins)or 0))>0 then
            Y[#Y+1]="Coins: "..M(K.coins)
          end
          if((tonumber(K.xp)or 0))>0 then
            Y[#Y+1]="XP: "..M(K.xp)
          end
          local m={}
          for w, Y in pairs(K.items)do
            m[#m+1]={F(w);tonumber(Y)or 0}
          end
          table.sort(m, function
            (w, Y)
            if w[2]~=Y[2]then
              return w[2]>Y[2]
            end
            return w[1]<Y[1]
          end
          )
          for w=1, math.min(#m, 25), 1 do
            Y[#Y+1]=m[w][1]..(" x"..M(m[w][2]))
          end
          if#m>25 then
            Y[#Y+1]="... +"..((#m-25).." more")
          end
          local S=#Y>0 and table.concat(Y, "\n")or "Nothing yet" N(S, math.max(#Y, 1))
          if os.clock()-a>5 then
            a=os.clock()pcall(function
              ()
              if not isfolder(T)then
                makefolder(T)
              end
              writefile(w, I:JSONEncode(K))
            end
          )
          else
            x=true
          end
        end
      end
    end
    )task.spawn(function
      ()
      local w, Y=pcall(function
        ()
        local w=m:WaitForChild("Reward_Engine", 30)
        local Y=w and w:WaitForChild("Modules", 30)
        local K=Y and Y:WaitForChild("RewardScreen", 30)
        return K and require(K)
      end
      )
      local K=getgenv()
      if K.kw_rewardHook then
        return
      end
      if not w or type(Y)~="table" or type(Y.Show)~="function" then
        K.kw_rewardHook=true task.spawn(function
          ()
          local w=x:WaitForChild("PlayerGui", 30)
          local Y=w and w:WaitForChild("RewardScreen", 30)
          if not((Y and Y:IsA("ScreenGui")))then
            return
          end
          local K=game:GetService("VirtualInputManager")
          local F={{.5;.5};{.5;.92},{.08;.92};{.92, .08}}
          local I, m=0, 0
          while task.wait(.1)do
            if l.AutoLootEnabled and Y.Enabled then
              if os.clock()-m>.3 then
                m=os.clock()I=I%#F+1 pcall(function
                  ()
                  local w=workspace.CurrentCamera["ViewportSize"]
                  local Y, m=w.X*F[I][1], w.Y*F[I][2]K:SendMouseButtonEvent(Y, m, 0, true, game, 0)K:SendMouseButtonEvent(Y, m, 0, false, game, 0)
                end
                )
              end
            else
              m=0
            end
          end
        end
        )
        return
      end
      K.kw_rewardHook=true
      local F=Y.Show
      local function
        I(w, Y, K)
        if l.AutoLootEnabled and(type(K)=="table" and K.pages)then
          task.delay(.25, function
            ()
            if type(w)=="table" then
              for w, K in ipairs(w)do
                if typeof(K)=="Instance" and K:IsA("GuiObject")then
                  local w=false
                  if Y then
                    w=pcall(Y, K)
                  end
                  if not w then
                    pcall(function
                      ()K:Destroy()
                    end
                    )
                  end
                end
              end
            end
          end
          )
          return true
        end
        return false
      end
      local M=false
      if type(hookfunction)=="function" then
        pcall(function
          ()
          local w w=hookfunction(F, function
            (Y, K, F)
            if I(Y, K, F)then
              return
            end
            return w(Y, K, F)
          end
          )M=type(w)=="function"
        end
        )
      end
      if not M then
        pcall(function
          ()Y.Show=function
            (w, Y, K)
            if I(w, Y, K)then
              return
            end
            return F(w, Y, K)
          end
        end
        )
      end
    end
    )
  end
  ))()
end
task.wait()do
  ((function
    ()
    local w=N1:Tab({["Title"]="Collect";["Icon"]="package"})
    local Y=w:Section({["Title"]="Auto Collect",["Box"]=true;["BoxBorder"]=true,["Opened"]=true})
    local K=Y:Group({})Q.AutoCollectEnabled=K:Toggle({["Title"]="Enable Auto Collect";["Value"]=l.AutoCollectEnabled,["Callback"]=function
      (w)U(w)
    end
    })K:Space()K:Keybind({["Title"]="Auto Collect Key";["Value"]=l.AutoCollectBind;["Callback"]=function
      (w)l.AutoCollectBind=w o()
    end
    })Y:Toggle({["Title"]="Collect all items",["Desc"]="Ignores the filter",["Value"]=l.CollectAll;["Callback"]=function
      (w)l.CollectAll=w o()
    end
    })Y:Slider({["Title"]="Pickup Radius",["Step"]=1;["Value"]={["Min"]=2;["Max"]=50,["Default"]=l.CollectRadius};["Callback"]=function
      (w)l.CollectRadius=w o()
    end
    })do
      local w=Y:Group({})w:Toggle({["Title"]="Extended range";["Desc"]="Beyond prompt range (test)";["Value"]=l.CollectIgnoreRange;["Callback"]=function
        (w)l.CollectIgnoreRange=w o()
      end
      })w:Space()w:Toggle({["Title"]="Walk to drops (optional)";["Value"]=l.CollectWalk;["Callback"]=function
        (w)l.CollectWalk=w o()
      end
      })
    end
    Y:Slider({["Title"]="Walk Radius",["Step"]=5,["Value"]={["Min"]=10;["Max"]=120;["Default"]=l.CollectWalkRadius},["Callback"]=function
      (w)l.CollectWalkRadius=w o()
    end
    })
    local F=w:Section({["Title"]="Dungeon room sweep";["Box"]=true,["BoxBorder"]=true,["Opened"]=false})F:Toggle({["Title"]="Collect drops before leaving a room";["Value"]=l.SweepEnabled;["Callback"]=function
      (w)l.SweepEnabled=w o()
    end
    })F:Slider({["Title"]="Search radius",["Step"]=5,["Value"]={["Min"]=10,["Max"]=200;["Default"]=l.SweepRadius};["Callback"]=function
      (w)l.SweepRadius=w o()
    end
    })F:Slider({["Title"]="Wait for drops to land (sec)",["Step"]=1,["Value"]={["Min"]=0;["Max"]=8;["Default"]=l.SweepGrace};["Callback"]=function
      (w)l.SweepGrace=w o()
    end
    })F:Slider({["Title"]="Max sweep time per room (sec)";["Step"]=5;["Value"]={["Min"]=5;["Max"]=90;["Default"]=l.SweepMaxTime},["Callback"]=function
      (w)l.SweepMaxTime=w o()
    end
    })
    local I=w:Section({["Title"]="Item Filter";["Box"]=true,["BoxBorder"]=true;["Opened"]=false})I:Dropdown({["Title"]="Whole categories",["Values"]={"Material";"Consumable", "Armor";"Weapon"},["Value"]=(#l.CollectKinds>0)and l.CollectKinds or nil;["Multi"]=true;["AllowNone"]=true,["Callback"]=function
      (w)
      local Y={}
      if type(w)=="table" then
        for w, K in pairs(w)do
          if type(K)=="table" then
            K=K.Title or K.Name or K.Value
          end
          if K~=nil then
            table.insert(Y, tostring(K))
          end
        end
      end
      l.CollectKinds=Y o()
    end
    })
    local function
      m(Y, K)
      local F, I={},{}
      for w, K in ipairs(n)do
        if K.kind==Y then
          table.insert(F, K.name)I[K.id]=true
        end
      end
      local m=w:Section({["Title"]="%s (%d)":format(K,#F);["Box"]=true;["BoxBorder"]=true;["Opened"]=false})
      local M={}
      for w, Y in ipairs(l.CollectItems)do
        if I[Y]then
          table.insert(M, j(Y))
        end
      end
      m:Dropdown({["Title"]=K;["Values"]=F;["Value"]=(#M>0)and M or nil,["Multi"]=true;["AllowNone"]=true;["Callback"]=function
        (w)
        local Y={}
        for w, K in ipairs(l.CollectItems)do
          if not I[K]then
            table.insert(Y, K)
          end
        end
        for w, K in ipairs(C(w))do
          table.insert(Y, K)
        end
        l.CollectItems=Y o()
      end
      })
    end
    m("Material", "Materials")m("Consumable", "Consumables")
    for w, Y in ipairs(n)do
      if Y.kind=="Chest" then
        m("Chest", "Chests")break
      end
    end
    do
      local Y={{["t"]="Sword";["title"]="Swords"};{["t"]="GreatSword",["title"]="Great Swords"};{["t"]="Katana";["title"]="Katanas"},{["t"]="Dagger";["title"]="Daggers"};{["t"]="Axe",["title"]="Axes"},{["t"]="GreatAxe";["title"]="Great Axes"};{["t"]="TwinbladeAxe";["title"]="Twinblade Axes"},{["t"]="Hammer",["title"]="Hammers"};{["t"]="Scythe";["title"]="Scythes"},{["t"]="Spear";["title"]="Spears"};{["t"]="Bow",["title"]="Bows"}}
      local K=0
      for w, Y in ipairs(n)do
        if Y.kind=="Weapon" then
          K=K+1
        end
      end
      local F=w:Section({["Title"]="Weapons (%d)":format(K);["Box"]=true,["BoxBorder"]=true,["Opened"]=false})
      local I=true
      for w, Y in ipairs(Y)do
        local K, m={},{}
        for w, F in ipairs(n)do
          if F.kind=="Weapon" and F.wtype==Y.t then
            table.insert(K, F.name)m[F.id]=true
          end
        end
        if#K>0 then
          I=false
          local w={}
          for Y, K in ipairs(l.CollectItems)do
            if m[K]then
              table.insert(w, j(K))
            end
          end
          F:Dropdown({["Title"]="%s (%d)":format(Y.title,#K),["Values"]=K;["Value"]=(#w>0)and w or nil,["Multi"]=true;["AllowNone"]=true;["Callback"]=function
            (w)
            local Y={}
            for w, K in ipairs(l.CollectItems)do
              if not m[K]then
                table.insert(Y, K)
              end
            end
            for w, K in ipairs(C(w))do
              table.insert(Y, K)
            end
            l.CollectItems=Y o()
          end
          })
        end
      end
    end
    do
      local Y={}
      for w, K in ipairs(p)do
        table.insert(Y, V[K])
      end
      local K=w:Section({["Title"]="Armor (%d sets)":format(#Y),["Box"]=true;["BoxBorder"]=true;["Opened"]=false})
      local F={}
      for w, Y in ipairs(l.CollectArmorSets)do
        if V[Y]then
          table.insert(F, V[Y])
        end
      end
      K:Dropdown({["Title"]="Armor sets";["Values"]=Y,["Value"]=(#F>0)and F or nil;["Multi"]=true;["AllowNone"]=true;["Callback"]=function
        (w)
        local Y={}
        if type(w)=="table" then
          for w, K in pairs(w)do
            if type(K)=="table" then
              K=K.Title or K.Name or K.Value
            end
            local F=K~=nil and t[tostring(K)]
            if F then
              table.insert(Y, F)
            end
          end
        end
        l.CollectArmorSets=Y o()
      end
      })K:Dropdown({["Title"]="Pieces (empty = all)",["Values"]={"Helmet", "ChestPlate";"Leggings", "Boots"};["Value"]=(#l.CollectArmorPieces>0)and l.CollectArmorPieces or nil;["Multi"]=true;["AllowNone"]=true,["Callback"]=function
        (w)
        local Y={}
        if type(w)=="table" then
          for w, K in pairs(w)do
            if type(K)=="table" then
              K=K.Title or K.Name or K.Value
            end
            if K~=nil then
              table.insert(Y, tostring(K))
            end
          end
        end
        l.CollectArmorPieces=Y o()
      end
      })
    end
  end
  ))()
end
task.wait()do
  ((function
    ()
    local w=(g.fold("Farm", "swords")):Tab({["Title"]="Dungeon Dark",["Icon"]="ghost"})
    local Y=w:Section({["Title"]="Dark Dungeon Auto Farm";["Box"]=true,["BoxBorder"]=true;["Opened"]=true})Y:Paragraph({["Title"]="Before you start",["Desc"]="Enter the first room yourself; the farm starts inside."})
    local K=Y:Group({})Q.DKEnabled=K:Toggle({["Title"]="Enable Dark Dungeon Farm",["Value"]=l.DKEnabled,["Callback"]=function
      (w)S1(w)
    end
    })K:Space()K:Keybind({["Title"]="Dark Dungeon Farm Key";["Value"]=l.DKBind,["Callback"]=function
      (w)l.DKBind=w o()
    end
    })Y:Slider({["Title"]="Fly speed",["Desc"]="Whole dungeon";["Step"]=1;["Value"]={["Min"]=5,["Max"]=40;["Default"]=math.clamp(tonumber(l.DKSpeed)or 35, 5, 40)};["Callback"]=function
      (w)l.DKSpeed=w o()
    end
    })
    local function
      F(Y, K)
      local F=w:Section({["Title"]=Y,["Box"]=true;["BoxBorder"]=true,["Opened"]=true})F:Slider({["Title"]="Height",["Step"]=1;["Value"]={["Min"]=-10;["Max"]=20,["Default"]=AL(l[K])};["Callback"]=function
        (w)l[K]=w o()
      end
      })
    end
    F("Shadow Dog", "DKHeightDog")F("Jumping Spider", "DKHeightSpider")F("Hellhound", "DKHeightHound")F("Boss · Voodoo Doll", "DKHeightBoss")
    local I=w:Section({["Title"]="Voodoo Effigy (death doll)";["Box"]=true,["BoxBorder"]=true;["Opened"]=false})I:Toggle({["Title"]="Auto break my Effigy";["Value"]=l.DKEffigy,["Callback"]=function
      (w)l.DKEffigy=w o()
    end
    })I:Slider({["Title"]="Height above Effigy",["Step"]=1,["Value"]={["Min"]=-10;["Max"]=20;["Default"]=AL(l.DKHeightEffigy)},["Callback"]=function
      (w)l.DKHeightEffigy=w o()
    end
    })
    local m=w:Section({["Title"]="Options";["Box"]=true;["BoxBorder"]=true,["Opened"]=true})do
      local w=m:Group({})w:Toggle({["Title"]="Relative height";["Desc"]="Measured from the enemy, not the floor";["Value"]=l.DKRelTarget,["Callback"]=function
        (w)l.DKRelTarget=w o()
      end
      })w:Space()w:Toggle({["Title"]="Lie flat",["Desc"]="Body horizontal, weapon down";["Value"]=l.DKProne,["Callback"]=function
        (w)l.DKProne=w o()
      end
      })
    end
    do
      local w=m:Group({})w:Toggle({["Title"]="Face the enemy";["Value"]=l.DKFace,["Callback"]=function
        (w)l.DKFace=w o()
      end
      })w:Space()w:Toggle({["Title"]="Noclip while farming",["Value"]=l.DKNoclip,["Callback"]=function
        (w)l.DKNoclip=w o()
      end
      })
    end
    do
      local w=m:Group({})w:Toggle({["Title"]="Auto advance";["Desc"]="Fly through the opened door";["Value"]=l.DKAutoAdvance,["Callback"]=function
        (w)l.DKAutoAdvance=w o()
      end
      })w:Space()w:Toggle({["Title"]="Auto repeat dungeon",["Value"]=l.DKAutoRepeat,["Callback"]=function
        (w)l.DKAutoRepeat=w o()
      end
      })
    end
    m:Toggle({["Title"]="Also repeat after defeat",["Value"]=l.DKRetryDefeat;["Callback"]=function
      (w)l.DKRetryDefeat=w o()
    end
    })
  end
  ))()
end
task.wait()do
  ((function
    ()
    local w=(g.fold("Farm", "swords")):Tab({["Title"]="Heroes";["Icon"]="wand"})
    local Y=w:Section({["Title"]="Archmage Vex Auto Kill",["Box"]=true,["BoxBorder"]=true;["Opened"]=true})
    local K=Y:Group({})Q.VXEnabled=K:Toggle({["Title"]="Enable Vex Farm";["Value"]=l.VXEnabled;["Callback"]=function
      (w)PL(w)
    end
    })K:Space()K:Keybind({["Title"]="Vex Farm Key",["Value"]=l.VXBind;["Callback"]=function
      (w)l.VXBind=w o()
    end
    })Y:Toggle({["Title"]="Auto repeat";["Desc"]="Place Rift Key when Vex is gone";["Value"]=l.VXAutoRift,["Callback"]=function
      (w)l.VXAutoRift=w o()
    end
    })Y:Slider({["Title"]="Height above Vex";["Step"]=1,["Value"]={["Min"]=0;["Max"]=10;["Default"]=vL(l.VXHeight)},["Callback"]=function
      (w)l.VXHeight=w o()
    end
    })Y:Slider({["Title"]="Fly speed",["Step"]=1,["Value"]={["Min"]=5,["Max"]=20;["Default"]=math.clamp(tonumber(l.VXSpeed)or 20, 5, 20)},["Callback"]=function
      (w)l.VXSpeed=w o()
    end
    })do
      local w=Y:Group({})w:Toggle({["Title"]="Starfall escape",["Desc"]="Fly to a safe zone if the channel isn't broken in time",["Value"]=l.VXSafe;["Callback"]=function
        (w)l.VXSafe=w o()
      end
      })w:Space()w:Toggle({["Title"]="Lie flat",["Desc"]="Body horizontal, weapon down";["Value"]=l.VXProne;["Callback"]=function
        (w)l.VXProne=w o()
      end
      })
    end
    Y:Toggle({["Title"]="Face the boss",["Value"]=l.VXFace;["Callback"]=function
      (w)l.VXFace=w o()
    end
    })
    local F=w:Section({["Title"]="Captain Blackpowder Auto Kill",["Box"]=true,["BoxBorder"]=true;["Opened"]=true})F:Paragraph({["Title"]="Before you start",["Desc"]="Start the fight yourself (quest, level 300+). Once the Captain is on the ship the script flies above him. Use Auto Heal with Castle only turned off."})
    local I=F:Group({})Q.CPEnabled=I:Toggle({["Title"]="Enable Captain Auto Kill";["Value"]=l.CPEnabled,["Callback"]=function
      (w)eL(w)
    end
    })I:Space()I:Keybind({["Title"]="Captain Auto Kill Key",["Value"]=l.CPBind;["Callback"]=function
      (w)l.CPBind=w o()
    end
    })F:Slider({["Title"]="Fly speed";["Step"]=1;["Value"]={["Min"]=5;["Max"]=30;["Default"]=math.clamp(tonumber(l.CPSpeed)or 20, 5, 30)};["Callback"]=function
      (w)l.CPSpeed=w o()
    end
    })F:Slider({["Title"]="Height above the Captain";["Step"]=1;["Value"]={["Min"]=0,["Max"]=10;["Default"]=math.clamp(tonumber(l.CPHeight)or 8, 0, 10)};["Callback"]=function
      (w)l.CPHeight=w o()
    end
    })do
      local w=F:Group({})w:Toggle({["Title"]="Lie flat";["Desc"]="Body horizontal, weapon down",["Value"]=l.CPProne;["Callback"]=function
        (w)l.CPProne=w o()
      end
      })w:Space()w:Toggle({["Title"]="Face the boss",["Value"]=l.CPFace,["Callback"]=function
        (w)l.CPFace=w o()
      end
      })
    end
  end
  ))()
end
task.wait()do
  ((function
    ()
    local Y=N1:Tab({["Title"]="Settings";["Icon"]="settings"})
    local K=Y:Section({["Title"]="Menu";["Box"]=true;["BoxBorder"]=true;["Opened"]=true})K:Keybind({["Title"]="Menu Toggle Key",["Value"]=l.MenuBind;["Callback"]=function
      (w)l.MenuBind=w o()pcall(function
        ()N1:SetToggleKey(Enum.KeyCode[w]or Enum.KeyCode["RightControl"])
      end
      )
    end
    })
    local F=K:Group({})Q.NotifyEnabled=F:Toggle({["Title"]="Notifications",["Value"]=l.NotifyEnabled~=false;["Callback"]=function
      (w)l.NotifyEnabled=w o()
    end
    })F:Space()Q.KeyWidget=F:Toggle({["Title"]="Keybind widget";["Desc"]="drag to move";["Value"]=l.KeyWidget~=false,["Callback"]=function
      (w)l.KeyWidget=w o()
      local Y=Q.KW
      if Y and Y.refresh then
        pcall(Y.refresh)
      end
    end
    })
    local I=Y:Section({["Title"]="Config";["Box"]=true;["BoxBorder"]=true;["Opened"]=true})
    local m=I:Group({})m:Button({["Title"]="Save Config";["Icon"]="save";["Justify"]="Center",["Callback"]=function
      ()o()w:Notify({["Title"]="Config",["Content"]="Saved.";["Duration"]=2})
    end
    })m:Space()m:Button({["Title"]="Reset Defaults";["Icon"]="rotate-ccw";["Justify"]="Center";["Callback"]=function
      ()
      for w, Y in pairs(L)do
        (getgenv())[w]=Y
      end
      o()J("FlyEnabled", false)J("SpeedEnabled", false)J("AutoAttackEnabled", false)J("AutoCollectEnabled", false)J("InfJumpEnabled", false)J("NoclipEnabled", false)J("AutoLootEnabled", false)J("AutoCastEnabled", false)J("AntiKnockbackEnabled", false)J("CPEnabled", false)J("DKEnabled", false)J("NotifyEnabled", true)J("AutoAttackSync", true)J("KeyWidget", true)do
        local w=Q.KW
        if w and w.reset then
          pcall(w.reset)
        end
      end
      mL(false)ML(false)y(false)U(false)Z(false)A(false)q(false)eL(false)S1(false)w:Notify({["Title"]="Config";["Content"]="Reset to defaults.";["Duration"]=3})
    end
    })
  end
  ))()
end
local function
  T1(w, Y, K, I, m, M, S)
  local N={}
  local T, v=pcall(function
    ()
    local T=game:GetService("CoreGui")
    local v=Instance.new("ScreenGui")v.Name=w v.ResetOnSpawn=false v.IgnoreGuiInset=true v.DisplayOrder=998 pcall(function
      ()
      if syn and syn.protect_gui then
        syn.protect_gui(v)
      end
    end
    )pcall(function
      ()v.Parent=(gethui and gethui())or T
    end
    )
    if not v.Parent then
      v.Parent=x:WaitForChild("PlayerGui")
    end
    local L=math.clamp(tonumber(l[Y])or I, .05, 1)
    local G=math.clamp(tonumber(l[K])or m, 0, .95)
    local i=Instance.new("Frame")i.AnchorPoint=Vector2.new(1, 0)i.Position=UDim2.new(L, 0, G, 0)i.AutomaticSize=Enum.AutomaticSize["XY"]i.Size=UDim2.new(0, 0, 0, 0)i.BackgroundColor3=Color3.new(0, 0, 0)i.BackgroundTransparency=.4 i.BorderSizePixel=0 i.Active=true i.Parent=v;(Instance.new("UICorner", i)).CornerRadius=UDim.new(0, 6)
    local a=Instance.new("UIPadding")a.PaddingLeft=UDim.new(0, 8)a.PaddingRight=UDim.new(0, 8)a.PaddingTop=UDim.new(0, 5)a.PaddingBottom=UDim.new(0, 5)a.Parent=i
    local Q=Instance.new("TextLabel")Q.AutomaticSize=Enum.AutomaticSize["XY"]Q.Size=UDim2.new(0, 0, 0, 0)Q.BackgroundTransparency=1 Q.Font=Enum.Font["Code"]Q.TextSize=13 Q.RichText=true Q.TextXAlignment=Enum.TextXAlignment["Left"]Q.TextColor3=Color3.new(1, 1, 1)Q.Text="" Q.Parent=i
    local g, J, D, y=false, nil, 0, 0 i.InputBegan:Connect(function
      (w)
      if w.UserInputType==Enum.UserInputType["MouseButton1"]or w.UserInputType==Enum.UserInputType["Touch"]then
        g=true J=Vector2.new(w.Position["X"], w.Position["Y"])D=i.AbsolutePosition["X"]+i.AbsoluteSize["X"]y=i.AbsolutePosition["Y"]w.Changed:Connect(function
          ()
          if w.UserInputState==Enum.UserInputState["End"]and g then
            g=false l[Y], l[K]=L, G o()
          end
        end
        )
      end
    end
    )F.InputChanged:Connect(function
      (w)
      if g and(J and((w.UserInputType==Enum.UserInputType["MouseMovement"]or w.UserInputType==Enum.UserInputType["Touch"])))then
        local Y=v.AbsoluteSize
        if Y.X<1 or Y.Y<1 then
          return
        end
        L=math.clamp((((D+w.Position["X"])-J.X))/Y.X, .05, 1)G=math.clamp((((y+w.Position["Y"])-J.Y))/Y.Y, 0, .95)i.Position=UDim2.new(L, 0, G, 0)
      end
    end
    )function
      N.refresh()v.Enabled=l[M]~=false
    end
    function
      N.reset()L, G=I, m l[Y], l[K]=L, G i.Position=UDim2.new(L, 0, G, 0)o()
    end
    N.refresh()task.spawn(function
      ()
      local w
      while task.wait(.25)do
        local Y=S()
        if Y~=w then
          w=Y Q.Text=Y
        end
      end
    end
    )
  end
  )
  if not T then
    warn("[kw] "..(w..(" widget error: "..tostring(v))))
  end
  return N
end
do
  ((function
    ()
    local w={{"Fly", "FlyBind", "FlyEnabled"},{"Speed", "SpeedBind", "SpeedEnabled"},{"Auto Attack", "AutoAttackBind", "AutoAttackEnabled"},{"Auto Collect", "AutoCollectBind", "AutoCollectEnabled"},{"Inf Jump";"InfJumpBind";"InfJumpEnabled"};{"Noclip", "NoclipBind";"NoclipEnabled"},{"Vex", "VXBind";"VXEnabled"};{"Captain";"CPBind", "CPEnabled"};{"Dark";"DKBind";"DKEnabled"},{"Menu", "MenuBind", nil}}
    local function
      Y()
      local Y={"<font color=\"#9aa0a6\">Keybinds (drag me)</font>"}
      for w, K in ipairs(w)do
        local F=l[K[2]]
        if type(F)=="string" and(F~="" and F~="None")then
          local w=K[3]and l[K[3]]Y[#Y+1]="<font color=\"%s\">[%s] %s</font>":format(w and "#6CFF8A" or "#E8E8E8", F, K[1])
        end
      end
      return table.concat(Y, "\n")
    end
    Q.KW=T1("kw_keys", "KeyWidgetX", "KeyWidgetY", .99, .35, "KeyWidget", Y)
  end
  ))()
end
F.InputBegan:Connect(function
  (w, Y)
  if Y then
    return
  end
  local K=w.KeyCode["Name"]
  if K==l.FlyBind and l.FlyBind~="None" then
    local w=not l.FlyEnabled J("FlyEnabled", w)mL(w)
  end
  if K==l.SpeedBind and l.SpeedBind~="None" then
    local w=not l.SpeedEnabled J("SpeedEnabled", w)g.Speed(w)
  end
  if K==l.AutoAttackBind and l.AutoAttackBind~="None" then
    local w=not l.AutoAttackEnabled J("AutoAttackEnabled", w)g.AutoAttack(w)
  end
  if K==l.AutoCollectBind and l.AutoCollectBind~="None" then
    local w=not l.AutoCollectEnabled J("AutoCollectEnabled", w)g.AutoCollect(w)
  end
  if K==l.InfJumpBind and l.InfJumpBind~="None" then
    local w=not l.InfJumpEnabled J("InfJumpEnabled", w)g.InfJump(w)
  end
  if K==l.NoclipBind and l.NoclipBind~="None" then
    local w=not l.NoclipEnabled J("NoclipEnabled", w)g.Noclip(w)
  end
  if K==l.VXBind and l.VXBind~="None" then
    local w=not l.VXEnabled J("VXEnabled", w)g.Vex(w)
  end
  if K==l.DKBind and l.DKBind~="None" then
    local w=not l.DKEnabled J("DKEnabled", w)g.DarkFarm(w)
  end
  if K==l.CPBind and l.CPBind~="None" then
    local w=not l.CPEnabled J("CPEnabled", w)g.Captain(w)
  end
end
)task.defer(function
  ()
  if l.FlyEnabled and((l.VXEnabled or l.CPEnabled))then
    SL.flyByFarm=true
  end
  if l.FlyEnabled then
    FL()J("FlyEnabled", true)
  end
  if l.SpeedEnabled then
    ML(true)J("SpeedEnabled", true)
  end
  if l.AutoAttackEnabled then
    y(true)J("AutoAttackEnabled", true)
  end
  if l.AutoCollectEnabled then
    U(true)J("AutoCollectEnabled", true)
  end
  if l.InfJumpEnabled then
    Z(true)J("InfJumpEnabled", true)
  end
  if l.NoclipEnabled then
    A(true)J("NoclipEnabled", true)
  end
  if l.AntiKnockbackEnabled then
    q(true)J("AntiKnockbackEnabled", true)
  end
  if l.VXEnabled then
    PL(true)J("VXEnabled", true)
  end
  if l.CPEnabled then
    eL(true)J("CPEnabled", true)
  end
  if l.DKEnabled then
    S1(true)J("DKEnabled", true)
  end
end
)
end
)(...)

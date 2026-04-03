-- ========== AUTO FARM LEVEL + BRING MOB - FIXED (No Teleport đột ngột) ==========
-- crack by HoangQuan nhatan

-- Bật FastMax
loadstring(game:HttpGet("https://raw.githubusercontent.com/AnhDzaiScript/Setting/refs/heads/main/FastMax.lua"))()

-- ========== ANTI & FIX ==========
hookfunction(require(game:GetService('ReplicatedStorage').Effect.Container.Death), function() end)
hookfunction(require(game:GetService('ReplicatedStorage').Effect.Container.Respawn), function() end)

local player = game.Players.LocalPlayer
player.Idled:connect(function()
    game:GetService('VirtualUser'):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    game:GetService('VirtualUser'):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

spawn(function()
    while true do
        task.wait(45)
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
    end
end)

-- ========== HÀM DI CHUYỂN (CHỈ BAY, KHÔNG TELEPORT) ==========
local hrp = nil
function MoveTo(cf)
    hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local dist = (cf.Position - hrp.Position).Magnitude
    if dist > 0.5 then
        local tween = game:GetService("TweenService"):Create(hrp, TweenInfo.new(dist/180, Enum.EasingStyle.Linear), {CFrame = cf})
        tween:Play()
        task.wait(dist/180)
        tween:Cancel()
    else
        hrp.CFrame = cf
    end
end

-- ========== AUTO HAKI ==========
function AutoHaki()
    if player.Character and not player.Character:FindFirstChild("HasBuso") then
        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer("Buso")
    end
end

-- ========== EQUIP VŨ KHÍ (ƯU TIÊN MELEE) ==========
function EquipWeapon()
    local bp = player.Backpack
    local char = player.Character
    if not char then return end
    for _, tool in pairs(bp:GetChildren()) do
        if tool:IsA("Tool") and tool.ToolTip == "Melee" then
            if char:FindFirstChild(tool.Name) == nil then
                char.Humanoid:EquipTool(tool)
            end
            return
        end
    end
    for _, tool in pairs(bp:GetChildren()) do
        if tool:IsA("Tool") and (tool.ToolTip == "Blox Fruit" or tool.ToolTip == "Sword") then
            if char:FindFirstChild(tool.Name) == nil then
                char.Humanoid:EquipTool(tool)
            end
            return
        end
    end
end

-- ========== BRING MOB (HÚT QUÁI VỀ 1 CHỖ) ==========
local bringPos = nil
function BringMob()
    if not bringPos then return end
    for _, mob in pairs(workspace.Enemies:GetChildren()) do
        if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart") then
            local dist = (mob.HumanoidRootPart.Position - bringPos.Position).Magnitude
            if dist <= 150 and dist > 12 then
                mob.HumanoidRootPart.CFrame = bringPos
                mob.HumanoidRootPart.CanCollide = false
                mob.Humanoid.WalkSpeed = 0
                mob.Humanoid.JumpPower = 0
                if mob.Humanoid:FindFirstChild("Animator") then
                    mob.Humanoid.Animator:Destroy()
                end
            end
        end
    end
end

-- ========== XÁC ĐỊNH WORLD ==========
if game.PlaceId == 2753915549 then
    World1 = true
elseif game.PlaceId == 4442272183 then
    World2 = true
elseif game.PlaceId == 7449423635 then
    World3 = true
end

-- ========== CHECK QUEST (ĐẦY ĐỦ CÁC MỐC LEVEL) ==========
function CheckQuest()
    local lv = player.Data.Level.Value
    -- World 1
    if World1 then
        if lv <= 9 then return "Bandit",1,"BanditQuest1","Bandit",CFrame.new(1059.37,15.45,1550.42),CFrame.new(1045.96,27.00,1560.82) end
        if lv <= 14 then return "Monkey",1,"JungleQuest","Monkey",CFrame.new(-1598.09,35.55,153.38),CFrame.new(-1448.52,67.85,11.47) end
        if lv <= 29 then return "Gorilla",2,"JungleQuest","Gorilla",CFrame.new(-1598.09,35.55,153.38),CFrame.new(-1129.88,40.46,-525.42) end
        if lv <= 39 then return "Pirate",1,"BuggyQuest1","Pirate",CFrame.new(-1141.07,4.10,3831.55),CFrame.new(-1103.51,13.75,3896.09) end
        if lv <= 59 then return "Brute",2,"BuggyQuest1","Brute",CFrame.new(-1141.07,4.10,3831.55),CFrame.new(-1140.08,14.81,4322.92) end
        if lv <= 74 then return "Desert Bandit",1,"DesertQuest","Desert Bandit",CFrame.new(894.49,5.14,4392.43),CFrame.new(924.80,6.45,4481.59) end
        if lv <= 89 then return "Desert Officer",2,"DesertQuest","Desert Officer",CFrame.new(894.49,5.14,4392.43),CFrame.new(1608.28,8.61,4371.01) end
        if lv <= 99 then return "Snow Bandit",1,"SnowQuest","Snow Bandit",CFrame.new(1389.74,88.15,-1298.91),CFrame.new(1354.35,87.27,-1393.95) end
        if lv <= 119 then return "Snowman",2,"SnowQuest","Snowman",CFrame.new(1389.74,88.15,-1298.91),CFrame.new(1201.64,144.58,-1550.07) end
        if lv <= 149 then return "Chief Petty Officer",1,"MarineQuest2","Chief Petty Officer",CFrame.new(-5039.59,27.35,4324.68),CFrame.new(-4881.23,22.65,4273.75) end
        if lv <= 174 then return "Sky Bandit",1,"SkyQuest","Sky Bandit",CFrame.new(-4839.53,716.37,-2619.44),CFrame.new(-4953.21,295.74,-2899.23) end
        if lv <= 189 then return "Dark Master",2,"SkyQuest","Dark Master",CFrame.new(-4839.53,716.37,-2619.44),CFrame.new(-5259.84,391.40,-2229.04) end
        if lv <= 209 then return "Prisoner",1,"PrisonerQuest","Prisoner",CFrame.new(5308.93,1.66,475.12),CFrame.new(5098.97,-0.32,474.24) end
        if lv <= 249 then return "Dangerous Prisoner",2,"PrisonerQuest","Dangerous Prisoner",CFrame.new(5308.93,1.66,475.12),CFrame.new(5654.56,15.63,866.30) end
        if lv <= 274 then return "Toga Warrior",1,"ColosseumQuest","Toga Warrior",CFrame.new(-1580.05,6.35,-2986.48),CFrame.new(-1820.21,51.68,-2740.67) end
        if lv <= 299 then return "Gladiator",2,"ColosseumQuest","Gladiator",CFrame.new(-1580.05,6.35,-2986.48),CFrame.new(-1292.84,56.38,-3339.03) end
        if lv <= 324 then return "Military Soldier",1,"MagmaQuest","Military Soldier",CFrame.new(-5313.37,10.95,8515.29),CFrame.new(-5411.16,11.08,8454.29) end
        if lv <= 374 then return "Military Spy",2,"MagmaQuest","Military Spy",CFrame.new(-5313.37,10.95,8515.29),CFrame.new(-5802.87,86.26,8828.86) end
        if lv <= 399 then return "Fishman Warrior",1,"FishmanQuest","Fishman Warrior",CFrame.new(61122.65,18.50,1569.40),CFrame.new(60878.30,18.48,1543.76) end
        if lv <= 449 then return "Fishman Commando",2,"FishmanQuest","Fishman Commando",CFrame.new(61122.65,18.50,1569.40),CFrame.new(61922.63,18.48,1493.93) end
        if lv <= 474 then return "God's Guard",1,"SkyExp1Quest","God's Guard",CFrame.new(-4721.89,843.87,-1949.97),CFrame.new(-4710.04,845.28,-1927.31) end
        if lv <= 524 then return "Shanda",2,"SkyExp1Quest","Shanda",CFrame.new(-7859.10,5544.19,-381.48),CFrame.new(-7678.49,5566.40,-497.22) end
        if lv <= 549 then return "Royal Squad",1,"SkyExp2Quest","Royal Squad",CFrame.new(-7906.82,5634.66,-1411.99),CFrame.new(-7624.25,5658.13,-1467.35) end
        if lv <= 624 then return "Royal Soldier",2,"SkyExp2Quest","Royal Soldier",CFrame.new(-7906.82,5634.66,-1411.99),CFrame.new(-7836.75,5645.66,-1790.62) end
        if lv <= 649 then return "Galley Pirate",1,"FountainQuest","Galley Pirate",CFrame.new(5259.82,37.35,4050.03),CFrame.new(5551.02,78.90,3930.41) end
        if lv <= 699 then return "Galley Captain",2,"FountainQuest","Galley Captain",CFrame.new(5259.82,37.35,4050.03),CFrame.new(5441.95,42.50,4950.09) end
        if lv >= 700 then
            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer("TravelDressrosa")
            return nil
        end
    end
    -- World 2
    if World2 then
        if lv <= 724 then return "Raider",1,"Area1Quest","Raider",CFrame.new(-429.54,71.77,1836.18),CFrame.new(-728.33,52.78,2345.77) end
        if lv <= 774 then return "Mercenary",2,"Area1Quest","Mercenary",CFrame.new(-429.54,71.77,1836.18),CFrame.new(-1004.32,80.16,1424.62) end
        if lv <= 799 then return "Swan Pirate",1,"Area2Quest","Swan Pirate",CFrame.new(638.44,71.77,918.28),CFrame.new(1068.66,137.61,1322.11) end
        if lv <= 874 then return "Factory Staff",2,"Area2Quest","Factory Staff",CFrame.new(632.70,73.11,918.67),CFrame.new(73.08,81.86,-27.47) end
        if lv <= 899 then return "Marine Lieutenant",1,"MarineQuest3","Marine Lieutenant",CFrame.new(-2440.80,71.71,-3216.07),CFrame.new(-2821.37,75.90,-3070.09) end
        if lv <= 949 then return "Marine Captain",2,"MarineQuest3","Marine Captain",CFrame.new(-2440.80,71.71,-3216.07),CFrame.new(-1861.23,80.18,-3254.70) end
        if lv <= 974 then return "Zombie",1,"ZombieQuest","Zombie",CFrame.new(-5497.06,47.59,-795.24),CFrame.new(-5657.78,78.97,-928.69) end
        if lv <= 999 then return "Vampire",2,"ZombieQuest","Vampire",CFrame.new(-5497.06,47.59,-795.24),CFrame.new(-6037.67,32.18,-1340.66) end
        if lv <= 1049 then return "Snow Trooper",1,"SnowMountainQuest","Snow Trooper",CFrame.new(609.86,400.12,-5372.26),CFrame.new(549.15,427.39,-5563.70) end
        if lv <= 1099 then return "Winter Warrior",2,"SnowMountainQuest","Winter Warrior",CFrame.new(609.86,400.12,-5372.26),CFrame.new(1142.75,475.64,-5199.42) end
        if lv <= 1124 then return "Lab Subordinate",1,"IceSideQuest","Lab Subordinate",CFrame.new(-6064.07,15.24,-4902.98),CFrame.new(-5707.47,15.95,-4513.39) end
        if lv <= 1174 then return "Horned Warrior",2,"IceSideQuest","Horned Warrior",CFrame.new(-6064.07,15.24,-4902.98),CFrame.new(-6341.37,15.95,-5723.16) end
        if lv <= 1199 then return "Magma Ninja",1,"FireSideQuest","Magma Ninja",CFrame.new(-5428.03,15.06,-5299.43),CFrame.new(-5449.67,76.66,-5808.20) end
        if lv <= 1249 then return "Lava Pirate",2,"FireSideQuest","Lava Pirate",CFrame.new(-5428.03,15.06,-5299.43),CFrame.new(-5213.33,49.74,-4701.45) end
        if lv <= 1274 then return "Ship Deckhand",1,"ShipQuest1","Ship Deckhand",CFrame.new(1037.80,125.09,32911.60),CFrame.new(1212.01,150.79,33059.25) end
        if lv <= 1299 then return "Ship Engineer",2,"ShipQuest1","Ship Engineer",CFrame.new(1037.80,125.09,32911.60),CFrame.new(919.48,43.54,32779.97) end
        if lv <= 1324 then return "Ship Steward",1,"ShipQuest2","Ship Steward",CFrame.new(968.81,125.09,33244.13),CFrame.new(919.44,129.56,33436.04) end
        if lv <= 1349 then return "Ship Officer",2,"ShipQuest2","Ship Officer",CFrame.new(968.81,125.09,33244.13),CFrame.new(1036.02,181.44,33315.73) end
        if lv <= 1374 then return "Arctic Warrior",1,"FrostQuest","Arctic Warrior",CFrame.new(5667.66,26.80,-6486.09),CFrame.new(5966.25,62.97,-6179.38) end
        if lv <= 1424 then return "Snow Lurker",2,"FrostQuest","Snow Lurker",CFrame.new(5667.66,26.80,-6486.09),CFrame.new(5407.07,69.19,-6880.88) end
        if lv <= 1449 then return "Sea Soldier",1,"ForgottenQuest","Sea Soldier",CFrame.new(-3054.44,235.54,-10142.82),CFrame.new(-3028.22,64.67,-9775.43) end
        if lv <= 1499 then return "Water Fighter",2,"ForgottenQuest","Water Fighter",CFrame.new(-3054.44,235.54,-10142.82),CFrame.new(-3352.90,285.02,-10534.84) end
        if lv >= 1500 then
            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer("TravelZou")
            return nil
        end
    end
    -- World 3
    if World3 then
        if lv <= 1524 then return "Pirate Millionaire",1,"PiratePortQuest","Pirate Millionaire",CFrame.new(-450.10,107.68,5950.73),CFrame.new(-245.99,47.31,5584.10) end
        if lv <= 1574 then return "Pistol Billionaire",2,"PiratePortQuest","Pistol Billionaire",CFrame.new(-450.10,107.68,5950.73),CFrame.new(-54.81,83.77,5947.84) end
        if lv <= 1599 then return "Dragon Crew Warrior",1,"DragonCrewQuest","Dragon Crew Warrior",CFrame.new(6750.49,127.45,-711.03),CFrame.new(6709.76,52.34,-1139.03) end
        if lv <= 1624 then return "Dragon Crew Archer",2,"DragonCrewQuest","Dragon Crew Archer",CFrame.new(6750.49,127.45,-711.03),CFrame.new(6668.76,481.38,329.12) end
        if lv <= 1649 then return "Hydra Enforcer",1,"VenomCrewQuest","Hydra Enforcer",CFrame.new(5206.40,1004.10,748.35),CFrame.new(4547.12,1003.10,334.19) end
        if lv <= 1699 then return "Venomous Assailant",2,"VenomCrewQuest","Venomous Assailant",CFrame.new(5206.40,1004.10,748.35),CFrame.new(4674.93,1134.83,996.31) end
        if lv <= 1724 then return "Marine Commodore",1,"MarineTreeIsland","Marine Commodore",CFrame.new(2481.09,74.27,-6779.64),CFrame.new(2577.25,75.61,-7739.87) end
        if lv <= 1774 then return "Marine Rear Admiral",2,"MarineTreeIsland","Marine Rear Admiral",CFrame.new(2481.09,74.27,-6779.64),CFrame.new(3761.81,123.91,-6823.52) end
        if lv <= 1799 then return "Fishman Raider",1,"DeepForestIsland3","Fishman Raider",CFrame.new(-10581.66,330.87,-8761.19),CFrame.new(-10407.53,331.76,-8368.52) end
        if lv <= 1824 then return "Fishman Captain",2,"DeepForestIsland3","Fishman Captain",CFrame.new(-10581.66,330.87,-8761.19),CFrame.new(-10994.70,352.38,-9002.11) end
        if lv <= 1849 then return "Forest Pirate",1,"DeepForestIsland","Forest Pirate",CFrame.new(-13234.04,331.49,-7625.40),CFrame.new(-13274.48,332.38,-7769.58) end
        if lv <= 1899 then return "Mythological Pirate",2,"DeepForestIsland","Mythological Pirate",CFrame.new(-13234.04,331.49,-7625.40),CFrame.new(-13680.61,501.08,-6991.19) end
        if lv <= 1924 then return "Jungle Pirate",1,"DeepForestIsland2","Jungle Pirate",CFrame.new(-12680.38,389.97,-9902.02),CFrame.new(-12256.16,331.74,-10485.84) end
        if lv <= 1974 then return "Musketeer Pirate",2,"DeepForestIsland2","Musketeer Pirate",CFrame.new(-12680.38,389.97,-9902.02),CFrame.new(-13457.90,391.55,-9859.18) end
        if lv <= 1999 then return "Reborn Skeleton",1,"HauntedQuest1","Reborn Skeleton",CFrame.new(-9479.22,141.22,5566.09),CFrame.new(-8763.72,165.72,6159.86) end
        if lv <= 2024 then return "Living Zombie",2,"HauntedQuest1","Living Zombie",CFrame.new(-9479.22,141.22,5566.09),CFrame.new(-10144.13,138.63,5838.09) end
        if lv <= 2049 then return "Demonic Soul",1,"HauntedQuest2","Demonic Soul",CFrame.new(-9516.99,172.02,6078.47),CFrame.new(-9505.87,172.10,6158.99) end
        if lv <= 2074 then return "Posessed Mummy",2,"HauntedQuest2","Posessed Mummy",CFrame.new(-9516.99,172.02,6078.47),CFrame.new(-9582.02,6.25,6205.48) end
        if lv <= 2099 then return "Peanut Scout",1,"NutsIslandQuest","Peanut Scout",CFrame.new(-2104.39,38.10,-10194.22),CFrame.new(-2143.24,47.72,-10030.00) end
        if lv <= 2124 then return "Peanut President",2,"NutsIslandQuest","Peanut President",CFrame.new(-2104.39,38.10,-10194.22),CFrame.new(-1859.35,38.10,-10422.43) end
        if lv <= 2149 then return "Ice Cream Chef",1,"IceCreamIslandQuest","Ice Cream Chef",CFrame.new(-820.65,65.82,-10965.80),CFrame.new(-872.25,65.82,-10919.96) end
        if lv <= 2199 then return "Ice Cream Commander",2,"IceCreamIslandQuest","Ice Cream Commander",CFrame.new(-820.65,65.82,-10965.80),CFrame.new(-558.06,112.05,-11290.77) end
        if lv <= 2224 then return "Cookie Crafter",1,"CakeQuest1","Cookie Crafter",CFrame.new(-2021.32,37.80,-12028.73),CFrame.new(-2374.14,37.80,-12125.31) end
        if lv <= 2249 then return "Cake Guard",2,"CakeQuest1","Cake Guard",CFrame.new(-2021.32,37.80,-12028.73),CFrame.new(-1598.31,43.77,-12244.58) end
        if lv <= 2274 then return "Baking Staff",1,"CakeQuest2","Baking Staff",CFrame.new(-1927.92,37.80,-12842.54),CFrame.new(-1887.81,77.62,-12998.35) end
        if lv <= 2299 then return "Head Baker",2,"CakeQuest2","Head Baker",CFrame.new(-1927.92,37.80,-12842.54),CFrame.new(-2216.19,82.88,-12869.29) end
        if lv <= 2324 then return "Cocoa Warrior",1,"ChocQuest1","Cocoa Warrior",CFrame.new(233.23,29.88,-12201.23),CFrame.new(-21.55,80.57,-12352.39) end
        if lv <= 2349 then return "Chocolate Bar Battler",2,"ChocQuest1","Chocolate Bar Battler",CFrame.new(233.23,29.88,-12201.23),CFrame.new(582.59,77.19,-12463.16) end
        if lv <= 2374 then return "Sweet Thief",1,"ChocQuest2","Sweet Thief",CFrame.new(150.51,30.69,-12774.50),CFrame.new(165.19,76.06,-12600.84) end
        if lv <= 2399 then return "Candy Rebel",2,"ChocQuest2","Candy Rebel",CFrame.new(150.51,30.69,-12774.50),CFrame.new(134.87,77.25,-12876.55) end
        if lv <= 2424 then return "Candy Pirate",1,"CandyQuest1","Candy Pirate",CFrame.new(-1150.04,20.38,-14446.33),CFrame.new(-1310.50,26.02,-14562.40) end
        if lv <= 2449 then return "Snow Demon",2,"CandyQuest1","Snow Demon",CFrame.new(-1150.04,20.38,-14446.33),CFrame.new(-880.20,71.25,-14538.61) end
        if lv <= 2474 then return "Isle Outlaw",1,"TikiQuest1","Isle Outlaw",CFrame.new(-16547.75,61.14,-173.41),CFrame.new(-16442.81,116.14,-264.46) end
        if lv <= 2524 then return "Island Boy",2,"TikiQuest1","Island Boy",CFrame.new(-16547.75,61.14,-173.41),CFrame.new(-16901.26,84.07,-192.89) end
        if lv <= 2550 then return "Isle Champion",2,"TikiQuest2","Isle Champion",CFrame.new(-16539.08,55.69,1051.57),CFrame.new(-16641.68,235.78,1031.28) end
        if lv <= 2574 then return "Serpent Hunter",1,"TikiQuest3","Serpent Hunter",CFrame.new(-16665.19,104.60,1579.69),CFrame.new(-16521.06,106.09,1488.78) end
        if lv >= 2575 then return "Skull Slayer",2,"TikiQuest3","Skull Slayer",CFrame.new(-16665.19,104.60,1579.69),CFrame.new(-16855.04,122.46,1478.15) end
    end
    return nil
end

-- ========== AUTO FARM CHÍNH ==========
_G.AutoFarm = true
local rs = game:GetService('ReplicatedStorage').Remotes.CommF_

function StartAutoFarm()
    while _G.AutoFarm and task.wait(0.1) do
        pcall(function()
            local mon, lq, nq, nm, cq, cm = CheckQuest()
            if not mon then return end
            
            hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            local questGui = player.PlayerGui.Main.Quest
            local questText = questGui.Visible and questGui.Container.QuestTitle.Title.Text or ""
            
            if not questGui.Visible or not string.find(questText, nm) then
                rs:InvokeServer("AbandonQuest")
                MoveTo(cq)
                task.wait(0.5)
                if (cq.Position - hrp.Position).Magnitude <= 40 then
                    rs:InvokeServer("StartQuest", nq, lq)
                end
                return
            end
            
            local closest = nil
            local closestDist = math.huge
            for _, e in pairs(workspace.Enemies:GetChildren()) do
                if e.Name == mon and e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 and e:FindFirstChild("HumanoidRootPart") then
                    local dist = (e.HumanoidRootPart.Position - hrp.Position).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closest = e
                    end
                end
            end
            
            if closest then
                bringPos = closest.HumanoidRootPart.CFrame * CFrame.new(0, 0, 8)
                MoveTo(closest.HumanoidRootPart.CFrame * CFrame.new(0, 18, 0))
                AutoHaki()
                EquipWeapon()
                BringMob()
                closest.HumanoidRootPart.CanCollide = false
                closest.Humanoid.WalkSpeed = 0
                closest.Humanoid.JumpPower = 0
                game:GetService('VirtualUser'):CaptureController()
                game:GetService('VirtualUser'):Button1Down(Vector2.new(1280, 672))
            else
                MoveTo(cm)
            end
        end)
    end
end

StartAutoFarm()
print("Auto Farm Level + Bring Mob đã khởi động (chỉ bay, không teleport đột ngột)")
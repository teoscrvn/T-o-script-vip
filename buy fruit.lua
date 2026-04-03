-- ========== AUTO FRUIT - téo hub ==========
-- Quét toàn bản đồ nhặt fruit + random fruit khi đủ tiền
-- crack by HoangQuan nhatan

local player = game.Players.LocalPlayer
local rs = game:GetService('ReplicatedStorage').Remotes.CommF_

-- Hàm teleport nhanh
function topos(cf)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = cf
    end
end

-- ========== NHẶT FRUIT (QUÉT TOÀN BẢN ĐỒ) ==========
_G.AutoCollectFruit = true

function CollectFruits()
    for _, obj in pairs(workspace:GetChildren()) do
        if string.find(obj.Name, "Fruit") and obj:FindFirstChild("Handle") then
            local fruitName = obj.Name
            print("Tìm thấy fruit: " .. fruitName)
            topos(obj.Handle.CFrame)
            task.wait(0.3)
            -- Thử nhặt
            for _, item in pairs(player.Character:GetChildren()) do
                if item:IsA("Tool") and string.find(item.Name, "Fruit") then
                    break
                end
            end
        end
    end
end

-- ========== BỎ FRUIT VÀO KHO ==========
_G.AutoStoreFruit = true

function StoreFruits()
    for _, item in pairs(player.Backpack:GetChildren()) do
        if item:IsA("Tool") and string.find(item.Name, "Fruit") then
            local original = item:GetAttribute("OriginalName")
            if original then
                rs:InvokeServer("StoreFruit", original, item)
                print("Đã cất " .. item.Name .. " vào kho")
                task.wait(0.5)
            end
        end
    end
    for _, item in pairs(player.Character:GetChildren()) do
        if item:IsA("Tool") and string.find(item.Name, "Fruit") then
            local original = item:GetAttribute("OriginalName")
            if original then
                rs:InvokeServer("StoreFruit", original, item)
                print("Đã cất " .. item.Name .. " vào kho")
                task.wait(0.5)
            end
        end
    end
end

-- ========== RANDOM FRUIT (CẦN 300K) ==========
_G.AutoRandomFruit = true

function RandomFruits()
    local money = player.Data.Beli.Value
    if money >= 300000 then
        print("Đang random fruit...")
        rs:InvokeServer("Cousin", "Buy")
        task.wait(1)
        -- Sau khi random, nếu ra fruit thì cất vào kho
        StoreFruits()
    end
end

-- ========== VÒNG LẶP CHÍNH ==========
spawn(function()
    print("Auto Fruit đã khởi động - Quét toàn bản đồ nhặt fruit")
    while true do
        task.wait(0.5)
        pcall(function()
            if _G.AutoCollectFruit then CollectFruits() end
            if _G.AutoStoreFruit then StoreFruits() end
            if _G.AutoRandomFruit then RandomFruits() end
        end)
    end
end)
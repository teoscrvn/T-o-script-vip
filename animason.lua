local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeoHubUI"
screenGui.Parent = player.PlayerGui
screenGui.ResetOnSpawn = false

local blackBg = Instance.new("Frame")
blackBg.Size = UDim2.new(1, 0, 1, 0)
blackBg.BackgroundColor3 = Color3.new(0,0,0)
blackBg.BackgroundTransparency = 0.3
blackBg.Parent = screenGui

local chars = {"t", "🍎", "o", " ", "h", "u", "b", " ", "v", "i", "p"}
local labels = {}
local targetPositions = {}
local startX = -280
local step = 60

for i = 1, #chars do
    targetPositions[i] = UDim2.new(0.5, startX + (i-1)*step, 0.5, -45)
end

local directions = {"left", "right", "top", "bottom"}
for i, ch in ipairs(chars) do
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0, 70, 0, 90)
    lbl.BackgroundTransparency = 1
    lbl.Text = ch
    lbl.TextSize = 60
    lbl.Font = Enum.Font.GothamBold
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.TextScaled = true
    lbl.Parent = screenGui
    
    local dir = directions[math.random(1,4)]
    local startPos
    if dir == "left" then
        startPos = UDim2.new(-0.2, 0, 0.5, -45)
    elseif dir == "right" then
        startPos = UDim2.new(1.2, 0, 0.5, -45)
    elseif dir == "top" then
        startPos = UDim2.new(0.5, -35, -0.2, 0)
    else
        startPos = UDim2.new(0.5, -35, 1.2, 0)
    end
    lbl.Position = startPos
    labels[i] = lbl
    
    local tween = game:GetService("TweenService"):Create(lbl, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = targetPositions[i]})
    tween:Play()
    task.wait(0.05)
end

task.wait(1)

for _ = 1, 3 do
    for i, lbl in ipairs(labels) do
        lbl.Position = lbl.Position + UDim2.new(0, math.random(-3,3), 0, math.random(-3,3))
    end
    task.wait(0.05)
    for i, lbl in ipairs(labels) do
        lbl.Position = targetPositions[i]
    end
    task.wait(0.05)
end

local finalTitle = Instance.new("TextLabel")
finalTitle.Size = UDim2.new(0, 180, 0, 35)
finalTitle.Position = UDim2.new(0.5, -90, 0.05, 0)
finalTitle.BackgroundTransparency = 1
finalTitle.Text = "téohub vip"
finalTitle.TextSize = 24
finalTitle.Font = Enum.Font.GothamBold
finalTitle.TextScaled = true
finalTitle.TextColor3 = Color3.new(1,1,1)
finalTitle.Visible = false
finalTitle.Parent = screenGui

local titleStroke = Instance.new("UIStroke")
titleStroke.Thickness = 2
titleStroke.Color = Color3.new(1,1,1)
titleStroke.Parent = finalTitle

for i, lbl in ipairs(labels) do
    local targetPos = UDim2.new(0.5, -90 + (i-1)*15, 0.05, 0)
    local targetSize = UDim2.new(0, 24, 0, 24)
    game:GetService("TweenService"):Create(lbl, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = targetPos, Size = targetSize}):Play()
end
task.wait(0.5)
for _, lbl in pairs(labels) do lbl.Visible = false end
finalTitle.Visible = true

local buttonFrame = Instance.new("Frame")
buttonFrame.Size = UDim2.new(0, 160, 0, 35)
buttonFrame.Position = UDim2.new(0.5, -80, 0.14, 0)
buttonFrame.BackgroundTransparency = 1
buttonFrame.Parent = screenGui

local zaloBtn = Instance.new("TextButton")
zaloBtn.Size = UDim2.new(1, 0, 1, 0)
zaloBtn.BackgroundTransparency = 1
zaloBtn.Text = "📱 box zalo téo"
zaloBtn.TextSize = 16
zaloBtn.Font = Enum.Font.GothamBold
zaloBtn.TextColor3 = Color3.new(1,1,1)
zaloBtn.Parent = buttonFrame

local btnStroke = Instance.new("UIStroke")
btnStroke.Thickness = 2
btnStroke.Color = Color3.new(1,1,1)
btnStroke.Parent = buttonFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = buttonFrame

local colors = {
    Color3.fromRGB(255,0,0), Color3.fromRGB(255,127,0), Color3.fromRGB(255,255,0),
    Color3.fromRGB(0,255,0), Color3.fromRGB(0,255,255), Color3.fromRGB(0,0,255),
    Color3.fromRGB(139,0,255)
}
local idx = 1
spawn(function()
    while screenGui.Parent do
        local txtColor = colors[idx]
        local strokeColor = colors[idx % #colors + 1]
        finalTitle.TextColor3 = txtColor
        titleStroke.Color = strokeColor
        zaloBtn.TextColor3 = txtColor
        btnStroke.Color = strokeColor
        idx = idx % #colors + 1
        task.wait(0.3)
    end
end)

zaloBtn.MouseButton1Click:Connect(function()
    setclipboard("https://zalo.me/g/nvmyhr001")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "téohub",
        Text = "Đã copy link Zalo!",
        Duration = 2
    })
end)

task.wait(1)
blackBg:Destroy()
local Players = game:GetService("Players")  
local RunService = game:GetService("RunService")  
local UserInputService = game:GetService("UserInputService")  
local SoundService = game:GetService("SoundService")  
local StarterGui = game:GetService("StarterGui")  
local HttpService = game:GetService("HttpService")  
  
local LocalPlayer = Players.LocalPlayer  
  
-- Sound Effects  
local function playSound(soundId)  
    local sound = Instance.new("Sound")  
    sound.SoundId = "rbxassetid://" .. soundId  
    sound.Parent = SoundService  
    sound:Play()  
    sound.Ended:Connect(function()  
        sound:Destroy()  
    end)  
end  
  
-- Play initial sound  
playSound("2865227271")  
  
-- GUI Creation  
local ScreenGui = Instance.new("ScreenGui")  
ScreenGui.Name = "SuperRingPartsGUI"  
ScreenGui.ResetOnSpawn = false  
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")  
  
local MainFrame = Instance.new("Frame")  
MainFrame.Size = UDim2.new(0, 300, 0, 500)  
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -250)  
MainFrame.BorderSizePixel = 0  
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)  
MainFrame.Parent = ScreenGui  
  
local UICorner = Instance.new("UICorner")  
UICorner.CornerRadius = UDim.new(0, 20)  
UICorner.Parent = MainFrame  
  
-- 🔘 FLOATING SHOW/HIDE BUTTON
local ToggleGuiButton = Instance.new("TextButton")
ToggleGuiButton.Size = UDim2.new(0, 50, 0, 50)
ToggleGuiButton.Position = UDim2.new(0, 10, 0.5, -25)
ToggleGuiButton.Text = "≡"
ToggleGuiButton.BackgroundColor3 = Color3.fromRGB(0, 204, 204)
ToggleGuiButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ToggleGuiButton.Font = Enum.Font.Fondamento
ToggleGuiButton.TextSize = 24
ToggleGuiButton.Parent = ScreenGui

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(1, 0)
BtnCorner.Parent = ToggleGuiButton

-- Dragging support
local dragging = false
local dragStart, startPos

ToggleGuiButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = ToggleGuiButton.Position
    end
end)

ToggleGuiButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        ToggleGuiButton.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Toggle visibility
local guiVisible = true
ToggleGuiButton.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    MainFrame.Visible = guiVisible
    playSound("12221967")
end)

local Title = Instance.new("TextLabel")  
Title.Size = UDim2.new(1, 0, 0, 40)  
Title.Position = UDim2.new(0, 0, 0, 0)  
Title.Text = "Super Ring Parts (Beta)"  
Title.TextColor3 = Color3.fromRGB(255, 255, 255)  
Title.BackgroundColor3 = Color3.fromRGB(0, 204, 204)  
Title.Font = Enum.Font.Fondamento  
Title.TextSize = 22  
Title.Parent = MainFrame  
  
local TitleCorner = Instance.new("UICorner")  
TitleCorner.CornerRadius = UDim.new(0, 20)  
TitleCorner.Parent = Title  
  
local ToggleButton = Instance.new("TextButton")  
ToggleButton.Size = UDim2.new(0.8, 0, 0, 40)  
ToggleButton.Position = UDim2.new(0.1, 0, 0.1, 0)  
ToggleButton.Text = "Ring Off"  
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  
ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)  
ToggleButton.Font = Enum.Font.Fondamento  
ToggleButton.TextSize = 18  
ToggleButton.Parent = MainFrame  
  
local ToggleCorner = Instance.new("UICorner")  
ToggleCorner.CornerRadius = UDim.new(0, 10)  
ToggleCorner.Parent = ToggleButton  
  
-- Config  
local config = {  
    radius = 50,  
    height = 100,  
    rotationSpeed = 10,  
    attractionStrength = 1000,  
}  
  
-- Save / Load  
local function saveConfig()  
    writefile("SuperRingPartsConfig.txt", HttpService:JSONEncode(config))  
end  
  
local function loadConfig()  
    if isfile("SuperRingPartsConfig.txt") then  
        config = HttpService:JSONDecode(readfile("SuperRingPartsConfig.txt"))  
    end  
end  
  
loadConfig()  
  
-- Controls  
local function createControl(name, positionY, color, labelText, defaultValue, callback)  
    local DecreaseButton = Instance.new("TextButton")  
    DecreaseButton.Size = UDim2.new(0.2, 0, 0, 40)  
    DecreaseButton.Position = UDim2.new(0.1, 0, positionY, 0)  
    DecreaseButton.Text = "-"  
    DecreaseButton.BackgroundColor3 = color  
    DecreaseButton.Parent = MainFrame  
  
    local IncreaseButton = Instance.new("TextButton")  
    IncreaseButton.Size = UDim2.new(0.2, 0, 0, 40)  
    IncreaseButton.Position = UDim2.new(0.7, 0, positionY, 0)  
    IncreaseButton.Text = "+"  
    IncreaseButton.BackgroundColor3 = color  
    IncreaseButton.Parent = MainFrame  
  
    local Display = Instance.new("TextLabel")  
    Display.Size = UDim2.new(0.4, 0, 0, 40)  
    Display.Position = UDim2.new(0.3, 0, positionY, 0)  
    Display.Text = labelText .. ": " .. defaultValue  
    Display.BackgroundColor3 = Color3.fromRGB(255, 153, 51)  
    Display.TextColor3 = Color3.fromRGB(0, 0, 0)  
    Display.Parent = MainFrame  
  
    DecreaseButton.MouseButton1Click:Connect(function()  
        local value = tonumber(Display.Text:match("%d+"))  
        value = math.max(0, value - 10)  
        Display.Text = labelText .. ": " .. value  
        callback(value)  
        playSound("12221967")  
        saveConfig()  
    end)  
  
    IncreaseButton.MouseButton1Click:Connect(function()  
        local value = tonumber(Display.Text:match("%d+"))  
        value = math.min(10000, value + 10)  
        Display.Text = labelText .. ": " .. value  
        callback(value)  
        playSound("12221967")  
        saveConfig()  
    end)  
end  
  
createControl("Radius", 0.2, Color3.fromRGB(153,153,0), "Radius", config.radius, function(v) config.radius=v end)  
createControl("Height", 0.4, Color3.fromRGB(153,0,153), "Height", config.height, function(v) config.height=v end)  
createControl("RotationSpeed", 0.6, Color3.fromRGB(0,153,153), "Rotation Speed", config.rotationSpeed, function(v) config.rotationSpeed=v end)  
createControl("AttractionStrength", 0.8, Color3.fromRGB(153,0,0), "Attraction Strength", config.attractionStrength, function(v) config.attractionStrength=v end)  
  
-- Toggle  
local ringPartsEnabled = false  
  
ToggleButton.MouseButton1Click:Connect(function()  
    ringPartsEnabled = not ringPartsEnabled  
    ToggleButton.Text = ringPartsEnabled and "Tornado On" or "Tornado Off"  
    ToggleButton.BackgroundColor3 = ringPartsEnabled and Color3.fromRGB(50,205,50) or Color3.fromRGB(160,82,45)  
    playSound("12221967")  
end)  
  
-- Notification  
StarterGui:SetCore("SendNotification", {  
    Title = "Credits",  
    Text = "Previously By Lukas",  
    Duration = 5  
})
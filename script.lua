-- SHIFTLOCK DELTA ULTRA GÜVENLİ VERSİYON (F1 ile aç/kapat + mini UI)
local uis = game:GetService("UserInputService")
local run = game:GetService("RunService")
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

-- UI oluşturma
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "ShiftLockStatusUI"
screenGui.ResetOnSpawn = false

local textLabel = Instance.new("TextLabel", screenGui)
textLabel.Size = UDim2.new(0, 100, 0, 15)
textLabel.Position = UDim2.new(1, -105, 0, 5)
textLabel.BackgroundTransparency = 0.6
textLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
textLabel.BorderSizePixel = 0
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.TextScaled = true
textLabel.Font = Enum.Font.GothamSemibold
textLabel.Text = "ShiftLock: KAPALI"
textLabel.ZIndex = 10

local shiftlock = false

local function lockCam()
    run:BindToRenderStep("ShiftLockSafe", Enum.RenderPriority.Camera.Value + 1, function()
        if player.Character and player.Character:FindFirstChild("Head") then
            camera.CFrame = CFrame.new(camera.CFrame.Position, player.Character.Head.Position)
        end
    end)
    textLabel.Text = "ShiftLock: AÇIK"
end

local function unlockCam()
    run:UnbindFromRenderStep("ShiftLockSafe")
    textLabel.Text = "ShiftLock: KAPALI"
end

uis.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F1 then
        shiftlock = not shiftlock
        if shiftlock then
            lockCam()
        else
            unlockCam()
        end
    end
end)

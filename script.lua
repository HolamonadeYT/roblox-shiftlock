local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local runService = game:GetService("RunService")

local shiftLocked = false
local originalOffset = Vector3.new(2, 0, 0) -- Kamera karakterin sağına kayar
local connection = nil

function enableShiftLock()
    shiftLocked = true
    connection = runService.RenderStepped:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local root = player.Character.HumanoidRootPart
            local camCF = CFrame.new(root.Position) * CFrame.Angles(0, math.rad(180), 0)
            camCF = camCF + camCF.RightVector * originalOffset.X
            camera.CFrame = camCF
        end
    end)
    print("🔒 ShiftLock: AÇIK")
end

function disableShiftLock()
    shiftLocked = false
    if connection then connection:Disconnect() end
    camera.CameraType = Enum.CameraType.Custom
    print("🔓 ShiftLock: KAPALI")
end

UIS.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.F1 then
        if shiftLocked then
            disableShiftLock()
        else
            enableShiftLock()
        end
    end
end)

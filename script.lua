local uis = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

local shiftLockEnabled = false

local function enableShiftLock()
    camera.CameraType = Enum.CameraType.Custom
    player.CameraMode = Enum.CameraMode.LockFirstPerson
end

local function disableShiftLock()
    player.CameraMode = Enum.CameraMode.Classic
end

uis.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.F1 then
        shiftLockEnabled = not shiftLockEnabled
        if shiftLockEnabled then
            enableShiftLock()
            print("🔒 ShiftLock Açıldı")
        else
            disableShiftLock()
            print("🔓 ShiftLock Kapatıldı")
        end
    end
end)

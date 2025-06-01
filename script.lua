local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local shiftLocked = false
local cameraOffset = Vector3.new(2, 0, 0) -- Kamera karakterin sağına kayar
local connection = nil

-- Crosshair GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "ShiftLockGUI"
local dot = Instance.new("ImageLabel", gui)
dot.Image = "rbxassetid://11463142652" -- Nişangah görseli (senin gibi)
dot.Size = UDim2.new(0, 32, 0, 32)
dot.Position = UDim2.new(0.5, -16, 0.5, -16)
dot.BackgroundTransparency = 1
dot.Visible = false

function enableShiftLock()
	shiftLocked = true
	dot.Visible = true
	camera.CameraType = Enum.CameraType.Scriptable

	connection = RunService.RenderStepped:Connect(function()
		local char = player.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			local root = char.HumanoidRootPart
			local rootCF = root.CFrame
			local camCF = CFrame.new(root.Position) * CFrame.Angles(0, math.rad(180), 0)
			camCF = camCF + camCF.RightVector * cameraOffset.X
			camera.CFrame = camCF
		end
	end)
end

function disableShiftLock()
	shiftLocked = false
	dot.Visible = false
	if connection then connection:Disconnect() end
	camera.CameraType = Enum.CameraType.Custom
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


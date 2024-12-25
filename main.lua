-- Services
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager") -- For simulating inputs

-- Variables
local isHoldingW = false
local dragging = false
local dragStart = nil
local startPos = nil

-- Create UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
local ToggleButton = Instance.new("TextButton", Frame)

-- Frame properties
Frame.Size = UDim2.new(0, 200, 0, 50)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Active = true
Frame.Draggable = false -- We'll implement custom dragging below

-- ToggleButton properties
ToggleButton.Size = UDim2.new(1, 0, 1, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Text = "Start Holding W"

-- Enable dragging for the frame
Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
    end
end)

Frame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

Frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Toggle holding W
ToggleButton.MouseButton1Click:Connect(function()
    isHoldingW = not isHoldingW
    ToggleButton.Text = isHoldingW and "Stop Holding W" or "Start Holding W"
end)

-- Simulate holding W
RunService.RenderStepped:Connect(function()
    if isHoldingW then
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, nil)
    else
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.W, false, nil)
    end
end)

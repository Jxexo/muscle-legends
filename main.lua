-- Initialize variables
local isHoldingW = false
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Create the GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local dragging, dragStart, startPos

-- Setup ScreenGui
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "HoldWGui"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.Size = UDim2.new(0, 150, 0, 50)
UICorner.Parent = Frame

-- Setup ToggleButton
ToggleButton.Parent = Frame
ToggleButton.Text = "Toggle Hold W"
ToggleButton.Size = UDim2.new(1, 0, 1, 0)
ToggleButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
UICorner:Clone().Parent = ToggleButton

-- Dragging functionality
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

-- Toggle W holding
ToggleButton.MouseButton1Click:Connect(function()
    isHoldingW = not isHoldingW
    ToggleButton.Text = isHoldingW and "Stop Holding W" or "Start Holding W"
end)

-- Simulate W key press
RunService.RenderStepped:Connect(function()
    if isHoldingW then
        local input = {
            KeyCode = Enum.KeyCode.W,
            UserInputState = Enum.UserInputState.Begin,
            UserInputType = Enum.UserInputType.Keyboard,
        }
        UIS.InputBegan:Fire(input)
    end
end)

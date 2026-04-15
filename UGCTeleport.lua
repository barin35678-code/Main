local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local checkpointsFolder = workspace:FindFirstChild("Checkpoints", true)

if not checkpointsFolder then return end

local checkpoints = {}
for _, v in ipairs(checkpointsFolder:GetChildren()) do
    if v:IsA("BasePart") then
        local num = tonumber(v.Name:match("%d+"))
        if num then table.insert(checkpoints, {part = v, num = num}) end
    end
end

table.sort(checkpoints, function(a, b) return a.num < b.num end)

local function setCanTouch(state)
    for _, v in ipairs(char:GetChildren()) do
        if v:IsA("BasePart") then v.CanTouch = state end
    end
end

for _, cp in ipairs(checkpoints) do
    if cp.num <= _G.CheckpointNumber then continue end

    local dist = (cp.part.Position - hrp.Position).Magnitude
    local duration = math.clamp(dist / 200, 0.1, 3)

    setCanTouch(false)

    local tween = TweenService:Create(
        hrp,
        TweenInfo.new(duration, Enum.EasingStyle.Linear),
        {CFrame = cp.part.CFrame * CFrame.new(0, 3, 0)}
    )

    tween:Play()
    tween.Completed:Wait()

    setCanTouch(true)
    _G.CheckpointNumber = cp.num
    task.wait(_G.WaitTime)
end

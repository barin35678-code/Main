local _v1 = game:GetService("TweenService")
local _v2 = game.Players.LocalPlayer
local _v3 = _v2.Character or _v2.CharacterAdded:Wait()
local _v4 = _v3:WaitForChild("HumanoidRootPart")
local _v5 = workspace:FindFirstChild("Checkpoints", true)

if not _v5 then return end

local _v6 = {}
for _, v in ipairs(_v5:GetChildren()) do
    if v:IsA("BasePart") then table.insert(_v6, v) end
end

table.sort(_v6, function(a, b)
    local _n1 = tonumber(a.Name:match("%d+")) or 0
    local _n2 = tonumber(b.Name:match("%d+")) or 0
    return _n1 < _n2
end)

local function _v7(_s1)
    for _, v in ipairs(_v3:GetChildren()) do
        if v:IsA("BasePart") then v.CanTouch = _s1 end
    end
end

for _, _v8 in ipairs(_v6) do
    local _v9 = tonumber(_v8.Name:match("%d+"))
    if _v9 and _v9 > _G.CheckpointNumber then
        
        local _dist = (_v8.Position - _v4.Position).Magnitude
        local _speed = _G.TweenSpeed
        
        if _dist > 150 then 
            _speed = 10 
        elseif _dist > 50 then
            _speed = 2
        end

        _v7(false)
        local _v10 = _v1:Create(_v4, 
            TweenInfo.new(_speed, Enum.EasingStyle.Linear), 
            {CFrame = _v8.CFrame * CFrame.new(0, 3, 0)}
        )
        _v10:Play()
        _v10.Completed:Wait()
        _v7(true)
        task.wait(_G.WaitTime)
        _G.CheckpointNumber = _v9
    end
end

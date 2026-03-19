-- CONFIG
local SPEED = SPEED or nil

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

getgenv().ORIGINAL_STATS = getgenv().ORIGINAL_STATS or {}

local function setup(char)
    local hum = char:WaitForChild("Humanoid")

    -- Guardar original una sola vez
    if not getgenv().ORIGINAL_STATS.speed then
        getgenv().ORIGINAL_STATS.speed = hum.WalkSpeed
    end

    local original = getgenv().ORIGINAL_STATS.speed

    task.spawn(function()
        while hum and hum.Parent do
            if SPEED and SPEED ~= original then
                hum.WalkSpeed = SPEED
            else
                hum.WalkSpeed = original
            end
            task.wait()
        end
    end)
end

if lp.Character then setup(lp.Character) end
lp.CharacterAdded:Connect(setup)

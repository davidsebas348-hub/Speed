-- FORCE SPEED FIX REAL

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

getgenv().ORIGINAL_SPEED = getgenv().ORIGINAL_SPEED or nil

local function setup(char)
    local hum = char:WaitForChild("Humanoid")

    -- Guardar original una vez
    if not getgenv().ORIGINAL_SPEED then
        getgenv().ORIGINAL_SPEED = hum.WalkSpeed
    end

    local original = getgenv().ORIGINAL_SPEED

    task.spawn(function()
        while hum and hum.Parent do
            -- 🔥 IMPORTANTE: usar _G / getgenv()
            local target = getgenv().SPEED

            if target and target ~= original then
                hum.WalkSpeed = target
            else
                hum.WalkSpeed = original
            end

            task.wait()
        end
    end)
end

if lp.Character then setup(lp.Character) end
lp.CharacterAdded:Connect(setup)

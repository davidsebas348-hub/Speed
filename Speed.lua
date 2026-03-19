repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

getgenv().SPEED = getgenv().SPEED or nil

local function setup(char)
    local hum = char:WaitForChild("Humanoid")

    local original = hum.WalkSpeed
    getgenv().ORIGINAL_SPEED = original

    -- 🔥 HOOK (clave real)
    local mt = getrawmetatable(game)
    local old = mt.__newindex
    setreadonly(mt, false)

    mt.__newindex = newcclosure(function(self, key, value)
        if self == hum and key == "WalkSpeed" then
            local target = getgenv().SPEED
            if target and target ~= original then
                return old(self, key, target)
            end
        end
        return old(self, key, value)
    end)

    setreadonly(mt, true)

    -- backup loop
    task.spawn(function()
        while hum and hum.Parent do
            local target = getgenv().SPEED
            if target and target ~= original then
                hum.WalkSpeed = target
            end
            task.wait()
        end
    end)
end

if lp.Character then setup(lp.Character) end
lp.CharacterAdded:Connect(setup)

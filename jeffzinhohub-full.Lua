--[[
Jeffzinho Hub Supreme V2
Feito por IsStar
100% gratuito, sem key system
Suporte a Português e Inglês
Compatível com PC e Celular
]]

l
ocal Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera

-- idioma
local Language = "Português" -- trocar para "English" se quiser mudar o padrão

local Text = {
    ["Hub_Title"] = {
        ["Português"] = "Jeffzinho Hub Supreme V2",
        ["English"] = "Jeffzinho Hub Supreme V2"
    },
    ["Credits"] = {
        ["Português"] = "Feito por IsStar",
        ["English"] = "Made by IsStar"
    },
    ["AutoFarm"] = {
        ["Português"] = "Ativar Auto Farm",
        ["English"] = "Enable Auto Farm"
    },
    ["AutoRaid"] = {
        ["Português"] = "Auto Raids",
        ["English"] = "Auto Raids"
    },
    ["AutoBoss"] = {
        ["Português"] = "Auto Derrotar Bosses",
        ["English"] = "Auto Kill Bosses"
    },
    ["FPSBoost"] = {
        ["Português"] = "Ativar FPS Boost",
        ["English"] = "Enable FPS Boost"
    },
    ["ChangeLang"] = {
        ["Português"] = "Mudar idioma",
        ["English"] = "Change language"
    }
}

local function GetText(id)
    return Text[id] and Text[id][Language] or id
end

-- UI Library (Kavo UI por simplicidade)
loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib(GetText("Hub_Title"), "DarkTheme")

local mainTab = Window:NewTab("Main")
local mainSection = mainTab:NewSection("Farm")

mainSection:NewToggle(GetText("AutoFarm"), "", function(state)
    _G.AutoFarm = state
    while _G.AutoFarm do
        pcall(function()
            local enemies = workspace.Enemies:GetChildren()
            for _, enemy in pairs(enemies) do
                if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                    local hrp = enemy:FindFirstChild("HumanoidRootPart")
                    local char = Player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") and hrp then
                        char.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 2, 0)
                        VirtualUser:Button1Down(Vector2.new(0,0), Camera.CFrame)
                        wait(0.2)
                        VirtualUser:Button1Up(Vector2.new(0,0), Camera.CFrame)
                    end
                end
            end
        end)
        wait(0.5)
    end
end)

mainSection:NewToggle(GetText("AutoBoss"), "", function(state)
    _G.AutoBoss = state
    while _G.AutoBoss do
        pcall(function()
            local bosses = workspace.Enemies:GetChildren()
            for _, boss in pairs(bosses) do
                if boss.Name:match("Boss") and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                    local hrp = boss:FindFirstChild("HumanoidRootPart")
                    local char = Player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") and hrp then
                        char.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 2, 0)
                        VirtualUser:Button1Down(Vector2.new(0,0), Camera.CFrame)
                        wait(0.2)
                        VirtualUser:Button1Up(Vector2.new(0,0), Camera.CFrame)
                    end
                end
            end
        end)
        wait(0.5)
    end
end)

local raidsTab = Window:NewTab("Raids")
local raidsSection = raidsTab:NewSection("Sistema de Raids")

raidsSection:NewButton(GetText("AutoRaid"), "", function()
    -- Código de auto raid pode ser integrado aqui futuramente
    print("Auto Raid ativado!")
end)

local miscTab = Window:NewTab("Misc")
local miscSection = miscTab:NewSection("Utilitários")

miscSection:NewButton(GetText("FPSBoost"), "", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") and v.Transparency < 1 then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") then
            v:Destroy()
        end
    end
    sethiddenproperty(game:GetService("Lighting"), "Technology", Enum.Technology.Compatibility)
    game:GetService("Lighting").FogEnd = 9e9
end)

local configTab = Window:NewTab("Config")
local configSection = configTab:NewSection("Idioma")

configSection:NewButton(GetText("ChangeLang"), "", function()
    Language = (Language == "Português") and "English" or "Português"
    Library:Notify("Idioma trocado para " .. Language, 5)
end)

local creditTab = Window:NewTab("Créditos")
creditTab:NewSection(GetText("Credits"))

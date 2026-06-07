AddCSLuaFile("bonnish/core/cl_menu.lua")
AddCSLuaFile("bonnish/core/menu.lua")

BonnishBase = BonnishBase or {}

function BonnishBase.HasPermission(ply)
    if not IsValid(ply) then return false end
    if ply:IsSuperAdmin() then return true end
    
    if BonnishBase.ServerConfig and BonnishBase.ServerConfig.AllowedRanks then
        local rank = ply:GetUserGroup()
        for _, allowed in ipairs(BonnishBase.ServerConfig.AllowedRanks) do
            if string.lower(rank) == string.lower(allowed) then
                return true
            end
        end
    end
    
    return false
end

if SERVER then
    resource.AddFile("resource/fonts/Outfit-Regular.ttf")
    resource.AddFile("resource/fonts/Outfit-Medium.ttf")
    resource.AddFile("resource/fonts/Outfit-SemiBold.ttf")
    
    AddCSLuaFile("bonnish/core/sh_language.lua")
    AddCSLuaFile("bonnish/core/cl_menu.lua")

    include("bonnish/core/sh_language.lua")
    include("bonnish/core/sv_registry.lua")
    include("bonnish/core/sv_config.lua")
    include("bonnish/core/sv_database.lua")
    include("bonnish/core/sv_net.lua")
end

if CLIENT then
    surface.CreateFont("BonnishFont_Large", {
        font = "Outfit",
        size = 80,
        weight = 600,
        antialias = true,
        extended = true
    })
    surface.CreateFont("BonnishFont_Medium", {
        font = "Outfit",
        size = 40,
        weight = 500,
        antialias = true,
        extended = true
    })

    include("bonnish/core/sh_language.lua")
    include("bonnish/core/cl_menu.lua")
    include("bonnish/core/menu.lua")
end
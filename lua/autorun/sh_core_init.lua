AddCSLuaFile("bonnish/core/cl_menu.lua")

if SERVER then
    include("bonnish/core/sv_registry.lua")
    include("bonnish/core/sv_config.lua")
    include("bonnish/core/sv_net.lua")
end

if CLIENT then
    include("bonnish/core/cl_menu.lua")
    include("bonnish/core/menu.lua")
end
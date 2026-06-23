BonnishBase = BonnishBase or {}
BonnishBase.Addons = BonnishBase.Addons or {}

BonnishBase.KnownAddons = BonnishBase.KnownAddons or {
    ["no_target"] = {
        name     = "No Target System",
        version  = "1.2",
        workshop = 'https://github.com/Bonnish/NoTarget-System',
        settings = {
            { type = "job_list", id = "allowed_jobs", name = "Allowed Jobs (DarkRP)" },
            { type = "boolean", id = "allow_self", name = "Allow Self No Target", default = true },
            { type = "boolean", id = "allow_others", name = "Allow Target Others", default = false },
            { type = "string", id = "command", name = "Chat Command", default = "!notarget" }
        }
    },
    ["job_spawns"] = {
        name     = "Custom Spawn Point Editor",
        version  = "1.0",
        workshop = "https://github.com/Bonnish",
        settings = {
            { type = "boolean", id = "enable_spawns", name = "Enable Spawn System", default = true }
        }
    }
}

local function PrintConsole(msg, col)
    MsgC(Color(147, 51, 234), "[Bonnish Core] ", col or Color(255, 255, 255), msg, "\n")
end

function BonnishBase.RegisterAddon(data)
    local known = BonnishBase.KnownAddons[data.id]
    local status = "unknown"

    if known then
        if data.version == known.version then
            status = "installed"
        else
            status = "outdated"
        end
    end

    data.status = status
    BonnishBase.Addons[data.id] = data
end

function BonnishBase.GetMissingAddons()
    local missing = {}
    for id, known in pairs(BonnishBase.KnownAddons) do
        if not BonnishBase.Addons[id] then
            missing[id] = {
                name      = known.name,
                version   = known.version,
                workshop  = known.workshop,
                settings  = known.settings,
                status    = "missing"
            }
        end
    end
    return missing
end

hook.Add("Initialize", "BonnishBase_ConsoleSummary", function()
    MsgC(Color(147, 51, 234), "\n========================================\n")
    MsgC(Color(147, 51, 234), "          BONNISH UTILITIES CORE        \n")
    MsgC(Color(147, 51, 234), "========================================\n")
    
    local c_installed = 0
    local c_outdated = 0
    local c_missing = 0

    for id, known in pairs(BonnishBase.KnownAddons) do
        local addon = BonnishBase.Addons[id]
        if addon then
            if addon.status == "installed" then
                MsgC(Color(147, 51, 234), "[Bonnish] ", Color(16, 185, 129), "✓ " .. addon.name .. " [v" .. addon.version .. "] - Installed\n")
                c_installed = c_installed + 1
            elseif addon.status == "outdated" then
                MsgC(Color(147, 51, 234), "[Bonnish] ", Color(245, 158, 11), "⚠ " .. addon.name .. " [v" .. addon.version .. " -> v" .. known.version .. "] - Update Available\n")
                c_outdated = c_outdated + 1
            else
                MsgC(Color(147, 51, 234), "[Bonnish] ", Color(148, 163, 184), "? " .. addon.name .. " [v" .. addon.version .. "] - Unknown\n")
            end
        else
            MsgC(Color(147, 51, 234), "[Bonnish] ", Color(239, 68, 68), "✖ " .. known.name .. " [v" .. known.version .. "] - Not Installed\n")
            c_missing = c_missing + 1
        end
    end

    for id, addon in pairs(BonnishBase.Addons) do
        if not BonnishBase.KnownAddons[id] then
            MsgC(Color(147, 51, 234), "[Bonnish] ", Color(148, 163, 184), "? " .. addon.name .. " [v" .. addon.version .. "] - Unregistered Addon\n")
        end
    end
    
    MsgC(Color(147, 51, 234), "----------------------------------------\n")
    
    local total = c_installed + c_outdated + c_missing
    if c_missing == 0 and c_outdated == 0 then
        MsgC(Color(147, 51, 234), "[Bonnish] ", Color(16, 185, 129), "★ All " .. total .. " modules loaded successfully.\n")
    else
        MsgC(Color(147, 51, 234), "[Bonnish] ", Color(245, 158, 11), "⚠ Status: " .. c_installed .. " Installed | " .. c_outdated .. " Outdated | " .. c_missing .. " Missing\n")
    end
    MsgC(Color(147, 51, 234), "========================================\n\n")
end)
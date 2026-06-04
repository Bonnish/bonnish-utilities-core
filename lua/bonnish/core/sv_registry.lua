BonnishBase = BonnishBase or {}
BonnishBase.Addons = BonnishBase.Addons or {}

BonnishBase.KnownAddons = BonnishBase.KnownAddons or {
    ["no_target"] = {
        name     = "No Target System",
        version  = "1.0",
        workshop = 'https://github.com/Bonnish/NoTarget-System',
        settings = {
            { type = "job_list", id = "allowed_jobs", name = "Jobs (DarkRP)" },
            { type = "boolean", id = "allow_self", name = "Permitir ponerse No Target a sí mismo", default = true },
            { type = "boolean", id = "allow_others", name = "Permitir dar No Target a otros", default = false },
            { type = "string", id = "command", name = "Comando de chat", default = "!notarget" }
        }
    },
    ["job_spawns"] = {
        name     = "Job Spawn System",
        version  = "1.0",
        workshop = "https://github.com/Bonnish",
        settings = {
            { type = "boolean", id = "enable_spawns", name = "Habilitar Sistema de Spawns", default = true }
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

    local col = Color(255, 255, 255)
    local statusText = ""
    if status == "installed" then
        col = Color(16, 185, 129)
        statusText = "✓ Instalado"
    elseif status == "outdated" then
        col = Color(245, 158, 11)
        statusText = "⚠ Desactualizado"
    else
        col = Color(148, 163, 184)
        statusText = "? Desconocido"
    end
    
    PrintConsole("Módulo cargado: " .. data.name .. " [v" .. data.version .. "] -> " .. statusText, col)
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
    local missing = BonnishBase.GetMissingAddons()
    local c = 0
    for id, data in pairs(missing) do
        MsgC(Color(147, 51, 234), "[Bonnish Core] ", Color(239, 68, 68), "✖ Módulo no instalado: " .. data.name, "\n")
        c = c + 1
    end
    
    if c == 0 then
        MsgC(Color(147, 51, 234), "[Bonnish Core] ", Color(16, 185, 129), "★ Todos los módulos requeridos están cargados correctamente.\n")
    else
        MsgC(Color(147, 51, 234), "[Bonnish Core] ", Color(245, 158, 11), "⚠ Faltan " .. c .. " módulos por instalar. Revisa tu consola.\n")
    end
    MsgC(Color(147, 51, 234), "========================================\n")
end)
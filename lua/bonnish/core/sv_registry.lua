BonnishBase = BonnishBase or {}
BonnishBase.Addons = BonnishBase.Addons or {}

BonnishBase.KnownAddons = BonnishBase.KnownAddons or {
    ["no_target"] = {
        name     = "No Target System",
        version  = "1.0",
        workshop = 'https://github.com/Bonnish/NoTarget-System',
        settings = {
            { type = "string_list", id = "allowed_jobs", name = "Jobs (DarkRP)" },
            { type = "boolean", id = "allow_self", name = "Permitir ponerse No Target a sí mismo", default = true },
            { type = "boolean", id = "allow_others", name = "Permitir dar No Target a otros", default = false },
            { type = "string", id = "command", name = "Comando de chat", default = "!notarget" }
        }
    }
}

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
    print("[BonnishBase] Addon registrado: " .. data.name .. " | Estado: " .. status)
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
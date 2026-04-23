BonnishBase.Config = BonnishBase.Config or {}

function BonnishBase.LoadConfig()
    if file.Exists("bonnish/config.json", "DATA") then
        local raw = file.Read("bonnish/config.json", "DATA")
        BonnishBase.Config = util.JSONToTable(raw) or {}
    else
        BonnishBase.Config = {}
    end
end

function BonnishBase.SaveConfig()
    file.CreateDir("bonnish")
    local raw = util.TableToJSON(BonnishBase.Config)
    file.Write("bonnish/config.json", raw)
end

function BonnishBase.GetConfig(id)
    return BonnishBase.Config[id] or {}
end

BonnishBase.LoadConfig()
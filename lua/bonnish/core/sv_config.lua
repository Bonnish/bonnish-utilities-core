BonnishBase.Config = BonnishBase.Config or {}

function BonnishBase.LoadConfig()
    if file.Exists("bonnish/config.json", "DATA") then
        local raw = file.Read("bonnish/config.json", "DATA")
        BonnishBase.Config = util.JSONToTable(raw) or {}
    else
        BonnishBase.Config = {}
    end

    local cfg = BonnishBase.ServerConfig and BonnishBase.ServerConfig.Database
    if cfg and cfg.Enabled and BonnishBase.DB then
        local queryStr = "CREATE TABLE IF NOT EXISTS bonnish_settings (id VARCHAR(50) PRIMARY KEY, data TEXT);"
        BonnishBase.Query(queryStr, function()
            BonnishBase.Query("SELECT * FROM bonnish_settings", function(res)
                if res then
                    for _, row in ipairs(res) do
                        BonnishBase.Config[row.id] = util.JSONToTable(row.data)
                    end
                    MsgC(Color(147, 51, 234), "[Bonnish Core] ", Color(16, 185, 129), "Dashboard configuration loaded from MySQL.\n")
                end
            end)
        end)
    end
end

function BonnishBase.SaveConfig()
    file.CreateDir("bonnish")
    local raw = util.TableToJSON(BonnishBase.Config)
    file.Write("bonnish/config.json", raw)

    local cfg = BonnishBase.ServerConfig and BonnishBase.ServerConfig.Database
    if cfg and cfg.Enabled and BonnishBase.DB then
        local queryStr = "CREATE TABLE IF NOT EXISTS bonnish_settings (id VARCHAR(50) PRIMARY KEY, data TEXT);"
        BonnishBase.Query(queryStr, function()
            for id, data in pairs(BonnishBase.Config) do
                local safeId = BonnishBase.Escape(id)
                local safeData = BonnishBase.Escape(util.TableToJSON(data))
                local q = "REPLACE INTO bonnish_settings (id, data) VALUES ('" .. safeId .. "', '" .. safeData .. "')"
                BonnishBase.Query(q)
            end
            MsgC(Color(147, 51, 234), "[Bonnish Core] ", Color(16, 185, 129), "Dashboard configuration synced to MySQL.\n")
        end)
    end
end

function BonnishBase.GetConfig(id)
    return BonnishBase.Config[id] or {}
end

BonnishBase.LoadConfig()

hook.Add("BonnishBase_DatabaseConnected", "BonnishBase_LoadConfigSQL", function()
    BonnishBase.LoadConfig()
end)
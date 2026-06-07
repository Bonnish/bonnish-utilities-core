BonnishBase = BonnishBase or {}
BonnishBase.DB = BonnishBase.DB or nil

local function PrintConsole(msg, col)
    MsgC(Color(147, 51, 234), "[Bonnish DB] ", col or Color(255, 255, 255), msg, "\n")
end

local function InitMySQL()
    local cfg = BonnishBase.ServerConfig.Database
    
    if not cfg or not cfg.Enabled then
        PrintConsole("MySQL is Disabled in config. Using local JSON fallback.", Color(148, 163, 184))
        return
    end

    -- Require mysqloo module safely
    local success, err = pcall(require, "mysqloo")
    if not success then
        PrintConsole("ERROR: MySQLOO module not found in lua/bin/!", Color(239, 68, 68))
        PrintConsole("Falling back to local JSON data.", Color(245, 158, 11))
        return
    end

    BonnishBase.DB = mysqloo.connect(cfg.Host, cfg.User, cfg.Password, cfg.DatabaseName, cfg.Port or 3306)

    function BonnishBase.DB:onConnected()
        PrintConsole("Successfully connected to MySQL database: " .. cfg.DatabaseName, Color(16, 185, 129))
        hook.Run("BonnishBase_DatabaseConnected")
    end

    function BonnishBase.DB:onConnectionFailed(errStr)
        PrintConsole("Connection to MySQL failed!", Color(239, 68, 68))
        PrintConsole("Error: " .. errStr, Color(239, 68, 68))
        PrintConsole("Falling back to local JSON data.", Color(245, 158, 11))
        BonnishBase.DB = nil
    end

    BonnishBase.DB:connect()
end

-- Universal Query Function
-- callback(data, lastInsertId)
function BonnishBase.Query(queryStr, callback, errorCallback)
    if not BonnishBase.DB then
        if errorCallback then errorCallback("Database not connected") end
        return
    end

    local q = BonnishBase.DB:query(queryStr)
    
    function q:onSuccess(data)
        if callback then callback(data, q:lastInsert()) end
    end

    function q:onError(err, sql)
        PrintConsole("Query Error: " .. err, Color(239, 68, 68))
        PrintConsole("Query String: " .. sql, Color(245, 158, 11))
        if errorCallback then errorCallback(err) end
    end

    q:start()
end

-- Escape string for safe SQL
function BonnishBase.Escape(str)
    if not BonnishBase.DB then return string.JavascriptSafe(str) end
    return BonnishBase.DB:escape(str)
end

-- Initialize the database connection later when server is ready
hook.Add("Initialize", "BonnishBase_InitDatabase", function()
    InitMySQL()
end)

BonnishBase = BonnishBase or {}
function BonnishBase.OpenMenu()
    if not BonnishBase.HasPermission(LocalPlayer()) then return end

    local frame = vgui.Create("DFrame")
    local sw, sh = ScrW(), ScrH()
    frame:SetSize(sw * 0.65, sh * 0.75)
    frame:Center()
    frame:SetTitle("")
    frame:SetDraggable(true)
    frame:MakePopup()
    frame.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end
    frame:SetKeyboardInputEnabled(true)
    frame.OnKeyCodePressed = function(self, key)
        if key == KEY_ESCAPE then self:Close() end
    end
    frame:ShowCloseButton(false)

    local html = vgui.Create("DHTML", frame)
    html:Dock(FILL)
    html:SetHTML(BonnishBase.MenuHTMLContent)
    html:AddFunction("bonnish", "SaveConfig", function(jsonString)
        net.Start("bonnish_save_config")
            net.WriteString(jsonString)
        net.SendToServer()
    end)

    html:AddFunction("bonnish", "Close", function()
        frame:Close()
    end)

    html:AddFunction("bonnish", "OpenURL", function(url)
        gui.OpenURL(url)
    end)
    
    html:AddFunction("bonnish", "Ready", function()
        net.Start("bonnish_request_config")
        net.SendToServer()
    end)

    BonnishBase.MenuHTML = html
end

local function GetDarkRPJobs()
    local cats = {}
    if DarkRP and DarkRP.getCategories then
        local darkrp_cats = DarkRP.getCategories().jobs
        for _, cat in ipairs(darkrp_cats) do
            local catData = { name = cat.name, color = cat.color, jobs = {} }
            for _, job in ipairs(cat.members) do
                table.insert(catData.jobs, { name = job.name, color = job.color })
            end
            table.insert(cats, catData)
        end
    else
        local catData = { name = "Trabajos", color = Color(0,150,255), jobs = {} }
        for k, v in pairs(RPExtraTeams or {}) do
            table.insert(catData.jobs, { name = v.name, color = v.color or Color(0,150,255) })
        end
        cats = {catData}
    end
    return cats
end

local function GetLangJSON()
    local lang = BonnishBase.ServerConfig and BonnishBase.ServerConfig.Language or "en"
    return util.TableToJSON(BonnishBase.Lang[lang] or BonnishBase.Lang["en"] or {})
end

net.Receive("bonnish_receive_config", function()
    local data = net.ReadTable()
    data.darkrp_jobs = GetDarkRPJobs()
    if IsValid(BonnishBase.MenuHTML) then
        BonnishBase.MenuHTML:Call("setLang(" .. GetLangJSON() .. ")")
        local json = util.TableToJSON(data)
        BonnishBase.MenuHTML:Call("receiveData(" .. json .. ")")
    end
end)

hook.Add("OnPlayerChat", "BonnishBase_ChatCommand", function(ply, text)
    if ply ~= LocalPlayer() then return end
    local lowerText = string.lower(text)
    if lowerText == "!bonnish" or lowerText == "/bonnish" then
        if BonnishBase.HasPermission(ply) then
            BonnishBase.OpenMenu()
        else
            ply:ChatPrint("[Bonnish] You do not have permission to use this command.")
        end
        return true -- Hide from chat
    end
end)

-- Only add the context menu button if it's explicitly enabled or nil (default true)
if BonnishBase.ServerConfig == nil or BonnishBase.ServerConfig.EnableContextMenuButton ~= false then
    list.Set("DesktopWindows", "BonnishUtilities", {
        title = "Bonnish Utils",
        icon = "icon16/application_double.png",
        init = function(icon, window)
            BonnishBase.OpenMenu()
        end
    })
end
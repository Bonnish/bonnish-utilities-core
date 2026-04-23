BonnishBase = BonnishBase or {}
function BonnishBase.OpenMenu()
    if not LocalPlayer():IsAdmin() then return end

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
        local data = util.JSONToTable(jsonString)
        net.Start("bonnish_save_config")
            net.WriteTable(data)
        net.SendToServer()
    end)

    html:AddFunction("bonnish", "Close", function()
        frame:Close()
    end)

    html:AddFunction("bonnish", "OpenURL", function(url)
        gui.OpenURL(url)
    end)

    BonnishBase.MenuHTML = html

    net.Start("bonnish_request_config")
    net.SendToServer()
end

net.Receive("bonnish_receive_config", function()
    local data = net.ReadTable()
    if IsValid(BonnishBase.MenuHTML) then
        local json = util.TableToJSON(data)
        BonnishBase.MenuHTML:Call("receiveData(" .. json .. ")")
    end
end)
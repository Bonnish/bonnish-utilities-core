util.AddNetworkString("bonnish_request_config")
util.AddNetworkString("bonnish_receive_config")
util.AddNetworkString("bonnish_save_config")

net.Receive("bonnish_request_config", function(len, ply)
    if not ply:IsAdmin() then return end

    net.Start("bonnish_receive_config")
        net.WriteTable({
            addons = BonnishBase.Addons,
            config = BonnishBase.Config
        })
    net.Send(ply)
end)

net.Receive("bonnish_save_config", function(len, ply)
    if not ply:IsAdmin() then return end

    local data = net.ReadTable()
    BonnishBase.Config = data
    BonnishBase.SaveConfig()
end)

net.Start("bonnish_receive_config")
    net.WriteTable({
        addons   = BonnishBase.Addons,
        missing  = BonnishBase.GetMissingAddons(),
        config   = BonnishBase.Config
    })
net.Send(ply)
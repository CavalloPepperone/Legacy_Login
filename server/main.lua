local Players = {}
local playerMaxPg

ESX.RegisterServerCallback('legacy:getData', function(source, cb)
    local playerIdentifier = ESX.GetIdentifier(source)
    SetPlayerRoutingBucket(source, source)

    Players[playerIdentifier] = {}


    local response = MySQL.query.await('SELECT * FROM `lg_login` WHERE `identifier` = ?', {
        playerIdentifier
    })

    playerMaxPg = response[1]?.pg or Config.DefaultSlots

    MySQL.query('SELECT * FROM `users`', {}, function(response)
        if response then
            for k, v in pairs(response) do
                if string.find(v.identifier, playerIdentifier) then
                    local account = json.decode(v.accounts)


                    Players[playerIdentifier][#Players[playerIdentifier] + 1] = {
                        skin = v.skin,
                        firstName = v.firstname,
                        lastname = v.lastname,
                        dob = v.dateofbirth,
                        sex = v.sex,
                        group = v.group,
                        job = v.job,
                        disabled = v.disabled,
                        time = v.time or 0,
                        bank = account.bank or 0,
                        money = account.money or 0,
                        slot = v.identifier:match("char(%d+):")
                    }
                end
            end

            cb(Players[playerIdentifier], playerMaxPg)
        end
    end)
end)

ESX.RegisterServerCallback('legacy:applicaSkin', function(source, cb, skin, ide) --rifare
    MySQL.query.await('UPDATE users SET skin = ? WHERE identifier = ?', { json.encode(skin), ide })
    local playerSteam = GetPlayerName(source) or "N/A"

    MySQL.update('UPDATE users SET steam = ? WHERE identifier = ?', {
        playerSteam, ide
    }, function(affectedRows)
    end)
end)

RegisterNetEvent("legacy:selectCharacter", function(id)
    TriggerEvent('esx:onPlayerJoined', source, "char" .. id)
    SetPlayerRoutingBucket(source, 0)
end)

RegisterNetEvent("legacy:savetime", function(time, id)
    local playerIdentifier = "char" .. id .. ":" .. ESX.GetIdentifier(source)

    MySQL.scalar('SELECT `time` FROM `users` WHERE `identifier` = ? LIMIT 1', {
        playerIdentifier
    }, function(value)
        MySQL.update('UPDATE users SET time = ? WHERE identifier = ?', {
            (value + time), playerIdentifier
        }, function(affectedRows)
            if affectedRows then

            end
        end)
    end)
end)



RegisterNetEvent('legacy:relog', function()
    local source = source
    TriggerEvent('esx:playerLogout', source)
end)


RegisterNetEvent("legacy:createPg", function(data)
    TriggerEvent('esx:onPlayerJoined', source, 'char' .. data.slot, {
        firstname = data.nome,
        lastname = data.cognome,
        dateofbirth = data.data,
        sex = data.sex,
        height = data.altezza
    })
end)


RegisterNetEvent("legacy:setupSlots", function(slots, license)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    local access = false

    for _, group in pairs(Config.PanelAccess) do
        if playerGroup == group then
            access = true
            break
        end
    end

    if not access then return end
    if not license then return end
    if not slots then return end

    MySQL.insert('INSERT INTO `lg_login` (identifier, pg) VALUES (?, ?) ON DUPLICATE KEY UPDATE pg = ? ', {
        license, slots, slots
    })
end)

local users = {}


function PlayerOnline(ide)
    local players = GetPlayers()
    for k, v in pairs(players) do
        if GetPlayerIdentifierByType(v, 'license') == 'license:' .. ide then
            return true
        end
    end
    return false
end

ESX.RegisterServerCallback('legacy:getPannelData', function(src, cb, passChar, requiringIde, disable, delete, license)
    local character = {}

    local xPlayer = ESX.GetPlayerFromId(src)
    local playerGroup = xPlayer.getGroup()
    local access = false

    for _, group in pairs(Config.PanelAccess) do
        if playerGroup == group then
            access = true
            break
        end
    end

    if not access then return end


    if disable then
        MySQL.update('UPDATE users SET disabled = ? WHERE identifier = ?', {
            disable.disable and 1 or 0, license
        }, function(affectedRows)
            print(affectedRows)
        end)
    end

    if delete then
        local response = MySQL.rawExecute.await('DELETE FROM `users` WHERE `identifier` = ?', {
            license
        })
    end

    MySQL.query('SELECT * FROM `users`', {}, function(res)
        if res then
            for k, v in pairs(res) do
                local identifier = v.identifier

                local modIde = string.match(identifier, "char%d:(%S+)")

                for _, i in pairs(users) do
                    if i.ide == modIde then
                        trovato = true
                        break
                    end
                end

                if not trovato then
                    local bool = PlayerOnline(modIde)
                    users[#users + 1] = {
                        ide = modIde,
                        steam = v.steam,
                        online = bool
                    }
                end

                if passChar then
                    if not character[requiringIde] then
                        character[requiringIde] = {}
                    end

                    if string.find(identifier, requiringIde) then
                        if not delete or delete and license ~= requiringIde then
                            character[requiringIde][identifier] = {}
                            character[requiringIde][identifier].firstName = v.firstname or "not found"
                            character[requiringIde][identifier].lastName = v.lastname or "not found"
                            character[requiringIde][identifier].dob = v.dateofbirth or "not found"
                            character[requiringIde][identifier].sex = v.sex or "not found"
                            character[requiringIde][identifier].disabled = v.disabled
                            character[requiringIde][identifier].height = v.height or "not found"
                            character[requiringIde][identifier].money = json.decode(v.accounts).money or "not found"
                            character[requiringIde][identifier].bank = json.decode(v.accounts).bank or "not found"
                            character[requiringIde][identifier].license = identifier
                            character[requiringIde][identifier].slot = identifier:match("char(%d+):") or "not found"
                        end
                    end
                end
            end
        end

        cb(users, character[requiringIde])
    end)
end)

local CreateThread                     = CreateThread
local Wait                             = Wait
local NetworkIsPlayerActive            = NetworkIsPlayerActive
local PlayerId                         = PlayerId
local DoScreenFadeOut                  = DoScreenFadeOut
local ShutdownLoadingScreen            = ShutdownLoadingScreen
local ShutdownLoadingScreenNui         = ShutdownLoadingScreenNui
local TriggerEvent                     = TriggerEvent
local DoScreenFadeIn                   = DoScreenFadeIn
local DisplayRadar                     = DisplayRadar
local PlayerPedId                      = PlayerPedId
local SetEntityCoords                  = SetEntityCoords
local FreezeEntityPosition             = FreezeEntityPosition
local SetEntityVisible                 = SetEntityVisible
local CreatePed                        = CreatePed
local SendNUIMessage                   = SendNUIMessage
local SetNuiFocus                      = SetNuiFocus
local SetCamActive                     = SetCamActive
local RenderScriptCams                 = RenderScriptCams
local DestroyCam                       = DestroyCam
local GetOffsetFromEntityInWorldCoords = GetOffsetFromEntityInWorldCoords
local GetEntityHeading                 = GetEntityHeading
local CreateCamWithParams              = CreateCamWithParams
local SetCamActiveWithInterp           = SetCamActiveWithInterp
local TriggerServerEvent               = TriggerServerEvent
local RegisterNuiCallback              = RegisterNuiCallback
local RegisterNetEvent                 = RegisterNetEvent
local AddEventHandler                  = AddEventHandler
local SetPlayerModel                   = SetPlayerModel
local SetModelAsNoLongerNeeded         = SetModelAsNoLongerNeeded
local SetPedAoBlobRendering            = SetPedAoBlobRendering
local ResetEntityAlpha                 = ResetEntityAlpha
local SetEntityCoordsNoOffset          = SetEntityCoordsNoOffset
local RegisterCommand                  = RegisterCommand
local DoesEntityExist                  = DoesEntityExist
local DeleteEntity                     = DeleteEntity
local GetCurrentResourceName           = GetCurrentResourceName

local Legacy                           = {}
local mp_m_freemode_01                 = `mp_m_freemode_01`
local mp_f_freemode_01                 = `mp_f_freemode_01`
local pg                               = {}

local canRelog                         = true
local plLoggato                        = false
local maxPg                            = Config.DefaultSlots

local cam                              = nil
local cams                             = {}
local activeCamIndex                   = 1

local currentSlot
local currentPg
local pgCreated
local timer

local spawnPoint
local gSpawnPos
local pgToCreate                       = {}
local PedSkin                          = {}

CreateThread(function()
    while not ESX.PlayerLoaded do
        Wait(100)

        if NetworkIsPlayerActive(PlayerId()) then
            exports[Config.Exports.SetAutoSpawn]:setAutoSpawn(false)
            DoScreenFadeOut(0)
            Legacy.startLogin()
            break
        end
    end
end)


local function charToCreate()
    local smallest = math.huge
    local foundSmallest = false
    local numbers = {}

    for k, v in pairs(pgToCreate) do
        local n = tonumber(v)
        if n then
            numbers[n] = true
            if n < smallest then
                smallest = n
                foundSmallest = true
            end
        end
    end

    if not foundSmallest then
        return 1
    end

    if smallest > 1 then
        return 1
    end

    for i = smallest + 1, math.huge do
        if not numbers[i] then
            return i
        end
    end
end


function Legacy.startLogin()
    pgCreated = 0
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}

    utils.requestModel(mp_m_freemode_01, 0)
    utils.requestModel(mp_f_freemode_01, 0)

    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
    TriggerEvent('esx:loadingScreenOff')

    canRelog = false

    local index = 0

    DisplayRadar(false)

    local playerPed = PlayerPedId()

    SetEntityCoords(playerPed, Config.CamStartPos.x, Config.CamStartPos.y, Config.CamStartPos.z, true, false, false,
        false)
    FreezeEntityPosition(playerPed, true)
    SetEntityVisible(playerPed, false)

    DoScreenFadeIn(0)
    ESX.TriggerServerCallback('legacy:getData', function(data, playerMaxPg)
        maxPg = playerMaxPg
        for i = 1, maxPg do
            local cfg = Config.PosPeds[i]
            index += 1
            pg[index] = {}

            local model = data[index]?.skin ~= nil and json.decode(data[index]?.skin)?.model or mp_m_freemode_01

            pg[index].ped = CreatePed(0, model, cfg.coords, false, true)
            pg[index].info = data[index]

            if pg[index].info then
                pgCreated += 1
                pgToCreate[#pgToCreate + 1] = data[index].slot
            else
                SetEntityAlpha(pg[index].ped, 150)
            end

            utils.playAnim(pg[index].ped, cfg.anim[1], cfg.anim[2], cfg.anim[3])
            exports[Config.Skin]:setPedAppearance(pg[index].ped, json.decode(data[index]?.skin))
        end

        SendNUIMessage({
            action = "infoPg",
            data = pg,
            lang = Config.Lang
        })

        SetNuiFocus(true, true)
        Legacy.setupCam('pg', pg[1].ped, true)
    end)
end

function Legacy.setupCam(type, entity, start, spawn)
    if type == "pg" then
        local entityCoords
        local camCoords
        local camRot
        local camZoom

        if cams[activeCamIndex] then
            SetCamActive(cams[activeCamIndex].cam, false)
            RenderScriptCams(false, false, 0, true, true)
            DestroyCam(cams[activeCamIndex].cam)
            cams[activeCamIndex] = nil
        end

        if entity then
            entityCoords = GetOffsetFromEntityInWorldCoords(entity, 0, 0.96, 0)
        end

        currentSlot = currentSlot and currentSlot or 1

        camCoords = Config.PosPeds[currentSlot].camPos or
            vector3(entityCoords.x, entityCoords.y, entityCoords.z + (start and 0.0 or 0.70))
        camRot = Config.PosPeds[currentSlot].camRot or vector3(-24.0, 0.0, GetEntityHeading(entity) + 160)
        camZoom = Config.PosPeds[currentSlot].camZoom or 100.0

        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", camCoords, camRot, camZoom, false, 1)

        cams[activeCamIndex] = { cam = cam, coords = camCoords }

        if cams[activeCamIndex - 1] then
            SetCamActiveWithInterp(cam, cams[activeCamIndex - 1].cam, 1000, true, true)
        else
            SetCamActive(cam, true)
        end

        RenderScriptCams(true, true, 700, true, true)
        SetFocusArea(camCoords, 0.0, 0.0, 0.0)

        activeCamIndex = activeCamIndex + 1
    elseif type == "spawnSelector" then
        Wait(500)

        ClearFocus()
        SetFocusArea(spawn.camPos, 0.0, 0.0, 0.0)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", spawn.camPos, spawn.camRot, 100.0, false, 1)

        SetCamActive(cam, true)
        RenderScriptCams(true, false, 700, true, true)
        DoScreenFadeIn(250)
    end
end

function Legacy.startTimer()
    timer = 0
    CreateThread(function()
        while ESX.PlayerLoaded do
            Wait(1 * 60000)
            timer += 1
        end
    end)
end

function Legacy.saveTime()
    if not currentPg then return end
    TriggerServerEvent("legacy:savetime", timer, currentPg)
end

function Legacy.clearPeds()
    for k, v in pairs(pg) do
        if v.ped and DoesEntityExist(v.ped) then
            DeleteEntity(v.ped)
        end
    end
end

function Legacy.resetCameraAndFocus()
    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, true)
    FreezeEntityPosition(playerPed, false)
    SetNuiFocus(false, false)
    SetCamActive(cam, false)
    RenderScriptCams(false, false, 0, true, true)
    DestroyCam(cam)
end

RegisterNuiCallback("action", function(data, cb)
    if data.tipo == "changeIndex" then
        local index = tonumber(data.slot)
        if index == currentSlot then return end

        selectedPg = pg[index].ped
        currentSlot = index

        Legacy.setupCam('pg', selectedPg)
    elseif data.tipo == "selectPg" then
        DoScreenFadeOut(400)
        while not IsScreenFadedOut() do Wait(10) end

        local index = tonumber(data.slot)

        Legacy.clearPeds()

        if not Config.ShowAllwaysSpawnSelector then
            Legacy.resetCameraAndFocus()
        end

        currentPg = index

        TriggerServerEvent("legacy:selectCharacter", index)
    elseif data.tipo == "emptySlot" then
        emtpySlotNum = data.idPg + 1

        if emtpySlotNum == currentSlot then return end

        currentSlot = emtpySlotNum

        Legacy.setupCam('pg', pg[data.idPg + 1].ped, true)
    elseif data.tipo == "createPg" then
        data.slot = charToCreate()
        SetNuiFocus(false, false)
        TriggerServerEvent("legacy:createPg", data)
    elseif data.tipo == "indietroSpawn" then
        DoScreenFadeOut(250)
        spawnPoint = Config.SpawnPositions[data.index]

        Legacy.setupCam("spawnSelector", false, false, spawnPoint)

        cb(spawnPoint.label)
    elseif data.tipo == "avantiSpawn" then
        DoScreenFadeOut(250)
        spawnPoint = Config.SpawnPositions[data.index]
        Legacy.setupCam("spawnSelector", false, false, spawnPoint)

        cb(spawnPoint.label)
    elseif data.tipo == "spawnSelectorSpawn" then
        cb(Config.SpawnPositions[1].label)

        local playerPed = PlayerPedId()
        DoScreenFadeOut(250)
        Legacy.resetCameraAndFocus()

        Wait(500)

        if not spawnPoint then spawnPoint = Config.SpawnPositions[1] end

        SetEntityCoordsNoOffset(playerPed, spawnPoint.coords.xyz, false, false, false)
        SetEntityHeading(playerPed, spawnPoint.coords.w)
        ClearPedTasksImmediately(PlayerPedId())
        DoScreenFadeIn(250)
        spawnPoint = nil
    elseif data.tipo == "spawnLast" then
        cb(Config.SpawnPositions[1].label)

        local playerPed = PlayerPedId()
        DoScreenFadeOut(250)

        Legacy.resetCameraAndFocus()

        Wait(500)
        SetFocusArea(gSpawnPos.x, gSpawnPos.y, gSpawnPos.z, 0.0, 0.0, 0.0)
        SetEntityCoordsNoOffset(playerPed, gSpawnPos.x, gSpawnPos.y, gSpawnPos.z, false, false, false)
        SetEntityHeading(playerPed, gSpawnPos.heading or 0.0)
        ClearPedTasksImmediately(PlayerPedId())
        DoScreenFadeIn(250)
    elseif data.tipo == "pgList" then
        ESX.TriggerServerCallback('legacy:getPannelData', function(users, character)
            cb(character)
        end, true, data.ide)
    elseif data.tipo == "changeStatus" then
        local i = string.match(data.license, "char%d:(%S+)")
        ESX.TriggerServerCallback('legacy:getPannelData', function(users, character)
            cb(character)
        end, true, i, { disable = data.status == "DISABLE" and true or false }, false, data.license)
    elseif data.tipo == "deletePg" then
        local i = string.match(data.license, "char%d:(%S+)")

        ESX.TriggerServerCallback('legacy:getPannelData', function(users, character)
            cb(character)
        end, true, i, false, true, data.license)
    elseif data.tipo == "updatePgSlots" then
        TriggerServerEvent("legacy:setupSlots", data.slots, data.license)
    elseif data.tipo == "close" then
        SetNuiFocus(false, false)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData, isNew, skin)
    local spawn = playerData.coords or Config.ClothingPos
    gSpawnPos = spawn
    ClearFocus()


    if isNew or not skin or #skin == 1 then
        local playerId = PlayerId()
        local finished = false

        --[[skin = Config.SpawnClothes[Config.skin]['m']
        skin.sex = playerData.sex == "m" and 0 or 1]]

        local model = mp_m_freemode_01

        utils.requestModel(model)

        SetPlayerModel(playerId, model)
        SetModelAsNoLongerNeeded(model)
        SetEntityCoords(PlayerPedId(), Config.ClothingPos)
        SetPedAoBlobRendering(PlayerPedId(), true)
        ResetEntityAlpha(PlayerPedId())
        SetEntityVisible(PlayerPedId(), true)
        FreezeEntityPosition(PlayerPedId(), false)
        SetFocusArea(GetEntityCoords(PlayerPedId()), 0.0, 0.0, 0.0)
        exports[Config.Skin]:setPedAppearance(PlayerPedId(), Config.SpawnClothes[Config.Skin][playerData.sex])
        local config = Config.fivemAppConfig
        exports[Config.Skin]:startPlayerCustomization(function(appearance)
            if (appearance) then
                ESX.TriggerServerCallback('legacy:applicaSkin', function(data)

                end, appearance, playerData.identifier)
                finished = true
            else
                local appearance = exports[Config.Skin]:getPedAppearance(playerPed)
                ESX.TriggerServerCallback('legacy:applicaSkin', function(data)

                end, appearance, playerData.identifier)
                finished = true
            end
        end, config)

        repeat Wait(200) until finished
    end
    local playerPed = PlayerPedId()

    DoScreenFadeOut(500)


    cam = nil

    if Config.ShowAllwaysSpawnSelector then
        SetNuiFocus(true, true)
        Legacy.setupCam("spawnSelector", false, false, Config.SpawnPositions[1])
        SendNUIMessage({
            action = "spawnSelector",
            numeroMax = #Config.SpawnPositions,
            isNew = isNew,
            lang = Config.Lang
        })
    elseif not Config.ShowAllwaysSpawnSelector and isNew then
        SetNuiFocus(true, true)
        Legacy.setupCam("spawnSelector", false, false, Config.SpawnPositions[1])
        SendNUIMessage({
            action = "spawnSelector",
            numeroMax = #Config.SpawnPositions,
            isNew = isNew,
            lang = Config.Lang
        })
    else
        SetEntityCoordsNoOffset(playerPed, spawn.x, spawn.y, spawn.z, false, false, false)
        SetEntityHeading(playerPed, spawn.heading)
    end




    if not isNew then
        TriggerEvent('skinchanger:loadSkin', skin or json.decode(pg[currentPg]?.skin))
    end

    Wait(400)

    DoScreenFadeIn(400)
    TriggerServerEvent('esx:onPlayerSpawn')
    TriggerEvent('esx:onPlayerSpawn')
    TriggerEvent('playerSpawned')
    TriggerEvent('esx:restoreLoadout')

    if not Config.ShowAllwaysSpawnSelector and isNew then
        SetFocusArea(Config.SpawnPositions[1].camPos, 0.0, 0.0, 0.0)
    elseif Config.ShowAllwaysSpawnSelector then
        SetFocusArea(Config.SpawnPositions[1].camPos, 0.0, 0.0, 0.0)
    end

    TriggerServerEvent("legacy_updateSteam", currentPg)
    canRelog = true
    Legacy.startTimer()
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    DoScreenFadeOut(500)
    Legacy.saveTime()

    Wait(1000)
    plLoggato = false


    Legacy.clearPeds()
    Legacy.startLogin()
    TriggerEvent('esx_skin:resetFirstSpawn')
end)

AddEventHandler("onResourceStop", function(r)
    if r == GetCurrentResourceName() then
        Legacy.clearPeds()
    end
end)

if Config.Relog then
    RegisterCommand('relog', function()
        if canRelog then
            canRelog = false
            TriggerServerEvent('legacy:relog')
            ESX.SetTimeout(10000, function()
                canRelog = true
            end)
        end
    end)
end

RegisterCommand('loginPannel', function()
    ESX.TriggerServerCallback('legacy:getPannelData', function(users, character)
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "openPannel",
            users = users,
            lang = Config.Lang
        })
    end, false, false)
end)

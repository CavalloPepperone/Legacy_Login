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
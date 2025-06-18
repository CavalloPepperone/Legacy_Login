utils = {}


function utils.playAnim(entity, animDict, animClip, scenario)
    if not scenario then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            RequestAnimDict(animDict)
            Wait(10)
        end

        TaskPlayAnim(entity, animDict, animClip, 8.0, 8.0, -1, 1, 1, false, false, false)

        RemoveAnimDict(animDict)
    else
        TaskStartScenarioInPlace(entity, scenario, 0, true)
    end
end

function utils.requestModel(model, tick)
    RequestModel(model)

    while not HasModelLoaded(model) do
        print('Un modello si sta caricando ' .. model)
        Wait(tick)
    end
end

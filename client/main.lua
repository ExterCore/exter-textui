Config.Players = {}
function displayTextUI(text, key)
    local key = key
    if Config.DefaultKey then
        key = Config.DefaultKey.Key
    end
    SendNUIMessage({action = "textUI", show = true, key = key, text = text})
end

function changeText(text, key)
    local key = key
    if Config.DefaultKey then
        key = Config.DefaultKey.Key
    end
    SendNUIMessage({action = "textUIUpdate", key = key, text = text})
end

function hideTextUI()
    SendNUIMessage({action = "textUI", show = false})
end

function create3DTextUIOnPlayers(id, data)
    if not Config.Players[id] then
        local targetPlayerId = GetPlayerFromServerId(data.id)
        local targetPed = GetPlayerPed(targetPlayerId)
        Config.Players[id] = {
            data = {
                id = id,
                ped = targetPed, 
                displayDist = data.displayDist,
                interactDist = data.interactDist,
                enableKeyClick = data.enableKeyClick,
                keyNum = data.keyNum, -- Key number
                keyNum2 = data.keyNum2,
                key = data.key, -- Key name
                text = data.text,
                theme = data.theme or "green",
                job = data.job or "all"
            },
            onKeyClick = function()
                if data.triggerData then
                    if data.triggerData.isServer then
                        TriggerServerEvent(data.triggerData.triggerName, data.triggerData.args)
                    else
                        TriggerEvent(data.triggerData.triggerName, data.triggerData.args)
                    end
                end
            end,
            onKeyClick2 = function()
                if data.triggerData2 then
                    if data.triggerData2.isServer then
                        TriggerServerEvent(data.triggerData2.triggerName, data.triggerData2.args)
                    else
                        TriggerEvent(data.triggerData2.triggerName, data.triggerData2.args)
                    end
                end
            end
        }
    end
end

function delete3DTextUIOnPlayers(id)
    if Config.Players[id] then
        Config.Players[id] = nil
        SendNUIMessage({action = "hide3DText", id = id})
    end
end

function create3DTextUI(id, data)
    if not Config.Areas[id] then
        if data.canInteract then
            Config.Areas[id] = {
                data = {
                    id = id,
                    type = "3dtext", -- 3dtext or textui
                    coords = data.coords, 
                    displayDist = data.displayDist,
                    interactDist = data.interactDist,
                    enableKeyClick = data.enableKeyClick,
                    keyNum = data.keyNum, -- Key number
                    key = data.key, -- Key name
                    text = data.text,
                    theme = data.theme or "green",
                    job = data.job or "all",
                    canInteract = data.canInteract
                },
                onKeyClick = function()
                    if data.triggerData then
                        if data.triggerData.isServer then
                            TriggerServerEvent(data.triggerData.triggerName, data.triggerData.args)
                        else
                            TriggerEvent(data.triggerData.triggerName, data.triggerData.args)
                        end
                    end
                end
            }
        else
            Config.Areas[id] = {
                data = {
                    id = id,
                    type = "3dtext", -- 3dtext or textui
                    coords = data.coords, 
                    displayDist = data.displayDist,
                    interactDist = data.interactDist,
                    enableKeyClick = data.enableKeyClick,
                    keyNum = data.keyNum, -- Key number
                    key = data.key, -- Key name
                    text = data.text,
                    theme = data.theme or "green",
                    job = data.job or "all",
                    canInteract = function()
                        return true
                    end
                },
                onKeyClick = function()
                    if data.triggerData then
                        if data.triggerData.isServer then
                            TriggerServerEvent(data.triggerData.triggerName, data.triggerData.args)
                        else
                            TriggerEvent(data.triggerData.triggerName, data.triggerData.args)
                        end
                    end
                end
            }
        end
    end
end

function delete3DTextUI(id)
    if Config.Areas[id] then
        Config.Areas[id] = nil
        SendNUIMessage({action = "hide3DText", id = id})
    end
end

function update3DTextUI(id, text, theme)
    Config.Areas[id].data.text = text
    SendNUIMessage({action = "update3DText2", id = id, key = Config.Areas[id].data.key, text = text, theme = theme})
end

local showTextUI = false
Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local playerCoords = GetEntityCoords(PlayerPedId())
        for k, v in pairs(Config.Areas) do
            local dist = #(v.data.coords - playerCoords)
            if v.data.type == "3dtext" then
                if dist <= v.data.displayDist then
                    local canInteract = v.data.canInteract() or true
                    if canInteract then
                        if v.data.job == "all" then
                            sleep = 0
                            local _, x, y = GetScreenCoordFromWorldCoord(v.data.coords.x, v.data.coords.y, v.data.coords.z)
                            if dist <= v.data.interactDist then
                                if not v.updatedNUI then
                                    v.updatedNUI = true
                                    SendNUIMessage({action = "update3DText", key = v.data.key, text = v.data.text, id = k, type = "text", theme = v.data.theme})
                                end
                                SendNUIMessage({action = "show3DText", id = k, x = x, y = y, type = "text", key = v.data.key, text = v.data.text, theme = v.data.theme})
                                if v.data.enableKeyClick then
                                    if v.data.keyNum then
                                        if IsControlJustReleased(0, v.data.keyNum) then
                                            v.onKeyClick()
                                        end
                                    end
                                end
                            else
                                if v.updatedNUI then
                                    v.updatedNUI = false
                                    SendNUIMessage({action = "update3DText", id = k, type = "svg"})
                                end
                                SendNUIMessage({action = "show3DText", id = k, x = x, y = y, type = "svg"})
                            end
                        elseif v.data.job == GetPlayerJob() then
                            sleep = 0
                            local _, x, y = GetScreenCoordFromWorldCoord(v.data.coords.x, v.data.coords.y, v.data.coords.z)
                            if dist <= v.data.interactDist then
                                if not v.updatedNUI then
                                    v.updatedNUI = true
                                    SendNUIMessage({action = "update3DText", key = v.data.key, text = v.data.text, id = k, type = "text", theme = v.data.theme})
                                end
                                SendNUIMessage({action = "show3DText", id = k, x = x, y = y, type = "text", key = v.data.key, text = v.data.text, theme = v.data.theme})
                                if v.data.enableKeyClick then
                                    if v.data.keyNum then
                                        if IsControlJustReleased(0, v.data.keyNum) then
                                            v.onKeyClick()
                                        end
                                    end
                                end
                            else
                                if v.updatedNUI then
                                    v.updatedNUI = false
                                    SendNUIMessage({action = "update3DText", id = k, type = "svg"})
                                end
                                SendNUIMessage({action = "show3DText", id = k, x = x, y = y, type = "svg"})
                            end
                        else
                            SendNUIMessage({action = "hide3DText", id = k})
                        end
                    else
                        SendNUIMessage({action = "hide3DText", id = k})
                    end
                else
                    SendNUIMessage({action = "hide3DText", id = k})
                end
            end
            if v.data.type == "textui" then
                if dist <= v.data.dist then
                    sleep = 0
                    if not showTextUI then
                        showTextUI = true
                        SendNUIMessage({action = "textUI", show = true, key = v.data.key, text = v.data.text})
                        if IsControlJustReleased(0, v.data.keyNum) then
                            v.onKeyClick()
                        end
                    end
                else
                    if showTextUI then
                        showTextUI = false
                        SendNUIMessage({action = "textUI", show = false})
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

local showTextUI2 = false
Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local playerCoords = GetEntityCoords(PlayerPedId())
        for k, v in pairs(Config.Players) do
            v.data.coords = GetEntityCoords(v.data.ped)
            local dist = #(v.data.coords - playerCoords)
            if dist <= v.data.displayDist then
                sleep = 0
                local _, x, y = GetScreenCoordFromWorldCoord(v.data.coords.x, v.data.coords.y, v.data.coords.z)
                if dist <= v.data.interactDist then
                    if not v.updatedNUI then
                        v.updatedNUI = true
                        SendNUIMessage({action = "update3DText", key = v.data.key, text = v.data.text, id = v.data.id, type = "text", theme = v.data.theme})
                    end
                    SendNUIMessage({action = "show3DText", id = k, x = x, y = y, type = "text", key = v.data.key, text = v.data.text, theme = v.data.theme})
                    if v.data.enableKeyClick then
                        if v.data.keyNum then
                            if IsControlJustReleased(0, v.data.keyNum) then
                                v.onKeyClick()
                            end
                        end
                        if v.data.keyNum2 then
                            if IsControlJustReleased(0, v.data.keyNum2) then
                                v.onKeyClick2()
                            end
                        end
                    end
                else
                    if v.updatedNUI then
                        v.updatedNUI = false
                        SendNUIMessage({action = "update3DText", id = v.data.id, type = "svg"})
                    end
                    SendNUIMessage({action = "show3DText", id = v.data.id, x = x, y = y, type = "svg"})
                end
            else
                SendNUIMessage({action = "hide3DText", id = v.data.id})
            end
        end
        Citizen.Wait(sleep)
    end
end)
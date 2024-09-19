
# Put this on top of your client side and you don't need to do anything else. This is for classic cordinates

![npx 2](https://github.com/user-attachments/assets/060313fa-d3df-4933-846f-c8f1c3e0ddff)


## This is for spesific coord text-ui
```
CreateThread(function()
    -- For fixed coordinate
    exports['exter-textui']:create3DTextUI("pa-test", {
        coords = vector3(-1461.18, -31.48, 54.63),
        displayDist = 6.0,
        interactDist = 2.0,
        enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
        keyNum = 38,
        key = "E",
        text = "PA Test",
        theme = "green", -- or red
        job = "all", -- or the job you want to show this for
        canInteract = function()
            return true
        end,
        triggerData = {
            triggerName = "",
            args = {}
        }
    })
    exports['exter-textui']:delete3DTextUI("pa-test")
    -- For Players
    exports['exter-textui']:create3DTextUIOnPlayers("pa-test", {
        id = targetId,
        ped = targetPed,
        displayDist = 6.0,
        interactDist = 2.0,
        enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
        keyNum = 38,
        key = "E",
        text = "PA Test",
        theme = "green", -- or red
        triggerData = {
            triggerName = "",
            args = {}
        }
    })
    -- Delete Text UI for player
    exports['exter-textui']:delete3DTextUIOnPlayers(targetId)
    -- For Entities, Vehicles, Peds (fixed coordinate)
    exports['exter-textui']:create3DTextUIOnEntity(entity, {
        displayDist = 6.0,
        interactDist = 2.0,
        enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
        keyNum = 38,
        key = "E",
        text = "PA Test",
        theme = "green", -- or red
        triggerData = {
            triggerName = "",
            args = {}
        }
    })
    -- Delete Text UI for entity, vehicle or ped
    exports['exter-textui']:delete3DTextUI(entity)
end)
```

# OPTIONAL

## qb-core/client/drawtext.lua
```lua
    local function hideText()
        exports["exter-textui"]:hideTextUI()
    end

    local function drawText(text, position)
        if type(position) ~= 'string' then position = 'left' end
        exports["exter-textui"]:displayTextUI(text, position)
    end

    local function changeText(text, position)
        if type(position) ~= 'string' then position = 'left' end
        exports['exter-textui']:changeText(text, position)
    end

    local function keyPressed()
        CreateThread(function() -- Not sure if a thread is needed but why not eh?
            -- SendNUIMessage({
            --     action = 'KEY_PRESSED',
            -- })
            Wait(500)
            hideText()
        end)
    end

    RegisterNetEvent('qb-core:client:DrawText', function(text, position)
        drawText(text, position)
    end)

    RegisterNetEvent('qb-core:client:ChangeText', function(text, position)
        changeText(text, position)
    end)

    RegisterNetEvent('qb-core:client:HideText', function()
        hideText()
    end)

    RegisterNetEvent('qb-core:client:KeyPressed', function()
        keyPressed()
    end)

    exports('DrawText', drawText)
    exports('ChangeText', changeText)
    exports('HideText', hideText)
    exports('KeyPressed', keyPressed)
```

## es_extended/client/functions.lua | Find these functions and replace
```lua
    function ESX.TextUI(message, notifyType)
        if GetResourceState("exter-textui") ~= "missing" then
            return exports["exter-textui"]:displayTextUI(message, notifyType)
        end
        print("[^1ERROR^7] ^5exter-textui^7 is Missing!")
    end

    function ESX.HideUI()
        if GetResourceState("exter-textui") ~= "missing" then
            return exports["exter-textui"]:hideTextUI()
        end
        print("[^1ERROR^7] ^5exter-textui^7 is Missing!")
    end
```

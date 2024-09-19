
# Put this on top of your client side and you don't need to do anything else. This is for classic cordinates

![npx 2](https://github.com/user-attachments/assets/060313fa-d3df-4933-846f-c8f1c3e0ddff)


## This is for spesific coord text-ui
```
CreateThread(function()
    exports['exter-textui']:create3DTextUI("test", {
        coords = vector3(-1461.18, -31.48, 54.63),
        displayDist = 6.0,
        interactDist = 2.0,
        enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
        keyNum = 38,
        key = "E",
        text = "Test",
        theme = "green", -- or red
        triggerData = {
            triggerName = "",
            args = {}
        }
    })
end)
```

# OPTIONAL

## qb-core/client/drawtext.lua
```lua
    local function hideText()
        exports["exter-textui-"]:hideTextUI()
    end

    local function drawText(text, position)
        if type(position) ~= 'string' then position = 'left' end
        exports["exter-textui-"]:displayTextUI(text, position)
    end

    local function changeText(text, position)
        if type(position) ~= 'string' then position = 'left' end
        exports['exter-textui-']:changeText(text, position)
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

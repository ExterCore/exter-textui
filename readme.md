
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
    exports['qb-core']:DrawText() => exports["exter-textui"]:displayTextUI(text, position)

    exports['qb-core']:HideText() => exports["exter-textui"]:hideTextUI()

    exports['qb-core']:KeyPressed() => Dont change it

    exports['qb-core']:ChangeText() => exports['exter-textui']:changeText(text, position)
```

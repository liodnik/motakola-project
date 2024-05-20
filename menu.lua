-- This file contains the logic and functionality for the game's menu screen. It handles drawing the menu options, responding to player input (keyboard or mouse), and transitioning to different game states based on menu selections.

local localization = require("localization")
local menu = {}

menu.items = {"continue", "new_game", "options", "exit"}
menu.selected = 1

function menu.load()
    -- Load the font
    menu.font = love.graphics.newFont("assets/fonts/Belarus.otf", 32)
    love.graphics.setFont(menu.font)

    -- Load the background image
    menu.background = love.graphics.newImage("assets/images/background.jpg")

    -- Screen dimensions
    menu.width, menu.height = love.graphics.getDimensions()
end

function menu.draw()
    -- Draw the background image
    love.graphics.draw(menu.background, 0, 0)

    -- Draw the menu items
    for i, key in ipairs(menu.items) do
        local item = localization.get_text(key)
        love.graphics.setColor(1, 1, 1)  -- Set default color for text
        if i == menu.selected then
            love.graphics.setColor(1, 0, 0)  -- Highlight selected item
        end
        love.graphics.printf(item, 50, menu.height / 2 + (i - 1) * 40, menu.width, "left")
    end

    -- Reset color back to default
    love.graphics.setColor(1, 1, 1)
end

function menu.keypressed(key)
    if key == "up" then
        menu.selected = menu.selected - 1
        if menu.selected < 1 then menu.selected = #menu.items end
    elseif key == "down" then
        menu.selected = menu.selected + 1
        if menu.selected > #menu.items then menu.selected = 1 end
    elseif key == "return" or key == "kpenter" then
        menu.activate()
    end
end

function menu.mousepressed(x, y, button)
    if button == 1 then  -- Left mouse button
        local item_height = menu.font:getHeight() + 10
        for i, key in ipairs(menu.items) do
            local item = localization.get_text(key)
            local item_y = menu.height / 2 + (i - 1) * item_height
            if y >= item_y and y <= item_y + item_height then
                menu.selected = i
                menu.activate()
                break
            end
        end
    end
end

function startGame()
    require("game") -- Load the game.lua file
    if love.load then
        love.load() -- Call the love.load() function from game.lua if it exists
    end
end

function menu.activate()
    local key = menu.items[menu.selected]
    if key == "exit" then
        love.event.quit()
    elseif key == "new_game" then
        startGame()
    elseif key == "continue" then
        -- Continue game logic here
    elseif key == "options" then
        -- Options logic here
    end
end

return menu

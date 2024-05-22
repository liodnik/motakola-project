-- This is the entry point of the game. It initializes the game engine, sets up the game environment, and starts the game loop. It might also handle high-level game state management, such as transitioning between different screens (e.g., menu screen, gameplay screen).

local menu = require("menu")
local localization = require("localization")

function love.load()
    love.window.setTitle("Motakola main menu")

    -- Set default language
    localization.set_language("be")
    menu.load()
end

function love.draw()
    menu.draw()
end

function love.keypressed(key)
    -- Switch language for demonstration purposes (e.g., pressing "l" switches language)
    if key == "l" then
        if localization.current_language == "en" then
            localization.set_language("be")
        else
            localization.set_language("en")
        end
    end
    menu.keypressed(key)
end

function love.mousepressed(x, y, button, istouch, presses)
    menu.mousepressed(x, y, button)
end

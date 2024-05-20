local json = require("lib/dkjson")
local localization = {}

localization.languages = {}
localization.current_language = "en"

local function load_language(lang)
    local path = "locales/" .. lang .. ".json"
    local file = love.filesystem.read(path)
    if file then
        localization.languages[lang] = json.decode(file)
    end
end

function localization.set_language(lang)
    if not localization.languages[lang] then
        load_language(lang)
    end
    if localization.languages[lang] then
        localization.current_language = lang
    end
end

function localization.get_text(key)
    return localization.languages[localization.current_language][key] or key
end

return localization

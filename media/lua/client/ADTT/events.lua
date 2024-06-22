-- -------------------------------------------------------------------------- --
--            Handles event stuff like registering listeners/hooks.           --
-- -------------------------------------------------------------------------- --

-- STD Lua Global Tables/Variables
local math         = math
-- STD Lua Global Functions
local pairs        = pairs

-- Vanilla Global Tables/Variables
local Events       = Events
-- Vanilla Global Functions
local getPlayer    = getPlayer
-- local getText     = getText

-- My Mod Modules
local hooks        = require("ADTT/hooks")
local translations = require("ADTT/translations")
local logger       = require("ADTT/logger")

-- ------------------------------ Module Start ------------------------------ --

local events       = {}

--- @param key_code integer
function events.on_key_start_pressed(key_code)
    if key_code ~= 157 then return end

    local key = "Moodles_tired_desc_lvl1"
    local text = translations.find(key)
    if text == nil then return end

    local new_text = text:sub(-1) .. text:sub(1, -2)
    translations.update(key, new_text)
end

function events.on_game_boot()
    logger.debug("Hooking getText...")
    hooks.o_get_text = getText
    getText = hooks.get_text
end

function events.register()
    logger.debug("Registering events...")

    Events.OnKeyStartPressed.Add(events.on_key_start_pressed)
    Events.OnGameBoot.Add(events.on_game_boot)
end

return events

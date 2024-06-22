-- -------------------------------------------------------------------------- --
--            Handles event stuff like registering listeners/hooks.           --
-- -------------------------------------------------------------------------- --

-- Vanilla Global Tables/Variables
local Events       = Events
-- Vanilla Global Functions
local getPlayer    = getPlayer
-- local getText     = getText

-- My Mod Modules
local hooks        = require("ADTAPI/hooks")
local translations = require("ADTAPI/translations")
local logger       = require("ADTAPI/logger")

-- ------------------------------ Module Start ------------------------------ --

local events       = {}

--- @param key_code integer
function events.on_key_start_pressed(key_code)
    local key = "IGUI_health_Overall_Body_Status"

    if key_code == 157 then -- RCTRL
        logger.debug("Pressed Key RCTRL")
        local text = translations.find(key)
        if text == nil then return end

        local new_text = text:sub(-1) .. text:sub(1, -2)
        translations.update(key, new_text)
    elseif key_code == 54 then -- RSHIFT
        logger.debug("Pressed key RSHIFT")
        if not translations.exists(key) and translations.exists_original(key) then return end
        translations.reset(key)
    end
end

function events.on_game_boot()
    logger.debug("Hooking getText...")
    hooks.o_get_text = getText
    getText = hooks.get_text
end

function events.register()
    logger.debug("Registering events...")

    -- Events.OnKeyStartPressed.Add(events.on_key_start_pressed)
    Events.OnGameBoot.Add(events.on_game_boot)
end

return events

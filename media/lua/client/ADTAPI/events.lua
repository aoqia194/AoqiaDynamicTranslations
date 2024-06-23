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

function events.on_game_boot()
    logger.debug("Hooking getText...")
    hooks.o_get_text = getText
    getText = hooks.get_text
end

function events.register()
    logger.debug("Registering events...")

    Events.OnGameBoot.Add(events.on_game_boot)
end

return events

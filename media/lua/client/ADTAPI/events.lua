-- -------------------------------------------------------------------------- --
--            Handles event stuff like registering callbacks.                 --
-- -------------------------------------------------------------------------- --

-- Vanilla Globals
local Events       = Events

-- My Mod Modules
local hooks        = require("ADTAPI/hooks")
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

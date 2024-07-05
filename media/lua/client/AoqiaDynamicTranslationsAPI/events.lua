-- -------------------------------------------------------------------------- --
--            Handles event stuff like registering callbacks.                 --
-- -------------------------------------------------------------------------- --

-- Vanilla Globals
local Events = Events

-- My Mod Modules
local logger = require("AoqiaZomboidUtils/logger")

local hooks  = require("AoqiaDynamicTranslationsAPI/hooks")

-- ------------------------------ Module Start ------------------------------ --

local events = {}

function events.on_game_boot()
    logger:debug("Hooking getText...")
    hooks.o_get_text = getText
    getText = hooks.get_text
end

function events.register()
    logger:debug("Registering events...")

    Events.OnGameBoot.Add(events.on_game_boot)
end

return events

-- -------------------------------------------------------------------------- --
--                      The main entry point for the mod.                     --
-- -------------------------------------------------------------------------- --

local AQEvents = require("AoqiaDynamicTranslations/AQEvents")
local AQLog = require("AoqiaDynamicTranslations/AQLog")

-- ------------------------------- Entrypoint ------------------------------- --

AQEvents.init()

AQLog.debug("Lua init done!")

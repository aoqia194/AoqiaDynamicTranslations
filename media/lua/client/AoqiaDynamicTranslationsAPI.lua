-- -------------------------------------------------------------------------- --
--                                 Entrypoint                                 --
-- -------------------------------------------------------------------------- --

local logger = require("AoqiaZomboidUtils/logger")

local mod_constants = require("AoqiaDynamicTranslationsAPI/mod_constants")
local events = require("AoqiaDynamicTranslationsAPI/events")

-- ------------------------------ Module Start ------------------------------ --

logger.register(mod_constants.MOD_ID)
events.register()

logger.debug("Lua init done!")

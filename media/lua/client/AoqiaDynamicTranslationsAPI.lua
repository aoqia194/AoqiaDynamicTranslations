-- -------------------------------------------------------------------------- --
--                                 Entrypoint                                 --
-- -------------------------------------------------------------------------- --

local mod_constants = require("AoqiaDynamicTranslationsAPI/mod_constants")
local events        = require("AoqiaDynamicTranslationsAPI/events")

local logger = mod_constants.LOGGER

-- ------------------------------ Module Start ------------------------------ --

events.register()

logger:debug("Lua init done!")

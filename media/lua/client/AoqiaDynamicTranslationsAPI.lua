-- -------------------------------------------------------------------------- --
--                                 Entrypoint                                 --
-- -------------------------------------------------------------------------- --

local events = require("ADTAPI/events")
local logger = require("ADTAPI/logger")

-- ------------------------------ Module Start ------------------------------ --

events.register()
logger.debug("Lua init done!")

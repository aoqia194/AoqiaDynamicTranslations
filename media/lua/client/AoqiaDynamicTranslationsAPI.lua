-- -------------------------------------------------------------------------- --
--                                 Entrypoint                                 --
-- -------------------------------------------------------------------------- --

local events = require("ADTAPI/events")
local logger = require("ADTAPI/logger")

-- ---------------------------------- ADTT ---------------------------------- --

events.register()
logger.debug("Lua init done!")

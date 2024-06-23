-- -------------------------------------------------------------------------- --
--                   Stores constants to be used everywhere.                  --
-- -------------------------------------------------------------------------- --

-- ------------------------------ Module Start ------------------------------ --

local constants = {}

constants.IS_DEBUG = getDebug() == true
constants.IS_LAST_STAND = getCore():getGameMode() == "LastStand"

constants.MOD_ID = "AoqiaDynamicTranslationsAPI"
constants.MOD_VERSION = "1.0.0"

return constants

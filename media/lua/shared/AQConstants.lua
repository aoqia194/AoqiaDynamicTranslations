-- -------------------------------------------------------------------------- --
--                   Stores constants to be used everywhere.                  --
-- -------------------------------------------------------------------------- --

-- ------------------------------ Module Start ------------------------------ --

local AQConstants = {}

AQConstants.IS_DEBUG = getDebug() == true
AQConstants.IS_LAST_STAND = getCore():getGameMode() == "LastStand"

AQConstants.MOD_ID = "AoqiaDynamicTranslations"
AQConstants.MOD_VERSION = "1.0.0"

return AQConstants

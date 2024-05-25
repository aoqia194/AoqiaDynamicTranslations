-- -------------------------------------------------------------------------- --
--            Handles event stuff like registering listeners/hooks.           --
-- -------------------------------------------------------------------------- --

local Events      = Events

local AQConstants                = require("AoqiaDynamicTranslations/AQConstants")
local AQLog                      = require("AoqiaDynamicTranslations/AQLog")
local AQTranslations             = require("AoqiaDynamicTranslations/AQTranslations")

-- ------------------------------ Module Start ------------------------------ --

local AQEvents                   = {}

---@class AQGlobalModDataStruct
---@field _modVersion string Tracks what version of the mod belongs to the mod data.
local AQGlobalModDataStructDummy = {
    _modVersion = AQConstants.MOD_VERSION,
}

function AQEvents.OnGameBoot()
    AQTranslations.init()
end

function AQEvents.init()
    AQLog.debug("Registering events...")

    Events.OnGameBoot.Add(AQEvents.OnGameBoot)
end

return AQEvents

-- -------------------------------------------------------------------------- --
--   Caches translations so that we don't call `getText()` a billion times.   --
-- -------------------------------------------------------------------------- --

local AQConstants                             = require("AoqiaDynamicTranslations/AQConstants")
local AQLog                                   = require("AoqiaDynamicTranslations/AQLog")

-- ------------------------------ Module Start ------------------------------ --

local AQTranslations                          = {}

---@type table<string, table<string, string>>
-- Stores all of the key value pairs for translations
AQTranslations.translationTable = {}

AQTranslations.oGetText = nil

---@param key string
function AQTranslations.getText(key)
    return AQTranslations.oGetText(key)
end

function AQTranslations.init()
    AQLog.debug("Hooking getText on Lua side...")
    AQTranslations.oGetText = getText
    getText = AQTranslations.getText
end

return AQTranslations

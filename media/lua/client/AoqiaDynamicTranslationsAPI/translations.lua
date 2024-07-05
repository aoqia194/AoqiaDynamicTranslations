-- -------------------------------------------------------------------------- --
--       Manages a translation cache that is used to change translations      --
-- -------------------------------------------------------------------------- --

local logger = require("AoqiaZomboidUtils/logger")

-- ------------------------------ Module Start ------------------------------ --

local translations = {}

-- Stores the original translation before it was added to the main cache.
translations.original_cache = {}
-- Stores the most up-to-date translations for the game in key-value pairs.
translations.cache = {}

--- A code following the IETF language code standard.
--- REF: https://en.wikipedia.org/wiki/IETF_language_tag
--- @alias language_code string

--- Language codes
--- @class language_codes
--- @field CHINESE language_code
--- @field CHINESE_TAIWAN language_code
--- @field DUTCH language_code
--- @field ENGLISH language_code
--- @field ENGLISH_BRITAIN language_code
--- @field FINNISH language_code
--- @field FRENCH language_code
--- @field GERMAN language_code
--- @field ITALIAN language_code
--- @field JAPANESE language_code
--- @field KOREAN language_code
--- @field POLISH language_code
--- @field PORTUGUESE language_code
--- @field PORTUGUESE_BRAZIL language_code
--- @field SPANISH language_code
--- @field SPANISH_MEXICO language_code
--- @field SWEDISH language_code
translations.language_codes = {
    CHINESE = "ZH-CN",
    CHINESE_TAIWAN = "ZH-TW",
    DUTCH = "NL",
    ENGLISH = "EN",
    ENGLISH_BRITAIN = "EN-GB",
    FINNISH = "FI",
    FRENCH = "FR",
    GERMAN = "DE",
    ITALIAN = "IT",
    JAPANESE = "JA",
    KOREAN = "KO",
    POLISH = "PL",
    PORTUGUESE = "PT",
    PORTUGUESE_BRAZIL = "PT-BR",
    SPANISH = "ES",
    SPANISH_MEXICO = "ES-MX",
    SWEDISH = "SV",
}

--- Changes a translation's language in-place to the specified language.
--- @param key string
--- @param language_code language_code
function translations.update_language(key, language_code)
    local new_key = (key .. "__ADTAPI_" .. language_code)

    -- TODO: Refactor this cancer

    -- Try to get translation using cache
    local translation = translations.find(new_key)
    if translation == nil then
        -- Try to get translation using getText
        translation = getText(new_key)
        if translation == "nil" then
            logger:debug("Couldn't get new language translation, falling back to default...")

            -- Try to get DEFAULT using cache
            translation = translations.find_original(key)
            if translation == nil then
                logger:warn("Translation (%s) was nil when trying to update language to (%s).", key, language_code)
                return
            end
        end
    end

    translations.update(key, translation)
end

--- Resets a translation in the cache to it's first ever cached state. If it doesn't exist, nothing happens.
--- @param key string
function translations.reset(key)
    local original = translations.find_original(key)
    if original == nil then return end

    translations.update(key, original)
end

--- Similar to find_original but returns if it is found instead of the value.
--- @param key string
--- @return boolean does_exist
function translations.exists_original(key)
    return translations.original_cache[key] ~= nil
end

--- Finds a translation in the ORIGINAL cache, returning the value.
--- @param key string
--- @return string|nil translation
function translations.find_original(key)
    return translations.original_cache[key] or nil
end

--- Updates an existing translation in the ORIGINAL cache.
--- @param key string
--- @param value string
function translations.update_original(key, value)
    if not translations.exists_original(key) then return end
    translations.original_cache[key] = value
end

--- Creates a new translation in the ORIGINAL cache only if it doesn't already exist.
--- This shouldn't be used by the user at all if not ever. Only here for parity.
--- @param key string
--- @param value string
function translations.create_original(key, value)
    if translations.exists_original(key) then return end
    translations.original_cache[key] = value
end

--- Similar to find but returns if it is found instead of the value.
--- @param key string
--- @return boolean does_exist
function translations.exists(key)
    return translations.cache[key] ~= nil
end

--- Finds a translation in the cache, returning the value.
--- @param key string
--- @return string|nil translation
function translations.find(key)
    return translations.cache[key] or nil
end

--- Updates an existing translation in the cache.
--- @param key string
--- @param value string
function translations.update(key, value)
    if not translations.exists(key) then return end
    translations.cache[key] = value
end

--- Creates a new translation in the cache only if it doesn't already exist.
--- @param key string
--- @param value string
function translations.create(key, value)
    translations.create_original(key, value)

    if translations.exists(key) then return end
    translations.cache[key] = value
end

return translations

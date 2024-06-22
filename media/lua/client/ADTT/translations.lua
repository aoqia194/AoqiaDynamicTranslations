-- -------------------------------------------------------------------------- --
--       Manages a translation cache that is used to change translations      --
-- -------------------------------------------------------------------------- --

-- ------------------------------ Module Start ------------------------------ --

local translations = {}

-- Stores the original translation before it was added to the main cache.
translations.original_cache = {}
-- Stores the most up-to-date translations for the game in key-value pairs.
translations.cache = {}

--- Resets a translation in the cache to it's first ever cached state. If it doesn't exist, nothing happens.
--- @param key string
function translations.reset(key)
    key = tostring(key)

    local original = translations.find_original(key)
    if original == nil then return end

    translations.create(key, original)
end

--- Finds a translation in the cache and returns the value. If it doesn't exist, it creates one and returns nil.
--- @param key string
--- @param value string
--- @return string|nil translation
function translations.find_or_create(key, value)
    key = tostring(key)
    value = tostring(value)

    local translation = translations.find(key)
    if translation == nil then
        translations.create(key, value)
        return nil
    end

    return translation
end

--- Similar to find but returns if it is found instead of the value.
--- @param key string
--- @return boolean does_exist
function translations.exists(key)
    key = tostring(key)

    return translations.cache[key] ~= nil
end

--- Finds a translation in the cache, returning the value.
--- @param key string
--- @return string|nil translation
function translations.find(key)
    key = tostring(key)

    return translations.cache[key] or nil
end

--- Updates an existing translation in the cache.
--- @param key string
--- @param value string
function translations.update(key, value)
    key = tostring(key)
    value = tostring(value)

    if not translations.exists(key) then return end
    translations.cache[key] = value
end

--- Creates a new translation in the cache only if it doesn't already exist.
--- @param key string
--- @param value string
function translations.create(key, value)
    -- For the dummies...
    key = tostring(key)
    value = tostring(value)

    translations.create_original(key, value)

    if translations.exists(key) then return end
    translations.cache[key] = value
end

return translations

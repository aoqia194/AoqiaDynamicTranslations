-- -------------------------------------------------------------------------- --
--                             Hooks stuff for fun                            --
-- -------------------------------------------------------------------------- --

local constants    = require("ADTAPI/constants")
local logger       = require("ADTAPI/logger")
local translations = require("ADTAPI/translations")

-- ------------------------------ Module Start ------------------------------ --

local hooks        = {}

hooks.o_get_text   = nil
--- @return string
--- @overload fun(text: string): string
--- @overload fun(text: string, arg1: any): string
--- @overload fun(text: string, arg1: any, arg2: any): string
--- @overload fun(text: string, arg1: any, arg2: any, arg3: any): string
--- @overload fun(text: string, arg1: any, arg2: any, arg3: any, arg4: any): string
function hooks.get_text(...)
    -- TODO: Optimise this function LIKE BRICKS. It will run *every frame* in most cases for always-shown text.
    -- This means if-checking the logger func calls for less overhead, min-maxing basically.

    -- logger.debug("Intercepted getText call with text (%s)!", tostring(select(1, ...)))

    local key = tostring(select(1, ...))
    local value = hooks.o_get_text(...)

    -- If the translation doesn't exist in the cache, create it and return the value from the original getText
    if not translations.exists(key) then
        if constants.IS_DEBUG then
            logger.debug("Creating translation (%s) with value (%s)", key, value)
        end

        translations.create(key, value)
        return value
    end

    -- Otherwise return the translation in the cache.
    local translation = translations.find(key)
    if translation == nil then
        logger.warn("Translation (%s) was nil.", key)
    end

    return translation or "nil"
end

return hooks

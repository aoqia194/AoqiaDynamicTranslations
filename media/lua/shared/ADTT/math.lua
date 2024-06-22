-- -------------------------------------------------------------------------- --
--           A utility module for math stuff not in lua math module           --
-- -------------------------------------------------------------------------- --

-- ------------------------------ Module Start ------------------------------ --

local math = {}

---@param value number
---@param min number
---@param max number
-- This function is basically just `min(max(value, min), max)`.
function math.clamp(value, min, max)
    local result = value

    if value < min then
        result = min
    elseif value > max then
        result = max
    end

    return result
end

return math

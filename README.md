## Aoqia's Dynamic Translations API (ADTAPI)

EDIT: No longer maintained as it was a proof of concept mod. I realised that it doesn't function well in the Lua side of modding. Adding hot-reloading of translations via Java modding would be more sufficient.

A mod to add dynamic translations to Project Zomboid. Also on the Steam Workshop!

### What does this do?

This mod simply adds support for dynamically changing translations from the Lua side ONLY (no way to do Java sided stuff). It's solely for other developers to use in their own mods.

Currently, you can only edit translations on the client side Lua as I don't have a sufficient reason (or any at all) to put the code on the server side.

To clear up some confusion:
- Any mod that doesn't use ADTAPI can still get backwards compatibility features of ADTAPI as long as ADTAPI is installed itself.
- Any mod that does depend on ADTAPI can use its full feature set to dynamically modify translations at runtime (even translations from a mod that doesn't use ADTAPI). Keep in mind that dynamic language translations will not work for mods that don't specifically use ADTAPI as it's required to set up very specifically.

Do NOT paste any code in these examples. The code provided is purposely provided as example code and is to help the developer understand features of the API. It is not a complete replica of what real code should look like, and is just an example! You can follow it and even use most of it, but some things aren't taken into account.

### How do I edit a translation at runtime?

You can do that by requiring the mod and then calling the proper function like so (assuming that your translation has been cached by calling `getText(key)` *or* `translations.create(key, value)` **AT LEAST ONCE**):

```lua
local ADTAPI = require("AoqiaDynamicTranslationsAPI/translations")

-- Appends "123" to the translation
local key = "IGUI_MyTestTranslation"
local value = ADTAPI.find(key)
if value == nil then return end

local new_value = value .. "123"
ADTAPI.update(key, new_value)

-- Every time getText is called after this point in the code, it will return the modified translation.
```

### How do I add a translation that changes languages at runtime?

Unfortunately there is no possible way to do this properly without reloading the language via the settings of the game. **However**, we can fake it to the user so that we can still get *some* value out of this.
	
**For this to work as intended, the user needs to have the game set to whatever language you are choosing to put your translations in (see below).**
English as the base language is highly recommended.

To achieve this, add your custom translations in the translations file like so (using English language as example):
```js
IG_UI_EN = {
    IGUI_MyTestTranslation = "Hello",
    
    -- Inline German Translations --
    IGUI_MyTestTranslation__ADTAPI_DE = "Guten Tag",
    
    -- Inline Japanese Translations --
    IGUI_MyTestTranslation__ADTAPI_JA = "どうも",
}
```
You can see that I don't add a translation for the English language for ADTAPI to use. This is because the language that this translation file is targeting (ref: `IG_UI_EN`) is English.
**Make sure that you choose the correct file encoding to save the file as, otherwise your characters might not be preserved with the default UTF-8.**

If you do wish to make your dynamic language translations available to all languages, you'll have to either:

- Copy paste all of the language translations to each base language respectively. This is tedious and annoying to manage, but ensures that your language translations work for everyone. The reason is because the game only loads one translation langauge at a time (whatever the user has chosen in the settings and reloaded the lua by clicking apply).

- Create the translations at runtime using ADTAPI (example below). The down-side to this is if there is not at least ONE mod using ADTAPI including your own, you will not be able to access the translations.

```lua
local ADTAPI = require("AoqiaDynamicTranslationsAPI/translations")

-- Preferably do all of the code below in OnGameBoot event!!

-- Static table containing key-value pairs of translations.
-- This is only to clean up the code instead of writing 100 lines of ADTAPI.create().
entries = {
    "IGUI_MyTestTranslation" = "Hello",
    "IGUI_MyTestTranslation__ADTAPI_EN" = "Hello",
    "IGUI_MyTestTranslation__ADTAPI_DE" = "Guten Tag",
    "IGUI_MyTestTranslation__ADTAPI_JA" = "どうも",
}

for key, value in pairs(entries) do
    -- Don't check if it exists because it literally can't exist at this point in the code (OnGameBoot).
    ADTAPI.create(key, value)
end


-- some_other_file.lua

local key = "IGUI_MyTestTranslation"
print(getText(key)) -- "Hello"

-- Do whatever now like change the language for a specific key!
ADTAPI.update_language(key, ADTAPI.language_codes.GERMAN)

print(getText(key)) -- "Guten Tag"
```

## Other

Any other details will be added as needed. If you have any questions or suggestions, feel free to talk about them here!


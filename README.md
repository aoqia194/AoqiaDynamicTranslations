## Aoqia's Dynamic Translations API (ADTAPI)

A mod to add dynamic translations to Project Zomboid. Also on the Steam Workshop!

### What does this do?

This mod simply adds support for dynamically changing translations from the Lua side ONLY (no way to do Java sided stuff). It's solely for other developers to use in their own mods.

Currently, you can only edit translations on the client side Lua as I don't have a sufficient reason (or any at all) to put the code on the server side.

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

If you do wish to make your dynamic language translations available to all languages, you'll have to copy paste all of the language translations to each base language respectively. This is tedious and annoying to manage, but ensures that your language translations work for everyone.
Think about writing a Python script to do this for you, so you only need to manage one file...

## Other

Any other details will be added as needed. If you have any questions or suggestions, feel free to talk about them here!


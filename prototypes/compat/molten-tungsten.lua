local frep = require("__fdsl__.lib.recipe")

-- Crushing Industry Mod Settings
local ci_ore_crushing = settings.startup["crushing-industry-ore"].value

if mods["molten-tungsten"] and mods["space-age"] and ci_ore_crushing then
	frep.replace_ingredient("molten-tungsten", "crushed-tungsten-ore", "ei-enriched-tungsten-ore")
	frep.scale_ingredient("molten-tungsten", "ei-enriched-tungsten-ore", {amount=4/3})
end

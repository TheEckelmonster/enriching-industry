local frep = require("__fdsl__.lib.recipe")

-- Crushing Industry Mod Settings
local ci_glass = settings.startup["crushing-industry-glass"].value

-- Align glass-from-quartz recipe with default AAI recipe
-- Only do if no other glass besides AAI-glass is present
-- IF AAI is present AND K2 is NOT present AND CI-glass is NOT enabled
if mods["aai-industry"] and not mods["Krastorio2"] and not ci_glass then
	frep.modify_ingredient("ei-quartz-smelting", "ei-quartz", {amount=4})
	frep.modify_result("ei-quartz-smelting", "glass", {amount=1})
--	frep.change_time("ei-quartz-smelting", {energy_required=4})
	data.raw.recipe["ei-quartz-smelting"].energy_required = 4
end

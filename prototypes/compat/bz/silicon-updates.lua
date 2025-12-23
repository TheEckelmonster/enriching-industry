-- Crushing Industry Mod Settings
local ci_glass = settings.startup["crushing-industry-glass"].value
local ci_ore_crushing = settings.startup["crushing-industry-ore"].value
local ci_hide_player_crafting = settings.startup["crushing-industry-hide-player-crafting"].value

if (ci_glass and ci_ore_crushing) then
    data:extend({
        {
            type = "recipe",
            name = "ei-silica-from-quartz",
            icons = EnrichingIndustry.make_smelting_icons("ei-quartz", "silica"),
            category = type(mods) == "table" and mods["space-age"] and "basic-crushing" or "smelting",
            hide_from_player_crafting = ci_hide_player_crafting == true,
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            energy_required = 0.5,
            ingredients =
            {
                { type = "item", name = "ei-quartz", amount = 1, },
            },
            results =
            {
                { type = "item", name = "silica", amount = 1, },
            },
        }
    })
end
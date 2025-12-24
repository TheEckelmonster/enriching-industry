-- Crushing Industry Mod Settings
local ci_glass = settings.startup["crushing-industry-glass"].value
local ci_ore_crushing = settings.startup["crushing-industry-ore"].value
local ci_hide_player_crafting = settings.startup["crushing-industry-hide-player-crafting"].value

--[[ Fluids ]]

--[[ Items ]]
data:extend({
	{
		type = "item",
		name = "ei-purified-zircon-ore",
		icon = "__enriching-industry__/graphics/icons/enriched-zircon-ore.png",
		icon_size = 64,
		pictures =
		{
			{ size = 64, filename = "__enriching-industry__/graphics/icons/enriched-zircon-ore.png",   scale = 0.5, mipmap_count = 1 },
			{ size = 64, filename = "__enriching-industry__/graphics/icons/enriched-zircon-ore-1.png", scale = 0.5, mipmap_count = 1 },
			{ size = 64, filename = "__enriching-industry__/graphics/icons/enriched-zircon-ore-2.png", scale = 0.5, mipmap_count = 1 },
			{ size = 64, filename = "__enriching-industry__/graphics/icons/enriched-zircon-ore-3.png", scale = 0.5, mipmap_count = 1 }
		},
		subgroup = "raw-resource",
		order = "f[zircon-ore]-d[enriched]",
		hidden = not ci_ore_crushing,
		stack_size = 100,
		weight = 2 * kg
	},
	{
		type = "item",
		name = "ei-enriched-zircon-ore",
		icon = "__bzzirconium__/graphics/icons/enriched-zircon.png",
		icon_size = 128,
		pictures =
		{
			{ size = 128, filename = "__bzzirconium__/graphics/icons/enriched-zircon.png",   scale = 0.125, mipmap_count = 1 },
			{ size = 128, filename = "__bzzirconium__/graphics/icons/enriched-zircon-2.png", scale = 0.125, mipmap_count = 1 },
			{ size = 128, filename = "__bzzirconium__/graphics/icons/enriched-zircon-3.png", scale = 0.125, mipmap_count = 1 },
			{ size = 128, filename = "__bzzirconium__/graphics/icons/enriched-zircon-4.png", scale = 0.125, mipmap_count = 1 }
		},
		subgroup = "raw-resource",
		order = "f[zircon-ore]-d[enriched]",
		hidden = not ci_ore_crushing,
		stack_size = 100,
		weight = 2 * kg
	}
})

--[[ Recipes ]]
if (ci_ore_crushing) then
    data:extend({
        {
            type = "recipe",
            name = "ei-purified-zircon-ore",
            localised_name = { "recipe-name.ei-purified-zircon-ore" },
            icons =
            {
                { icon = "__bzzirconium__/graphics/icons/zircon.png", icon_size = 128, shift = { -12, -12 }, scale = 0.4 * 0.25, },
                { icon = "__enriching-industry__/graphics/icons/enriched-zircon-ore.png", draw_background = true, },
            },
            category = "crafting-with-fluid",
            subgroup = "raw-resource",
            order = "c[zircon]-d[purified]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            energy_required = 16,
            ingredients =
            {
                { type = "item",  name = "zircon", amount = 1 },
                { type = "item",  name = ci_glass and "sand" or "stone", amount = 2 },
            },
            results =
            {
                { type = "item",  name = "ei-purified-zircon-ore", amount = 1, extra_count_fraction = 0.5 },
                { type = "item",  name = ci_glass and "sand" or "stone", amount = 1 },
            },
        },
        {
            type = "recipe",
            name = "ei-enriched-zircon-ore",
            localised_name = { "recipe-name.ei-enriched-zircon-ore" },
            icons =
            {
                { icon = "__enriching-industry__/graphics/icons/enriched-zircon-ore.png", shift = { -12, -12 }, scale = 0.4, },
                { icon = "__bzzirconium__/graphics/icons/enriched-zircon.png", icon_size = 128, draw_background = true, scale = 0.25 },
            },
            category = type(mods) == "table" and mods["space-age"] and "electronics-with-fluid" or "crafting-with-fluid",
            subgroup = "raw-resource",
            order = "c[zircon]-d[enriched]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            energy_required = 16,
            ingredients =
            {
                { type = "item",  name = "ei-purified-zircon-ore", amount = 1 },
            },
            results =
            {
                { type = "item",  name = "ei-enriched-zircon-ore", amount = 1, extra_count_fraction = 0.5 },
                { type = "item",  name = type(mods) == "table" and mods["bztitanium"] and "titanium-ore" or "iron-ore", amount = 1, probability = 0.1 },
            },
        },
        -- MATERIAL
        {
            type = "recipe",
            name = "ei-purified-zircon-smelting",
            icons =
            {
                { icon = "__enriching-industry__/graphics/icons/enriched-zircon-ore.png", shift = { -12, -12 }, scale = 0.4, },
                { icon = "__bzzirconium__/graphics/icons/zirconia.png", icon_size = 128, draw_background = true, scale = 0.25 },
            },
            category = "smelting",
            order = "a[smelting]-b[zircon]-d[purified]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            energy_required = 6.4,
            ingredients =
            {
                { type = "item", name = "ei-purified-zircon-ore", amount = 1 },
            },
            results =
            {
                { type = "item", name = "zirconia", amount = 2 },
                type(mods) == "table" and mods["bztitanium"] and { type = "item", name = "titanium-ore", amount = 1, probability = 0.1 } or nil,
            },
        },
        {
            type = "recipe",
            name = "ei-enriched-zircon-smelting",
            icons =
            {
                { icon = "__bzzirconium__/graphics/icons/enriched-zircon.png", icon_size = 128, shift = { -12, -12 }, scale = 0.4 * 0.25, },
                { icon = "__bzzirconium__/graphics/icons/zirconia.png", icon_size = 128, draw_background = true, scale = 0.25, },
            },
            category = "smelting",
            order = "a[smelting]-b[zircon]-d[enriched]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            energy_required = 6.4,
            ingredients =
            {
                { type = "item", name = "ei-enriched-zircon-ore", amount = 1 },
            },
            results =
            {
                { type = "item", name = "zirconia", amount = 2 },
            },
        },
    })
end
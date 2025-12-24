-- Crushing Industry Mod Settings
local ci_ore_crushing = settings.startup["crushing-industry-ore"].value

--[[ Fluids ]]

--[[ Items ]]
data:extend({
	{
		type = "item",
		name = "ei-purified-tin-ore",
		icon = "__enriching-industry__/graphics/icons/enriched-tin-ore.png",
		icon_size = 64,
		pictures =
		{
			{ size = 64, filename = "__enriching-industry__/graphics/icons/enriched-tin-ore.png",   scale = 0.5, mipmap_count = 1 },
			{ size = 64, filename = "__enriching-industry__/graphics/icons/enriched-tin-ore-1.png", scale = 0.5, mipmap_count = 1 },
			{ size = 64, filename = "__enriching-industry__/graphics/icons/enriched-tin-ore-2.png", scale = 0.5, mipmap_count = 1 },
			{ size = 64, filename = "__enriching-industry__/graphics/icons/enriched-tin-ore-3.png", scale = 0.5, mipmap_count = 1 },
		},
		subgroup = "raw-resource",
		order = "t-c-a[tin-ore]-d[enriched]-c[stage-1]",
		hidden = not ci_ore_crushing,
		stack_size = 100,
		weight = 2 * kg,
	},
	{
		type = "item",
		name = "ei-enriched-tin-ore",
		icon = "__bztin__/graphics/icons/enriched-tin.png",
		icon_size = 128,
		pictures =
		{
			{ size = 128, filename = "__bztin__/graphics/icons/enriched-tin.png",   scale = 0.125, mipmap_count = 1 },
			{ size = 128, filename = "__bztin__/graphics/icons/enriched-tin-1.png", scale = 0.125, mipmap_count = 1 },
			{ size = 128, filename = "__bztin__/graphics/icons/enriched-tin-2.png", scale = 0.125, mipmap_count = 1 },
			{ size = 128, filename = "__bztin__/graphics/icons/enriched-tin-3.png", scale = 0.125, mipmap_count = 1 },
		},
		subgroup = "raw-resource",
		order = "t-c-a[tin-ore]-d[enriched]-c[stage-2]",
		hidden = not ci_ore_crushing,
		stack_size = 100,
		weight = 2 * kg,
	},
})

--[[ Recipes ]]
if (ci_ore_crushing) then
    local alloy_smelting = false
    local space_age = false

    if (type(mods) == "table") then
        if (mods["space-age"]) then alloy_smelting = true end
        if (mods["alloy-smelting"]) then space_age = true end
    end

    local crafting_machine_tint =
    {
        primary = { r = 194, g = 163, b = 120, a = 1, }, -- #c2a378
        secondary = { r = 163, g = 160, b = 126, a = 1, }, -- #4a3a07e
        tertiary = { r = 206, g = 197, b = 115, a = 1, }, -- #cec573
        quaternary = { r = 163, g = 160, b = 126, a = 1, }, -- #4a3a07e
    }

    data:extend({
        {
            type = "recipe",
            name = "ei-purified-tin-ore",
            localised_name = { "recipe-name.ei-purified-tin-ore" },
            icons =
            {
                { icon = "__crushing-industry__/graphics/icons/compat/crushed-tin-ore.png", shift = { -12, -12 }, scale = 0.4, },
                { icon = "__enriching-industry__/graphics/icons/enriched-tin-ore.png", draw_background = true, },
            },
            category = space_age and "chemistry-or-cryogenics" or "chemistry",
            subgroup = "raw-resource",
            order = "t-c-a[tin-ore]-a[chemistry]-d[enriched]-c[stage-1]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            energy_required = 4.8,
            ingredients =
            {
                { type = "item",  name = "crushed-tin-ore", amount = 1 },
                { type = "fluid", name = "water", amount = 10, }
            },
            results =
            {
                { type = "item",  name = "ei-purified-tin-ore", amount = 1, extra_count_fraction = 0.5, },
                { type = "item",  name = "stone", amount_min = 0, amount_max = 2, probability = 0.35 },
                { type = "fluid", name = "water", amount = 5, ignored_by_productivity = 1000, },
                { type = "fluid", name = "ei-tailing-slurry", amount_min = 1, amount_max = 5, probability = 0.15, ignored_by_productivity = 1000, }
            },
            crafting_machine_tint = crafting_machine_tint,
        },
        {
            type = "recipe",
            name = "ei-enriched-tin-ore",
            localised_name = { "recipe-name.ei-enriched-tin-ore" },
            icons =
            {
                { icon = "__enriching-industry__/graphics/icons/enriched-tin-ore.png", shift = { -12, -12 }, scale = 0.4, },
                { icon = "__bztin__/graphics/icons/enriched-tin.png", icon_size = 128, draw_background = true, scale = 0.25 },
            },
            category = space_age and "chemistry-or-cryogenics" or "chemistry",
            subgroup = "raw-resource",
            order = "t-c-a[tin-ore]-a[chemistry]-d[enriched]-c[stage-2]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            energy_required = 9.6,
            emissions_multiplier = 1.5,
            ingredients =
            {
                { type = "item",  name = "ei-purified-tin-ore", amount = 1 },
                { type = "fluid", name = "sulfuric-acid", amount = 15, },
                { type = "fluid", name = "water", amount = 10, },
            },
            results =
            {
                { type = "item",  name = "ei-enriched-tin-ore", amount = 1, extra_count_fraction = 0.5, },
                { type = "item",  name = "stone", amount_min = 0, amount_max = 2, probability = 0.15 },
                { type = "fluid", name = "water", amount_min = 1, amount_max = 5, probability = 0.5, },
                { type = "fluid", name = "ei-tailing-slurry", amount_min = 1, amount_max = 5, probability = 0.35, ignored_by_productivity = 1000, }
            },
            crafting_machine_tint = crafting_machine_tint,
        },
        -- MATERIAL
        {
            type = "recipe",
            name = "ei-purified-tin-ore-smelting",
            localised_name = { "recipe-name.ei-purified-tin-ore-smelting" },
            icons =
            {
                { icon = "__enriching-industry__/graphics/icons/enriched-tin-ore.png", shift = { -12, -12 }, scale = 0.4, },
                { icon = "__bztin__/graphics/icons/tin-plate.png", icon_size = 128, draw_background = true, scale = 0.25, },
            },
            category = alloy_smelting and "kiln-smelting" or "smelting",
            subgroup = "raw-material",
            order = "d[tin-plate]-c[crushed]-a[smelting]-d[enriched]-c[stage-1]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            energy_required = alloy_smelting and 4.8 or space_age and 9.6 or 4.8,
            ingredients =
            {
                { type = "item",  name = "ei-purified-tin-ore", amount = alloy_smelting and 2 or space_age and 4 or 2 },
                { type = "item",  name = alloy_smelting and "coke" or space_age and "carbon" or "coal", amount = 1 },
            },
            results =
            {
                { type = "item",  name = "tin-plate", amount = alloy_smelting and 2 or space_age and 4 or 2, },
            },
        },
        {
            type = "recipe",
            name = "ei-enriched-tin-ore-smelting",
            localised_name = { "recipe-name.ei-enriched-tin-ore-smelting" },
            icons =
            {
                { icon = "__bztin__/graphics/icons/enriched-tin.png", icon_size = 128, shift = { -12, -12 }, scale = 0.4 * 0.5, },
                { icon = "__bztin__/graphics/icons/tin-plate.png", icon_size = 128, draw_background = true, scale = 0.25, },
            },
            category = alloy_smelting and "kiln-smelting" or "smelting",
            subgroup = "raw-material",
            order = "d[tin-plate]-c[crushed]-a[smelting]-d[enriched]-c[stage-2]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            energy_required = alloy_smelting and 4.8 or space_age and 9.6 or 4.8,
            ingredients =
            {
                { type = "item",  name = "ei-enriched-tin-ore", amount = alloy_smelting and 2 or space_age and 4 or 2 },
                { type = "item",  name = alloy_smelting and "coke" or space_age and "carbon" or "coal", amount = 1 },
            },
            results =
            {
                { type = "item",  name = "tin-plate", amount = alloy_smelting and 2 or space_age and 4 or 2, },
            },
        },
    })
end
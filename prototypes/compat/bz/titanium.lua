local Util = require("__core__.lualib.util")

local ei_washing_extra = settings.startup["ei-wash-bonus-direct-ssgq"].value * 0.01

-- Crushing Industry Mod Settings
local ci_ore_crushing = settings.startup["crushing-industry-ore"].value
local ci_hide_player_crafting = settings.startup["crushing-industry-hide-player-crafting"].value

--[[ Fluids ]]
data:extend({
    {
        type = "fluid",
        name = "ei-tailing-slurry-titanium",
        icon = "__enriching-industry__/graphics/icons/tailing-slurry-titanium.png",
        subgroup = "fluid",
        order = "a[fluid]-d[chemicals]-b[tailings]",
        hidden = not ci_ore_crushing,
        auto_barrel = ci_ore_crushing,
        default_temperature = 25,
        max_temperature = 100,
        heat_capacity = "0.01kJ",
        base_color = { r = 103, g = 103, b = 103, a = 1, }, -- #676767
        flow_color = { r = 155, g = 152, b = 140, a = 1, }, -- #9b988c
        visualization_color = { r = 103, g = 103, b = 103, a = 1, }, -- #676767
    }
})

--[[ Items ]]
data:extend({
    {
        type = "item",
        name = "ei-pseudobrookite",
        icon = "__enriching-industry__/graphics/icons/pseudobrookite-1.png",
        icon_size = 64,
        pictures =
        {
            { size = 64, filename = "__enriching-industry__/graphics/icons/pseudobrookite.png",   scale = 0.5, mipmap_count = 1 },
            { size = 64, filename = "__enriching-industry__/graphics/icons/pseudobrookite-1.png", scale = 0.5, mipmap_count = 1 },
            { size = 64, filename = "__enriching-industry__/graphics/icons/pseudobrookite-2.png", scale = 0.5, mipmap_count = 1 },
            { size = 64, filename = "__enriching-industry__/graphics/icons/pseudobrookite-3.png", scale = 0.5, mipmap_count = 1 },
        },
        subgroup = "raw-resource",
        order = "d[titanium-ore]-d[enriched]-d[stage-1]",
        hidden = not ci_ore_crushing,
        stack_size = 100,
        weight = 2 * kg,
    },
    {
        type = "item",
        name = "ei-reduced-ilmenite",
        icon = "__enriching-industry__/graphics/icons/enriched-titanium-ore.png",
        icon_size = 64,
        pictures =
        {
            { size = 64, filename = "__enriching-industry__/graphics/icons/enriched-titanium-ore.png",   scale = 0.5, mipmap_count = 1 },
            { size = 64, filename = "__enriching-industry__/graphics/icons/enriched-titanium-ore-1.png", scale = 0.5, mipmap_count = 1 },
            { size = 64, filename = "__enriching-industry__/graphics/icons/enriched-titanium-ore-2.png", scale = 0.5, mipmap_count = 1 },
            { size = 64, filename = "__enriching-industry__/graphics/icons/enriched-titanium-ore-3.png", scale = 0.5, mipmap_count = 1 },
        },
        subgroup = "raw-resource",
        order = "d[titanium-ore]-d[enriched]-d[stage-2]",
        hidden = not ci_ore_crushing,
        stack_size = 100,
        weight = 2 * kg,
    },
    {
        type = "item",
        name = "ei-enriched-titanium-ore",
        icon = "__bztitanium__/graphics/icons/enriched-titanium.png",
        icon_size = 64,
        pictures =
        {
            { size = 64, filename = "__bztitanium__/graphics/icons/enriched-titanium.png",   scale = 0.5, mipmap_count = 1 },
            { size = 64, filename = "__bztitanium__/graphics/icons/enriched-titanium-2.png", scale = 0.5, mipmap_count = 1 },
            { size = 64, filename = "__bztitanium__/graphics/icons/enriched-titanium-3.png", scale = 0.5, mipmap_count = 1 },
            { size = 64, filename = "__bztitanium__/graphics/icons/enriched-titanium-4.png", scale = 0.5, mipmap_count = 1 },
        },
        subgroup = "raw-resource",
        order = "d[titanium-ore]-d[enriched]-d[stage-3]",
        hidden = not ci_ore_crushing,
        stack_size = 100,
        weight = 2 * kg,
    },
})

--[[ Recipes ]]
if (ci_ore_crushing) then
    local ei_titanium_smelting_ingredients =
    {
        { type = "item", name = "ei-enriched-titanium-ore", amount = 10, },
    }

    if (type(mods) == "table" and mods["alloy-smelting"]) then
        table.insert(ei_titanium_smelting_ingredients, { type = "item", name = "coke", amount = 2 })
    end

    local foundry_smelting_icons = Util.table.deepcopy(data.raw["recipe"]["titanium-in-foundry"].icons)

    local crafting_machine_tint =
    {
        primary = { r = 155, g = 152, b = 140, a = 1, }, -- #9b988c
        secondary = { r = 103, g = 103, b = 103, a = 1, }, -- #676767
        tertiary = { r = 155, g = 152, b = 140, a = 1, }, -- #9b988c
        quaternary = { r = 103, g = 103, b = 103, a = 1, }, -- #676767
    }

    data:extend({
        {
            type = "recipe",
            name = "ei-enriched-titanium-ore-sulfate",
            icons =
            {
                {
                    icon = "__crushing-industry__/graphics/icons/compat/crushed-titanium-ore.png",
                    icon_size = 64,
                    shift = { 0, 6, },
                    scale = 0.75,
                    draw_background = true,
                },
                {
                    icon = "__base__/graphics/icons/fluid/sulfuric-acid.png",
                    icon_size = 64,
                    shift = { -15, -10, },
                    scale = 0.4,
                    draw_background = true,
                },
                {
                    icon = "__base__/graphics/icons/fluid/sulfuric-acid.png",
                    icon_size = 64,
                    shift = { 15, -10, },
                    scale = 0.4,
                    draw_background = true,
                },
            },
            localised_name = { "recipe-name.ei-enriched-titanium-ore-sulfate" },
            category = type(mods) == "table" and mods["space-age"] and "chemistry-or-cryogenics" or "chemistry",
            order = "c[chemistry]-f[titanium-ore]-d[enriched]-b[direct]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            energy_required = 96,
            ingredients =
            {
                { type = "item",  name = "titanium-ore",    amount = 20 },
                { type = "fluid", name = "sulfuric-acid",   amount = 250 },
            },
            results =
            {
                { type = "item",  name = "ei-enriched-titanium-ore",    amount_min = 20, amount_max = 30 },
                { type = "fluid", name = "ei-sulfuric-iron-solution",   amount_min = 2, amount_max = 15, ignored_by_productivity = 1000 },
                { type = "fluid", name = "ei-tailing-slurry-titanium",  amount = 10, ignored_by_productivity = 1000 },
                EnrichingIndustry.make_washing_byproduct("titanium-ore", EnrichingIndustry.STANDARD_BYPRODUCT),
            },
            main_product = "ei-enriched-titanium-ore",
            crafting_machine_tint = crafting_machine_tint,
        },
        {
            type = "recipe",
            name = "ei-enriched-titanium-ore-becher-oxidation",
            icons =
            {
                { icon = "__crushing-industry__/graphics/icons/compat/crushed-titanium-ore.png", shift = { -12, -12 }, scale = 0.4, },
                { icon = "__enriching-industry__/graphics/icons/pseudobrookite-1.png", draw_background = true, }
            },
            localised_name = { "recipe-name.ei-enriched-titanium-ore-becher-oxidation" },
            category = type(mods) == "table" and mods["alloy-smelting"] and "kiln-smelting" or "smelting",
            order = type(mods) == "table" and mods["alloy-smelting"] and "f[titanium-ore]-a[kiln-smelting]-d[enriched]-c[stage-1]-c[oxidation]" or "f[titanium-ore]-a[smelting]-d[enriched]-c[stage-1]-c[oxidation]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            energy_required = 9.6,
            ingredients =
            {
                { type = "item",  name = "crushed-titanium-ore", amount = 1 },
            },
            results =
            {
                { type = "item",  name = "ei-pseudobrookite", amount = 1, extra_count_fraction = ei_washing_extra },
                { type = "item",  name = "ei-enriched-iron-ore", amount_min = 0, amount_max = 2, probability = 0.15 },
            },
            main_product = "ei-pseudobrookite",
            crafting_machine_tint = crafting_machine_tint,
        },
        {
            type = "recipe",
            name = "ei-enriched-titanium-ore-becher-reduction",
            icons =
            {
                { icon = "__enriching-industry__/graphics/icons/pseudobrookite-1.png", shift = { -12, -12 }, scale = 0.4, },
                { icon = "__enriching-industry__/graphics/icons/enriched-titanium-ore.png", draw_background = true, }
            },
            localised_name = { "recipe-name.ei-enriched-titanium-ore-becher-reduction" },
            category = type(mods) == "table" and mods["alloy-smelting"] and "kiln-smelting" or "smelting",
            order = type(mods) == "table" and mods["alloy-smelting"] and "f[titanium-ore]-a[kiln-smelting]-d[enriched]-c[stage-2]-c[reduction]" or "f[titanium-ore]-a[smelting]-d[enriched]-c[stage-2]-c[reduction]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            energy_required = 9.6,
            ingredients =
            {
                { type = "item",  name = "ei-pseudobrookite",   amount = 1 },
                { type = "item",  name = "crushed-coal",        amount = 1 },
                { type = "item",  name = "sulfur",              amount = 1 },
            },
            results =
            {
                { type = "item",  name = "ei-reduced-ilmenite", amount = 1, extra_count_fraction = ei_washing_extra },
                type(mods) == "table" and mods["space-age"] and { type = "item", name = "carbon", amount = 1, probability = 0.05, ignored_by_productivity = 1000, } or nil,
            },
            main_product = "ei-reduced-ilmenite",
            crafting_machine_tint = crafting_machine_tint,
        },
        {
            type = "recipe",
            name = "ei-enriched-titanium-ore-becher-leaching",
            icons =
            {
                { icon = "__enriching-industry__/graphics/icons/enriched-titanium-ore.png", shift = { -12, -12 }, scale = 0.4, },
                { icon = "__bztitanium__/graphics/icons/enriched-titanium.png", draw_background = true, }
            },
            localised_name = { "recipe-name.ei-enriched-titanium-ore-becher-leaching" },
            category = type(mods) == "table" and mods["space-age"] and "chemistry-or-cryogenics" or "chemistry",
            order = "f[titanium-ore]-a[chemistry]-d[enriched]-c[stage-3]-d[leaching]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            energy_required = 8,
            ingredients =
            {
                { type = "item",  name = "ei-reduced-ilmenite", amount = 1 },
                { type = "fluid", name = "sulfuric-acid",       amount = 15 },
            },
            results =
            {
                { type = "item",  name = "ei-enriched-titanium-ore",   amount = 1,  extra_count_fraction = ei_washing_extra },
                { type = "fluid", name = "ei-sulfuric-iron-solution",  amount_min = 1, amount_max = 5, },
                { type = "fluid", name = "ei-tailing-slurry-titanium", amount = 10, ignored_by_productivity = 1000 },
            },
            main_product = "ei-enriched-titanium-ore",
            crafting_machine_tint = crafting_machine_tint,
        },
        -- MATERIAL
        {
            type = "recipe",
            name = "ei-enriched-titanium-smelting",
            icons = EnrichingIndustry.make_smelting_icons("ei-enriched-titanium-ore", "titanium-plate"),
            category = type(mods) == "table" and mods["alloy-smelting"] and "kiln-smelting" or "smelting",
            order = type(mods) == "table" and mods["alloy-smelting"] and "f[titanium-plate]-a[kiln-smelting]-b[titanium-]-d[enriched]" or "f[titanium-plate]-a[smelting]-d[enriched]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            hide_from_player_crafting = ci_hide_player_crafting == true,
            energy_required = 8,
            ingredients = ei_titanium_smelting_ingredients,
            results =
            {
                { type = "item", name = "titanium-plate", amount = 1 },
            },
            main_product = "titanium-plate",
        },
        type(mods) == "table" and mods["space-age"] and {
            type = "recipe",
            name = "ei-enriched-titanium-smelting-metallurgy",
            icons = foundry_smelting_icons,
            category = "metallurgy",
            order = "a[metallurgy]-b[titanium-plate]-d[enriched]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            hide_from_player_crafting = ci_hide_player_crafting == true,
            energy_required = 8,
            ingredients =
            {
                { type = "item", name = "ei-enriched-titanium-ore", amount = 4, },
                { type = "item", name = "carbon", amount = 1, },
                { type = "fluid", name = "vacuum", amount = 10, },
            },
            results =
            {
                { type = "item", name = "titanium-plate", amount = 1 },
            },
            main_product = "titanium-plate",
        } or nil,
        {
            type = "recipe",
            name = "ei-tailing-slurry-filtering-titanium",
            icon = "__enriching-industry__/graphics/icons/tailing-slurry-filtering-titanium.png",
            category = type(mods) == "table" and mods["space-age"] and "chemistry-or-cryogenics" or "chemistry",
            subgroup = "fluid-recipes",
            order = "d[other-chemistry]-D[tailing-slurry-processing]-f[filtering]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            energy_required = 4.8,
            ingredients =
            {
                { type = "fluid", name = "ei-tailing-slurry-titanium", amount = 100, },
            },
            results =
            {
                { type = "fluid", name = "ei-tailing-slurry",    amount = 10, },
                { type = "fluid", name = "water",                amount = 90, ignored_by_productivity = 1000, },
                { type = "item",  name = "ei-enriched-titanium-ore", amount_min = 0, amount_max = 1, probability = 0.02, },
                { type = "item",  name = "titanium-ore",             amount_min = 0, amount_max = 2, probability = 0.05, },
            },
            main_product = "ei-tailing-slurry",
            crafting_machine_tint = crafting_machine_tint,
        },
        {
            type = "recipe",
            name = "ei-tailing-slurry-reprocessing-titanium",
            icons =
            {
                {
                    icon = "__base__/graphics/icons/fluid/sulfuric-acid.png",
                    icon_size = 64,
                    shift = { -15, 10 },
                    scale = 0.48,
                    draw_background = true,
                },
                {
                    icon = "__base__/graphics/icons/fluid/sulfuric-acid.png",
                    icon_size = 64,
                    shift = { 15, 10 },
                    scale = 0.48,
                    draw_background = true,
                },
                {
                    icon = "__enriching-industry__/graphics/icons/tailing-slurry-titanium.png",
                    icon_size = 64,
                    shift = { 0, -12 },
                    scale = 0.55,
                    draw_background = true,
                },
            },
            category = type(mods) == "table" and mods["space-age"] and "chemistry-or-cryogenics" or "chemistry",
            subgroup = "fluid-recipes",
            order = "d[other-chemistry]-D[tailing-slurry-processing]-f[reprocessing]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            energy_required = 4.8,
            ingredients =
            {
                { type = "fluid", name = "ei-tailing-slurry-titanium", amount = 100, },
                { type = "fluid", name = "sulfuric-acid",              amount = 15, },
            },
            results =
            {
                { type = "fluid", name = "ei-tailing-slurry",        amount = 10, },
                { type = "item",  name = "ei-enriched-titanium-ore", amount = 1, probability = 0.35, },
            },
            main_product = "ei-tailing-slurry",
            crafting_machine_tint = crafting_machine_tint,
        },
    })
end
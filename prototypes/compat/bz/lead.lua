local ei_washing_extra = settings.startup["ei-washing-extra"].value * 0.01

-- Crushing Industry Mod Settings
local ci_ore_crushing = settings.startup["crushing-industry-ore"].value
local ci_hide_player_crafting = settings.startup["crushing-industry-hide-player-crafting"].value

--[[ Fluids ]]
data:extend({
    {
        type = "fluid",
        name = "ei-tailing-slurry-lead",
        icon = "__enriching-industry__/graphics/icons/tailing-slurry-lead.png",
        subgroup = "fluid",
        order = "a[fluid]-d[chemicals]-b[tailings]",
        hidden = not ci_ore_crushing,
        auto_barrel = ci_ore_crushing,
        default_temperature = 25,
        max_temperature = 100,
        heat_capacity = "0.01kJ",
        base_color = { r = 116, g = 83, b = 89, a = 1, }, -- #745359
        flow_color = { r = 78, g = 67, b = 69, a = 1, }, -- #4e4345
        visualization_color = { r = 116, g = 83, b = 89, a = 1, }, -- #745359
    }
})

--[[ Items ]]
data:extend({
    {
        type = "item",
        name = "ei-enriched-lead-ore",
        icon = "__enriching-industry__/graphics/icons/enriched-lead-ore.png",
        icon_size = 64,
        pictures =
        {
            { size = 64, filename = "__enriching-industry__/graphics/icons/enriched-lead-ore.png",   scale = 0.5, mipmap_count = 1 },
            { size = 64, filename = "__enriching-industry__/graphics/icons/enriched-lead-ore-1.png", scale = 0.5, mipmap_count = 1 },
            { size = 64, filename = "__enriching-industry__/graphics/icons/enriched-lead-ore-2.png", scale = 0.5, mipmap_count = 1 },
            { size = 64, filename = "__enriching-industry__/graphics/icons/enriched-lead-ore-3.png", scale = 0.5, mipmap_count = 1 },
        },
        subgroup = "raw-resource",
        order = "g-d[lead-ore]-d[enriched]",
        hidden = not ci_ore_crushing,
        stack_size = 100,
        weight = 2 * kg,
    },
})

--[[ Recipes ]]
if (ci_ore_crushing) then
    local ei_lead_smelting_ingredients =
    {
        { type = "item", name = "ei-enriched-lead-ore", amount = 1, },
    }

    local multiplier = 1

    if (type(mods) == "table" and mods["alloy-smelting"]) then
        table.insert(ei_lead_smelting_ingredients, { type = "item", name = "coke", amount = 1 })

        multiplier = 2
        ei_lead_smelting_ingredients[1].amount = ei_lead_smelting_ingredients[1].amount * multiplier
    end

    local crafting_machine_tint =
    {
        primary = { r = 116, g = 83, b = 89, a = 1, }, -- #745359
        secondary = { r = 78, g = 67, b = 69, a = 1, }, -- #4e4345
        tertiary = { r = 89, g = 65, b = 71, a = 1, }, -- #594147
        quaternary = { r = 55, g = 47, b = 48, a = 1, }, -- #372f30
    }

    data:extend({
        {
            type = "recipe",
            name = "ei-enriched-lead-ore",
            icons = EnrichingIndustry.make_washing_icons("crushed-lead-ore"),
            localised_name = { "recipe-name.ei-enriched-lead-ore" },
            category = type(mods) == "table" and mods["space-age"] and "chemistry-or-cryogenics" or "chemistry",
            order = "f[lead-ore]-d[enriched]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            energy_required = 1.2,
            ingredients =
            {
                { type = "item",  name = "crushed-lead-ore", amount = 1 },
                { type = "fluid", name = "water",            amount = 10 },
            },
            results =
            {
                { type = "item",  name = "ei-enriched-lead-ore",   amount = 1,  extra_count_fraction = ei_washing_extra },
                { type = "fluid", name = "ei-tailing-slurry-lead", amount = 10, ignored_by_productivity = 1000 },
                EnrichingIndustry.make_washing_byproduct("crushed-lead-ore", EnrichingIndustry.STANDARD_BYPRODUCT),
                EnrichingIndustry.make_washing_byproduct("lead-ore", EnrichingIndustry.FLAVOR_BYPRODUCT),
            },
            main_product = "ei-enriched-lead-ore",
            crafting_machine_tint = crafting_machine_tint,
        },
        -- MATERIAL
        {
            type = "recipe",
            name = "ei-enriched-lead-smelting",
            icons = EnrichingIndustry.make_smelting_icons("ei-enriched-lead-ore", "lead-plate"),
            category = type(mods) == "table" and mods["alloy-smelting"] and "kiln-smelting" or "smelting",
            order = "a[smelting]-b[lead-plate]-d[enriched]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            hide_from_player_crafting = ci_hide_player_crafting == true,
            energy_required = 3.2 * multiplier,
            ingredients = ei_lead_smelting_ingredients,
            results =
            {
                { type = "item", name = "lead-plate", amount = 1 * multiplier },
            },
            main_product = "lead-plate",
        },
        {
            type = "recipe",
            name = "ei-tailing-slurry-filtering-lead",
            icon = "__enriching-industry__/graphics/icons/tailing-slurry-filtering-lead.png",
            category = type(mods) == "table" and mods["space-age"] and "chemistry-or-cryogenics" or "chemistry",
            subgroup = "fluid-recipes",
            order = "d[other-chemistry]-D[tailing-slurry-processing]-f[filtering]",
            enabled = false,
            allow_productivity = true,
            auto_recycle = false,
            energy_required = 2.4,
            ingredients =
            {
                { type = "fluid", name = "ei-tailing-slurry-lead", amount = 100, },
            },
            results =
            {
                { type = "fluid", name = "ei-tailing-slurry",    amount = 10, },
                { type = "fluid", name = "water",                amount = 90, ignored_by_productivity = 1000, },
                { type = "item",  name = "ei-enriched-lead-ore", amount_min = 0, amount_max = 2, probability = 0.02, },
                { type = "item",  name = "crushed-lead-ore",     amount_min = 0, amount_max = 2, probability = 0.05, },
                { type = "item",  name = "lead-ore",             amount_min = 0, amount_max = 1, probability = 0.125, },
            },
            main_product = "ei-tailing-slurry",
            crafting_machine_tint = crafting_machine_tint,
        },
        {
            type = "recipe",
            name = "ei-tailing-slurry-reprocessing-lead",
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
                    icon = "__enriching-industry__/graphics/icons/tailing-slurry-lead.png",
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
                { type = "fluid", name = "ei-tailing-slurry-lead", amount = 100, },
                { type = "fluid", name = "sulfuric-acid",          amount = 10, },
            },
            results =
            {
                { type = "fluid", name = "ei-tailing-slurry",       amount = 10, },
                { type = "item",  name = "ei-enriched-lead-ore",    amount_min = 1, amount_max = 2, },
                { type = "item",  name = "crushed-lead-ore",        amount_min = 0, amount_max = 2, probability = 0.125, },
                { type = "fluid", name = "ei-tailing-slurry-lead",  amount_min = 1, amount_max = 12.5, },
            },
            main_product = "ei-tailing-slurry",
            crafting_machine_tint = crafting_machine_tint,
        },
    })
end
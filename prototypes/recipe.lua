local util = require("__enriching-industry__.api")

local ei_washing_extra = settings.startup["ei-washing-extra"].value * 0.01
local ei_quartz_extra = settings.startup["ei-quartz-extra"].value * 0.01
local ei_leaching_amount = settings.startup["ei-leaching-extra"].value * 0.1 + 10
local ei_recrystall_extra = settings.startup["ei-recrystall-extra"].value * 0.01
--local ei_recrystall_byprod_extra = settings.startup["ei-recrystall-byprod-extra"].value * 0.01

-- Crushing Industry Mod Settings
local ci_glass = settings.startup["crushing-industry-glass"].value
local ci_ore_crushing = settings.startup["crushing-industry-ore"].value
local ci_concrete_mix = settings.startup["crushing-industry-concrete-mix"].value
local ci_hide_player_crafting = settings.startup["crushing-industry-hide-player-crafting"].value

-- If CI-glass is false, only do for AAI if K2 is not present
if ci_glass or (mods["aai-industry"] and not mods["Krastorio2"]) then
	data:extend(
	{
		{
			type = "recipe",
			name = "ei-quartz",
			icons = EnrichingIndustry.make_washing_icons("sand"),
			localised_name = {"recipe-name.ei-quartz"},
			category = mods["space-age"] and "chemistry-or-cryogenics" or "chemistry",
--			order = "d[stone]-d[quartz]",
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			energy_required = 1.2,
			ingredients = {
				{type="item", name="sand", amount=1},
				{type="fluid", name="water", amount=10}
			},
			results = {
				{type="item", name="ei-quartz", amount=1, extra_count_fraction=ei_quartz_extra},
				{type="fluid", name="ei-tailing-slurry", amount=10, ignored_by_productivity=1000},
				EnrichingIndustry.make_washing_byproduct("sand", EnrichingIndustry.STANDARD_BYPRODUCT),
				EnrichingIndustry.make_washing_byproduct("stone", EnrichingIndustry.FLAVOR_BYPRODUCT),
			},
			main_product = "ei-quartz",
			crafting_machine_tint =
			{
				primary = {r = 0.75, g = 0.75, b = 0.75, a = 1.000}, --	#C0C0C0	silver
				secondary = {r = 1.00, g = 1.00, b = 1.00, a = 1.000},--	#FFFFFF	white
				tertiary = {r = 0.75, g = 0.95, b = 1.00, a = 1.000},--	#BFEFFF	light blue1
				quaternary = {r = 1.00, g = 1.00, b = 0.67, a = 1.000}, --	#FFFFAA	popcornyellow
			}
		},
		{
			type = "recipe",
			name = "ei-quartz-smelting",
			localised_name = {"recipe-name.ei-quartz-smelting"},
			icons = EnrichingIndustry.make_smelting_icons("ei-quartz", "glass"),
	-- 		icons = {
	-- 			{icon="__enriching-industry__/graphics/icons/enriched-iron-ore.png", shift={-12, -12}, scale=0.4},
	-- 			{icon="__base__/graphics/icons/iron-plate.png", draw_background=true}
	-- 		},
			category = "smelting",
--			order = "a[smelting]-a[iron-plate]-d[enriched]",
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
	--		hide_from_player_crafting = settings.startup["crushing-industry-hide-player-crafting"].value,
			hide_from_player_crafting = ci_hide_player_crafting == true,
			energy_required = 6.4,
			ingredients = {{type="item", name="ei-quartz", amount=5}},
			results = {{type="item", name="glass", amount=2}},
			main_product = "glass"
		}
	}
	)
end

if ci_ore_crushing then
	data:extend(
	{
		{
			type = "recipe",
			name = "ei-enriched-iron-ore",
			icons = EnrichingIndustry.make_washing_icons("crushed-iron-ore"),
			localised_name = {"recipe-name.ei-enriched-iron-ore"},
			category = mods["space-age"] and "chemistry-or-cryogenics" or "chemistry",
			order = "e[iron-ore]-d[enriched]",
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			energy_required = 1.2,
			ingredients = {
				{type="item", name="crushed-iron-ore", amount=1},
				{type="fluid", name="water", amount=10}
			},
			results = {
				{type="item", name="ei-enriched-iron-ore", amount=1, extra_count_fraction=ei_washing_extra},
				{type="fluid", name="ei-tailing-slurry", amount=10, ignored_by_productivity=1000},
				EnrichingIndustry.make_washing_byproduct("crushed-iron-ore", EnrichingIndustry.STANDARD_BYPRODUCT),
				EnrichingIndustry.make_washing_byproduct("iron-ore", EnrichingIndustry.FLAVOR_BYPRODUCT),
			},
			main_product = "ei-enriched-iron-ore",
			crafting_machine_tint =
			{
	--			secondary = {r = 0.75, g = 0.95, b = 1.00, a = 1.000},--	#BFEFFF	light blue1
	--			secondary = {r = 0.00, g = 0.75, b = 1.00, a = 1.000},--	#00BFFF	deepskyblue
	--			primary = {r = 0.75, g = 0.75, b = 0.75, a = 1.000}, --	#C0C0C0	silver
				primary = {r = 0.75, g = 0.95, b = 1.00, a = 1.000},--	#BFEFFF	light blue1
				secondary = {r = 0.40, g = 0.78, b = 1.00, a = 1.000},--	#67C8FF	neon blue
				tertiary = {r = 0.75, g = 0.95, b = 1.00, a = 1.000},--	#BFEFFF	light blue1
				quaternary = {r = 0.40, g = 0.78, b = 1.00, a = 1.000},--	#67C8FF	neon blue
	-- 			primary = {r = 0.75, g = 0.95, b = 1.00, a = 1.000},--	#BFEFFF	light blue1
	-- 			secondary = {r = 0.75, g = 0.75, b = 0.75, a = 1.000}, --	#C0C0C0	silver
	-- 			tertiary = {r = 0.75, g = 0.95, b = 1.00, a = 1.000},--	#BFEFFF	light blue1
	-- 			quaternary = {r = 0.75, g = 0.75, b = 0.75, a = 1.000}, --	#C0C0C0	silver
			}
		},
		{
			type = "recipe",
			name = "ei-enriched-copper-ore",
			icons = EnrichingIndustry.make_washing_icons("crushed-copper-ore"),
			localised_name = {"recipe-name.ei-enriched-copper-ore"},
			category = mods["space-age"] and "chemistry-or-cryogenics" or "chemistry",
			order = "f[copper-ore]-d[enriched]",
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			energy_required = 1.2,
			ingredients = {
				{type="item", name="crushed-copper-ore", amount=1},
				{type="fluid", name="water", amount=10}
			},
			results = {
				{type="item", name="ei-enriched-copper-ore", amount=1, extra_count_fraction=ei_washing_extra},
				{type="fluid", name="ei-tailing-slurry", amount=10, ignored_by_productivity=1000},
				EnrichingIndustry.make_washing_byproduct("crushed-copper-ore", EnrichingIndustry.STANDARD_BYPRODUCT),
				EnrichingIndustry.make_washing_byproduct("copper-ore", EnrichingIndustry.FLAVOR_BYPRODUCT),
			},
			main_product = "ei-enriched-copper-ore",
			crafting_machine_tint =
			{
	--			secondary = {r = 0.72, g = 0.45, b = 0.20, a = 1.000},--	#B87333	copper
	--			primary = {r = 0.75, g = 0.75, b = 0.75, a = 1.000}, --	#C0C0C0	silver
				primary = {r = 0.93, g = 0.76, b = 0.58, a = 1.000}, --	#EDC393	light copper
				secondary = {r = 0.85, g = 0.53, b = 0.10, a = 1.000},--	#D98719	cool copper
				tertiary = {r = 0.93, g = 0.76, b = 0.58, a = 1.000}, --	#EDC393	light copper
				quaternary = {r = 0.85, g = 0.53, b = 0.10, a = 1.000},--	#D98719	cool copper
			}
		},
		{
			type = "recipe",
			name = "ei-sulfuric-iron-leaching",
	--		icons = EnrichingIndustry.make_washing_icons("crushed-iron-ore"),
			localised_name = {"recipe-name.ei-sulfuric-iron-leaching"},
			category = mods["space-age"] and "chemistry-or-cryogenics" or "chemistry",
			subgroup = "raw-resource",--fluid-recipes",
			order = "e[iron-ore]-e[leached]",
	--		order = "d[other-chemistry]-e[iron-ore]-d[sulfuric-solution]",
	--		factoriopedia_alternative = "ei-sulfuric-iron-solution",
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			energy_required = 1.2,
			ingredients = {
				{type="item", name="crushed-iron-ore", amount=1},
				{type="fluid", name="water", amount=10},
				{type="fluid", name="sulfuric-acid", amount=5}
			},
			results = {
				{type="fluid", name="ei-sulfuric-iron-solution", amount=ei_leaching_amount},
	--			EnrichingIndustry.make_washing_byproduct("sand", EnrichingIndustry.COMMON_BYPRODUCT),
	--			EnrichingIndustry.make_washing_byproduct("stone"),
			},
			main_product = "ei-sulfuric-iron-solution",
			crafting_machine_tint =
			{
				primary = {r = 0.75, g = 0.95, b = 1.00, a = 1.000},--	#BFEFFF	light blue1
				secondary = {r = 0.40, g = 0.78, b = 1.00, a = 1.000},--	#67C8FF	neon blue
				tertiary = {r = 0.75, g = 0.95, b = 1.00, a = 1.000},--	#BFEFFF	light blue1
				quaternary = {r = 1.00, g = 1.00, b = 0.49, a = 1.000},--	#FFFF7E	papaya
			}
		},
		{
			type = "recipe",
			name = "ei-sulfuric-copper-leaching",
	--		icons = EnrichingIndustry.make_washing_icons("crushed-copper-ore"),
			localised_name = {"recipe-name.ei-sulfuric-copper-leaching"},
			category = mods["space-age"] and "chemistry-or-cryogenics" or "chemistry",
			subgroup = "raw-resource",--fluid-recipes",
			order = "f[copper-ore]-e[leached]",
	--		order = "d[other-chemistry]-f[copper-ore]-d[sulfuric-solution]",
	--		factoriopedia_alternative = "ei-sulfuric-copper-solution",
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			energy_required = 1.2,
			ingredients = {
				{type="item", name="crushed-copper-ore", amount=1},
				{type="fluid", name="water", amount=10},
				{type="fluid", name="sulfuric-acid", amount=5}
			},
			results = {
				{type="fluid", name="ei-sulfuric-copper-solution", amount=ei_leaching_amount},
	--			EnrichingIndustry.make_washing_byproduct("sand", EnrichingIndustry.COMMON_BYPRODUCT),
	--			EnrichingIndustry.make_washing_byproduct("stone"),
			},
			main_product = "ei-sulfuric-copper-solution",
			crafting_machine_tint =
			{
				primary = {r = 0.93, g = 0.76, b = 0.58, a = 1.000}, --	#EDC393	light copper
				secondary = {r = 0.85, g = 0.53, b = 0.10, a = 1.000},--	#D98719	cool copper
				tertiary = {r = 0.93, g = 0.76, b = 0.58, a = 1.000}, --	#EDC393	light copper
				quaternary = {r = 1.00, g = 1.00, b = 0.49, a = 1.000},--	#FFFF7E	papaya
			}
		},
		{
			type = "recipe",
			name = "ei-enriched-iron-ore-recrystallization",
			icons = EnrichingIndustry.make_smelting_icons("ei-sulfuric-iron-solution", "ei-enriched-iron-ore", true),
			localised_name = {"recipe-name.ei-enriched-iron-ore-recrystallization"},
			category = mods["space-age"] and "chemistry-or-cryogenics" or "chemistry",
			order = "e[iron-ore]-f[recrystal]",
			factoriopedia_alternative = "ei-enriched-iron-ore",
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			energy_required = 0.6,
			ingredients = {
				{type="fluid", name="ei-sulfuric-iron-solution", amount=10}
			},
			results = {
				{type="item", name="ei-enriched-iron-ore", amount=1, extra_count_fraction=ei_recrystall_extra},
--				{type="item", name="ei-enriched-copper-ore", amount=0, extra_count_fraction=ei_recrystall_byprod_extra},
--				{type="item", name="sulfur", amount=1, extra_count_fraction=0.5},
				{type="fluid", name="water", amount=5, ignored_by_productivity=100},
--				EnrichingIndustry.make_washing_byproduct("sulfur", EnrichingIndustry.FREQUENT_BYPRODUCT)
			},
			main_product = "ei-enriched-iron-ore",
			crafting_machine_tint =
			{
				primary = {r = 0.93, g = 0.76, b = 0.58, a = 1.000}, --	#EDC393	light copper
				secondary = {r = 0.40, g = 0.78, b = 1.00, a = 1.000},--	#67C8FF	neon blue
				tertiary = {r = 0.75, g = 0.95, b = 1.00, a = 1.000},--	#BFEFFF	light blue1
				quaternary = {r = 0.40, g = 0.78, b = 1.00, a = 1.000},--	#67C8FF	neon blue
			}
		},
		{
			type = "recipe",
			name = "ei-enriched-copper-ore-recrystallization",
			icons = EnrichingIndustry.make_smelting_icons("ei-sulfuric-copper-solution", "ei-enriched-copper-ore", true),
			localised_name = {"recipe-name.ei-enriched-copper-ore-recrystallization"},
			category = mods["space-age"] and "chemistry-or-cryogenics" or "chemistry",
			order = "f[copper-ore]-f[recrystal]",
			factoriopedia_alternative = "ei-enriched-copper-ore",
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			energy_required = 0.6,
			ingredients = {
				{type="fluid", name="ei-sulfuric-copper-solution", amount=10}
			},
			results = {
				{type="item", name="ei-enriched-copper-ore", amount=1, extra_count_fraction=ei_recrystall_extra},
--				{type="item", name="ei-enriched-iron-ore", amount=0, extra_count_fraction=ei_recrystall_byprod_extra},
--				{type="item", name="sulfur", amount=1, extra_count_fraction=0.5},
				{type="fluid", name="water", amount=5, ignored_by_productivity=1000},
--				EnrichingIndustry.make_washing_byproduct("sulfur", EnrichingIndustry.FREQUENT_BYPRODUCT)
			},
			main_product = "ei-enriched-copper-ore",
			crafting_machine_tint =
			{
				primary = {r = 0.75, g = 0.95, b = 1.00, a = 1.000},--	#BFEFFF	light blue1
				secondary = {r = 0.85, g = 0.53, b = 0.10, a = 1.000},--	#D98719	cool copper
				tertiary = {r = 0.93, g = 0.76, b = 0.58, a = 1.000}, --	#EDC393	light copper
				quaternary = {r = 0.85, g = 0.53, b = 0.10, a = 1.000},--	#D98719	cool copper
			}
		},
	-- MATERIAL
		{
			type = "recipe",
			name = "ei-enriched-iron-smelting",
	--		localised_name = {"recipe-name.crushed-smelting", {"item-name.tin-plate"}},
			icons = EnrichingIndustry.make_smelting_icons("ei-enriched-iron-ore", "iron-plate"),
	-- 		icons = {
	-- 			{icon="__enriching-industry__/graphics/icons/enriched-iron-ore.png", shift={-12, -12}, scale=0.4},
	-- 			{icon="__base__/graphics/icons/iron-plate.png", draw_background=true}
	-- 		},
			category = "smelting",
			order = "a[smelting]-a[iron-plate]-d[enriched]",
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
	--		hide_from_player_crafting = settings.startup["crushing-industry-hide-player-crafting"].value,
			hide_from_player_crafting = ci_hide_player_crafting == true,
			energy_required = 3.2,
			ingredients = {{type="item", name="ei-enriched-iron-ore", amount=1}},
			results = {{type="item", name="iron-plate", amount=1}},
			main_product = "iron-plate",
		},
		{
			type = "recipe",
			name = "ei-enriched-copper-smelting",
	--		localised_name = {"recipe-name.crushed-smelting", {"item-name.tin-plate"}},
			icons = EnrichingIndustry.make_smelting_icons("ei-enriched-copper-ore", "copper-plate"),
	-- 		icons = {
	-- 			{icon="__enriching-industry__/graphics/icons/enriched-copper-ore.png", shift={-12, -12}, scale=0.4},
	-- 			{icon="__base__/graphics/icons/copper-plate.png", draw_background=true}
	-- 		},
			category = "smelting",
			order = "a[smelting]-b[copper-plate]-d[enriched]",
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
	--		hide_from_player_crafting = settings.startup["crushing-industry-hide-player-crafting"].value,
			hide_from_player_crafting = ci_hide_player_crafting == true,
			energy_required = 3.2,
			ingredients = {{type="item", name="ei-enriched-copper-ore", amount=1}},
			results = {{type="item", name="copper-plate", amount=1}},
			main_product = "copper-plate",
		},
		{
			type = "recipe",
			name = "ei-tailing-slurry-reprocessing",
			icon = "__enriching-industry__/graphics/icons/tailing-slurry-reprocessing.png",
	--		icons = EnrichingIndustry.make_smelting_icons("ei-tailing-slurry", "steam", true, true),
	-- 		icons = {
	-- 			{icon="__enriching-industry__/graphics/icons/fluid-droplet-tailings.png", shift={-12, -12}, scale=0.4},
	-- 			{icon="__base__/graphics/icons/fluid/steam.png", draw_background=true}
	-- 		},
			category = mods["space-age"] and "chemistry-or-cryogenics" or "chemistry",
			subgroup = "fluid-recipes",
			order = "d[other-chemistry]-D[tailing-slurry-processing]-f[reprocessing]",
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			energy_required = 4.8,
			ingredients = {
				{type="fluid", name="ei-tailing-slurry", amount=100},
				{type="fluid", name="sulfuric-acid", amount=10}
			},
			results = {
				{type="fluid", name="water", amount=90, ignored_by_productivity=1000},
				{type="item", name="ei-enriched-iron-ore", amount=1},--amount_min=0, amount_max=2},
				{type="item", name="ei-enriched-copper-ore", amount=1},--amount_min=0, amount_max=2},
	-- 			EnrichingIndustry.make_washing_byproduct("ei-enriched-iron-ore", 0.9),
	-- 			EnrichingIndustry.make_washing_byproduct("ei-enriched-copper-ore", 0.9),
	-- 			EnrichingIndustry.make_washing_byproduct("sand", EnrichingIndustry.FREQUENT_BYPRODUCT),
	-- 			EnrichingIndustry.make_washing_byproduct("stone", EnrichingIndustry.COMMON_BYPRODUCT),
	-- 			EnrichingIndustry.make_washing_byproduct("sulfur"),
			},
			main_product = "water",
			crafting_machine_tint =
			{
				primary = {r = 1.000, g = 1.000, b = 1.000, a = 1.000}, -- #fefeffff
				secondary = {r = 0.271, g = 0.271, b = 0.271, a = 1.000}, -- #c4c4c4ff
				tertiary = {r = 1.00, g = 1.00, b = 0.49, a = 1.000},--	#FFFF7E	papaya
				quaternary = {r = 0.67, g = 0.33, b = 0.01, a = 1.000}, --#AA5303	coffee
			}
		}
	-- PRODUCTION
	-- INTERMEDIATE
	}
	)
end

if ci_glass or ci_ore_crushing or mods["aai-industry"] then
	data:extend(
	{
		{
			type = "recipe",
			name = "ei-tailing-slurry-filtering",
			icon = "__enriching-industry__/graphics/icons/tailing-slurry-filtering.png",
	--		icons = EnrichingIndustry.make_smelting_icons("ei-tailing-slurry", "water", true, true),
	-- 		icons = {
	-- 			{icon="__enriching-industry__/graphics/icons/fluid-droplet-tailings.png", shift={-12, -12}, scale=0.4},
	-- 			{icon="__base__/graphics/icons/fluid/water.png", draw_background=true}
	-- 		},
			category = "crafting-with-fluid",
			subgroup = "fluid-recipes",
			order = "d[other-chemistry]-D[tailing-slurry-processing]-c[filtering]",
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			energy_required = 1,
			ingredients = {
				{type="fluid", name="ei-tailing-slurry", amount=100}
			},
			results = {
				{type="fluid", name="water", amount=90, ignored_by_productivity=1000},
	--			EnrichingIndustry.make_washing_byproduct("sand", EnrichingIndustry.FREQUENT_BYPRODUCT),
	--			EnrichingIndustry.make_washing_byproduct("stone", EnrichingIndustry.COMMON_BYPRODUCT),
	--			EnrichingIndustry.make_washing_byproduct("sulfur", EnrichingIndustry.FLAVOR_BYPRODUCT),
			},
			main_product = "water",
			crafting_machine_tint =
			{
				primary = {r = 1.000, g = 1.000, b = 1.000, a = 1.000}, -- #fefeffff
				secondary = {r = 0.271, g = 0.271, b = 0.271, a = 1.000}, -- #c4c4c4ff
				tertiary = {r = 0.75, g = 0.75, b = 0.75, a = 1.000}, --	#C0C0C0	silver
				quaternary = {r = 0.67, g = 0.33, b = 0.01, a = 1.000}, --#AA5303	coffee
			}
		}
	}
	)
	if ci_concrete_mix then
		data:extend(
		{
			{
				type = "recipe",
				name = "ei-concrete-mix-from-tailing-slurry",
				icon = "__enriching-industry__/graphics/icons/concrete-mix-from-tailing-slurry.png",
		--		icons = EnrichingIndustry.make_smelting_icons("ei-tailing-slurry", "concrete-mix", true, true),
		-- 		icons = {
		-- 			{icon="__enriching-industry__/graphics/icons/fluid-droplet-tailings.png", shift={-12, -12}, scale=0.4},
		-- 			{icon="__crushing-industry__/graphics/icons/fluid/concrete-mix.png", draw_background=true}
		-- 		},
				category = "crafting-with-fluid",
				subgroup = "fluid-recipes",
				order = "d[other-chemistry]-C[concrete-mix]f",
				enabled = false,
				allow_productivity = true,
				auto_recycle = false,
				energy_required = 1,
				ingredients = {
					{type="item", name="sand", amount=2},
					{type="fluid", name="ei-tailing-slurry", amount=100}
				},
				results = {
					{type="fluid", name="concrete-mix", amount=25}
				},
				main_product = "concrete-mix",
				crafting_machine_tint =
				{
					primary = {r = 1.000, g = 1.000, b = 1.000, a = 1.000}, -- #fefeffff
					secondary = {r = 0.271, g = 0.271, b = 0.271, a = 1.000}, -- #c4c4c4ff
					tertiary = {r = 1.00, g = 1.00, b = 0.67, a = 1.000}, --	#FFFFAA	popcornyellow
					quaternary = {r = 0.67, g = 0.33, b = 0.01, a = 1.000}, --#AA5303	coffee
				}
			},
		}
		)
	end
end

if mods["space-age"] then
	local ei_tungsten_extra = settings.startup["ei-tungsten-extra"].value * 0.01
	local ei_holmium_extra = settings.startup["ei-holmium-extra"].value * 0.01
	if ci_ore_crushing then
		data:extend(
		{
			{
				type = "recipe",
				name = "ei-enriched-tungsten-ore",
				icons = EnrichingIndustry.make_washing_icons("crushed-tungsten-ore"),
				localised_name = {"recipe-name.ei-enriched-tungsten-ore"},
				category = "chemistry-or-cryogenics",
				subgroup = "vulcanus-processes",
				order = "c[tungsten]-a[tungsten-ore]-d[enriched]",
				enabled = false,
				allow_productivity = true,
				auto_recycle = false,
				energy_required = 1.2,
				ingredients = {
					{type="item", name="crushed-tungsten-ore", amount=1},
					{type="fluid", name="water", amount=10}
				},
				results = {
					{type="item", name="ei-enriched-tungsten-ore", amount=1, extra_count_fraction=ei_tungsten_extra},
					{type="fluid", name="ei-tailing-slurry", amount=10, ignored_by_productivity=1000},
					EnrichingIndustry.make_washing_byproduct("crushed-tungsten-ore"),
					EnrichingIndustry.make_washing_byproduct("tungsten-ore", EnrichingIndustry.FLAVOR_BYPRODUCT),
				},
				main_product = "ei-enriched-tungsten-ore",
				crafting_machine_tint =
				{
					primary = {r = 1.000, g = 1.000, b = 1.000, a = 1.000}, -- #fefeffff
					secondary = {r = 0.271, g = 0.271, b = 0.271, a = 1.000}, -- #c4c4c4ff
					tertiary = {r = 0.068, g = 0.065, b = 0.062, a = 1.000}, -- #c3a9c2ff
					quaternary = {r = 0.000, g = 0.000, b = 0.000, a = 1.000}, -- #000000ff
				}
			},
			{
				type = "recipe",
				name = "ei-enriched-tungsten-carbide",
				localised_name = {"recipe-name.ei-enriched-tungsten-carbide"},
				icons = {
					{icon="__enriching-industry__/graphics/icons/enriched-tungsten-ore.png", shift={-12, -12}, scale=0.4},
					{icon="__space-age__/graphics/icons/tungsten-carbide.png", draw_background=true}
				},
				category = "crafting-with-fluid",
				subgroup = "vulcanus-processes",
				order = "c[tungsten]-b[tungsten-carbide]-c[enriched]",
				enabled = false,
				allow_productivity = true,
				auto_recycle = false,
				energy_required = 1,
				ingredients = {
					{type="item", name="ei-enriched-tungsten-ore", amount=4},
					{type="fluid", name="sulfuric-acid", amount=10},
					{type="item", name="carbon", amount=1}
				},
				results = {{type="item", name="tungsten-carbide", amount=1}},
				main_product = "tungsten-carbide"
			},
			{
				type = "recipe",
				name = "ei-enriched-holmium",
	--			icons = EnrichingIndustry.make_smelting_icons("holmium-solution", "ei-enriched-holmium", true),
	--			icons = EnrichingIndustry.make_washing_icons("holmium-powder"),
				localised_name = {"recipe-name.ei-enriched-holmium"},
				category = "chemistry-or-cryogenics",
				subgroup = "fulgora-processes",
				order = "b[holmium]-c[enriched-holmium]",
				enabled = false,
				allow_productivity = true,
				auto_recycle = false,
				energy_required = 6,
				ingredients = {
					{type="fluid", name="holmium-solution", amount=20}
				},
				results = {
					{type="item", name="ei-enriched-holmium", amount=1, extra_count_fraction=ei_holmium_extra},
					EnrichingIndustry.make_washing_byproduct("holmium-powder"),
					EnrichingIndustry.make_washing_byproduct("holmium-ore", EnrichingIndustry.FLAVOR_BYPRODUCT),
				},
				main_product = "ei-enriched-holmium",
				crafting_machine_tint =
				{
					primary = {r = 1.000, g = 1.000, b = 1.000, a = 1.000}, -- #fefeffff
					secondary = {r = 0.271, g = 0.271, b = 0.271, a = 1.000}, -- #c4c4c4ff
					tertiary = {r = 0.068, g = 0.065, b = 0.062, a = 1.000}, -- #c3a9c2ff
					quaternary = {r = 0.000, g = 0.000, b = 0.000, a = 1.000}, -- #000000ff
				}
			}
		}
		)
	end
end

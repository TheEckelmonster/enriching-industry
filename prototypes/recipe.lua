local util = require("__enriching-industry__.api")

-- Enriching Industry Mod Settings
local ei_leach_sulfuric_acid = settings.startup["ei-leach-sulfuric-acid"].value
local ei_productivity_precursor = settings.startup["ei-productivity-precursor"].value
-- Direct bonus
local ei_selection_bonus_direct = settings.startup["ei-selection-bonus-direct"].value
local ei_wash_bonus_direct_ssgq = {}
local ei_wash_bonus_direct = {}
local ei_leach_amount = {}
local ei_recry_bonus_direct = {}
-- Primary precursor bonus
local ei_selection_bonus_primprec = settings.startup["ei-selection-bonus-primprec"].value
local ei_wash_bonus_primprec_ssgq = {}
local ei_wash_bonus_primprec = {}
local ei_leach_bonus_primprec = {}
-- Secondary precursor bonus
local ei_selection_bonus_secoprec = settings.startup["ei-selection-bonus-secoprec"].value
local ei_wash_bonus_secoprec_ssgq = {}
local ei_wash_bonus_secoprec = {}
local ei_secoprec_leaching_extra = {}
--local ei_secoprec_productivity = settings.startup["ei-secoprec-productivity"].value

-- Crushing Industry Mod Settings
local ci_glass = settings.startup["crushing-industry-glass"].value
local ci_ore_crushing = settings.startup["crushing-industry-ore"].value
local ci_concrete_mix = settings.startup["crushing-industry-concrete-mix"].value
local ci_hide_player_crafting = settings.startup["crushing-industry-hide-player-crafting"].value

-- Selection or Full Control
-- Direct bonus
if ei_selection_bonus_direct == "custom" then
	ei_wash_bonus_direct_ssgq = settings.startup["ei-wash-bonus-direct-ssgq"].value * 0.01
	ei_wash_bonus_direct = settings.startup["ei-wash-bonus-direct"].value * 0.01
	ei_leach_amount = settings.startup["ei-leach-bonus-direct"].value * 0.1 + 10
	ei_recry_bonus_direct = settings.startup["ei-recry-bonus-direct"].value * 0.01
	--ei_recry_byprod = settings.startup["ei-recry-byprod"].value * 0.01
else
	ei_selection_bonus_direct = tonumber(ei_selection_bonus_direct) * 0.01
	ei_wash_bonus_direct_ssgq = ei_selection_bonus_direct
	ei_wash_bonus_direct = ei_selection_bonus_direct
	ei_leach_amount = ei_selection_bonus_direct * 10 + 10
	ei_recry_bonus_direct = ei_selection_bonus_direct
end

-- Primary precursor bonus
if ei_selection_bonus_primprec == "custom" then
	ei_wash_bonus_primprec_ssgq = settings.startup["ei-wash-bonus-primprec-ssgq"].value * 0.01
	ei_wash_bonus_primprec = settings.startup["ei-wash-bonus-primprec"].value * 0.01
	ei_leach_bonus_primprec = settings.startup["ei-leach-bonus-primprec"].value * 0.01
else
	ei_selection_bonus_primprec = tonumber(ei_selection_bonus_primprec) * 0.01
	ei_wash_bonus_primprec_ssgq = ei_selection_bonus_primprec
	ei_wash_bonus_primprec = ei_selection_bonus_primprec
	ei_leach_bonus_primprec = ei_selection_bonus_primprec
end

-- Secondary precursor bonus
if ei_selection_bonus_secoprec == "custom" then
	ei_wash_bonus_secoprec_ssgq = settings.startup["ei-wash-bonus-secoprec-ssgq"].value * 0.01
	ei_wash_bonus_secoprec = settings.startup["ei-wash-bonus-secoprec"].value * 0.01
else
	ei_selection_bonus_secoprec = tonumber(ei_selection_bonus_secoprec) * 0.01
	ei_wash_bonus_secoprec_ssgq = ei_selection_bonus_secoprec
	ei_wash_bonus_secoprec = ei_selection_bonus_secoprec
end

-- ????????????????????????????????????????????????????????????????? TODO
-- Missing: ei_crush_bonus_precursor_ssgq > 0.1 or ei_crush_bonus_precursor > 0.1
-- Disable productivity if any precursor > 10%
if ei_wash_bonus_primprec_ssgq > 0.1 or ei_wash_bonus_primprec > 0.1 or ei_leach_bonus_primprec > 0.1 or ei_wash_bonus_secoprec_ssgq > 0.1 or ei_wash_bonus_secoprec > 0.1 then
	ei_productivity_precursor = false
end
-- Disable productivity if any secondary precursor > 10%
-- if ei_wash_bonus_secoprec_ssgq > 0.1 or ei_wash_bonus_secoprec > 0.1 then
-- 	ei_productivity_precursor = false
-- end

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
				{type="item", name="ei-quartz", amount=1, extra_count_fraction=ei_wash_bonus_direct_ssgq},
				{type="fluid", name="ei-tailing-slurry", amount=10, ignored_by_productivity=1000},
				EnrichingIndustry.make_washing_byproduct("sand", ei_wash_bonus_primprec_ssgq, 1, ei_productivity_precursor),
--				EnrichingIndustry.make_washing_byproduct("sand", EnrichingIndustry.STANDARD_BYPRODUCT),
				EnrichingIndustry.make_washing_byproduct("stone", ei_wash_bonus_secoprec_ssgq, 1, ei_productivity_precursor),
--				EnrichingIndustry.make_washing_byproduct("stone", EnrichingIndustry.FLAVOR_BYPRODUCT),
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
				{type="item", name="ei-enriched-iron-ore", amount=1, extra_count_fraction=ei_wash_bonus_direct},
				{type="fluid", name="ei-tailing-slurry", amount=10, ignored_by_productivity=1000},
				EnrichingIndustry.make_washing_byproduct("crushed-iron-ore", ei_wash_bonus_primprec, 1, ei_productivity_precursor),
				EnrichingIndustry.make_washing_byproduct("iron-ore", ei_wash_bonus_secoprec, 1, ei_productivity_precursor),
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
				{type="item", name="ei-enriched-copper-ore", amount=1, extra_count_fraction=ei_wash_bonus_direct},
				{type="fluid", name="ei-tailing-slurry", amount=10, ignored_by_productivity=1000},
				EnrichingIndustry.make_washing_byproduct("crushed-copper-ore", ei_wash_bonus_primprec, 1, ei_productivity_precursor),
				EnrichingIndustry.make_washing_byproduct("copper-ore", ei_wash_bonus_secoprec, 1, ei_productivity_precursor),
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
				{type="fluid", name="sulfuric-acid", amount=ei_leach_sulfuric_acid}
			},
			results = {
				{type="fluid", name="ei-sulfuric-iron-solution", amount=ei_leach_amount},
				EnrichingIndustry.make_washing_byproduct("crushed-iron-ore", ei_leach_bonus_primprec, 1, ei_productivity_precursor),
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
				{type="fluid", name="sulfuric-acid", amount=ei_leach_sulfuric_acid}
			},
			results = {
				{type="fluid", name="ei-sulfuric-copper-solution", amount=ei_leach_amount},
				EnrichingIndustry.make_washing_byproduct("crushed-copper-ore", ei_leach_bonus_primprec, 1, ei_productivity_precursor),
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
				{type="item", name="ei-enriched-iron-ore", amount=1, extra_count_fraction=ei_recry_bonus_direct},
--				{type="item", name="ei-enriched-copper-ore", amount=0, extra_count_fraction=ei_recry_byprod},
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
				{type="item", name="ei-enriched-copper-ore", amount=1, extra_count_fraction=ei_recry_bonus_direct},
--				{type="item", name="ei-enriched-iron-ore", amount=0, extra_count_fraction=ei_recry_byprod},
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
					EnrichingIndustry.make_washing_byproduct("crushed-tungsten-ore", ei_wash_bonus_primprec, 1, ei_productivity_precursor),
					EnrichingIndustry.make_washing_byproduct("tungsten-ore", ei_wash_bonus_secoprec, 1, ei_productivity_precursor),
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
					EnrichingIndustry.make_washing_byproduct("holmium-powder", ei_wash_bonus_primprec, 1, ei_productivity_precursor),
					EnrichingIndustry.make_washing_byproduct("holmium-ore", ei_wash_bonus_secoprec, 1, ei_productivity_precursor),
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

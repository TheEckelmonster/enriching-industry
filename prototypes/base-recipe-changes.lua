local frep = require("__fdsl__.lib.recipe")

-- Enriching Industry Mod Settings
-- Amount of secondary metal from recrystallization. Disabled if == 0
-- Overwrite Crushing Industrys default 50% setting if enabled
-- Amount of bonus from crushing, if above is enabled

-- Enriching Industry Mod Settings
local ei_ci_overwrite = settings.startup["ei-ci-overwrite"].value
local ei_selection_byproduct_metal = settings.startup["ei-selection-byproduct-metal"].value
local ei_productivity_precursor = settings.startup["ei-productivity-precursor"].value
local ei_recry_byprod = {}
-- Direct bonus
local ei_selection_bonus_direct = settings.startup["ei-selection-bonus-direct"].value
local ei_crush_bonus_direct = {}
-- Primary precursor bonus
local ei_selection_bonus_primprec = settings.startup["ei-selection-bonus-primprec"].value
local ei_crush_bonus_precursor_ssgq = {}
local ei_wash_bonus_primprec_ssgq = {}
local ei_crush_bonus_precursor = {}
local ei_wash_bonus_primprec = {}
local ei_leach_bonus_primprec = {}
-- Non-metal byproduct
local ei_crush_byprod_sand = settings.startup["ei-crush-byprod-sand"].value * 0.01
local ei_nonmetal_byproduct_sand = settings.startup["ei-nonmetal-byproduct-sand"].value * 0.01
local ei_nonmetal_byproduct_stone = settings.startup["ei-nonmetal-byproduct-stone"].value * 0.01
local ei_nonmetal_byproduct_sulfur_tailfilt = settings.startup["ei-nonmetal-byproduct-sulfur-tailfilt"].value * 0.01
local ei_nonmetal_byproduct_sulfur_tailrepr = settings.startup["ei-nonmetal-byproduct-sulfur-tailrepr"].value * 0.01
local ei_nonmetal_byproduct_sulfur_recrystall = settings.startup["ei-nonmetal-byproduct-sulfur-recrystall"].value * 0.01

-- Crushing Industry Mod Settings
local ci_glass = settings.startup["crushing-industry-glass"].value
local ci_ore_crushing = settings.startup["crushing-industry-ore"].value
local ci_byproducts = settings.startup["crushing-industry-byproducts"].value

-- Selection or Full Control
-- Direct bonus
if ei_selection_bonus_direct == "custom" then
	ei_crush_bonus_direct = settings.startup["ei-crush-bonus-direct"].value * 0.01
else
	ei_crush_bonus_direct = tonumber(ei_selection_bonus_direct) * 0.01
end

-- Primary precursor bonus
if ei_selection_bonus_primprec == "custom" then
	ei_crush_bonus_precursor_ssgq = settings.startup["ei-crush-bonus-precursor-ssgq"].value * 0.01
	ei_crush_bonus_precursor = settings.startup["ei-crush-bonus-precursor"].value * 0.01
--	ei_wash_bonus_primprec = settings.startup["ei-wash-bonus-primprec"].value * 0.01
--	ei_leach_bonus_primprec = settings.startup["ei-leach-bonus-primprec"].value * 0.01
else
	ei_selection_bonus_primprec = tonumber(ei_selection_bonus_primprec) * 0.01
	ei_crush_bonus_precursor_ssgq = ei_selection_bonus_primprec
	ei_crush_bonus_precursor = ei_selection_bonus_primprec
--	ei_wash_bonus_primprec = ei_selection_bonus_primprec
--	ei_leach_bonus_primprec = ei_selection_bonus_primprec
end

-- Metal by-product
if ei_selection_byproduct_metal == "custom" then
	ei_recry_byprod = settings.startup["ei-recry-byprod"].value * 0.01
else
	ei_recry_byprod = tonumber(ei_selection_byproduct_metal) * 0.01
end

-- ????????????????????????????????????????????????????????????????? TODO
-- Missing: ei_wash_bonus_secoprec; ei_wash_bonus_primprec_ssgq
-- Disable productivity if any precursor > 10%
--if ei_wash_bonus_primprec_ssgq > 0.1 or ei_wash_bonus_primprec > 0.1 or ei_leach_bonus_primprec > 0.1 or ei_wash_bonus_secoprec_ssgq > 0.1 or ei_wash_bonus_secoprec > 0.1 then
-- WHAT WOULD BE NEEDED:
--if ei_crush_bonus_precursor_ssgq > 0.1 or ei_crush_bonus_precursor > 0.1 or ei_wash_bonus_primprec_ssgq > 0.1 or ei_wash_bonus_secoprec_ssgq > 0.1 or ei_wash_bonus_primprec > 0.1 or ei_wash_bonus_secoprec > 0.1 or ei_leach_bonus_primprec > 0.1 then
if ei_crush_bonus_precursor_ssgq > 0.1 or ei_crush_bonus_precursor > 0.1 then
	ei_productivity_precursor = false
end

-- ==================================================

if ci_glass then
	if ei_ci_overwrite then
		frep.remove_result("sand", "stone")
		if ei_crush_bonus_precursor_ssgq > 0 then
			frep.add_result("sand", EnrichingIndustry.make_washing_byproduct("stone", ei_crush_bonus_precursor_ssgq, 1, ei_productivity_precursor))
		end
	end
end

if ci_glass or mods["aai-industry"] then
	if mods["space-age"] then
		frep.replace_ingredient("holmium-solution", "sand", {type="item", name="ei-quartz", amount=3})
		frep.replace_ingredient("electrolyte", "sand", {type="item", name="ei-quartz", amount=4})
		frep.replace_ingredient("molten-glass", "sand", {type="item", name="ei-quartz", amount=100})
	end
end

-- Ore Refining
if ci_ore_crushing then
	if ei_ci_overwrite then
		-- Modify CI's crushing bonus if enabled
		frep.modify_result("crushed-iron-ore", "crushed-iron-ore", {extra_count_fraction=ei_crush_bonus_direct})
		frep.modify_result("crushed-copper-ore", "crushed-copper-ore", {extra_count_fraction=ei_crush_bonus_direct})
		frep.remove_result("crushed-iron-ore", "iron-ore")
		frep.remove_result("crushed-copper-ore", "copper-ore")
		if ei_crush_bonus_precursor > 0 then
			frep.add_result("crushed-iron-ore", EnrichingIndustry.make_washing_byproduct("iron-ore", ei_crush_bonus_precursor, 1, ei_productivity_precursor), true, 2)
			frep.add_result("crushed-copper-ore", EnrichingIndustry.make_washing_byproduct("copper-ore", ei_crush_bonus_precursor, 1, ei_productivity_precursor), true, 2)
		end
		if ci_byproducts then
			frep.remove_result("crushed-iron-ore", "sand")
			frep.remove_result("crushed-copper-ore", "sand")
			if ei_crush_byprod_sand > 0 then
				frep.add_result("crushed-iron-ore", EnrichingIndustry.make_washing_byproduct("sand", ei_crush_byprod_sand), true, 3)
				frep.add_result("crushed-copper-ore", EnrichingIndustry.make_washing_byproduct("sand", ei_crush_byprod_sand), true, 3)
			end
		end
	end
-- Add secondary metal byproduct to recrystallization if sec. bonus > 0
	if ei_recry_byprod > 0 then
		frep.add_result("ei-enriched-iron-ore-recrystallization", {type="item", name="ei-enriched-copper-ore", amount=1, probability=ei_recry_byprod})
		frep.add_result("ei-enriched-copper-ore-recrystallization", {type="item", name="ei-enriched-iron-ore", amount=1, probability=ei_recry_byprod})
	end
-- Add sulfur after secondary metal to recrystallization
	if ei_nonmetal_byproduct_sulfur_recrystall > 0 then
		frep.add_result("ei-enriched-iron-ore-recrystallization", EnrichingIndustry.make_washing_byproduct("sulfur", ei_nonmetal_byproduct_sulfur_recrystall), false)
		frep.add_result("ei-enriched-copper-ore-recrystallization", EnrichingIndustry.make_washing_byproduct("sulfur", ei_nonmetal_byproduct_sulfur_recrystall), false)
	end
-- Add byproducts if enabled
	if ci_byproducts then
	-- Sulfuric leaching byproducts: Sand & Stone
		if ei_nonmetal_byproduct_sand > 0 then
			frep.add_result("ei-sulfuric-iron-leaching", EnrichingIndustry.make_washing_byproduct("sand", ei_nonmetal_byproduct_sand), false)
			frep.add_result("ei-sulfuric-copper-leaching", EnrichingIndustry.make_washing_byproduct("sand", ei_nonmetal_byproduct_sand), false)
		end
		if ei_nonmetal_byproduct_stone > 0 then
			frep.add_result("ei-sulfuric-iron-leaching", EnrichingIndustry.make_washing_byproduct("stone", ei_nonmetal_byproduct_stone), false)
			frep.add_result("ei-sulfuric-copper-leaching", EnrichingIndustry.make_washing_byproduct("stone", ei_nonmetal_byproduct_stone), false)
		end
	end
	if mods["space-age"] then
		frep.replace_ingredient("tungsten-plate", "crushed-tungsten-ore", "ei-enriched-tungsten-ore")
	--	frep.scale_ingredient("tungsten-plate", "ei-enriched-tungsten-ore", {amount=1.5})
		frep.replace_ingredient("molten-iron", "crushed-iron-ore", "ei-enriched-iron-ore")
		frep.scale_ingredient("molten-iron", "ei-enriched-iron-ore", {amount=4/3})
		frep.replace_ingredient("molten-copper", "crushed-copper-ore", "ei-enriched-copper-ore")
		frep.scale_ingredient("molten-copper", "ei-enriched-copper-ore", {amount=4/3})
		frep.modify_ingredient("holmium-plate", "holmium-solution", {type="item", name="ei-enriched-holmium", amount=1})
		if ci_byproducts then
			frep.add_result("ei-enriched-tungsten-ore", EnrichingIndustry.make_washing_byproduct("crushed-coal", EnrichingIndustry.FLAVOR_BYPRODUCT), false)
		end
	end
end

-- Tailing slurry: Non-metal by-products
if ci_glass or ci_ore_crushing or mods["aai-industry"] then
-- Tailing slurry filtering and reprocessing byproducts: Sand, Stone & Sulfur
	if ei_nonmetal_byproduct_sand > 0 then
		-- F&R: Add Sand if primary byprod. enabled
		frep.add_result("ei-tailing-slurry-filtering", EnrichingIndustry.make_washing_byproduct("sand", ei_nonmetal_byproduct_sand * 10), false)
		frep.add_result("ei-tailing-slurry-reprocessing", EnrichingIndustry.make_washing_byproduct("sand", ei_nonmetal_byproduct_sand * 10), false)
	end
	if ei_nonmetal_byproduct_stone > 0 then
		-- F&R: Add Stone if secondary byprod. enabled
		frep.add_result("ei-tailing-slurry-filtering", EnrichingIndustry.make_washing_byproduct("stone", ei_nonmetal_byproduct_stone * 10), false)
		frep.add_result("ei-tailing-slurry-reprocessing", EnrichingIndustry.make_washing_byproduct("stone", ei_nonmetal_byproduct_stone * 10), false)
	end
	if ei_nonmetal_byproduct_sulfur_tailfilt > 0 then
		-- F: Add Sulfur if enabled
		frep.add_result("ei-tailing-slurry-filtering", EnrichingIndustry.make_washing_byproduct("sulfur", ei_nonmetal_byproduct_sulfur_tailfilt), false)
	end
	if ei_nonmetal_byproduct_sulfur_tailrepr > 0 then
		-- R: Add Sulfur if enabled
		frep.add_result("ei-tailing-slurry-reprocessing", EnrichingIndustry.make_washing_byproduct("sulfur", ei_nonmetal_byproduct_sulfur_tailrepr), false)
	end
end

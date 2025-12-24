-- FDSL is dependency of crushing-industry
local ftech = require("__fdsl__.lib.technology")

-- Crushing Industry Mod Settings
local ci_ore_crushing = settings.startup["crushing-industry-ore"].value

if (mods and mods["bzlead"]) then
    if ci_ore_crushing then
        ftech.add_unlock("ore-enriching", "ei-enriched-lead-ore")
        ftech.add_unlock("ore-enriching", "ei-enriched-lead-smelting")
        ftech.add_unlock("ore-enriching", "ei-tailing-slurry-filtering-lead")

        ftech.add_unlock("ore-enriching-2", "ei-tailing-slurry-reprocessing-lead")
    end
end

if (mods and mods["bzsilicon"]) then
    if ci_ore_crushing then
        ftech.add_unlock("ore-enriching", "ei-silica-from-quartz")
    end
end

if (mods and mods["bztin"]) then
end

if (mods and mods["bztitanium"]) then
    if ci_ore_crushing then
        ftech.add_unlock("ore-enriching", "ei-enriched-titanium-ore")
        ftech.add_unlock("ore-enriching", "ei-enriched-titanium-ore-sulfate")
        ftech.add_unlock("ore-enriching", "ei-enriched-titanium-smelting")
        ftech.add_unlock("ore-enriching", "ei-tailing-slurry-filtering-titanium")

        ftech.add_unlock("ore-enriching-2", "ei-enriched-titanium-ore-becher-oxidation")
        ftech.add_unlock("ore-enriching-2", "ei-enriched-titanium-ore-becher-reduction")
        ftech.add_unlock("ore-enriching-2", "ei-enriched-titanium-ore-becher-leaching")
        ftech.add_unlock("ore-enriching-2", "ei-tailing-slurry-reprocessing-titanium")

        if (mods["space-age"]) then
            ftech.add_unlock("foundry", "ei-enriched-titanium-smelting-metallurgy")
        end
    end
end

if (mods and mods["bzzirconium"]) then
    if ci_ore_crushing then
        ftech.add_unlock("ore-enriching", "ei-purified-zircon-ore")
        ftech.add_unlock("ore-enriching", "ei-purified-zircon-smelting")

        ftech.add_unlock("ore-enriching-2", "ei-enriched-zircon-ore")
        ftech.add_unlock("ore-enriching-2", "ei-enriched-zircon-smelting")
    end
end


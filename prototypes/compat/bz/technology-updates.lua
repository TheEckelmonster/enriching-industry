-- FDSL is dependency of crushing-industry
local ftech = require("__fdsl__.lib.technology")

-- Crushing Industry Mod Settings
local ci_ore_crushing = settings.startup["crushing-industry-ore"].value

if (type(mods) == "table" and ci_ore_crushing) then
    if (mods["bzlead"]) then
        ftech.add_unlock("ore-enriching", "ei-enriched-lead-ore")
        ftech.add_unlock("ore-enriching", "ei-enriched-lead-smelting")
        ftech.add_unlock("ore-enriching", "ei-tailing-slurry-filtering-lead")

        ftech.add_unlock("ore-enriching-2", "ei-tailing-slurry-reprocessing-lead")
    end

    if (mods["bzsilicon"]) then
        ftech.add_unlock("ore-enriching", "ei-silica-from-quartz")
    end

    if (mods["bztin"]) then
        ftech.add_unlock("ore-enriching", "ei-purified-tin-ore")
        ftech.add_unlock("ore-enriching", "ei-purified-tin-ore-smelting")

        ftech.add_unlock("ore-enriching-2", "ei-enriched-tin-ore")
        ftech.add_unlock("ore-enriching-2", "ei-enriched-tin-ore-smelting")
    end

    if (mods["bztitanium"]) then
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

    if (mods["bzzirconium"]) then
        ftech.add_unlock("ore-enriching", "ei-purified-zircon-ore")
        ftech.add_unlock("ore-enriching", "ei-purified-zircon-smelting")

        ftech.add_unlock("ore-enriching-2", "ei-enriched-zircon-ore")
        ftech.add_unlock("ore-enriching-2", "ei-enriched-zircon-smelting")
    end
end
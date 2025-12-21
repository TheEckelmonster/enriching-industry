data:extend({
	{
		type = "item",
		name = "ei-enriched-titanium-ore",
		icon = "__enriching-industry__/graphics/icons/enriched-titanium-ore.png",
		icon_size = 64,
--		icon_mipmaps = 4,
		pictures =
		{
			{ size = 64, filename = "__enriching-industry__/graphics/icons/enriched-titanium-ore.png",   scale = 0.5, mipmap_count = 1 },
			{ size = 64, filename = "__enriching-industry__/graphics/icons/enriched-titanium-ore-1.png", scale = 0.5, mipmap_count = 1 },
			{ size = 64, filename = "__enriching-industry__/graphics/icons/enriched-titanium-ore-2.png", scale = 0.5, mipmap_count = 1 },
			{ size = 64, filename = "__enriching-industry__/graphics/icons/enriched-titanium-ore-3.png", scale = 0.5, mipmap_count = 1 }
		},
		subgroup = "raw-resource",
		order = "g-e[titanium-ore]-d[enriched]",
		hidden = not ci_ore_crushing,
		stack_size = 100,
		weight = 2 * kg
	},
})
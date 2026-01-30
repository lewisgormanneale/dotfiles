return {
  paddings = 2,
  group_paddings = 4,

  icons = "sf-symbols", -- alternatively available: NerdFont

  -- This is a font configuration for SF Pro and SF Mono (installed from Brewfile)
  font = {
    text = "SF Pro",   -- Used for text
    numbers = "SF Mono", -- Used for numbers

    -- Unified font style map
    style_map = {
      ["Regular"] = "Regular",
      ["Semibold"] = "Semibold",
      ["Bold"] = "Bold",
      ["Heavy"] = "Heavy",
      ["Black"] = "Black",
    }
  },
}

-- Catppuccin Mocha theme
return {
  black = 0xff1e1e2e,       -- base
  white = 0xffcdd6f4,       -- text
  red = 0xfff38ba8,
  green = 0xffa6e3a1,
  blue = 0xff89b4fa,
  yellow = 0xfff9e2af,
  orange = 0xfffab387,      -- peach
  magenta = 0xffcba6f7,     -- mauve
  grey = 0xff6c7086,        -- overlay0
  transparent = 0x00000000,

  -- Additional Catppuccin colors
  lavender = 0xffb4befe,
  sapphire = 0xff74c7ec,
  sky = 0xff89dceb,
  teal = 0xff94e2d5,
  maroon = 0xffeba0ac,
  pink = 0xfff5c2e7,
  subtext = 0xffa6adc8,
  surface0 = 0xff313244,
  surface1 = 0xff45475a,

  bar = {
    bg = 0xf01e1e2e,        -- base with slight transparency
    border = 0xff313244,    -- surface0
  },
  popup = {
    bg = 0xc01e1e2e,        -- base with transparency
    border = 0xff6c7086     -- overlay0
  },
  bg1 = 0xff313244,         -- surface0
  bg2 = 0xff45475a,         -- surface1

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}

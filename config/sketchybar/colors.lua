-- Catppuccin Mocha Color Palette for SketchyBar
return {
  -- Main palette
  black = 0xff1e1e2e,      -- Base
  white = 0xffcdd6f4,      -- Text
  red = 0xfff38ba8,        -- Red
  green = 0xffa6e3a1,      -- Green
  blue = 0xff89b4fa,       -- Blue
  yellow = 0xfff9e2af,     -- Yellow
  orange = 0xfffab387,     -- Peach
  magenta = 0xffcba6f7,    -- Mauve
  grey = 0xff6c7086,       -- Overlay0
  transparent = 0x00000000,

  -- Surface colors
  bar = {
    bg = 0xf01e1e2e,       -- Base with transparency
    border = 0xff1e1e2e,   -- Base
  },
  popup = {
    bg = 0xc01e1e2e,       -- Base with more transparency
    border = 0xff6c7086    -- Overlay0
  },
  bg1 = 0xff313244,        -- Surface0
  bg2 = 0xff45475a,        -- Surface1

  -- Additional Catppuccin colors
  lavender = 0xffb4befe,
  sapphire = 0xff74c7ec,
  sky = 0xff89dceb,
  teal = 0xff94e2d5,
  peach = 0xfffab387,
  maroon = 0xffeba0ac,
  pink = 0xfff5c2e7,
  subtext = 0xffa6adc8,

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}

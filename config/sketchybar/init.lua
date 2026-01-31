-- Require the sketchybar module
sbar = require("sketchybar")

-- Start JankyBorders for window focus borders (Catppuccin Pink)
os.execute("pkill borders 2>/dev/null; borders active_color=0xfff5c2e7 inactive_color=0x00000000 width=6.0 &")

-- Set the bar name, if you are using another bar instance than sketchybar
-- sbar.set_bar_name("bottom_bar")

-- Bundle the entire initial configuration into a single message to sketchybar
sbar.begin_config()
require("bar")
require("default")
require("items")
sbar.end_config()

-- Run the event loop of the sketchybar module (without this there will be no
-- callback functions executed in the lua module)
sbar.event_loop()

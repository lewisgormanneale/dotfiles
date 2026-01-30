-- Add the sketchybar module to the package cpath
package.cpath = package.cpath .. ";/Users/" .. os.getenv("USER") .. "/.local/share/sketchybar_lua/?.so"

-- Compile helper binaries if makefile exists
os.execute("(cd $HOME/.config/sketchybar/helpers 2>/dev/null && make) >/dev/null 2>&1")

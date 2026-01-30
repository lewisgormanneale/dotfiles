local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local spaces = {}

-- Create 10 workspace indicators for aerospace
for i = 1, 10, 1 do
  local space = sbar.add("item", "space." .. i, {
    icon = {
      font = { family = settings.font.numbers },
      string = i,
      padding_left = 12,
      padding_right = 8,
      color = colors.white,
      highlight_color = colors.blue,
    },
    label = {
      padding_right = 12,
      color = colors.grey,
      highlight_color = colors.white,
      font = "sketchybar-app-font:Regular:16.0",
      y_offset = -1,
      string = "",
    },
    padding_right = 2,
    padding_left = 2,
    background = {
      color = colors.bg1,
      border_width = 2,
      height = 26,
      border_color = colors.bg2,
      corner_radius = 6,
    },
    display = "active",
  })

  spaces[i] = space

  -- Click to switch workspace with aerospace
  space:subscribe("mouse.clicked", function(env)
    sbar.exec("aerospace workspace " .. tostring(i))
  end)
end

-- Update workspace indicators on aerospace events
local function update_spaces()
  sbar.exec("aerospace list-workspaces --monitor all", function(workspaces_output)
    -- Get focused workspace
    sbar.exec("aerospace list-workspaces --focused", function(focused_output)
      local focused = focused_output:match("^%s*(.-)%s*$") -- trim whitespace

      -- Parse workspace list
      local active_workspaces = {}
      for ws in workspaces_output:gmatch("[^\r\n]+") do
        local ws_num = tonumber(ws:match("^%s*(.-)%s*$"))
        if ws_num then
          active_workspaces[ws_num] = true
        end
      end

      -- Update each space indicator
      for i = 1, 10 do
        local has_windows = active_workspaces[i] or false
        local is_focused = (focused == tostring(i))

        -- Only show workspaces with windows or the focused workspace
        if has_windows or is_focused then
          -- Get app icons for this workspace
          sbar.exec("aerospace list-windows --workspace " .. i .. " --format '%{app-name}'", function(windows)
            local icon_line = ""
            local seen_apps = {}

            for app in windows:gmatch('[^\r\n]+') do
              if app ~= "" and not seen_apps[app] then
                seen_apps[app] = true
                local lookup = app_icons[app]
                local icon = ((lookup == nil) and app_icons["Default"] or lookup)
                icon_line = icon_line .. " " .. icon
              end
            end

            spaces[i]:set({
              display = "active",
              icon = {
                highlight = is_focused,
                color = is_focused and colors.blue or colors.white,
              },
              label = {
                string = icon_line,
                highlight = is_focused,
              },
              background = {
                color = is_focused and colors.bg2 or colors.bg1,
                border_color = is_focused and colors.blue or colors.bg2,
              }
            })
          end)
        else
          -- Hide empty, non-focused workspaces
          spaces[i]:set({ display = "off" })
        end
      end
    end)
  end)
end

-- Subscribe to aerospace workspace changes
sbar.add("item", {
  drawing = false,
  updates = true,
}):subscribe("aerospace_workspace_change", function(env)
  update_spaces()
end)

-- Initial update
update_spaces()

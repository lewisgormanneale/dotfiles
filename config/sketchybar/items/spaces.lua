local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

-- Custom event for aerospace workspace changes
sbar.add("event", "aerospace_workspace_change")
sbar.add("event", "aerospace_monitor_change")

local spaces = {}
local space_brackets = {}

for i = 1, 9, 1 do
  local space = sbar.add("item", "space." .. i, {
    icon = {
      font = { family = settings.font.numbers },
      string = i,
      padding_left = 15,
      padding_right = 8,
      color = colors.white,
      highlight_color = colors.red,
    },
    label = {
      padding_right = 20,
      color = colors.grey,
      highlight_color = colors.white,
      font = "sketchybar-app-font:Regular:16.0",
      y_offset = -1,
    },
    padding_right = 1,
    padding_left = 1,
    background = {
      color = colors.bg1,
      border_width = 1,
      height = 26,
      border_color = colors.black,
    },
  })

  spaces[i] = space

  -- Single item bracket for space items to achieve double border on highlight
  local space_bracket = sbar.add("bracket", "space.bracket." .. i, { space.name }, {
    background = {
      color = colors.transparent,
      border_color = colors.bg2,
      height = 28,
      border_width = 2
    }
  })
  space_brackets[i] = space_bracket

  -- Padding space
  sbar.add("item", "space.padding." .. i, {
    width = settings.group_paddings,
  })

  -- Click to switch workspace
  space:subscribe("mouse.clicked", function(env)
    sbar.exec("aerospace workspace " .. i)
  end)
end

local space_window_observer = sbar.add("item", {
  drawing = false,
  updates = true,
})

-- Update spaces with app icons and visibility using aerospace
local function update_spaces()
  -- First, get which workspaces are currently visible on monitors AND the focused workspace
  sbar.exec("aerospace list-workspaces --focused", function(focused_ws)
    local focused_workspace = tonumber(focused_ws and focused_ws:match("^(%d+)"))

    sbar.exec("aerospace list-workspaces --monitor 1 --visible", function(mon1_ws)
      sbar.exec("aerospace list-workspaces --monitor 2 --visible", function(mon2_ws)
        local visible_workspaces = {}
        if mon1_ws and mon1_ws ~= "" then
          local ws = tonumber(mon1_ws:match("^(%d+)"))
          if ws then visible_workspaces[ws] = true end
        end
        if mon2_ws and mon2_ws ~= "" then
          local ws = tonumber(mon2_ws:match("^(%d+)"))
          if ws then visible_workspaces[ws] = true end
        end

        -- Now update each workspace
        for i = 1, 9, 1 do
          sbar.exec("aerospace list-windows --workspace " .. i .. " --format '%{app-name}'", function(result)
            local icon_line = ""
            local has_windows = false

            if result and result ~= "" then
              for app in result:gmatch("[^\r\n]+") do
                has_windows = true
                local lookup = app_icons[app]
                local icon = ((lookup == nil) and app_icons["Default"] or lookup)
                icon_line = icon_line .. icon
              end
            end

            if not has_windows then
              icon_line = " —"
            end

            -- Show if has windows OR is currently visible on a monitor
            local should_show = has_windows or (visible_workspaces[i] == true)
            if should_show == nil then should_show = false end

            -- Styling based on state:
            -- Focused workspace: pink border, highlighted text
            -- Other visible workspace: lavender border
            -- Workspaces with windows but not visible: bg2 border
            local is_focused = (i == focused_workspace)
            local is_monitor_visible = visible_workspaces[i] == true
            local border_color = colors.bg2
            if is_focused then
              border_color = colors.pink
            elseif is_monitor_visible then
              border_color = colors.lavender
            end

            spaces[i]:set({
              icon = { highlight = is_focused },
              label = { string = icon_line, highlight = is_focused },
              drawing = should_show,
              background = { border_color = border_color }
            })
            space_brackets[i]:set({
              drawing = should_show,
              background = { border_color = border_color }
            })
            sbar.set("space.padding." .. i, { drawing = should_show })
          end)
        end
      end)
    end)
  end)
end

space_window_observer:subscribe({ "aerospace_workspace_change", "aerospace_monitor_change", "front_app_switched" }, function(env)
  update_spaces()
end)

-- Initial update
update_spaces()

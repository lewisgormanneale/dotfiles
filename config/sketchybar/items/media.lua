local colors = require("colors")
local icons = require("icons")

local whitelist = { ["Spotify"] = true,
                    ["Music"] = true    };

local media_cover = sbar.add("item", {
  position = "right",
  background = {
    image = {
      string = "media.artwork",
      scale = 0.85,
    },
    color = colors.transparent,
  },
  label = { drawing = false },
  icon = { drawing = false },
  drawing = false,
  updates = true,
  popup = {
    align = "center",
    horizontal = true,
  }
})

local media_artist = sbar.add("item", {
  position = "right",
  drawing = false,
  padding_left = 3,
  padding_right = 0,
  width = 0,
  icon = { drawing = false },
  label = {
    width = 0,
    font = { size = 9 },
    color = colors.with_alpha(colors.white, 0.6),
    max_chars = 18,
    y_offset = 6,
  },
})

local media_title = sbar.add("item", {
  position = "right",
  drawing = false,
  padding_left = 3,
  padding_right = 0,
  icon = { drawing = false },
  label = {
    font = { size = 11 },
    width = 0,
    max_chars = 16,
    y_offset = -5,
  },
})

sbar.add("item", {
  position = "popup." .. media_cover.name,
  icon = { string = icons.media.back },
  label = { drawing = false },
  click_script = "nowplaying-cli previous",
})
sbar.add("item", {
  position = "popup." .. media_cover.name,
  icon = { string = icons.media.play_pause },
  label = { drawing = false },
  click_script = "nowplaying-cli togglePlayPause",
})
sbar.add("item", {
  position = "popup." .. media_cover.name,
  icon = { string = icons.media.forward },
  label = { drawing = false },
  click_script = "nowplaying-cli next",
})

local interrupt = 0
local function animate_detail(detail)
  if detail == false then
    interrupt = interrupt - 1
    if interrupt == 0 then
      sbar.animate("tanh", 30, function()
        media_artist:set({ label = { width = 0 } })
        media_title:set({ label = { width = 0 } })
      end)
    end
    return
  end

  interrupt = interrupt + 1
  sbar.animate("tanh", 30, function()
    media_artist:set({ label = { width = "dynamic" } })
    media_title:set({ label = { width = "dynamic" } })
  end)
end

media_cover:subscribe("media_change", function(env)
  if whitelist[env.INFO.app] then
    local drawing = (env.INFO.state == "playing")
    media_artist:set({ drawing = drawing, label = env.INFO.artist })
    media_title:set({ drawing = drawing, label = env.INFO.title })
    media_cover:set({ drawing = drawing })
  end
end)

media_title:subscribe("mouse.entered", function(env)
  animate_detail(true)
end)

media_artist:subscribe("mouse.entered", function(env)
  animate_detail(true)
end)

media_cover:subscribe("mouse.entered", function(env)
  animate_detail(true)
end)

media_title:subscribe("mouse.exited", function(env)
  animate_detail(false)
end)

media_artist:subscribe("mouse.exited", function(env)
  animate_detail(false)
end)

media_cover:subscribe("mouse.exited.global", function(env)
  media_cover:set({ popup = { drawing = false } })
end)

media_cover:subscribe("mouse.exited", function(env)
  animate_detail(false)
end)

media_cover:subscribe("mouse.clicked", function(env)
  media_cover:set({ popup = { drawing = "toggle" } })
end)

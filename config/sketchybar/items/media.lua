local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local whitelist = { 
  ["Spotify"] = true,
  ["Music"] = true,
  ["com.apple.Music"] = true,
  ["com.spotify.client"] = true 
}

local media_cover = sbar.add("item", {
  position = "right",
  update_freq = 3,
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
  click_script = "media-control previous-track",
})
sbar.add("item", {
  position = "popup." .. media_cover.name,
  icon = { string = icons.media.play_pause },
  label = { drawing = false },
  click_script = "media-control toggle-play-pause",
})
sbar.add("item", {
  position = "popup." .. media_cover.name,
  icon = { string = icons.media.forward },
  label = { drawing = false },
  click_script = "media-control next-track",
})

local interrupt = 0
local function animate_detail(detail)
  if (not detail) then interrupt = interrupt - 1 end
  if interrupt > 0 and (not detail) then return end

  sbar.animate("tanh", 30, function()
    media_artist:set({ label = { width = detail and "dynamic" or 0 } })
    media_title:set({ label = { width = detail and "dynamic" or 0 } })
  end)
end

local function update_media()
  sbar.exec("media-control get 2>/dev/null", function(result)
    if not result or type(result) ~= "table" then
      media_cover:set({ drawing = false })
      media_artist:set({ drawing = false })
      media_title:set({ drawing = false })
      return
    end
    
    -- result is already a parsed Lua table
    local app = result.bundleIdentifier
    local playing = result.playing
    local title = result.title
    local artist = result.artist
    
    if app and whitelist[app] then
      media_artist:set({ drawing = playing, label = artist or "" })
      media_title:set({ drawing = playing, label = title or "" })
      media_cover:set({ drawing = playing })

      if playing then
        animate_detail(true)
        interrupt = interrupt + 1
        sbar.delay(5, animate_detail)
      else
        media_cover:set({ popup = { drawing = false } })
      end
    else
      media_cover:set({ drawing = false })
      media_artist:set({ drawing = false })
      media_title:set({ drawing = false })
    end
  end)
end

-- Poll for media updates every 3 seconds
media_cover:subscribe("routine", function(env)
  update_media()
end)

-- Also run on front_app_switched to catch app changes
media_cover:subscribe("front_app_switched", function(env)
  update_media()
end)

-- Initial update
update_media()

media_cover:subscribe("mouse.entered", function(env)
  interrupt = interrupt + 1
  animate_detail(true)
end)

media_cover:subscribe("mouse.exited", function(env)
  animate_detail(false)
end)

media_cover:subscribe("mouse.clicked", function(env)
  media_cover:set({ popup = { drawing = "toggle" }})
end)

media_title:subscribe("mouse.exited.global", function(env)
  media_cover:set({ popup = { drawing = false }})
end)

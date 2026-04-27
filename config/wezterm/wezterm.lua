local wezterm = require 'wezterm'
local config = {}

-- =========================================================
-- WINDOW
-- =========================================================
config.window_decorations = "TITLE | RESIZE"

config.window_background_opacity = 0.96
config.macos_window_background_blur = 30

config.window_padding = {
  left = 10,
  right = 10,
  top = 6,
  bottom = 0,
}

-- =========================================================
-- FONT
-- =========================================================

config.font_size = 12.5

config.line_height = 1.0
config.cell_width = 0.95

config.freetype_load_target = "HorizontalLcd"
config.freetype_render_target = "HorizontalLcd"

config.harfbuzz_features = {
  "calt=1",
  "clig=1",
  "liga=1",
}

config.bold_brightens_ansi_colors = false

-- =========================================================
-- CURSOR
-- =========================================================
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 700

-- =========================================================
-- TAB BAR
-- =========================================================
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = true

-- =========================================================
--  COLORSCHEME
-- =========================================================
config.colors = {
  foreground = "#403E3C",
  background = "#FFFCF0",

  cursor_bg = "#100F0F",
  cursor_fg = "#FFFCF0",

  selection_bg = "#DAD8CE",
  selection_fg = "#100F0F",

  ansi = {
    "#100F0F",
    "#AF3029",
    "#81a306",
    "#AD8301",
    "#205EA6",
    "#A02F6F",
    "#24837B",
    "#100F0F",
  },

  brights = {
    "#878580",
    "#D14D41",
    "#879A39",
    "#D0A215",
    "#3e93f6",
    "#de7777",
    "#3AA99F",
    "#FFFCF0",
  },

  tab_bar = {
    background = "#F2F0E5",

    active_tab = {
      bg_color = "#FFFCF0",
      fg_color = "#100F0F",
    },

    inactive_tab = {
      bg_color = "#F2F0E5",
      fg_color = "#6F6E69",
    },

    inactive_tab_hover = {
      bg_color = "#E6E4D9",
      fg_color = "#100F0F",
    },

    new_tab = {
      bg_color = "#F2F0E5",
      fg_color = "#6F6E69",
    },
  },
}
config.window_background_opacity = 0.98
config.macos_window_background_blur = 20
-- =========================================================
-- TAB TITLE
-- =========================================================
wezterm.on("format-tab-title", function(tab)
  local title = tab.active_pane.title

  title = title:gsub("zsh", "")
  title = title:gsub("bash", "")
  title = title:gsub("^%s+", "")
  title = title:gsub("%s+$", "")

  if title == "" then
    title = "terminal"
  end

  return {
    {
      Background = {
        Color = tab.is_active and "#ffffff" or "#ececec",
      },
    },
    {
      Foreground = {
        Color = tab.is_active and "#000000" or "#777777",
      },
    },
    {
      Text = "  " .. title .. "  ",
    },
  }
end)

-- =========================================================
-- STATUS BAR
-- =========================================================
wezterm.on("update-right-status", function(window)
  local dias = {
    ["Sun"] = "Dom",
    ["Mon"] = "Seg",
    ["Tue"] = "Ter",
    ["Wed"] = "Qua",
    ["Thu"] = "Qui",
    ["Fri"] = "Sex",
    ["Sat"] = "Sáb",
  }

  local day_en = wezterm.strftime("%a")
  local day_pt = dias[day_en] or day_en

  local time = wezterm.strftime("%H:%M:%S")
  local date = day_pt .. " " .. time

  local bat = ""

  for _, b in ipairs(wezterm.battery_info()) do
    bat = string.format("%.0f%%", b.state_of_charge * 100)
  end

  window:set_right_status(
    wezterm.format({
      {
        Foreground = {
          Color = "#777777",
        },
      },
      {
        Text = " " .. date .. "  ",
      },

      {
        Foreground = {
          Color = "#007acc",
        },
      },
      {
        Text = "  " .. bat .. " ",
      },
    })
  )
end)

-- =========================================================
-- KEYBINDINGS
-- =========================================================
config.keys = {
  {
    key = "t",
    mods = "CMD",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },

  {
    key = "w",
    mods = "CMD",
    action = wezterm.action.CloseCurrentTab({
      confirm = false,
    }),
  },

  {
    key = "d",
    mods = "CMD",
    action = wezterm.action.SplitHorizontal({
      domain = "CurrentPaneDomain",
    }),
  },

  {
    key = "D",
    mods = "CMD|SHIFT",
    action = wezterm.action.SplitVertical({
      domain = "CurrentPaneDomain",
    }),
  },

  {
    key = "[",
    mods = "CMD",
    action = wezterm.action.ActivateTabRelative(-1),
  },

  {
    key = "]",
    mods = "CMD",
    action = wezterm.action.ActivateTabRelative(1),
  },
}

return config
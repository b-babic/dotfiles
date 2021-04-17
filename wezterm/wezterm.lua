local wezterm = require("wezterm")

return {
  -- Smart tab bar [distraction-free mode]
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  tab_max_width = 30,

  -- Prompt on close
  window_close_confirmation = "NeverPrompt",

  -- Fonts
  --[[ font = wezterm.font("SF Mono"), ]]
  --[[ font_size= 18, ]]
  --[[ font = wezterm.font("Mononoki"), ]]
  font = wezterm.font_with_fallback {
    { family = "mononoki", weight = "Regular", italic = false },
    { family = 'Cascadia Code', weight = 'Regular', italic = false },
    { family = 'SF Mono', weight = 'Regular', italic = false },
    'SF Mono',
  },
  font_size = 18,
  line_height = 1.8,
  cell_width = 1.12,

  -- UI
  --[[ color_scheme = "Classic Light (base16)", ]]
  --[[ color_scheme = "Ashes (dark) (terminal.sexy)", ]]
  --[[ color_scheme = "Atelier Lakeside Light (base16)", ]]
  color_scheme = "tlh (terminal.sexy)",
  window_background_opacity = 0.95,
  default_cursor_style = "BlinkingBlock"
}

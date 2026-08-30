-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 2
local omarchy_monitor_scale = 1.6

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- LG 4K (DP-2) - left
hl.monitor({ output = "DP-2", mode = "3840x2160@60", position = "0x0", scale = 1.25 })

-- Dell AW2521HF (DP-3) - right, vertically centered against the LG, max refresh rate
-- Temporarily disabled to save power
hl.monitor({ output = "DP-3", disabled = true })

-- Fallback for any other/future monitor
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })

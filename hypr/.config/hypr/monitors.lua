-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1.25

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- Dell AW2521HF (DP-3) - top, centered over the LG below, max refresh rate
hl.monitor({ output = "DP-3", mode = "1920x1080@239.76", position = "576x0", scale = 1.0 })

-- LG 4K (HDMI-A-1) - bottom
hl.monitor({ output = "HDMI-A-1", mode = "3840x2160@60", position = "0x1080", scale = 1.25 })

-- Fallback for any other/future monitor
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })

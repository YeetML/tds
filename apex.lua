-- ═══════════════════════════════════════════════════════════════════════════
--  APEX UI v3.0 "Singularity"
--  Shared UI framework. Load with loadstring(game:HttpGet(URL))()
--  Returns: { Window, UILib, Themes, ApplyTheme, GetTheme, formatNumber, Utility }
-- ═══════════════════════════════════════════════════════════════════════════

local Apex = {}
Apex.Version = "3.0"

local TweenService = game:GetService("TweenService")
local UIS          = game:GetService("UserInputService")
local CoreGuiRef   = game:GetService("CoreGui")
local RS           = game:GetService("RunService")

local F = {
    Black   = Enum.Font.GothamBlack,
    Bold    = Enum.Font.GothamBold,
    Medium  = Enum.Font.GothamMedium,
    Regular = Enum.Font.Gotham,
}

-- ═══════════════════════════════════════════════════════════════════════════
--  THEMES
-- ═══════════════════════════════════════════════════════════════════════════

local C = Color3.fromRGB
local THEMES = {
    Obsidian = { Name="Obsidian",
        Bg=C(13,13,19), BgSolid=C(17,17,25), Surface=C(23,23,34), Surface2=C(30,30,44), Surface3=C(40,40,58),
        Border=C(48,48,66), BorderHi=C(72,72,98),
        Text=C(240,240,250), TextDim=C(160,160,180), TextMute=C(108,108,130),
        Accent=C(126,92,255), AccentHi=C(170,132,255), AccentAlt=C(255,100,200),
        Success=C(52,211,130), Danger=C(240,75,95), Warn=C(245,190,70),
        Coin=C(255,200,70), Gem=C(100,220,255), Xp=C(150,240,130),
    },
    Midnight = { Name="Midnight",
        Bg=C(8,12,24), BgSolid=C(12,18,34), Surface=C(18,26,48), Surface2=C(26,36,64), Surface3=C(36,48,80),
        Border=C(42,56,92), BorderHi=C(66,86,130),
        Text=C(230,238,255), TextDim=C(150,170,210), TextMute=C(100,120,160),
        Accent=C(80,140,255), AccentHi=C(130,180,255), AccentAlt=C(80,220,255),
        Success=C(52,211,130), Danger=C(240,75,95), Warn=C(245,190,70),
        Coin=C(255,200,70), Gem=C(100,220,255), Xp=C(150,240,130),
    },
    Violet = { Name="Violet",
        Bg=C(18,10,28), BgSolid=C(24,14,40), Surface=C(34,20,56), Surface2=C(46,28,74), Surface3=C(60,38,92),
        Border=C(70,46,108), BorderHi=C(100,70,150),
        Text=C(245,232,255), TextDim=C(180,150,210), TextMute=C(130,100,160),
        Accent=C(180,100,255), AccentHi=C(210,150,255), AccentAlt=C(255,100,220),
        Success=C(52,211,130), Danger=C(240,75,95), Warn=C(245,190,70),
        Coin=C(255,200,70), Gem=C(100,220,255), Xp=C(150,240,130),
    },
    Ocean = { Name="Ocean",
        Bg=C(8,18,24), BgSolid=C(12,26,34), Surface=C(18,36,48), Surface2=C(26,50,64), Surface3=C(38,68,84),
        Border=C(42,78,96), BorderHi=C(66,116,140),
        Text=C(230,250,255), TextDim=C(150,200,220), TextMute=C(100,150,170),
        Accent=C(60,190,220), AccentHi=C(110,220,245), AccentAlt=C(60,160,255),
        Success=C(52,211,130), Danger=C(240,75,95), Warn=C(245,190,70),
        Coin=C(255,200,70), Gem=C(100,220,255), Xp=C(150,240,130),
    },
    Sunset = { Name="Sunset",
        Bg=C(26,14,18), BgSolid=C(34,18,24), Surface=C(50,24,32), Surface2=C(68,32,42), Surface3=C(88,42,54),
        Border=C(102,52,64), BorderHi=C(140,74,88),
        Text=C(255,238,232), TextDim=C(230,170,160), TextMute=C(180,120,120),
        Accent=C(255,120,90), AccentHi=C(255,160,120), AccentAlt=C(255,80,140),
        Success=C(120,220,130), Danger=C(255,90,90), Warn=C(255,200,80),
        Coin=C(255,200,70), Gem=C(100,220,255), Xp=C(150,240,130),
    },
    Matrix = { Name="Matrix",
        Bg=C(6,14,6), BgSolid=C(10,20,10), Surface=C(16,30,16), Surface2=C(22,42,22), Surface3=C(32,56,32),
        Border=C(40,72,40), BorderHi=C(66,110,66),
        Text=C(220,255,220), TextDim=C(140,200,140), TextMute=C(90,140,90),
        Accent=C(60,255,90), AccentHi=C(120,255,140), AccentAlt=C(180,255,60),
        Success=C(60,255,90), Danger=C(255,80,80), Warn=C(255,220,80),
        Coin=C(255,220,80), Gem=C(120,255,220), Xp=C(180,255,120),
    },
    Blood = { Name="Blood",
        Bg=C(16,6,6), BgSolid=C(24,10,10), Surface=C(34,14,14), Surface2=C(46,20,20), Surface3=C(62,28,28),
        Border=C(76,34,34), BorderHi=C(110,50,50),
        Text=C(255,235,235), TextDim=C(220,160,160), TextMute=C(160,110,110),
        Accent=C(230,40,60), AccentHi=C(255,90,110), AccentAlt=C(255,150,60),
        Success=C(120,220,130), Danger=C(255,60,60), Warn=C(255,200,80),
        Coin=C(255,200,70), Gem=C(100,220,255), Xp=C(150,240,130),
    },
    Sakura = { Name="Sakura",
        Bg=C(20,14,20), BgSolid=C(28,20,28), Surface=C(40,26,40), Surface2=C(56,36,56), Surface3=C(74,48,74),
        Border=C(90,58,86), BorderHi=C(130,84,124),
        Text=C(255,240,250), TextDim=C(230,180,215), TextMute=C(170,125,160),
        Accent=C(255,150,200), AccentHi=C(255,190,220), AccentAlt=C(200,140,255),
        Success=C(120,220,160), Danger=C(255,90,120), Warn=C(255,200,120),
        Coin=C(255,200,70), Gem=C(150,220,255), Xp=C(200,240,150),
    },
}

Apex.Themes = THEMES

-- theme state
local CurrentTheme = THEMES.Obsidian
local ThemeListeners = {}
local function onThemeChange(fn) table.insert(ThemeListeners, fn) end
local function applyTheme(t)
    if type(t) == "string" then t = THEMES[t] end
    if not t then return end
    CurrentTheme = t
    for _, fn in ipairs(ThemeListeners) do pcall(fn, t) end
end
Apex.ApplyTheme = applyTheme
Apex.GetTheme = function() return CurrentTheme end

-- internal alias (so all components can reference Theme cleanly)
local function Theme() return CurrentTheme end

-- ═══════════════════════════════════════════════════════════════════════════
--  UTILITIES
-- ═══════════════════════════════════════════════════════════════════════════

local function N(cls, props, parent)
    local i = Instance.new(cls)
    for k, v in pairs(props or {}) do i[k] = v end
    if parent then i.Parent = parent end
    return i
end

local function Tw(inst, dur, props, style, dir)
    local t = TweenService:Create(inst,
        TweenInfo.new(dur or 0.25, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

local function Corner(p, r) local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, r or 8); c.Parent = p; return c end

local function Stroke(p, color, t, trans)
    local s = Instance.new("UIStroke")
    s.Color = color or Theme().Border
    s.Thickness = t or 1
    s.Transparency = trans or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = p
    return s
end

local function Grad(p, c1, c2, rot)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(c1, c2)
    g.Rotation = rot or 0
    g.Parent = p
    return g
end

local function List(p, props)
    props = props or {}
    local l = Instance.new("UIListLayout")
    l.FillDirection       = props.FillDirection       or Enum.FillDirection.Vertical
    l.HorizontalAlignment = props.HorizontalAlignment or Enum.HorizontalAlignment.Left
    l.VerticalAlignment   = props.VerticalAlignment   or Enum.VerticalAlignment.Top
    l.SortOrder           = props.SortOrder           or Enum.SortOrder.LayoutOrder
    l.Padding             = props.Padding             or UDim.new(0, 8)
    l.Parent = p
    return l
end

local function Pad(p, t, r, b, l)
    local u = Instance.new("UIPadding")
    u.PaddingTop = UDim.new(0, t or 0)
    u.PaddingRight = UDim.new(0, r or t or 0)
    u.PaddingBottom = UDim.new(0, b or t or 0)
    u.PaddingLeft = UDim.new(0, l or r or t or 0)
    u.Parent = p
    return u
end

local function clamp(v, mn, mx) return math.max(mn, math.min(mx, v)) end

local function formatNumber(n)
    n = tonumber(n) or 0
    local abs = math.abs(n)
    if abs >= 1e9 then return string.format("%.2fB", n/1e9) end
    if abs >= 1e6 then return string.format("%.2fM", n/1e6) end
    if abs >= 1e3 then return string.format("%.1fK", n/1e3) end
    return tostring(math.floor(n))
end
Apex.formatNumber = formatNumber

-- ═══════════════════════════════════════════════════════════════════════════
--  TOOLTIPS
-- ═══════════════════════════════════════════════════════════════════════════

local tooltipGui, tooltipHolder, tooltipLabel
local function ensureTooltip()
    if tooltipGui and tooltipGui.Parent then return end
    tooltipGui = N("ScreenGui", {
        Name = "ApexTooltips", ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 999,
    }, CoreGuiRef)
    tooltipHolder = N("Frame", {
        BackgroundColor3 = C(20,20,30), BackgroundTransparency = 0.05,
        BorderSizePixel = 0, Size = UDim2.new(0, 10, 0, 24),
        AutomaticSize = Enum.AutomaticSize.X, Visible = false,
    }, tooltipGui)
    Corner(tooltipHolder, 6)
    Stroke(tooltipHolder, CurrentTheme.BorderHi, 1, 0.4)
    Pad(tooltipHolder, 5, 10, 5, 10)
    tooltipLabel = N("TextLabel", {
        BackgroundTransparency = 1, Font = F.Medium, TextSize = 12,
        TextColor3 = CurrentTheme.Text, Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X, TextXAlignment = Enum.TextXAlignment.Center,
    }, tooltipHolder)
end

local function showTooltip(text, mx, my)
    ensureTooltip()
    tooltipLabel.Text = text
    tooltipHolder.Position = UDim2.fromOffset(mx + 14, my + 14)
    tooltipHolder.Visible = true
end
local function hideTooltip() if tooltipHolder then tooltipHolder.Visible = false end end

-- ═══════════════════════════════════════════════════════════════════════════
--  COMPONENT LIBRARY
-- ═══════════════════════════════════════════════════════════════════════════

local UILib = {}
Apex.UILib = UILib

function UILib.AttachTooltip(inst, text)
    inst.MouseEnter:Connect(function(x, y) showTooltip(text, x, y) end)
    inst.MouseMove:Connect(function(x, y) showTooltip(text, x, y) end)
    inst.MouseLeave:Connect(hideTooltip)
end

-- Section ─────────────────────────────────────────────────────────────────
function UILib.Section(parent, title, order)
    local t = Theme()
    local holder = N("Frame", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 24),
        LayoutOrder = order or -os.clock() * 1000,
    }, parent)
    holder:SetAttribute("_Section", true)

    local dot = N("Frame", {
        BackgroundColor3 = t.Accent, BorderSizePixel = 0,
        Size = UDim2.fromOffset(4, 14), Position = UDim2.new(0, 0, 0, 5),
    }, holder)
    Corner(dot, 2)
    Grad(dot, t.Accent, t.AccentAlt, 90)

    N("TextLabel", {
        Text = title, Font = F.Bold, TextSize = 12, TextColor3 = t.Text,
        BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, -20, 1, 0), Position = UDim2.new(0, 14, 0, 0),
    }, holder)

    local line = N("Frame", {
        BackgroundColor3 = t.Border, BorderSizePixel = 0,
        Size = UDim2.new(1, -14, 0, 1), Position = UDim2.new(0, 14, 1, -4),
        BackgroundTransparency = 0.5,
    }, holder)

    onThemeChange(function(nt)
        dot.BackgroundColor3 = nt.Accent
        line.BackgroundColor3 = nt.Border
    end)
    return holder
end

-- Toggle ──────────────────────────────────────────────────────────────────
function UILib.Toggle(parent, cfg)
    cfg = cfg or {}
    local t = Theme()
    local value = cfg.Value == true
    local row = N("Frame", {
        BackgroundColor3 = t.Surface, BackgroundTransparency = 0.4, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 48), LayoutOrder = cfg.Order or -os.clock() * 1000,
    }, parent)
    Corner(row, 10)
    local rowStroke = Stroke(row, t.Border, 1, 0.4)

    N("TextLabel", {
        Text = cfg.Title or "Toggle", Font = F.Bold, TextSize = 13, TextColor3 = t.Text,
        BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, -80, 0, 16), Position = UDim2.new(0, 14, 0, 8),
    }, row)
    if cfg.Desc and cfg.Desc ~= "" then
        N("TextLabel", {
            Text = cfg.Desc, Font = F.Regular, TextSize = 11, TextColor3 = t.TextMute,
            BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            Size = UDim2.new(1, -80, 0, 14), Position = UDim2.new(0, 14, 0, 26),
        }, row)
    end

    local track = N("Frame", {
        BackgroundColor3 = value and t.Success or t.Surface3, BorderSizePixel = 0,
        Size = UDim2.fromOffset(44, 24), Position = UDim2.new(1, -56, 0, 12),
    }, row)
    Corner(track, 12)
    local trackStroke = Stroke(track, value and t.Success or t.BorderHi, 1, 0.3)

    local knob = N("Frame", {
        BackgroundColor3 = C(255,255,255), BorderSizePixel = 0, Size = UDim2.fromOffset(18, 18),
        Position = value and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
    }, track)
    Corner(knob, 9)

    local glow = N("Frame", {
        BackgroundColor3 = t.Success, BackgroundTransparency = value and 0.85 or 1,
        BorderSizePixel = 0, Size = UDim2.new(1, 4, 1, 4), Position = UDim2.new(0, -2, 0, -2),
        ZIndex = -1,
    }, track)
    Corner(glow, 14)

    local click = N("TextButton", {
        Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), AutoButtonColor = false,
    }, row)

    local function setValue(v, fire)
        value = v
        local nt = Theme()
        Tw(track, 0.2, { BackgroundColor3 = v and nt.Success or nt.Surface3 }, Enum.EasingStyle.Quad)
        Tw(trackStroke, 0.2, { Color = v and nt.Success or nt.BorderHi })
        Tw(knob, 0.22, { Position = v and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9) },
            Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        Tw(glow, 0.3, { BackgroundTransparency = v and 0.85 or 1 })
        if fire and cfg.Callback then task.spawn(cfg.Callback, v) end
    end

    click.MouseEnter:Connect(function()
        local nt = Theme()
        Tw(row, 0.15, { BackgroundTransparency = 0.15, BackgroundColor3 = nt.Surface2 })
        Tw(rowStroke, 0.15, { Color = nt.BorderHi, Transparency = 0.2 })
    end)
    click.MouseLeave:Connect(function()
        local nt = Theme()
        Tw(row, 0.15, { BackgroundTransparency = 0.4, BackgroundColor3 = nt.Surface })
        Tw(rowStroke, 0.15, { Color = nt.Border, Transparency = 0.4 })
    end)
    click.MouseButton1Click:Connect(function() setValue(not value, true) end)

    if cfg.Tooltip then UILib.AttachTooltip(row, cfg.Tooltip) end

    onThemeChange(function(nt)
        row.BackgroundColor3 = nt.Surface
        rowStroke.Color = nt.Border
        if value then
            track.BackgroundColor3 = nt.Success
            trackStroke.Color = nt.Success
        else
            track.BackgroundColor3 = nt.Surface3
            trackStroke.Color = nt.BorderHi
        end
    end)

    return {
        Frame = row,
        Set = function(v) setValue(v, false) end,
        Get = function() return value end,
        Toggle = function() setValue(not value, true) end,
    }
end

-- Button ──────────────────────────────────────────────────────────────────
function UILib.Button(parent, cfg)
    cfg = cfg or {}
    local t = Theme()
    local height = cfg.Height or 40
    local variant = cfg.Variant or "default"

    local pal = {
        default = { bg = t.Surface2, txt = t.Text,         stroke = t.Border },
        primary = { bg = t.Accent,   txt = C(255,255,255), stroke = t.AccentHi },
        danger  = { bg = t.Danger,   txt = C(255,255,255), stroke = t.Danger },
        success = { bg = t.Success,  txt = C(255,255,255), stroke = t.Success },
    }[variant]

    local btn = N("TextButton", {
        Text = "", BackgroundColor3 = pal.bg, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, height), AutoButtonColor = false,
        LayoutOrder = cfg.Order or -os.clock() * 1000,
    }, parent)
    Corner(btn, 10)
    local st = Stroke(btn, pal.stroke, 1, 0.25)

    if variant == "primary" then Grad(btn, t.Accent, t.AccentAlt, 45) end

    local hasDesc = cfg.Desc and cfg.Desc ~= ""
    N("TextLabel", {
        Text = cfg.Title or "Button", Font = F.Bold, TextSize = 13, TextColor3 = pal.txt,
        BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Center,
        Size = UDim2.new(1, 0, 0, hasDesc and 16 or height),
        Position = UDim2.new(0, 0, 0, hasDesc and 5 or 0),
    }, btn)
    if hasDesc then
        N("TextLabel", {
            Text = cfg.Desc, Font = F.Regular, TextSize = 10,
            TextColor3 = C(255,255,255), TextTransparency = 0.4, BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Center,
            Size = UDim2.new(1, 0, 0, 12), Position = UDim2.new(0, 0, 0, 22),
        }, btn)
    end

    local origBg = pal.bg
    btn.MouseEnter:Connect(function()
        Tw(btn, 0.15, { BackgroundColor3 = origBg:Lerp(C(1,1,1), 0.12) })
        Tw(st, 0.15, { Transparency = 0 })
    end)
    btn.MouseLeave:Connect(function()
        Tw(btn, 0.15, { BackgroundColor3 = origBg })
        Tw(st, 0.15, { Transparency = 0.25 })
    end)
    btn.MouseButton1Down:Connect(function()
        Tw(btn, 0.08, { Size = UDim2.new(1, -6, 0, height - 4), Position = UDim2.new(0, 3, 0, 2) })
    end)
    btn.MouseButton1Up:Connect(function()
        Tw(btn, 0.12, { Size = UDim2.new(1, 0, 0, height), Position = UDim2.new(0, 0, 0, 0) }, Enum.EasingStyle.Back)
    end)
    btn.MouseButton1Click:Connect(function()
        if cfg.Callback then task.spawn(cfg.Callback) end
    end)

    if cfg.Tooltip then UILib.AttachTooltip(btn, cfg.Tooltip) end
    return { Frame = btn }
end

-- Slider ──────────────────────────────────────────────────────────────────
function UILib.Slider(parent, cfg)
    cfg = cfg or {}
    local t = Theme()
    local min = cfg.Min or 0
    local max = cfg.Max or 100
    local value = clamp(cfg.Value or min, min, max)

    local holder = N("Frame", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 52),
        LayoutOrder = cfg.Order or -os.clock() * 1000,
    }, parent)

    N("TextLabel", {
        Text = cfg.Title or "Slider", Font = F.Bold, TextSize = 12, TextColor3 = t.Text,
        BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(0.7, 0, 0, 16),
    }, holder)

    local valLbl = N("TextLabel", {
        Text = tostring(value), Font = F.Bold, TextSize = 12, TextColor3 = t.AccentHi,
        BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Right,
        Size = UDim2.new(0.3, 0, 0, 16), Position = UDim2.new(0.7, 0, 0, 0),
    }, holder)

    local track = N("Frame", {
        BackgroundColor3 = t.Surface2, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 8), Position = UDim2.new(0, 0, 0, 28),
    }, holder)
    Corner(track, 4)
    Stroke(track, t.Border, 1, 0.4)

    local pct = (value - min) / (max - min)
    local fill = N("Frame", { BackgroundColor3 = t.Accent, BorderSizePixel = 0, Size = UDim2.new(pct, 0, 1, 0) }, track)
    Corner(fill, 4)
    Grad(fill, t.Accent, t.AccentHi, 0)

    local knob = N("Frame", {
        BackgroundColor3 = C(255,255,255), BorderSizePixel = 0, Size = UDim2.fromOffset(16, 16),
        Position = UDim2.new(pct, -8, 0.5, -8), ZIndex = 4,
    }, track)
    Corner(knob, 8)
    Stroke(knob, t.Accent, 2, 0)

    local function setValue(v, fire)
        v = clamp(tonumber(v) or value, min, max)
        value = v
        local p = (v - min) / (max - min)
        Tw(fill, 0.1, { Size = UDim2.new(p, 0, 1, 0) })
        Tw(knob, 0.1, { Position = UDim2.new(p, -8, 0.5, -8) })
        valLbl.Text = cfg.Format and cfg.Format(v) or tostring(v)
        if fire and cfg.Callback then task.spawn(cfg.Callback, v) end
    end

    local dragging = false
    local btn = N("TextButton", {
        Text = "", BackgroundTransparency = 1,
        Size = UDim2.new(1, 20, 1, 0), Position = UDim2.new(0, -10, 0, 0),
        AutoButtonColor = false, ZIndex = 5,
    }, track)

    local function posToValue(x)
        local rel = clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        return math.floor(min + rel * (max - min) + 0.5)
    end

    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            setValue(posToValue(input.Position.X), true)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
                        or input.UserInputType == Enum.UserInputType.Touch) then
            setValue(posToValue(input.Position.X), true)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1
                        or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = false
        end
    end)

    onThemeChange(function(nt)
        track.BackgroundColor3 = nt.Surface2
        fill.BackgroundColor3 = nt.Accent
        valLbl.TextColor3 = nt.AccentHi
    end)

    return {
        Frame = holder,
        Set = function(v) setValue(v, false) end,
        Get = function() return value end,
        SetMax = function(m) max = m; setValue(value, false) end,
    }
end

-- Textbox ─────────────────────────────────────────────────────────────────
function UILib.Textbox(parent, cfg)
    cfg = cfg or {}
    local t = Theme()
    local holder = N("Frame", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 52),
        LayoutOrder = cfg.Order or -os.clock() * 1000,
    }, parent)

    N("TextLabel", {
        Text = cfg.Title or "Input", Font = F.Bold, TextSize = 12, TextColor3 = t.Text,
        BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, 0, 0, 16),
    }, holder)

    local box = N("Frame", {
        BackgroundColor3 = t.Surface2, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 30), Position = UDim2.new(0, 0, 0, 20),
    }, holder)
    Corner(box, 8)
    local bs = Stroke(box, t.Border, 1, 0.4)

    local tb = N("TextBox", {
        Text = cfg.Value or "", PlaceholderText = cfg.Placeholder or "",
        PlaceholderColor3 = t.TextMute, TextColor3 = t.Text,
        Font = F.Medium, TextSize = 12, BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = cfg.ClearTextOnFocus or false,
        Size = UDim2.new(1, -24, 1, 0), Position = UDim2.new(0, 12, 0, 0),
    }, box)

    tb.Focused:Connect(function() Tw(bs, 0.15, { Color = Theme().Accent, Transparency = 0 }) end)
    tb.FocusLost:Connect(function()
        Tw(bs, 0.15, { Color = Theme().Border, Transparency = 0.4 })
        if cfg.Callback then task.spawn(cfg.Callback, tb.Text) end
    end)

    onThemeChange(function(nt)
        box.BackgroundColor3 = nt.Surface2
        tb.TextColor3 = nt.Text
        tb.PlaceholderColor3 = nt.TextMute
    end)

    return { Frame = holder, Set = function(v) tb.Text = v end, Get = function() return tb.Text end }
end

-- Dropdown ────────────────────────────────────────────────────────────────
function UILib.Dropdown(parent, cfg)
    cfg = cfg or {}
    local t = Theme()
    local options = cfg.Options or cfg.List or {}
    local value = cfg.Value or (options[1] or "")
    local open = false

    local holder = N("Frame", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 52),
        LayoutOrder = cfg.Order or -os.clock() * 1000,
        ClipsDescendants = false, ZIndex = 5,
    }, parent)

    N("TextLabel", {
        Text = cfg.Title or "Select", Font = F.Bold, TextSize = 12, TextColor3 = t.Text,
        BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, 0, 0, 16),
    }, holder)

    local box = N("TextButton", {
        Text = "", BackgroundColor3 = t.Surface2, BorderSizePixel = 0,
        AutoButtonColor = false, Size = UDim2.new(1, 0, 0, 30),
        Position = UDim2.new(0, 0, 0, 20), ZIndex = 5,
    }, holder)
    Corner(box, 8)
    Stroke(box, t.Border, 1, 0.4)

    local valueLbl = N("TextLabel", {
        Text = tostring(value), Font = F.Medium, TextSize = 12, TextColor3 = t.Text,
        BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, -40, 1, 0), Position = UDim2.new(0, 12, 0, 0), ZIndex = 6,
    }, box)

    local arrow = N("TextLabel", {
        Text = "▾", Font = F.Bold, TextSize = 14, TextColor3 = t.TextDim,
        BackgroundTransparency = 1, Size = UDim2.fromOffset(24, 24),
        Position = UDim2.new(1, -30, 0.5, -12), ZIndex = 6,
    }, box)

    local menu = N("Frame", {
        BackgroundColor3 = t.Surface, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 0), Position = UDim2.new(0, 0, 1, 4),
        Visible = false, ClipsDescendants = true, ZIndex = 10,
    }, box)
    Corner(menu, 8)
    Stroke(menu, t.Border, 1, 0)
    List(menu, { Padding = UDim.new(0, 0) })

    local function rebuild()
        for _, c in ipairs(menu:GetChildren()) do
            if c:IsA("TextButton") then c:Destroy() end
        end
        for _, opt in ipairs(options) do
            local ob = N("TextButton", {
                Text = tostring(opt), Font = F.Medium, TextSize = 12,
                TextColor3 = Theme().TextDim, BackgroundColor3 = Theme().Surface,
                BackgroundTransparency = 1, BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 26),
                TextXAlignment = Enum.TextXAlignment.Left,
                AutoButtonColor = false, ZIndex = 11,
            }, menu)
            Pad(ob, 0, 10, 0, 10)
            ob.MouseEnter:Connect(function() Tw(ob, 0.1, { BackgroundTransparency = 0.6, TextColor3 = Theme().Text }) end)
            ob.MouseLeave:Connect(function() Tw(ob, 0.1, { BackgroundTransparency = 1, TextColor3 = Theme().TextDim }) end)
            ob.MouseButton1Click:Connect(function()
                value = opt
                valueLbl.Text = tostring(opt)
                toggle(false)
                if cfg.Callback then task.spawn(cfg.Callback, opt) end
            end)
        end
    end
    rebuild()

    local function toggle(state)
        if state == nil then state = not open end
        open = state
        local h = math.min(#options * 26, 200)
        if open then
            menu.Visible = true
            Tw(menu, 0.2, { Size = UDim2.new(1, 0, 0, h) })
            Tw(arrow, 0.2, { Rotation = 180 })
        else
            Tw(menu, 0.2, { Size = UDim2.new(1, 0, 0, 0) })
            Tw(arrow, 0.2, { Rotation = 0 })
            task.delay(0.2, function() if not open then menu.Visible = false end end)
        end
    end

    box.MouseButton1Click:Connect(function() toggle() end)

    onThemeChange(function(nt)
        box.BackgroundColor3 = nt.Surface2
        valueLbl.TextColor3 = nt.Text
        arrow.TextColor3 = nt.TextDim
        menu.BackgroundColor3 = nt.Surface
    end)

    return {
        Frame = holder,
        Get = function() return value end,
        Set = function(v) value = v; valueLbl.Text = tostring(v) end,
        SetOptions = function(opts) options = opts; rebuild() end,
    }
end

-- StatCard ────────────────────────────────────────────────────────────────
function UILib.StatCard(parent, cfg)
    cfg = cfg or {}
    local t = Theme()
    local card = N("Frame", {
        BackgroundColor3 = t.Surface, BackgroundTransparency = 0.3, BorderSizePixel = 0,
        Size = UDim2.new(0.5, -5, 0, 68), LayoutOrder = cfg.Order or 0,
    }, parent)
    Corner(card, 12)
    local st = Stroke(card, t.Border, 1, 0.35)

    local bar = N("Frame", {
        BackgroundColor3 = cfg.Color or t.Accent, BorderSizePixel = 0,
        Size = UDim2.new(0, 3, 0, 40), Position = UDim2.new(0, 8, 0.5, -20),
    }, card)
    Corner(bar, 2)

    local icon = N("TextLabel", {
        Text = cfg.Icon or "★", Font = F.Black, TextSize = 22,
        TextColor3 = cfg.Color or t.Accent, BackgroundTransparency = 1,
        Size = UDim2.fromOffset(28, 28), Position = UDim2.new(0, 16, 0, 10),
    }, card)

    N("TextLabel", {
        Text = cfg.Label or "Label", Font = F.Medium, TextSize = 10,
        TextColor3 = t.TextMute, BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, -50, 0, 14), Position = UDim2.new(0, 46, 0, 10),
    }, card)

    local valueLbl = N("TextLabel", {
        Text = tostring(cfg.Value or "0"), Font = F.Black, TextSize = 20,
        TextColor3 = t.Text, BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, -50, 0, 24), Position = UDim2.new(0, 46, 0, 26),
    }, card)

    card.MouseEnter:Connect(function()
        Tw(card, 0.2, { BackgroundTransparency = 0.15, BackgroundColor3 = Theme().Surface2 })
        Tw(st, 0.2, { Color = cfg.Color or Theme().AccentHi, Transparency = 0 })
    end)
    card.MouseLeave:Connect(function()
        Tw(card, 0.2, { BackgroundTransparency = 0.3, BackgroundColor3 = Theme().Surface })
        Tw(st, 0.2, { Color = Theme().Border, Transparency = 0.35 })
    end)

    if cfg.Tooltip then UILib.AttachTooltip(card, cfg.Tooltip) end

    return {
        Frame = card,
        SetValue = function(v)
            valueLbl.Text = tostring(v)
            Tw(valueLbl, 0.1, { TextSize = 22 })
            Tw(valueLbl, 0.25, { TextSize = 20 }, Enum.EasingStyle.Back)
        end,
        SetColor = function(c) icon.TextColor3 = c; bar.BackgroundColor3 = c end,
    }
end

-- Progress ────────────────────────────────────────────────────────────────
function UILib.Progress(parent, cfg)
    cfg = cfg or {}
    local t = Theme()
    local holder = N("Frame", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 46),
        LayoutOrder = cfg.Order or -os.clock() * 1000,
    }, parent)

    N("TextLabel", {
        Text = cfg.Label or "Progress", Font = F.Bold, TextSize = 12,
        TextColor3 = t.TextDim, BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(0.6, 0, 0, 16),
    }, holder)

    local valLbl = N("TextLabel", {
        Text = "0 / 100", Font = F.Bold, TextSize = 12, TextColor3 = t.Text,
        BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Right,
        Size = UDim2.new(0.4, 0, 0, 16), Position = UDim2.new(0.6, 0, 0, 0),
    }, holder)

    local track = N("Frame", {
        BackgroundColor3 = t.Surface2, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 0, 22),
    }, holder)
    Corner(track, 7)
    Stroke(track, t.Border, 1, 0.4)

    local fill = N("Frame", {
        BackgroundColor3 = cfg.Color or t.Accent, BorderSizePixel = 0,
        Size = UDim2.new(0, 0, 1, 0),
    }, track)
    Corner(fill, 7)
    Grad(fill, cfg.Color or t.Accent, t.AccentHi, 0)

    local shimmer = N("Frame", {
        BackgroundColor3 = C(255,255,255), BackgroundTransparency = 0.85,
        BorderSizePixel = 0, Size = UDim2.new(0, 40, 1, 0), Position = UDim2.new(0, -40, 0, 0),
    }, track)
    Corner(shimmer, 7)
    local sg = Instance.new("UIGradient")
    sg.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0.6),
        NumberSequenceKeypoint.new(1, 1),
    })
    sg.Parent = shimmer

    local shimmerT = 0
    local shimmerConn = RS.Heartbeat:Connect(function(dt)
        shimmerT = shimmerT + dt
        if shimmerT > 1.8 then
            shimmerT = 0
            if fill.AbsoluteSize.X > 10 then
                shimmer.Position = UDim2.new(0, -40, 0, 0)
                Tw(shimmer, 1.6, { Position = UDim2.new(1, 0, 0, 0) }, Enum.EasingStyle.Linear)
            end
        end
    end)
    holder.Destroying:Connect(function() shimmerConn:Disconnect() end)

    return {
        Frame = holder,
        SetProgress = function(cur, max)
            max = math.max(max or 100, 1)
            cur = clamp(cur or 0, 0, max)
            local p = cur / max
            Tw(fill, 0.4, { Size = UDim2.new(p, 0, 1, 0) }, Enum.EasingStyle.Quart)
            valLbl.Text = string.format("%d / %d", math.floor(cur), math.floor(max))
        end,
    }
end

-- Badge ───────────────────────────────────────────────────────────────────
function UILib.Badge(parent, cfg)
    cfg = cfg or {}
    local t = Theme()
    local holder = N("Frame", {
        BackgroundColor3 = cfg.Color or t.Accent, BackgroundTransparency = 0.8,
        BorderSizePixel = 0, Size = UDim2.new(0, 0, 0, 20),
        AutomaticSize = Enum.AutomaticSize.X, LayoutOrder = cfg.Order or 0,
    }, parent)
    Corner(holder, 10)
    Stroke(holder, cfg.Color or t.Accent, 1, 0.3)
    Pad(holder, 0, 8, 0, 8)
    N("TextLabel", {
        Text = cfg.Text or "Badge", Font = F.Bold, TextSize = 10,
        TextColor3 = cfg.Color or t.Accent, BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Center,
        Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X,
    }, holder)
    return holder
end

-- Divider ─────────────────────────────────────────────────────────────────
function UILib.Divider(parent, order)
    local d = N("Frame", {
        BackgroundColor3 = Theme().Border, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 1), BackgroundTransparency = 0.5,
        LayoutOrder = order or 0,
    }, parent)
    onThemeChange(function(nt) d.BackgroundColor3 = nt.Border end)
    return d
end

-- Graph ───────────────────────────────────────────────────────────────────
function UILib.Graph(parent, cfg)
    cfg = cfg or {}
    local t = Theme()
    local MAX_POINTS = cfg.MaxPoints or 60
    local samples = {}

    local holder = N("Frame", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 140),
        LayoutOrder = cfg.Order or -os.clock() * 1000,
    }, parent)

    N("TextLabel", {
        Text = cfg.Label or "Rate", Font = F.Bold, TextSize = 12,
        TextColor3 = t.TextDim, BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(0.7, 0, 0, 16),
    }, holder)

    local statLbl = N("TextLabel", {
        Text = "—", Font = F.Bold, TextSize = 12, TextColor3 = cfg.Color or t.Success,
        BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Right,
        Size = UDim2.new(0.3, 0, 0, 16), Position = UDim2.new(0.7, 0, 0, 0),
    }, holder)

    local plot = N("Frame", {
        BackgroundColor3 = t.Surface2, BackgroundTransparency = 0.4, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 110), Position = UDim2.new(0, 0, 0, 22),
        ClipsDescendants = true,
    }, holder)
    Corner(plot, 10)
    Stroke(plot, t.Border, 1, 0.5)

    for i = 1, 3 do
        N("Frame", {
            BackgroundColor3 = t.Border, BackgroundTransparency = 0.7,
            BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 1),
            Position = UDim2.new(0, 0, i/4, 0),
        }, plot)
    end

    local bars = {}
    for i = 1, MAX_POINTS do
        local b = N("Frame", {
            BackgroundColor3 = cfg.Color or t.Success, BorderSizePixel = 0,
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(i / MAX_POINTS, -2, 1, 0),
            AnchorPoint = Vector2.new(0.5, 1),
        }, plot)
        Corner(b, 1)
        table.insert(bars, b)
    end

    onThemeChange(function(nt)
        plot.BackgroundColor3 = nt.Surface2
        for _, b in ipairs(bars) do b.BackgroundColor3 = cfg.Color or nt.Success end
    end)

    local function push(v)
        table.insert(samples, v)
        while #samples > MAX_POINTS do table.remove(samples, 1) end
        local mx = 1
        for _, s in ipairs(samples) do if s > mx then mx = s end end
        for i = 1, MAX_POINTS do
            local idx = #samples - (MAX_POINTS - i)
            local s = samples[idx]
            local bar = bars[i]
            if s then
                bar.Size = UDim2.new(0, 3, 0, math.max((s/mx)*100, 2))
            else
                bar.Size = UDim2.new(0, 3, 0, 0)
            end
        end
        if v then statLbl.Text = cfg.Format and cfg.Format(v) or tostring(v) end
    end

    return { Frame = holder, Push = push }
end

-- LogView ─────────────────────────────────────────────────────────────────
function UILib.LogView(parent)
    local t = Theme()
    local scroll = N("ScrollingFrame", {
        BackgroundColor3 = t.BgSolid, BackgroundTransparency = 0.3, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0), CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 4, ScrollBarImageColor3 = t.Border,
        ScrollBarImageTransparency = 0.4,
    }, parent)
    Corner(scroll, 10)
    Stroke(scroll, t.Border, 1, 0.4)
    List(scroll, { Padding = UDim.new(0, 4) })
    Pad(scroll, 10, 10, 10, 10)

    local entries = {}
    local filter, search = "all", ""

    local function match(e)
        if filter ~= "all" and e.kind ~= filter then return false end
        if search ~= "" and not e.text:lower():find(search:lower(), 1, true) then return false end
        return true
    end

    local function refresh()
        for _, e in ipairs(entries) do e.frame.Visible = match(e) end
    end

    local api = {}

    function api.Append(text, color, kind)
        kind = kind or "info"
        local frame = N("Frame", {
            BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 18),
            LayoutOrder = -math.floor(os.clock() * 1000),
        }, scroll)
        N("TextLabel", {
            Text = os.date("%H:%M:%S"), Font = F.Medium, TextSize = 10,
            TextColor3 = Theme().TextMute, BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.fromOffset(60, 18),
            TextTransparency = 1, Name = "TS",
        }, frame)
        local msg = N("TextLabel", {
            Text = text, Font = F.Regular, TextSize = 12,
            TextColor3 = color or Theme().Text, BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
            Size = UDim2.new(1, -64, 0, 18), Position = UDim2.new(0, 64, 0, 0),
            TextTransparency = 1,
        }, frame)
        local entry = { frame = frame, text = text, kind = kind }
        table.insert(entries, entry)
        frame.Visible = match(entry)
        Tw(frame.TS, 0.25, { TextTransparency = 0 })
        Tw(msg, 0.25, { TextTransparency = 0 })
        if #entries > 300 then
            local old = table.remove(entries, 1)
            old.frame:Destroy()
        end
    end

    function api.Clear()
        for _, e in ipairs(entries) do e.frame:Destroy() end
        entries = {}
    end
    function api.SetFilter(f) filter = f; refresh() end
    function api.SetSearch(s) search = s; refresh() end
    function api.Export()
        local out = {}
        for _, e in ipairs(entries) do
            table.insert(out, string.format("[%s] %s", e.kind:upper(), e.text))
        end
        return table.concat(out, "\n")
    end

    onThemeChange(function(nt)
        scroll.BackgroundColor3 = nt.BgSolid
        scroll.ScrollBarImageColor3 = nt.Border
    end)

    return api, scroll
end

-- Context menu ────────────────────────────────────────────────────────────
local contextMenu = nil
local function closeContextMenu() if contextMenu then contextMenu:Destroy(); contextMenu = nil end end

function UILib.AttachContextMenu(inst, items)
    inst.MouseButton2Click:Connect(function()
        closeContextMenu()
        local t = Theme()
        local mouse = UIS:GetMouseLocation()
        local gui = N("ScreenGui", {
            ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 1000,
        }, CoreGuiRef)
        contextMenu = gui
        local frame = N("Frame", {
            BackgroundColor3 = t.Surface, BorderSizePixel = 0,
            Size = UDim2.fromOffset(180, #items * 28 + 8),
            Position = UDim2.fromOffset(mouse.X, mouse.Y),
        }, gui)
        Corner(frame, 8)
        Stroke(frame, t.Border, 1, 0)
        List(frame, { Padding = UDim.new(0, 2) })
        Pad(frame, 4, 4, 4, 4)
        for _, item in ipairs(items) do
            local b = N("TextButton", {
                Text = item.Title or "Item", Font = F.Medium, TextSize = 12,
                TextColor3 = item.Color or t.TextDim, BackgroundColor3 = t.Surface,
                BackgroundTransparency = 1, BorderSizePixel = 0,
                AutoButtonColor = false, Size = UDim2.new(1, 0, 0, 24),
                TextXAlignment = Enum.TextXAlignment.Left,
            }, frame)
            Pad(b, 0, 8, 0, 8)
            b.MouseEnter:Connect(function() Tw(b, 0.1, { BackgroundTransparency = 0.6, TextColor3 = Theme().Text }) end)
            b.MouseLeave:Connect(function() Tw(b, 0.1, { BackgroundTransparency = 1, TextColor3 = item.Color or Theme().TextDim }) end)
            b.MouseButton1Click:Connect(function()
                closeContextMenu()
                if item.Callback then task.spawn(item.Callback) end
            end)
        end
        task.delay(0.05, function()
            local conn
            conn = UIS.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1
                   or inp.UserInputType == Enum.UserInputType.Touch then
                    closeContextMenu()
                    conn:Disconnect()
                end
            end)
        end)
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════
--  NOTIFICATIONS
-- ═══════════════════════════════════════════════════════════════════════════

local Notif = {}
Notif.__index = Notif
function Notif.new(holder)
    return setmetatable({ Holder = holder, Queue = {}, Active = 0, MaxActive = 4 }, Notif)
end
function Notif:Push(cfg)
    cfg = cfg or {}
    if self.Active >= self.MaxActive then table.insert(self.Queue, cfg); return end
    self:_show(cfg)
end
function Notif:_show(cfg)
    self.Active = self.Active + 1
    local t = Theme()
    local ntype = cfg.Type or "info"
    local dur = cfg.Duration or 3.5
    local accent = t.Accent
    if ntype == "success" then accent = t.Success
    elseif ntype == "error" then accent = t.Danger
    elseif ntype == "warn" then accent = t.Warn
    elseif ntype == "coin" then accent = t.Coin
    elseif ntype == "gem" then accent = t.Gem
    end

    local toast = N("Frame", {
        BackgroundColor3 = t.Surface, BackgroundTransparency = 1, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 56), LayoutOrder = -math.floor(os.clock() * 1000),
        ClipsDescendants = true,
    }, self.Holder)
    Corner(toast, 12)
    Stroke(toast, accent, 1, 0.3)

    local bar = N("Frame", {
        BackgroundColor3 = accent, BorderSizePixel = 0,
        Size = UDim2.new(0, 4, 1, -12), Position = UDim2.new(0, 6, 0, 6),
        BackgroundTransparency = 1,
    }, toast)
    Corner(bar, 2)

    N("TextLabel", {
        Text = cfg.Title or "Notice", Font = F.Bold, TextSize = 13,
        TextColor3 = t.Text, BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
        Size = UDim2.new(1, -30, 0, 16), Position = UDim2.new(0, 20, 0, 8),
        TextTransparency = 1, Name = "T",
    }, toast)

    N("TextLabel", {
        Text = cfg.Desc or "", Font = F.Regular, TextSize = 11,
        TextColor3 = t.TextDim, BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
        Size = UDim2.new(1, -30, 0, 14), Position = UDim2.new(0, 20, 0, 28),
        TextTransparency = 1, Name = "D",
    }, toast)

    local prog = N("Frame", {
        BackgroundColor3 = accent, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 2), Position = UDim2.new(0, 0, 1, -2),
        BackgroundTransparency = 0.5,
    }, toast)

    toast.Position = UDim2.new(1, 20, 0, 0)
    Tw(toast, 0.35, { Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 0.05 }, Enum.EasingStyle.Quart)
    Tw(bar, 0.3, { BackgroundTransparency = 0 })
    Tw(toast.T, 0.3, { TextTransparency = 0 })
    Tw(toast.D, 0.3, { TextTransparency = 0 })
    Tw(prog, dur, { Size = UDim2.new(0, 0, 0, 2) }, Enum.EasingStyle.Linear)

    local function dismiss()
        Tw(toast, 0.3, { Position = UDim2.new(1, 20, 0, 0), BackgroundTransparency = 1 })
        Tw(bar, 0.25, { BackgroundTransparency = 1 })
        Tw(toast.T, 0.25, { TextTransparency = 1 })
        Tw(toast.D, 0.25, { TextTransparency = 1 })
        task.wait(0.35)
        toast:Destroy()
        self.Active = self.Active - 1
        local nxt = table.remove(self.Queue, 1)
        if nxt then self:_show(nxt) end
    end
    task.delay(dur, dismiss)
end

-- ═══════════════════════════════════════════════════════════════════════════
--  WINDOW
-- ═══════════════════════════════════════════════════════════════════════════

local Window = {}
Window.__index = Window

function Apex.Window(cfg)
    cfg = cfg or {}
    local self = setmetatable({}, Window)
    local t = Theme()

    local width  = cfg.Width  or 660
    local height = cfg.Height or 500

    local screen = N("ScreenGui", {
        Name = cfg.ScreenGuiName or "ApexUI",
        ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, IgnoreGuiInset = true,
    }, CoreGuiRef)
    self.Screen = screen

    local shadow = N("ImageLabel", {
        BackgroundTransparency = 1, Image = "rbxassetid://6015906700",
        ImageColor3 = C(0,0,0), ImageTransparency = 0.5,
        ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(30,30,30,30),
        Size = UDim2.fromOffset(width + 40, height + 40),
        Position = UDim2.new(0.5, -(width+40)/2, 0.5, -(height+40)/2), ZIndex = 1,
    }, screen)
    self.Shadow = shadow

    local main = N("Frame", {
        Name = "Main", BackgroundColor3 = t.Bg, BorderSizePixel = 0,
        Size = UDim2.fromOffset(width, height),
        Position = UDim2.new(0.5, -width/2, 0.5, -height/2),
        ClipsDescendants = true, BackgroundTransparency = 1, ZIndex = 2,
    }, screen)
    Corner(main, 16)
    local mainStroke = Stroke(main, t.Border, 1, 0.2)
    local mainGrad = Grad(main, t.Bg, t.BgSolid, 135)
    self.Frame = main

    -- header
    local header = N("Frame", {
        Name = "Header", BackgroundColor3 = t.BgSolid, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 58), ZIndex = 3,
    }, main)
    Corner(header, 16)
    N("Frame", {
        BackgroundColor3 = t.BgSolid, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 16), Position = UDim2.new(0, 0, 1, -16), ZIndex = 3,
    }, header)

    local hTop = N("Frame", {
        BackgroundColor3 = t.Accent, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 2), ZIndex = 4,
    }, header)
    local hGrad = Grad(hTop, t.Accent, t.AccentAlt, 0)

    local logoBadge = N("Frame", {
        BackgroundColor3 = t.Surface2, BorderSizePixel = 0,
        Size = UDim2.fromOffset(38, 38), Position = UDim2.new(0, 14, 0.5, -19), ZIndex = 4,
    }, header)
    Corner(logoBadge, 10)
    Stroke(logoBadge, t.Accent, 1, 0.3)
    local lbGrad = Grad(logoBadge, t.Surface2, t.Surface3, 45)
    N("TextLabel", {
        Text = cfg.Logo or "⚡", Font = F.Black, TextSize = 22,
        TextColor3 = t.AccentHi, BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0), ZIndex = 5,
    }, logoBadge)

    local titleLbl = N("TextLabel", {
        Text = cfg.Title or "Window", Font = F.Bold, TextSize = 16,
        TextColor3 = t.Text, BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(0, 400, 0, 20), Position = UDim2.new(0, 62, 0, 10), ZIndex = 4,
    }, header)
    self.TitleLabel = titleLbl

    local subLbl = N("TextLabel", {
        Text = cfg.Subtitle or "", Font = F.Regular, TextSize = 11,
        TextColor3 = t.TextMute, BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(0, 400, 0, 14), Position = UDim2.new(0, 62, 0, 30), ZIndex = 4,
    }, header)

    -- ctrl buttons
    local function mkCtrl(text, xOff, hoverCol)
        local b = N("TextButton", {
            Text = text, Font = F.Bold, TextSize = 14, TextColor3 = t.TextDim,
            BackgroundColor3 = t.Surface, BackgroundTransparency = 1,
            Size = UDim2.fromOffset(28, 28), Position = UDim2.new(1, xOff, 0.5, -14),
            AutoButtonColor = false, ZIndex = 5,
        }, header)
        Corner(b, 8)
        local s = Stroke(b, t.Border, 1, 1)
        b.MouseEnter:Connect(function()
            Tw(b, 0.15, { BackgroundTransparency = 0.2, BackgroundColor3 = hoverCol })
            Tw(b, 0.15, { TextColor3 = Theme().Text })
            Tw(s, 0.15, { Transparency = 0.3 })
        end)
        b.MouseLeave:Connect(function()
            Tw(b, 0.15, { BackgroundTransparency = 1, BackgroundColor3 = Theme().Surface })
            Tw(b, 0.15, { TextColor3 = Theme().TextDim })
            Tw(s, 0.15, { Transparency = 1 })
        end)
        return b
    end
    local closeBtn = mkCtrl("✕", -40, t.Danger)
    local minBtn   = mkCtrl("—", -74, t.Surface2)

    -- sidebar
    local sidebar = N("Frame", {
        Name = "Sidebar", BackgroundColor3 = t.BgSolid, BackgroundTransparency = 0.4,
        BorderSizePixel = 0, Size = UDim2.new(0, 72, 1, -58 - 30),
        Position = UDim2.new(0, 0, 0, 58), ZIndex = 3,
    }, main)
    self.Sidebar = sidebar
    N("Frame", {
        BackgroundColor3 = t.Border, BorderSizePixel = 0, BackgroundTransparency = 0.5,
        Size = UDim2.new(0, 1, 1, 0), Position = UDim2.new(1, -1, 0, 0), ZIndex = 4,
    }, sidebar)

    local indicator = N("Frame", {
        BackgroundColor3 = t.Accent, BorderSizePixel = 0,
        Size = UDim2.new(0, 3, 0, 32), Position = UDim2.new(0, 0, 0, 20),
        ZIndex = 5, Visible = false,
    }, sidebar)
    Corner(indicator, 2)
    local indGrad = Grad(indicator, t.Accent, t.AccentAlt, 90)
    self.Indicator = indicator

    local tabList = N("Frame", {
        Name = "TabList", BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0), ZIndex = 4,
    }, sidebar)
    List(tabList, { Padding = UDim.new(0, 6), HorizontalAlignment = Enum.HorizontalAlignment.Center })
    Pad(tabList, 10, 0, 10, 0)
    self.TabList = tabList

    -- content
    local content = N("Frame", {
        Name = "Content", BackgroundTransparency = 1,
        Size = UDim2.new(1, -72, 1, -58 - 30),
        Position = UDim2.new(0, 72, 0, 58), ZIndex = 3,
    }, main)
    self.Content = content

    -- footer
    local footer = N("Frame", {
        Name = "Footer", BackgroundColor3 = t.BgSolid, BackgroundTransparency = 0.2,
        BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 30),
        Position = UDim2.new(0, 0, 1, -30), ZIndex = 3,
    }, main)
    N("Frame", {
        BackgroundColor3 = t.Border, BorderSizePixel = 0, BackgroundTransparency = 0.5,
        Size = UDim2.new(1, 0, 0, 1),
    }, footer)

    local statusDot = N("Frame", {
        BackgroundColor3 = t.TextMute, BorderSizePixel = 0,
        Size = UDim2.fromOffset(8, 8), Position = UDim2.new(0, 14, 0.5, -4), ZIndex = 4,
    }, footer)
    Corner(statusDot, 4)
    self.StatusDot = statusDot

    local statusLbl = N("TextLabel", {
        Text = cfg.Status or "Status: Idle", Font = F.Medium, TextSize = 12,
        TextColor3 = t.TextDim, BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(0.7, -26, 1, 0), Position = UDim2.new(0, 28, 0, 0), ZIndex = 4,
    }, footer)
    self.StatusLabel = statusLbl

    local clockLbl = N("TextLabel", {
        Text = "00:00:00", Font = F.Bold, TextSize = 11, TextColor3 = t.TextMute,
        BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Right,
        Size = UDim2.new(0.3, -14, 1, 0), Position = UDim2.new(0.7, 0, 0, 0), ZIndex = 4,
    }, footer)
    self.ClockLabel = clockLbl

    -- notifications
    local notifHolder = N("Frame", {
        Name = "Notifications", BackgroundTransparency = 1,
        Size = UDim2.new(0, 290, 1, -80), Position = UDim2.new(1, 10, 0, 70), ZIndex = 900,
    }, main)
    List(notifHolder, {
        Padding = UDim.new(0, 8),
        VerticalAlignment = Enum.VerticalAlignment.Top,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
    })
    self.Notif = Notif.new(notifHolder)

    -- dragging
    local dragging, dragStart, startPos, dragInput
    local function setPos(x, y)
        main.Position = UDim2.fromOffset(x, y)
        shadow.Position = UDim2.fromOffset(x - 20, y - 20)
    end
    self._setPos = setPos

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
           or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
           or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local d = input.Position - dragStart
            setPos(startPos.X.Offset + d.X, startPos.Y.Offset + d.Y)
        end
    end)

    -- resize handle
    local resizeHandle = N("TextButton", {
        Text = "", BackgroundTransparency = 1,
        Size = UDim2.fromOffset(18, 18), Position = UDim2.new(1, -18, 1, -18),
        AutoButtonColor = false, ZIndex = 10,
    }, main)
    local rz = N("Frame", {
        BackgroundColor3 = t.TextMute, BorderSizePixel = 0,
        Size = UDim2.fromOffset(8, 8), Position = UDim2.new(0.5, -4, 0.5, -4),
        Rotation = 45, BackgroundTransparency = 0.5,
    }, resizeHandle)
    Corner(rz, 1)

    local resizing, resizeStart, sizeStart
    resizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
           or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            resizeStart = input.Position
            sizeStart = main.AbsoluteSize
            Tw(resizeHandle, 0.15, { BackgroundTransparency = 0 })
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement
                        or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - resizeStart
            local w = math.max(560, sizeStart.X + d.X)
            local h = math.max(400, sizeStart.Y + d.Y)
            main.Size = UDim2.fromOffset(w, h)
            shadow.Size = UDim2.fromOffset(w + 40, h + 40)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.MouseButton1
                        or input.UserInputType == Enum.UserInputType.Touch) then
            resizing = false
            Tw(resizeHandle, 0.15, { BackgroundTransparency = 1 })
        end
    end)

    closeBtn.MouseButton1Click:Connect(function()
        for _, d in ipairs(main:GetDescendants()) do
            if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
                Tw(d, 0.2, { TextTransparency = 1 })
            elseif d:IsA("Frame") and d.BackgroundTransparency < 1 then
                Tw(d, 0.2, { BackgroundTransparency = 1 })
            elseif d:IsA("ImageLabel") then
                Tw(d, 0.2, { ImageTransparency = 1, BackgroundTransparency = 1 })
            end
        end
        Tw(main, 0.25, { BackgroundTransparency = 1 })
        Tw(shadow, 0.25, { ImageTransparency = 1 })
        task.wait(0.3)
        screen:Destroy()
    end)

    local minimized = false
    local fullSize, fullPos
    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            fullSize = main.Size
            fullPos  = main.Position
            Tw(main, 0.3, { Size = UDim2.new(0, 340, 0, 58) })
            Tw(shadow, 0.3, { Size = UDim2.new(0, 380, 0, 98) })
            content.Visible = false
            sidebar.Visible = false
            footer.Visible = false
            notifHolder.Visible = false
            minBtn.Text = "▢"
        else
            content.Visible = true
            sidebar.Visible = true
            footer.Visible = true
            notifHolder.Visible = true
            Tw(main, 0.35, { Size = fullSize or UDim2.fromOffset(width, height) }, Enum.EasingStyle.Back)
            Tw(shadow, 0.35, { Size = UDim2.new(0, (fullSize and fullSize.X.Offset or width) + 40,
                                                 0, (fullSize and fullSize.Y.Offset or height) + 40) }, Enum.EasingStyle.Back)
            minBtn.Text = "—"
        end
    end)

    -- open animation
    main.Size = UDim2.fromOffset(width * 0.92, height * 0.92)
    main.Position = UDim2.new(0.5, -(width * 0.92)/2, 0.5, -(height * 0.92)/2)
    task.wait()
    Tw(main, 0.45, { Size = UDim2.fromOffset(width, height), BackgroundTransparency = 0 }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    Tw(main, 0.45, { Position = UDim2.new(0.5, -width/2, 0.5, -height/2) }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    Tw(shadow, 0.45, { ImageTransparency = 0.5 }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    -- state
    self.Tabs = {}
    self.TabCount = 0
    self.CreatedAt = os.clock()

    function self:SetOpacity(v)
        local o = clamp(v, 0, 0.7)
        main.BackgroundTransparency = o
        sidebar.BackgroundTransparency = o + 0.4
        footer.BackgroundTransparency = o + 0.2
        header.BackgroundTransparency = o
    end

    -- session clock
    task.spawn(function()
        while self.Screen and self.Screen.Parent do
            local secs = math.floor(os.clock() - self.CreatedAt)
            self.ClockLabel.Text = string.format("%02d:%02d:%02d",
                math.floor(secs / 3600), math.floor((secs % 3600) / 60), secs % 60)
            task.wait(1)
        end
    end)

    -- theme listener
    onThemeChange(function(nt)
        main.BackgroundColor3 = nt.Bg
        mainStroke.Color = nt.Border
        mainGrad.Color = ColorSequence.new(nt.Bg, nt.BgSolid)
        header.BackgroundColor3 = nt.BgSolid
        hTop.BackgroundColor3 = nt.Accent
        hGrad.Color = ColorSequence.new(nt.Accent, nt.AccentAlt)
        sidebar.BackgroundColor3 = nt.BgSolid
        footer.BackgroundColor3 = nt.BgSolid
        indicator.BackgroundColor3 = nt.Accent
        indGrad.Color = ColorSequence.new(nt.Accent, nt.AccentAlt)
        logoBadge.BackgroundColor3 = nt.Surface2
        lbGrad.Color = ColorSequence.new(nt.Surface2, nt.Surface3)
        titleLbl.TextColor3 = nt.Text
        subLbl.TextColor3 = nt.TextMute
        statusLbl.TextColor3 = nt.TextDim
        clockLbl.TextColor3 = nt.TextMute
    end)

    return self
end

function Window:AddTab(cfg)
    cfg = cfg or {}
    self.TabCount = self.TabCount + 1
    local idx = self.TabCount
    local t = Theme()

    local btn = N("TextButton", {
        Name = "Tab_" .. idx, Text = cfg.Icon or "•",
        Font = F.Bold, TextSize = 22, TextColor3 = t.TextMute,
        BackgroundColor3 = t.Surface2, BackgroundTransparency = 1,
        Size = UDim2.fromOffset(48, 48), AutoButtonColor = false,
        LayoutOrder = idx, ZIndex = 4,
    }, self.TabList)
    Corner(btn, 12)

    local activeBar = N("Frame", {
        BackgroundColor3 = t.Accent, BorderSizePixel = 0,
        Size = UDim2.new(1, -12, 0, 3), Position = UDim2.new(0, 6, 1, -4),
        BackgroundTransparency = 1,
    }, btn)
    Corner(activeBar, 2)

    local page = N("ScrollingFrame", {
        Name = "Page_" .. idx, BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0), CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 4, ScrollBarImageColor3 = t.Border,
        ScrollBarImageTransparency = 0.4, Visible = (idx == 1),
        BorderSizePixel = 0, ZIndex = 3,
    }, self.Content)
    List(page, { Padding = UDim.new(0, 10) })
    Pad(page, 14, 14, 14, 14)

    local tab = { Button = btn, Page = page, Content = page, Index = idx,
                  Title = cfg.Title or ("Tab " .. idx), ActiveBar = activeBar }
    table.insert(self.Tabs, tab)

    btn.MouseEnter:Connect(function()
        if self.CurrentTab ~= tab then
            Tw(btn, 0.15, { BackgroundTransparency = 0.7, BackgroundColor3 = Theme().Surface3 })
            Tw(btn, 0.15, { TextColor3 = Theme().TextDim })
        end
    end)
    btn.MouseLeave:Connect(function()
        if self.CurrentTab ~= tab then
            Tw(btn, 0.15, { BackgroundTransparency = 1 })
            Tw(btn, 0.15, { TextColor3 = Theme().TextMute })
        end
    end)
    btn.MouseButton1Click:Connect(function() self:SelectTab(tab) end)

    if cfg.Tooltip then UILib.AttachTooltip(btn, cfg.Tooltip) end

    if idx == 1 then
        self.CurrentTab = tab
        self.Indicator.Visible = true
        task.defer(function()
            local targetY = btn.AbsolutePosition.Y - self.Sidebar.AbsolutePosition.Y - 10
            self.Indicator.Position = UDim2.new(0, 0, 0, targetY)
            Tw(activeBar, 0.25, { BackgroundTransparency = 0 })
        end)
    end

    return tab
end

function Window:SelectTab(tab)
    if self.CurrentTab == tab then return end
    self.CurrentTab = tab
    self.Indicator.Visible = true
    local targetY = tab.Button.AbsolutePosition.Y - self.Sidebar.AbsolutePosition.Y - 10
    Tw(self.Indicator, 0.28, { Position = UDim2.new(0, 0, 0, targetY) }, Enum.EasingStyle.Back)

    for _, t in ipairs(self.Tabs) do
        if t == tab then
            t.Page.Visible = true
            Tw(t.Button, 0.2, { TextColor3 = Theme().Text, BackgroundTransparency = 0.35, BackgroundColor3 = Theme().Surface2 })
            Tw(t.ActiveBar, 0.25, { BackgroundTransparency = 0 })
        else
            t.Page.Visible = false
            Tw(t.Button, 0.2, { TextColor3 = Theme().TextMute, BackgroundTransparency = 1 })
            Tw(t.ActiveBar, 0.25, { BackgroundTransparency = 1 })
        end
    end
end

function Window:SetTitle(text) self.TitleLabel.Text = text end
function Window:SetStatus(text, color)
    self.StatusLabel.Text = "Status: " .. text
    if color then
        Tw(self.StatusDot, 0.3, { BackgroundColor3 = color })
        Tw(self.StatusLabel, 0.3, { TextColor3 = color })
    end
end

-- ═══════════════════════════════════════════════════════════════════════════
--  UTILITY EXPORTS
-- ═══════════════════════════════════════════════════════════════════════════

Apex.Utility = {
    N = N, Tw = Tw, Corner = Corner, Stroke = Stroke, Grad = Grad,
    List = List, Pad = Pad, clamp = clamp, Fonts = F,
}

return Apex

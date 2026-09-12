-- ═══════════════════════════════════════════════════════════════════════════
--  APEX UI — external load
-- ═══════════════════════════════════════════════════════════════════════════

local APEX_URL = "https://raw.githubusercontent.com/YOUR_USER/YOUR_REPO/refs/heads/main/apex.lua"
local Apex = loadstring(game:HttpGet(APEX_URL))()
local UILib = Apex.UILib
local Themes = Apex.Themes

-- Session tracker (kept local — it uses your globals)
local Session = {
    StartLevel = 0, StartCoins = 0, StartGems = 0,
    Wins = 0, Losses = 0, Matches = 0,
}

local function formatNumber(n) return Apex.formatNumber(n) end

local function GetExpInfo()
    local expObj = LocalPlayer:FindFirstChild("Experience")
    local exp    = expObj and tonumber(expObj.Value) or nil
    local maxExp = expObj and tonumber(expObj:GetAttribute("Max")) or nil
    return exp, maxExp
end

local function CreateUI()
    local old = CoreGui:FindFirstChild("AutoProgressionUI")
    if old then old:Destroy() end

    local win = Apex.Window({
        ScreenGuiName = "AutoProgressionUI",
        Title = "Auto Progression",
        Subtitle = "Apex v3.0 · Singularity",
        Logo = "⚡",
        Width = 660, Height = 500,
    })

    -- shared references
    local modeButtons = {}
    local masterToggle

    -- ── helpers ─────────────────────────────────────────────────────────
    local function saveSettings()
        if writefile then
            local sd = { AutoProgressionEnabled = _G.AutoProgSettings.AutoProgressionEnabled }
            for _, m in ipairs(MODE_REGISTRY) do sd[m.key] = _G.AutoProgSettings[m.key] end
            sd.__theme = Apex.GetTheme().Name
            pcall(function() writefile(SETTINGS_FILE, HttpService:JSONEncode(sd)) end)
        end
    end

    local function updateMainTitle()
        local any = IsAnyForceOn()
        if AutoProgressionEnabled or any then
            win:SetTitle(any and "Auto Progression · FORCED" or "Auto Progression")
        else
            win:SetTitle("Auto Progression · OFF")
        end
    end

    -- ═════════════════════════════════════════════════════════════════════
    --  TAB 1 — MAIN
    -- ═════════════════════════════════════════════════════════════════════
    local mainTab = win:AddTab({ Title = "Main", Icon = "🏠", Tooltip = "Dashboard & master control" })
    UILib.Section(mainTab.Content, "Master Control")

    masterToggle = UILib.Toggle(mainTab.Content, {
        Title = "Auto Progression",
        Desc = "Automatic match running based on your level",
        Value = AutoProgressionEnabled,
        Tooltip = "When enabled, the script will run matches automatically.",
        Callback = function(v)
            AutoProgressionEnabled = v
            _G.AutoProgSettings.AutoProgressionEnabled = v
            if not v then
                ClearAllForceModes(nil)
                getgenv().HcEvoActive = false
                getgenv().HcUnevoActive = false
                for _, m in ipairs(MODE_REGISTRY) do
                    if modeButtons[m.key] and modeButtons[m.key].Set then modeButtons[m.key].Set(false) end
                end
                SetStatus("Stopped")
                win:SetStatus("Idle", Themes.Obsidian.TextMute)
            else
                SetStatus("Starting...")
                win:SetStatus("Running", Themes.Obsidian.Success)
                win.Notif:Push({ Title = "Auto Progression", Desc = "Enabled", Type = "success" })
            end
            updateMainTitle()
            saveSettings()
            if v then task.spawn(RunAutoProgression) end
        end,
    })

    UILib.Section(mainTab.Content, "Quick Actions")

    local actionsRow = Instance.new("Frame")
    actionsRow.BackgroundTransparency = 1
    actionsRow.Size = UDim2.new(1, 0, 0, 40)
    actionsRow.LayoutOrder = -100
    actionsRow.Parent = mainTab.Content

    local runBtn = UILib.Button(actionsRow, {
        Title = "🚀  Force Run Now",
        Variant = "primary",
        Tooltip = "Immediately triggers the auto-progression logic.",
        Callback = function()
            if not AutoProgressionEnabled then
                AutoProgressionEnabled = true
                _G.AutoProgSettings.AutoProgressionEnabled = true
                if masterToggle then masterToggle.Set(true) end
                updateMainTitle()
            end
            task.spawn(RunAutoProgression)
            win.Notif:Push({ Title = "Progression", Desc = "Running now", Type = "success" })
        end,
    })
    runBtn.Frame.Size = UDim2.new(0.5, -5, 1, 0)
    runBtn.Frame.Position = UDim2.new(0, 0, 0, 0)
    runBtn.Frame.Parent = actionsRow

    local lobbyBtn = UILib.Button(actionsRow, {
        Title = "↺  Return to Lobby",
        Tooltip = "Uses SmartTeleportToLobby to return to the main hub.",
        Callback = function()
            local tp = getgenv().SmartTeleportToLobby
            if type(tp) == "function" then
                pcall(tp)
                win.Notif:Push({ Title = "Teleport", Desc = "Returning to lobby", Type = "warn" })
            end
        end,
    })
    lobbyBtn.Frame.Size = UDim2.new(0.5, -5, 1, 0)
    lobbyBtn.Frame.Position = UDim2.new(0.5, 0, 0, 0)
    lobbyBtn.Frame.Parent = actionsRow

    UILib.Section(mainTab.Content, "Current Activity")

    local activityCard = Instance.new("Frame")
    activityCard.BackgroundColor3 = Themes.Obsidian.Surface
    activityCard.BackgroundTransparency = 0.3
    activityCard.BorderSizePixel = 0
    activityCard.Size = UDim2.new(1, 0, 0, 76)
    activityCard.LayoutOrder = -100
    activityCard.Parent = mainTab.Content
    local actCorner = Instance.new("UICorner"); actCorner.CornerRadius = UDim.new(0, 12); actCorner.Parent = activityCard

    local actIcon = Instance.new("Frame")
    actIcon.BackgroundColor3 = Themes.Obsidian.Accent
    actIcon.BorderSizePixel = 0
    actIcon.Size = UDim2.fromOffset(44, 44)
    actIcon.Position = UDim2.new(0, 16, 0.5, -22)
    actIcon.Parent = activityCard
    Instance.new("UICorner", actIcon).CornerRadius = UDim.new(0, 10)

    local actIconLbl = Instance.new("TextLabel")
    actIconLbl.Text = "⚡"; actIconLbl.Font = Enum.Font.GothamBlack; actIconLbl.TextSize = 22
    actIconLbl.TextColor3 = Color3.new(1,1,1); actIconLbl.BackgroundTransparency = 1
    actIconLbl.Size = UDim2.new(1, 0, 1, 0); actIconLbl.Parent = actIcon

    local actTitle = Instance.new("TextLabel")
    actTitle.Text = "Idle"; actTitle.Font = Enum.Font.GothamBold; actTitle.TextSize = 15
    actTitle.TextColor3 = Themes.Obsidian.Text; actTitle.BackgroundTransparency = 1
    actTitle.TextXAlignment = Enum.TextXAlignment.Left
    actTitle.Size = UDim2.new(1, -80, 0, 18); actTitle.Position = UDim2.new(0, 72, 0, 14)
    actTitle.Parent = activityCard

    local actDesc = Instance.new("TextLabel")
    actDesc.Text = "Waiting for instructions..."
    actDesc.Font = Enum.Font.Gotham; actDesc.TextSize = 11
    actDesc.TextColor3 = Themes.Obsidian.TextMute; actDesc.BackgroundTransparency = 1
    actDesc.TextXAlignment = Enum.TextXAlignment.Left
    actDesc.TextTruncate = Enum.TextTruncate.AtEnd
    actDesc.Size = UDim2.new(1, -80, 0, 16); actDesc.Position = UDim2.new(0, 72, 0, 36)
    actDesc.Parent = activityCard

    local pulseDot = Instance.new("Frame")
    pulseDot.BackgroundColor3 = Themes.Obsidian.TextMute
    pulseDot.BorderSizePixel = 0
    pulseDot.Size = UDim2.fromOffset(8, 8)
    pulseDot.Position = UDim2.new(1, -22, 0.5, -4)
    pulseDot.Parent = activityCard
    Instance.new("UICorner", pulseDot).CornerRadius = UDim.new(0, 4)

    task.spawn(function()
        local t = 0
        while activityCard.Parent do
            if win.Screen and win.Screen.Parent then
                t = t + 0.1
                pulseDot.BackgroundTransparency = 0.7 + math.sin(t * 3) * 0.3
            end
            task.wait(0.1)
        end
    end)

    -- ═════════════════════════════════════════════════════════════════════
    --  TAB 2 — MODES
    -- ═════════════════════════════════════════════════════════════════════
    local modesTab = win:AddTab({ Title = "Modes", Icon = "⚔️", Tooltip = "Force a specific difficulty" })
    UILib.Section(modesTab.Content, "Forced Difficulty")

    local modeDesc = Instance.new("TextLabel")
    modeDesc.Text = "Forcing a mode overrides level-based selection. Only one can be active at once."
    modeDesc.Font = Enum.Font.Gotham; modeDesc.TextSize = 11
    modeDesc.TextColor3 = Themes.Obsidian.TextMute; modeDesc.BackgroundTransparency = 1
    modeDesc.TextXAlignment = Enum.TextXAlignment.Left
    modeDesc.TextWrapped = true
    modeDesc.Size = UDim2.new(1, 0, 0, 30); modeDesc.LayoutOrder = -1000
    modeDesc.Parent = modesTab.Content

    for _, m in ipairs(MODE_REGISTRY) do
        modeButtons[m.key] = UILib.Toggle(modesTab.Content, {
            Title = m.label,
            Desc = "Force " .. m.label .. " on next match",
            Value = _G.AutoProgSettings[m.key] or false,
            Callback = function(v)
                getgenv().HcEvoActive = false
                getgenv().HcUnevoActive = false
                ClearAllForceModes(m.key)
                _G.AutoProgSettings[m.key] = v
                for _, other in ipairs(MODE_REGISTRY) do
                    if other.key ~= m.key and modeButtons[other.key] then
                        modeButtons[other.key].Set(false)
                    end
                end
                if v then
                    if not AutoProgressionEnabled then
                        AutoProgressionEnabled = true
                        _G.AutoProgSettings.AutoProgressionEnabled = true
                        if masterToggle then masterToggle.Set(true) end
                        updateMainTitle()
                    end
                    saveSettings()
                    task.spawn(RunAutoProgression)
                    win.Notif:Push({ Title = "Force Mode", Desc = m.label .. " enabled", Type = "warn" })
                else
                    saveSettings()
                end
            end,
        })
    end

    -- ═════════════════════════════════════════════════════════════════════
    --  TAB 3 — STATS
    -- ═════════════════════════════════════════════════════════════════════
    local statsTab = win:AddTab({ Title = "Stats", Icon = "📊", Tooltip = "Account & session statistics" })
    UILib.Section(statsTab.Content, "Account")

    local r1 = Instance.new("Frame")
    r1.BackgroundTransparency = 1; r1.Size = UDim2.new(1, 0, 0, 68); r1.LayoutOrder = -100
    r1.Parent = statsTab.Content
    local l1 = Instance.new("UIListLayout", r1)
    l1.FillDirection = Enum.FillDirection.Horizontal; l1.Padding = UDim.new(0, 10)

    local cardLevel = UILib.StatCard(r1, { Icon="⭐", Label="Level", Value="0", Color=Themes.Obsidian.Accent, Tooltip="Your current account level" })
    local cardCoins = UILib.StatCard(r1, { Icon="🪙", Label="Coins", Value="0", Color=Themes.Obsidian.Coin, Tooltip="Total coins" })

    local r2 = Instance.new("Frame")
    r2.BackgroundTransparency = 1; r2.Size = UDim2.new(1, 0, 0, 68); r2.LayoutOrder = -99
    r2.Parent = statsTab.Content
    local l2 = Instance.new("UIListLayout", r2)
    l2.FillDirection = Enum.FillDirection.Horizontal; l2.Padding = UDim.new(0, 10)

    local cardGems = UILib.StatCard(r2, { Icon="💎", Label="Gems", Value="0", Color=Themes.Obsidian.Gem, Tooltip="Total gems" })
    local cardTix  = UILib.StatCard(r2, { Icon="🎫", Label="Timescale", Value="0", Color=Themes.Obsidian.AccentAlt, Tooltip="Timescale tickets" })

    UILib.Section(statsTab.Content, "Experience")
    local progress = UILib.Progress(statsTab.Content, { Label="Progress to next level", Color=Themes.Obsidian.Xp, Order=-90 })

    UILib.Section(statsTab.Content, "This Session")
    local r3 = Instance.new("Frame")
    r3.BackgroundTransparency = 1; r3.Size = UDim2.new(1, 0, 0, 68); r3.LayoutOrder = -80
    r3.Parent = statsTab.Content
    local l3 = Instance.new("UIListLayout", r3)
    l3.FillDirection = Enum.FillDirection.Horizontal; l3.Padding = UDim.new(0, 10)

    local cardSC = UILib.StatCard(r3, { Icon="📈", Label="Coins Earned", Value="+0", Color=Themes.Obsidian.Success, Tooltip="Coins gained this session" })
    local cardSG = UILib.StatCard(r3, { Icon="📈", Label="Gems Earned", Value="+0", Color=Themes.Obsidian.Success, Tooltip="Gems gained this session" })

    local r4 = Instance.new("Frame")
    r4.BackgroundTransparency = 1; r4.Size = UDim2.new(1, 0, 0, 68); r4.LayoutOrder = -79
    r4.Parent = statsTab.Content
    local l4 = Instance.new("UIListLayout", r4)
    l4.FillDirection = Enum.FillDirection.Horizontal; l4.Padding = UDim.new(0, 10)

    local cardWins   = UILib.StatCard(r4, { Icon="🏆", Label="Wins", Value="0", Color=Themes.Obsidian.Success })
    local cardLosses = UILib.StatCard(r4, { Icon="💀", Label="Losses", Value="0", Color=Themes.Obsidian.Danger })

    UILib.Section(statsTab.Content, "Rate Tracking (last 5 min)")
    local coinGraph = UILib.Graph(statsTab.Content, {
        Label = "Coins / min", Color = Themes.Obsidian.Coin, Order = -50,
        Format = function(v) return formatNumber(v) .. " c/m" end,
    })
    local gemGraph = UILib.Graph(statsTab.Content, {
        Label = "Gems / min", Color = Themes.Obsidian.Gem, Order = -49,
        Format = function(v) return formatNumber(v) .. " g/m" end,
    })

    task.spawn(function()
        Session.StartLevel = GetStat("Level")
        Session.StartCoins = GetStat("Coins")
        Session.StartGems  = GetStat("Gems")
        while statsTab.Page.Parent do
            local lvl   = GetStat("Level")
            local coins = GetStat("Coins")
            local gems  = GetStat("Gems")
            local tix   = GetStat("TimescaleTickets"); if tix == 0 then tix = GetStat("Tickets") end
            cardLevel:SetValue(lvl)
            cardCoins:SetValue(formatNumber(coins))
            cardGems:SetValue(formatNumber(gems))
            cardTix:SetValue(tix)
            cardSC:SetValue("+" .. formatNumber(math.max(0, coins - Session.StartCoins)))
            cardSG:SetValue("+" .. formatNumber(math.max(0, gems - Session.StartGems)))
            cardWins:SetValue(Session.Wins)
            cardLosses:SetValue(Session.Losses)
            local exp, mx = GetExpInfo()
            if exp and mx and mx > 0 then progress.SetProgress(exp, mx)
            else progress.SetProgress(lvl, math.max(lvl + 1, 175)) end
            task.wait(1)
        end
    end)

    task.spawn(function()
        local lastC, lastG = GetStat("Coins"), GetStat("Gems")
        while statsTab.Page.Parent do
            task.wait(6)
            local c, g = GetStat("Coins"), GetStat("Gems")
            coinGraph.Push(math.max(0, c - lastC) * 10)
            gemGraph.Push(math.max(0, g - lastG) * 10)
            lastC, lastG = c, g
        end
    end)

    -- ═════════════════════════════════════════════════════════════════════
    --  TAB 4 — ACTIVITY
    -- ═════════════════════════════════════════════════════════════════════
    local actTab = win:AddTab({ Title = "Activity", Icon = "📜", Tooltip = "Live activity feed" })
    local logView, logScroll = UILib.LogView(actTab.Content)
    logScroll.Size = UDim2.new(1, 0, 1, -90)
    logScroll.LayoutOrder = -800

    local filterRow = Instance.new("Frame")
    filterRow.BackgroundTransparency = 1
    filterRow.Size = UDim2.new(1, 0, 0, 30)
    filterRow.LayoutOrder = -900
    filterRow.Parent = actTab.Content
    local frl = Instance.new("UIListLayout", filterRow)
    frl.FillDirection = Enum.FillDirection.Horizontal; frl.Padding = UDim.new(0, 6)

    local function mkFilter(title, key, color)
        local b = Instance.new("TextButton")
        b.Text = title; b.Font = Enum.Font.GothamBold; b.TextSize = 11
        b.TextColor3 = color or Themes.Obsidian.TextDim
        b.BackgroundColor3 = Themes.Obsidian.Surface2; b.BackgroundTransparency = 0.4
        b.BorderSizePixel = 0; b.AutoButtonColor = false
        b.Size = UDim2.fromOffset(60, 26)
        b.Parent = filterRow
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        b.MouseButton1Click:Connect(function()
            logView.SetFilter(key)
            for _, other in ipairs(filterRow:GetChildren()) do
                if other:IsA("TextButton") then other.BackgroundTransparency = 0.4 end
            end
            b.BackgroundTransparency = 0
        end)
        return b
    end
    mkFilter("All", "all")
    mkFilter("Info", "info")
    mkFilter("Win", "success", Themes.Obsidian.Success)
    mkFilter("Err", "error", Themes.Obsidian.Danger)
    mkFilter("Warn", "warn", Themes.Obsidian.Warn)

    UILib.Textbox(actTab.Content, {
        Title = "Search", Placeholder = "Type to filter...", Order = -850,
        Callback = function(v) logView.SetSearch(v) end,
    })

    UILib.Button(actTab.Content, {
        Title = "📄  Export Log to Clipboard", Order = -840,
        Callback = function()
            if setclipboard then
                setclipboard(logView.Export())
                win.Notif:Push({ Title="Export", Desc="Log copied", Type="success" })
            end
        end,
    })

    -- ═════════════════════════════════════════════════════════════════════
    --  TAB 5 — SETTINGS
    -- ═════════════════════════════════════════════════════════════════════
    local setTab = win:AddTab({ Title = "Settings", Icon = "⚙️", Tooltip = "Configuration" })

    UILib.Section(setTab.Content, "Appearance")

    local themeNames = {}
    for k in pairs(Themes) do table.insert(themeNames, k) end
    table.sort(themeNames)

    UILib.Dropdown(setTab.Content, {
        Title = "Theme", Options = themeNames, Value = "Obsidian",
        Callback = function(choice)
            Apex.ApplyTheme(choice)
            saveSettings()
            win.Notif:Push({ Title = "Theme", Desc = choice .. " applied", Type = "success" })
        end,
    })

    UILib.Slider(setTab.Content, {
        Title = "Window Opacity", Min = 0, Max = 70, Value = 0,
        Format = function(v) return v .. "%" end,
        Callback = function(v) win:SetOpacity(v / 100) end,
    })

    UILib.Section(setTab.Content, "Window Controls")
    UILib.Button(setTab.Content, {
        Title = "🎯  Reset Window Position",
        Callback = function()
            local w = win.Frame.AbsoluteSize.X
            local h = win.Frame.AbsoluteSize.Y
            win._setPos((1920 - w) / 2, (1080 - h) / 2)
        end,
    })
    UILib.Button(setTab.Content, {
        Title = "🔔  Test Notification",
        Callback = function()
            win.Notif:Push({ Title = "Test", Desc = "Hello from Apex!", Type = "success" })
        end,
    })

    UILib.Section(setTab.Content, "Configuration")
    UILib.Button(setTab.Content, {
        Title = "💾  Save Settings",
        Callback = function() saveSettings(); win.Notif:Push({Title="Config",Desc="Saved",Type="success"}) end,
    })
    UILib.Button(setTab.Content, {
        Title = "🔄  Reload Settings",
        Callback = function()
            if isfile and isfile(SETTINGS_FILE) then
                local ok, data = pcall(function() return HttpService:JSONDecode(readfile(SETTINGS_FILE)) end)
                if ok and type(data) == "table" then
                    for k, v in pairs(data) do _G.AutoProgSettings[k] = v end
                    for _, m in ipairs(MODE_REGISTRY) do
                        if modeButtons[m.key] and modeButtons[m.key].Set then
                            modeButtons[m.key].Set(_G.AutoProgSettings[m.key] == true)
                        end
                    end
                    win.Notif:Push({Title="Config",Desc="Loaded",Type="success"})
                end
            end
        end,
    })

    -- ═════════════════════════════════════════════════════════════════════
    --  HOTKEY — RightShift toggles UI
    -- ═════════════════════════════════════════════════════════════════════
    local uiVisible = true
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            uiVisible = not uiVisible
            win.Screen.Enabled = uiVisible
            if uiVisible then
                win.Notif:Push({ Title = "UI", Desc = "Visible", Type = "info", Duration = 1.5 })
            end
        end
    end)

    -- ═════════════════════════════════════════════════════════════════════
    --  HOOK SetStatus → activity log
    -- ═════════════════════════════════════════════════════════════════════
    local lastStatus = ""
    task.spawn(function()
        while win.Screen and win.Screen.Parent do
            local s = getgenv().AutoProgressionUI
            if s and s.status and s.status.Text then
                local text = s.status.Text:gsub("^Status:%s*", "")
                if text ~= lastStatus and text ~= "" and text ~= "Stopped" then
                    lastStatus = text
                    local lower = text:lower()
                    local kind = "info"
                    if lower:find("error") or lower:find("fail") or lower:find("not enough") then kind = "error"
                    elseif lower:find("bought") or lower:find("complete") or lower:find("success") or lower:find("win") then kind = "success"
                    elseif lower:find("warn") or lower:find("skip") or lower:find("fallback") then kind = "warn" end
                    logView.Append(text, Apex.GetTheme().Text, kind)
                end
            end
            task.wait(0.4)
        end
    end)

    -- ═════════════════════════════════════════════════════════════════════
    --  RETURN API
    -- ═════════════════════════════════════════════════════════════════════
    local out = {
        _window = win,
        _ui = UILib,
        _log = logView,
        title  = win.TitleLabel,
        status = win.StatusLabel,
        toggle = masterToggle.Frame,
        levelDisplay = cardLevel.Frame,
        coinsDisplay = cardCoins.Frame,
        gemsDisplay  = cardGems.Frame,
        Notify = function(cfg) win.Notif:Push(cfg) end,
    }
    for _, m in ipairs(MODE_REGISTRY) do
        out[m.key] = modeButtons[m.key] and modeButtons[m.key].Frame or nil
    end

    -- replace global SetStatus
    getgenv().SetStatus = function(text)
        win:SetStatus(text, Apex.GetTheme().Success)
        if _G.AutoProgressionUI and _G.AutoProgressionUI.status then
            _G.AutoProgressionUI.status.Text = "Status: " .. text
        end
    end

    if AutoProgressionEnabled or IsAnyForceOn() then
        win:SetStatus("Running", Apex.GetTheme().Success)
    else
        win:SetStatus("Idle", Apex.GetTheme().TextMute)
    end

    task.delay(0.6, function()
        win.Notif:Push({
            Title = "Apex UI v" .. Apex.Version,
            Desc = "Loaded externally. RightShift to hide.",
            Type = "info", Duration = 5,
        })
    end)

    return out
end

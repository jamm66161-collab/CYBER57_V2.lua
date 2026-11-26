
-- CYBER 57 V2 | FULL REBUILT
-- LocalScript داخل StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local RED = Color3.fromRGB(220, 25, 45)
local PURPLE = Color3.fromRGB(170, 0, 255)
local DARK = Color3.fromRGB(13, 13, 18)
local PANEL = Color3.fromRGB(24, 24, 32)
local WHITE = Color3.fromRGB(245, 245, 245)

local old = PlayerGui:FindFirstChild("CYBER57_V2")
if old then old:Destroy() end

local function create(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function corner(obj, radius)
    create("UICorner", {
        CornerRadius = UDim.new(0, radius or 8)
    }, obj)
end

local function stroke(obj, color, thickness)
    create("UIStroke", {
        Color = color or RED,
        Thickness = thickness or 1
    }, obj)
end

local gui = create("ScreenGui", {
    Name = "CYBER57_V2",
    ResetOnSpawn = false
}, PlayerGui)

-- پنل اصلی
local main = create("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(530, 365),
    Position = UDim2.new(0.5, -265, 0.5, -182),
    BackgroundColor3 = DARK,
    BorderSizePixel = 0
}, gui)
corner(main, 12)
stroke(main, RED, 2)

local header = create("Frame", {
    Size = UDim2.new(1, 0, 0, 45),
    BackgroundColor3 = Color3.fromRGB(35, 17, 23),
    BorderSizePixel = 0
}, main)
corner(header, 10)

create("TextLabel", {
    Size = UDim2.new(1, -60, 1, 0),
    Position = UDim2.fromOffset(14, 0),
    BackgroundTransparency = 1,
    Text = "CYBER 57  |  COMMAND CENTER V2",
    TextColor3 = RED,
    TextSize = 17,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

local close = create("TextButton", {
    Size = UDim2.fromOffset(34, 30),
    Position = UDim2.new(1, -42, 0, 7),
    BackgroundColor3 = RED,
    Text = "X",
    TextColor3 = WHITE,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    BorderSizePixel = 0
}, header)
corner(close, 7)

-- جابه‌جایی پنل از بالا و کناره
local dragArea = create("Frame", {
    Size = UDim2.new(0, 12, 1, -45),
    Position = UDim2.new(1, -12, 0, 45),
    BackgroundColor3 = Color3.fromRGB(65, 25, 40),
    BorderSizePixel = 0,
    Active = true
}, main)
corner(dragArea, 5)

local dragging = false
local dragStart
local startPosition

local function beginDrag(input)
    dragging = true
    dragStart = input.Position
    startPosition = main.Position
end

local function updateDrag(input)
    if not dragging then return end

    local delta = input.Position - dragStart

    main.Position = UDim2.new(
        startPosition.X.Scale,
        startPosition.X.Offset + delta.X,
        startPosition.Y.Scale,
        startPosition.Y.Offset + delta.Y
    )
end

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        beginDrag(input)
    end
end)

dragArea.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        beginDrag(input)
    end
end)

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        updateDrag(input)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- منوی کناری
local sidebar = create("Frame", {
    Size = UDim2.new(0, 125, 1, -55),
    Position = UDim2.fromOffset(8, 50),
    BackgroundColor3 = PANEL,
    BorderSizePixel = 0
}, main)
corner(sidebar, 9)

create("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder
}, sidebar)

local pagesHolder = create("Frame", {
    Size = UDim2.new(1, -150, 1, -60),
    Position = UDim2.fromOffset(140, 52),
    BackgroundTransparency = 1
}, main)

local names = {
    "خانه",
    "حرکت",
    "بازیکنان",
    "گزارش‌ها",
    "تنظیمات"
}

local pages = {}
local tabs = {}

for _, name in ipairs(names) do
    local tab = create("TextButton", {
        Size = UDim2.new(1, -12, 0, 39),
        Position = UDim2.fromOffset(6, 0),
        BackgroundColor3 = Color3.fromRGB(38, 28, 35),
        Text = name,
        TextColor3 = WHITE,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0
    }, sidebar)

    corner(tab, 7)
    tabs[name] = tab

    local page = create("ScrollingFrame", {
        Name = name,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = PANEL,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = RED,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(),
        Visible = false
    }, pagesHolder)

    corner(page, 9)

    create("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10)
    }, page)

    create("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, page)

    pages[name] = page
end

local function showPage(name)
    for n, page in pairs(pages) do
        page.Visible = n == name

        tabs[n].BackgroundColor3 =
            n == name and RED or Color3.fromRGB(38, 28, 35)
    end
end

for name, tab in pairs(tabs) do
    tab.MouseButton1Click:Connect(function()
        showPage(name)
    end)
end

showPage("خانه")

-- ابزارهای متن و دکمه
local function label(parent, text)
    return create("TextLabel", {
        Size = UDim2.new(1, -4, 0, 28),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = WHITE,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
    }, parent)
end

local function button(parent, text, callback)
    local b = create("TextButton", {
        Size = UDim2.new(1, -4, 0, 36),
        BackgroundColor3 = Color3.fromRGB(43, 29, 37),
        Text = text,
        TextColor3 = WHITE,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0
    }, parent)

    corner(b, 7)
    stroke(b, RED, 1)

    b.MouseButton1Click:Connect(callback)

    return b
end

-- خانه
local home = pages["خانه"]

label(home, "به پنل CYBER 57 خوش آمدید")
label(home, "نسخه: V2")

local countLabel = label(
    home,
    "تعداد بازیکنان: " .. #Players:GetPlayers()
)

local statusLabel = label(home, "وضعیت: آماده")

label(home, "پنل مدیریت و آزمایش تجربه خودت")

local function setStatus(text)
    statusLabel.Text = "وضعیت: " .. text
end

-- گزارش ورود و خروج
local reports = pages["گزارش‌ها"]

label(reports, "گزارش ورود و خروج بازیکنان")

local reportList = create("Frame", {
    Size = UDim2.new(1, -4, 0, 10),
    AutomaticSize = Enum.AutomaticSize.Y,
    BackgroundTransparency = 1
}, reports)

create("UIListLayout", {
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder
}, reportList)

local reportCount = 0

local function addReport(message, color)
    reportCount += 1

    local row = create("TextLabel", {
        Size = UDim2.new(1, -4, 0, 30),
        BackgroundColor3 = Color3.fromRGB(35, 29, 38),
        Text = os.date("%H:%M:%S") .. "  |  " .. message,
        TextColor3 = color or WHITE,
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        BorderSizePixel = 0,
        LayoutOrder = -reportCount
    }, reportList)

    corner(row, 6)

    while #reportList:GetChildren() > 61 do
        for _, child in ipairs(reportList:GetChildren()) do
            if child:IsA("TextLabel") then
                child:Destroy()
                break
            end
        end
    end
end

Players.PlayerAdded:Connect(function(target)
    countLabel.Text =
        "تعداد بازیکنان: " .. #Players:GetPlayers()

    addReport(
        target.Name .. " وارد سرور شد",
        Color3.fromRGB(80, 230, 120)
    )
end)

Players.PlayerRemoving:Connect(function(target)
    countLabel.Text =
        "تعداد بازیکنان: " .. (#Players:GetPlayers() - 1)

    addReport(
        target.Name .. " سرور را ترک کرد",
        Color3.fromRGB(255, 100, 100)
    )
end)

-- حرکت
local movement = pages["حرکت"]

label(movement, "تنظیمات حرکت")

local walkSpeed = 16
local jumpPower = 50
local flySpeed = 45
local spinSpeed = 10

local function getCharacter()
    return Player.Character
end

local function getHumanoid()
    local char = getCharacter()
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function applyMovement()
    local hum = getHumanoid()

    if hum then
        hum.WalkSpeed = walkSpeed
        hum.UseJumpPower = true
        hum.JumpPower = jumpPower
    end
end

button(movement, "افزایش سرعت حرکت +5", function()
    walkSpeed += 5
    applyMovement()
    setStatus("سرعت حرکت: " .. walkSpeed)
end)

button(movement, "کاهش سرعت حرکت -5", function()
    walkSpeed = math.max(0, walkSpeed - 5)
    applyMovement()
    setStatus("سرعت حرکت: " .. walkSpeed)
end)

button(movement, "افزایش پرش +10", function()
    jumpPower += 10
    applyMovement()
    setStatus("قدرت پرش: " .. jumpPower)
end)

button(movement, "کاهش پرش -10", function()
    jumpPower = math.max(0, jumpPower - 10)
    applyMovement()
    setStatus("قدرت پرش: " .. jumpPower)
end)

-- =========================================
-- CYBER57 FLY | MOBILE + PC
-- =========================================

local flying = false
local flyConnection

local flyVelocity
local flyGyro

local flyRoot
local flyHumanoid

local oldAutoRotate
local oldPlatformStand

local flyUp = false
local flyDown = false

-- رابط دکمه‌های موبایل
local flyControls = create("Frame", {
    Name = "CYBER57_FlyControls",
    Size = UDim2.fromOffset(76, 158),
    Position = UDim2.new(1, -92, 0.5, -79),
    BackgroundTransparency = 1,
    Visible = false
}, gui)

local function makeFlyButton(name, text, y, color)
    local b = create("TextButton", {
        Name = name,
        Size = UDim2.fromOffset(68, 68),
        Position = UDim2.fromOffset(4, y),
        BackgroundColor3 = color,
        Text = text,
        TextColor3 = WHITE,
        TextSize = 25,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        AutoButtonColor = true
    }, flyControls)

    corner(b, 14)
    stroke(b, WHITE, 1)

    return b
end

local upButton = makeFlyButton(
    "FlyUpButton",
    "▲",
    0,
    Color3.fromRGB(35, 145, 75)
)

local downButton = makeFlyButton(
    "FlyDownButton",
    "▼",
    82,
    Color3.fromRGB(35, 90, 160)
)

local function connectHold(btn, callback)
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch
            or input.UserInputType == Enum.UserInputType.MouseButton1 then
            callback(true)
        end
    end)

    btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch
            or input.UserInputType == Enum.UserInputType.MouseButton1 then
            callback(false)
        end
    end)
end

connectHold(upButton, function(value)
    flyUp = value
end)

connectHold(downButton, function(value)
    flyDown = value
end)

local function cleanupFly()
    flying = false
    flyUp = false
    flyDown = false

    flyControls.Visible = false

    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end

    if flyVelocity then
        flyVelocity:Destroy()
        flyVelocity = nil
    end

    if flyGyro then
        flyGyro:Destroy()
        flyGyro = nil
    end

    if flyHumanoid and flyHumanoid.Parent then
        flyHumanoid.AutoRotate = oldAutoRotate
        flyHumanoid.PlatformStand = oldPlatformStand
        flyHumanoid:ChangeState(
            Enum.HumanoidStateType.GettingUp
        )
    end

    flyRoot = nil
    flyHumanoid = nil
end

local function stopFly()
    cleanupFly()
    setStatus("پرواز خاموش")
end

local function startFly()
    if flying then return end

    cleanupFly()

    local character = getCharacter()
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local root = character and character:FindFirstChild("HumanoidRootPart")

    if not humanoid or not root or humanoid.Health <= 0 then
        setStatus("کاراکتر آماده نیست")
        return
    end

    flyRoot = root
    flyHumanoid = humanoid

    oldAutoRotate = humanoid.AutoRotate
    oldPlatformStand = humanoid.PlatformStand

    humanoid.AutoRotate = false
    humanoid.PlatformStand = false

    -- روش قدیمی Fly
    flyVelocity = Instance.new("BodyVelocity")
    flyVelocity.Name = "CYBER57_FlyVelocity"
    flyVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
    flyVelocity.P = 1e5
    flyVelocity.Velocity = Vector3.zero
    flyVelocity.Parent = root

    flyGyro = Instance.new("BodyGyro")
    flyGyro.Name = "CYBER57_FlyGyro"
    flyGyro.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
    flyGyro.P = 90000
    flyGyro.CFrame = root.CFrame
    flyGyro.Parent = root

    flying = true
    flyControls.Visible = true

    flyConnection = RunService.RenderStepped:Connect(function()
        if not flying
            or not root.Parent
            or humanoid.Health <= 0 then
            stopFly()
            return
        end

        local camera = workspace.CurrentCamera
        if not camera then return end

        -- دریافت جهت جوی‌استیک موبایل
        local moveDirection = humanoid.MoveDirection

        -- حرکت افقی
        local horizontal = Vector3.new(
            moveDirection.X,
            0,
            moveDirection.Z
        )

        if horizontal.Magnitude > 1 then
            horizontal = horizontal.Unit
        end

        -- حرکت عمودی با دکمه‌های موبایل
        local vertical = 0

        if flyUp and not flyDown then
            vertical = flySpeed
        elseif flyDown and not flyUp then
            vertical = -flySpeed
        end

        -- سرعت عمودی صفر = حفظ ارتفاع
        flyVelocity.Velocity =
            (horizontal * flySpeed)
            + Vector3.new(0, vertical, 0)

        -- چرخش کاراکتر با دوربین
        local look = camera.CFrame.LookVector
        local flatLook = Vector3.new(look.X, 0, look.Z)

        if flatLook.Magnitude > 0.001 then
            flyGyro.CFrame = CFrame.lookAt(
                root.Position,
                root.Position + flatLook.Unit
            )
        end
    end)

    setStatus("پرواز روشن | جوی‌استیک برای حرکت")
end

button(movement, "روشن / خاموش پرواز", function()
    if flying then
        stopFly()
    else
        startFly()
    end
end)

button(movement, "افزایش سرعت پرواز +5", function()
    flySpeed += 5
    setStatus("سرعت پرواز: " .. flySpeed)
end)

button(movement, "کاهش سرعت پرواز -5", function()
    flySpeed = math.max(5, flySpeed - 5)
    setStatus("سرعت پرواز: " .. flySpeed)
end)

-- چرخش
local spinEnabled = false
local spinConnection

button(movement, "چرخش روشن / خاموش", function()
    spinEnabled = not spinEnabled

    if spinConnection then
        spinConnection:Disconnect()
        spinConnection = nil
    end

    if spinEnabled then
        spinConnection = RunService.Heartbeat:Connect(function(dt)
            local char = getCharacter()
            local root = char and char:FindFirstChild("HumanoidRootPart")

            if root then
                root.CFrame *= CFrame.Angles(
                    0,
                    math.rad(spinSpeed) * dt * 60,
                    0
                )
            end
        end)
    end

    setStatus(
        spinEnabled and "چرخش روشن" or "چرخش خاموش"
    )
end)

button(movement, "افزایش سرعت چرخش +2", function()
    spinSpeed += 2
    setStatus("سرعت چرخش: " .. spinSpeed)
end)

button(movement, "کاهش سرعت چرخش -2", function()
    spinSpeed = math.max(0, spinSpeed - 2)
    setStatus("سرعت چرخش: " .. spinSpeed)
end)

-- بازیکنان
local playersPage = pages["بازیکنان"]

label(playersPage, "فهرست بازیکنان")

local playerList = create("Frame", {
    Size = UDim2.new(1, -4, 0, 10),
    AutomaticSize = Enum.AutomaticSize.Y,
    BackgroundTransparency = 1
}, playersPage)

create("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder
}, playerList)

local function refreshPlayers()
    for _, child in ipairs(playerList:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    for _, target in ipairs(Players:GetPlayers()) do
        local row = create("Frame", {
            Size = UDim2.new(1, -4, 0, 68),
            BackgroundColor3 = Color3.fromRGB(35, 28, 39),
            BorderSizePixel = 0
        }, playerList)

        corner(row, 7)

        create("TextLabel", {
            Size = UDim2.new(1, -95, 0, 25),
            Position = UDim2.fromOffset(8, 5),
            BackgroundTransparency = 1,
            Text = target.DisplayName .. "  (@" .. target.Name .. ")",
            TextColor3 = PURPLE,
            TextSize = 12,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left
        }, row)

        create("TextLabel", {
            Size = UDim2.new(1, -95, 0, 20),
            Position = UDim2.fromOffset(8, 32),
            BackgroundTransparency = 1,
            Text = "سن حساب: " .. target.AccountAge .. " روز",
            TextColor3 = WHITE,
            TextSize = 11,
            Font = Enum.Font.Gotham
        }, row)

        local tp = create("TextButton", {
            Size = UDim2.fromOffset(75, 36),
            Position = UDim2.new(1, -82, 0, 16),
            BackgroundColor3 = RED,
            Text = "تلپورت",
            TextColor3 = WHITE,
            TextSize = 11,
            Font = Enum.Font.GothamBold,
            BorderSizePixel = 0
        }, row)

        corner(tp, 6)

        tp.MouseButton1Click:Connect(function()
            local myChar = getCharacter()
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")

            local targetChar = target.Character
            local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")

            if myRoot and targetRoot then
                myRoot.CFrame = targetRoot.CFrame
                setStatus("انتقال به موقعیت " .. target.Name)
            else
                setStatus("کاراکتر بازیکن در دسترس نیست")
            end
        end)
    end
end

button(playersPage, "به‌روزرسانی فهرست", refreshPlayers)
refreshPlayers()

-- هایلایت بنفش
local espEnabled = false
local highlights = {}
local characterConnections = {}

local function removeHighlight(target)
    if highlights[target] then
        highlights[target]:Destroy()
        highlights[target] = nil
    end
end

local function addHighlight(target)
    if target == Player or not espEnabled then return end

    removeHighlight(target)

    local char = target.Character
    if not char then return end

    local h = Instance.new("Highlight")
    h.Name = "CYBER57_PlayerHighlight"
    h.Adornee = char
    h.FillColor = PURPLE
    h.OutlineColor = PURPLE
    h.FillTransparency = 0.35
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = gui

    highlights[target] = h
end

local function watchPlayer(target)
    if target == Player or characterConnections[target] then
        return
    end

    characterConnections[target] = target.CharacterAdded:Connect(function()
        task.wait(0.4)
        addHighlight(target)
    end)

    if espEnabled then
        addHighlight(target)
    end
end

for _, target in ipairs(Players:GetPlayers()) do
    watchPlayer(target)
end

Players.PlayerAdded:Connect(watchPlayer)

Players.PlayerRemoving:Connect(function(target)
    removeHighlight(target)

    if characterConnections[target] then
        characterConnections[target]:Disconnect()
        characterConnections[target] = nil
    end
end)

local function setESP(enabled)
    espEnabled = enabled

    for _, target in ipairs(Players:GetPlayers()) do
        if enabled then
            addHighlight(target)
        else
            removeHighlight(target)
        end
    end
end

button(playersPage, "نمایش کاراکترها از پشت دیوار: روشن / خاموش", function()
    setESP(not espEnabled)

    setStatus(
        espEnabled and "نمایش کاراکترها روشن"
        or "نمایش کاراکترها خاموش"
    )
end)

-- تنظیمات
local settings = pages["تنظیمات"]

label(settings, "تنظیمات پنل")

local minimized = false

button(settings, "جمع کردن / باز کردن پنل", function()
    minimized = not minimized

    sidebar.Visible = not minimized
    pagesHolder.Visible = not minimized
    dragArea.Visible = not minimized

    main.Size = minimized
        and UDim2.fromOffset(530, 45)
        or UDim2.fromOffset(530, 365)
end)

button(settings, "بازنشانی تنظیمات حرکت", function()
    walkSpeed = 16
    jumpPower = 50
    flySpeed = 45
    spinSpeed = 10

    applyMovement()
    stopFly()

    spinEnabled = false

    if spinConnection then
        spinConnection:Disconnect()
        spinConnection = nil
    end

    setStatus("تنظیمات بازنشانی شد")
end)

button(settings, "خاموش کردن نمایش بازیکنان", function()
    setESP(false)
    setStatus("نمایش بازیکنان خاموش شد")
end)

-- دکمه شناور 57
local floating = create("TextButton", {
    Size = UDim2.fromOffset(52, 52),
    Position = UDim2.new(0, 20, 0.5, -26),
    BackgroundColor3 = DARK,
    Text = "57",
    TextColor3 = RED,
    TextSize = 20,
    Font = Enum.Font.GothamBlack,
    BorderSizePixel = 0,
    Visible = false
}, gui)

corner(floating, 50)
stroke(floating, RED, 2)

local floatDragging = false
local floatStart
local floatPosition

floating.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        floatDragging = true
        floatStart = input.Position
        floatPosition = floating.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if floatDragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - floatStart

        floating.Position = UDim2.new(
            floatPosition.X.Scale,
            floatPosition.X.Offset + delta.X,
            floatPosition.Y.Scale,
            floatPosition.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        floatDragging = false
    end
end)

floating.Activated:Connect(function()
    main.Visible = not main.Visible
end)

close.Activated:Connect(function()
    main.Visible = false
    floating.Visible = true
end)

-- respawn
Player.CharacterAdded:Connect(function()
    cleanupFly()

    task.wait(0.5)

    applyMovement()

    if espEnabled then
        setESP(true)
    end
end)

addReport("پنل CYBER 57 فعال شد", RED)
setStatus("آماده")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ICON_IMAGE_ID = "rbxassetid://85004856887979"
local BACKGROUND_IMAGE_ID = "rbxassetid://126183598605584"
local CLOSE_IMAGE_ID = "rbxassetid://95635409643839"

local TOGGLE_SIZE = 44
local MENU_WIDTH = 500
local MENU_HEIGHT = 420

local RAW = "https://raw.githubusercontent.com/bloxfruitsnokey/"

local categories = {
	{
		title = "script no key ❌🔑",
		open = true,
		scripts = {
			{ name = "Gavz (nokey)", url = RAW .. "Redz-Hub/refs/heads/main/Gavz/load.luau" },
			{ name = "garnet hub (nokey)", url = RAW .. "Redz/refs/heads/main/Garnet/load.luau" },
			{ name = "banana hub (nokey)", url = RAW .. "Banana/refs/heads/main/Banana/load.luau" },
			{ name = "Gravity blade (nokey)", url = RAW .. "Banana/refs/heads/main/GB/load.luau" },
			{ name = "dark blade hub (nokey)", url = RAW .. "Banana/refs/heads/main/DB/load.luau" },
			{ name = "aquamarine (nokey)", url = RAW .. "Redz/refs/heads/main/Aquamarine/load.luau" },
			{ name = "ruby hub (nokey)", url = RAW .. "Redz/refs/heads/main/Ruby/load.luau" },
			{ name = "pole hub (nokey)", url = RAW .. "Banana/refs/heads/main/Pole/load.luau" },
			{ name = "koko hub (nokey)", url = RAW .. "Banana/refs/heads/main/Koko/load.luau" },
			{ name = "simple hub (nokey)", url = RAW .. "Fluent/refs/heads/main/Simple/run.luau" },
			{ name = "plain hub (nokey)", url = RAW .. "Fluent/refs/heads/main/Plain/run.luau" },
			{ name = "ez hub (nokey)", url = RAW .. "Fluent/refs/heads/main/EZ/script.luau" },
			{ name = "basic hub (nokey)", url = RAW .. "Fluent/refs/heads/main/Basic/loader.luau" },
			{ name = "flen hub (nokey)", url = RAW .. "Fluent/refs/heads/main/Flen/loader.luau" },
			{ name = "lavz (nokey)", url = RAW .. "Redz-Hub/refs/heads/main/Lavz/load.luau" },
			{ name = "sunz (nokey)", url = RAW .. "Redz-Hub/refs/heads/main/Sunz/load.luau" },
			{ name = "navz (nokey)", url = RAW .. "Redz-Hub/refs/heads/main/Navz/load.luau" },
			{ name = "ravz (nokey)", url = RAW .. "Redz-Hub/refs/heads/main/Ravz/load.luau" },
			{ name = "emerald hub (nokey)", url = RAW .. "Redz/refs/heads/main/Emerald/load.luau" },
			{ name = "amethyst (nokey)", url = RAW .. "Redz/refs/heads/main/Amethyst/load.luau" },
		},
	},
	{
		title = "script cần key ✅🔑",
		open = true,
		scripts = {
			{ name = "teddy hub (key)", url = nil },
			{ name = "realkid hub (key)", url = "https://raw.githubusercontent.com/realkidhub/realkid/refs/heads/main/main.lua" },
			{ name = "Quantum onyx (key)", url = "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua" },
			{ name = "speed hub (key)", url = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua" },
			{ name = "omg hub (key)", url = "https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua" },
			{ name = "Alchemy hub (key)", url = "https://getalchemy.net/n" },
			{ name = "Axon hub (key)", url = "https://xenith-auth.online/v1/loader/5b193fc732db5c93" },
			{ name = "Symbiote (key)", url = "https://raw.githubusercontent.com/ssssssssss21/Symbiote/refs/heads/main/symbiote-loader.lua" },
			{ name = "4479 hub (key)", url = "https://raw.githubusercontent.com/4479cantcode/4479Hub/refs/heads/main/Script.lua" },
			{ name = "LP10 hub (key)", url = "https://raw.githubusercontent.com/LPOLVO/LP10-UNIVERSAL-/refs/heads/main/Blox%20Fruits" },
		},
	},
	{
		title = "hop farm script 📨",
		open = true,
		scripts = {
			{ name = "real kid hop farm (key)", url = "https://raw.githubusercontent.com/realkidhub/realkid/refs/heads/main/RealKidHop.lua" },
			{ name = "night hub (key)", url = "https://github.com/WhiteX1208/Scripts/blob/main/HopScript.luau?raw=true" },
		},
	},
}

if PlayerGui:FindFirstChild("NorraHubCustom") then
	PlayerGui.NorraHubCustom:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NorraHubCustom"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999

local function makeDraggable(handle, target)
	local dragging = false
	local moved = false
	local dragStart, startPos, dragInput

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			moved = false
			dragInput = input
			dragStart = input.Position
			startPos = target.Position

			local conn
			conn = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
					conn:Disconnect()
				end
			end)
		end
	end)

	local moveConn = UserInputService.InputChanged:Connect(function(input)
		if not dragging then
			return
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input == dragInput then
			local delta = input.Position - dragStart
			if not moved and delta.Magnitude > 6 then
				moved = true
			end
			if moved then
				target.Position = UDim2.new(
					startPos.X.Scale, startPos.X.Offset + delta.X,
					startPos.Y.Scale, startPos.Y.Offset + delta.Y
				)
			end
		end
	end)

	ScreenGui.Destroying:Connect(function()
		moveConn:Disconnect()
	end)

	return function()
		return moved
	end
end

local ToggleButton = Instance.new("ImageButton")
ToggleButton.Name = "ToggleIcon"
ToggleButton.Size = UDim2.new(0, TOGGLE_SIZE, 0, TOGGLE_SIZE)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -TOGGLE_SIZE / 2)
ToggleButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
ToggleButton.BackgroundTransparency = 0.1
ToggleButton.Image = ICON_IMAGE_ID
ToggleButton.ImageTransparency = 0
ToggleButton.ScaleType = Enum.ScaleType.Fit
ToggleButton.ZIndex = 100
ToggleButton.Visible = true
ToggleButton.Active = true
ToggleButton.AutoButtonColor = false
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

ToggleButton.MouseEnter:Connect(function()
	ToggleButton.BackgroundTransparency = 0
end)
ToggleButton.MouseLeave:Connect(function()
	ToggleButton.BackgroundTransparency = 0.1
end)

local toggleWasDragged = makeDraggable(ToggleButton, ToggleButton)

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, MENU_WIDTH, 0, MENU_HEIGHT)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.ZIndex = 50
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 16)
UICornerMain.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 221, 0)
MainStroke.Thickness = 2.5
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame

local MenuScale = Instance.new("UIScale")
MenuScale.Parent = MainFrame

local function updateScale()
	local camera = workspace.CurrentCamera
	if not camera then
		return
	end
	local viewport = camera.ViewportSize
	MenuScale.Scale = math.clamp(math.min(viewport.X / 540, viewport.Y / 460), 0.55, 1)
end

updateScale()
if workspace.CurrentCamera then
	local viewportConn = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
	ScreenGui.Destroying:Connect(function()
		viewportConn:Disconnect()
	end)
end

local OPEN_INFO = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local CLOSE_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local OPEN_SIZE = UDim2.new(0, MENU_WIDTH, 0, MENU_HEIGHT)
local CLOSED_SIZE = UDim2.new(0, MENU_WIDTH, 0, 0)

local menuOpen = false
local menuTween

local function setMenu(open)
	if menuOpen == open then
		return
	end
	menuOpen = open

	if menuTween then
		menuTween:Cancel()
	end

	if open then
		if not MainFrame.Visible then
			MainFrame.Size = CLOSED_SIZE
			MainFrame.Visible = true
		end
		menuTween = TweenService:Create(MainFrame, OPEN_INFO, { Size = OPEN_SIZE })
		menuTween:Play()
	else
		local tween = TweenService:Create(MainFrame, CLOSE_INFO, { Size = CLOSED_SIZE })
		menuTween = tween
		tween.Completed:Connect(function(state)
			if state == Enum.PlaybackState.Completed then
				MainFrame.Visible = false
			end
		end)
		tween:Play()
	end
end

local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Size = UDim2.new(1, 0, 0, MENU_HEIGHT)
BackgroundImage.Image = BACKGROUND_IMAGE_ID
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.ZIndex = 0
BackgroundImage.Parent = MainFrame

local BackgroundCorner = Instance.new("UICorner")
BackgroundCorner.CornerRadius = UDim.new(0, 16)
BackgroundCorner.Parent = BackgroundImage

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundTransparency = 1
TopBar.Active = true
TopBar.Parent = MainFrame

makeDraggable(TopBar, MainFrame)

local CloseButton = Instance.new("ImageButton")
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Position = UDim2.new(1, -36, 0.5, -12)
CloseButton.BackgroundTransparency = 1
CloseButton.Image = CLOSE_IMAGE_ID
CloseButton.ZIndex = 5
CloseButton.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
	setMenu(false)
end)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "Norra Hub | Blox Fruits"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 15
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 36)
TabContainer.Position = UDim2.new(0, 10, 0, 42)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 8)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Parent = TabContainer

local ScrollContent = Instance.new("ScrollingFrame")
ScrollContent.Size = UDim2.new(1, -20, 0, MENU_HEIGHT - 90)
ScrollContent.Position = UDim2.new(0, 10, 0, 85)
ScrollContent.BackgroundTransparency = 1
ScrollContent.BorderSizePixel = 0
ScrollContent.ScrollBarThickness = 4
ScrollContent.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
ScrollContent.ScrollingDirection = Enum.ScrollingDirection.Y
ScrollContent.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollContent.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = ScrollContent

local tabs = { "Blox Fruit", "Chung", "Tối ưu hóa" }
local tabButtons = {}

local function restoreMobileControls()
	task.spawn(function()
		task.wait(1.2)

		local touchGui = PlayerGui:FindFirstChild("TouchGui")
		if touchGui and touchGui:IsA("ScreenGui") then
			touchGui.Enabled = true
			local controlFrame = touchGui:FindFirstChild("TouchControlFrame")
			if controlFrame then
				controlFrame.Visible = true
			end
		end

		local playerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
		local playerModule = playerScripts and playerScripts:FindFirstChild("PlayerModule")
		if playerModule then
			pcall(function()
				require(playerModule):GetControls():Enable()
			end)
		end
	end)
end

local isRunning = false

local function runScript(entry, rightLabel)
	if isRunning then
		return
	end

	if not entry.url then
		rightLabel.Text = "Chưa có link"
		rightLabel.TextColor3 = Color3.fromRGB(255, 160, 50)
		return
	end

	isRunning = true
	rightLabel.Text = "Đang chạy..."
	rightLabel.TextColor3 = Color3.fromRGB(255, 200, 50)

	task.spawn(function()
		task.wait(0.2)

		local okFetch, fn, compileErr = pcall(function()
			return loadstring(game:HttpGet(entry.url, true))
		end)

		if okFetch and typeof(fn) == "function" then
			task.spawn(function()
				local okRun, runErr = pcall(fn)
				if not okRun then
					warn(entry.name .. " Runtime Error:", runErr)
				end
			end)

			rightLabel.Text = "Đã chạy ✓"
			rightLabel.TextColor3 = Color3.fromRGB(80, 255, 80)

			restoreMobileControls()

			task.wait(0.4)
			setMenu(false)
		else
			rightLabel.Text = "Lỗi tải!"
			rightLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
			warn(entry.name .. " Load Error:", okFetch and compileErr or fn)
		end

		isRunning = false
	end)
end

local function clearContent()
	for _, child in ipairs(ScrollContent:GetChildren()) do
		if child:IsA("TextButton") or child:IsA("TextLabel") then
			child:Destroy()
		end
	end
end

local function showInfo(text)
	local info = Instance.new("TextLabel")
	info.Size = UDim2.new(1, -6, 0, 100)
	info.BackgroundTransparency = 1
	info.Font = Enum.Font.Gotham
	info.Text = text
	info.TextColor3 = Color3.fromRGB(200, 200, 200)
	info.TextSize = 14
	info.TextWrapped = true
	info.Parent = ScrollContent
end

local Toast = Instance.new("TextLabel")
Toast.Name = "Toast"
Toast.AnchorPoint = Vector2.new(0.5, 1)
Toast.Position = UDim2.new(0.5, 0, 0, MENU_HEIGHT - 14)
Toast.Size = UDim2.new(0, 320, 0, 32)
Toast.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toast.BackgroundTransparency = 1
Toast.Font = Enum.Font.GothamSemibold
Toast.Text = ""
Toast.TextColor3 = Color3.fromRGB(255, 255, 255)
Toast.TextTransparency = 1
Toast.TextSize = 13
Toast.ZIndex = 10
Toast.Parent = MainFrame

local ToastCorner = Instance.new("UICorner")
ToastCorner.CornerRadius = UDim.new(0, 16)
ToastCorner.Parent = Toast

local toastToken = 0

local function showToast(text, color)
	toastToken = toastToken + 1
	local token = toastToken

	Toast.Text = text
	Toast.TextColor3 = color
	TweenService:Create(Toast, TweenInfo.new(0.2), {
		BackgroundTransparency = 0.15,
		TextTransparency = 0,
	}):Play()

	task.delay(1.8, function()
		if token == toastToken then
			TweenService:Create(Toast, TweenInfo.new(0.3), {
				BackgroundTransparency = 1,
				TextTransparency = 1,
			}):Play()
		end
	end)
end

local function copyLoadstring(entry)
	if not entry.url then
		showToast("script này chưa có link để copy", Color3.fromRGB(255, 160, 50))
		return
	end

	local setClip = setclipboard or toclipboard or (syn and syn.write_clipboard) or (Clipboard and Clipboard.set)
	if not setClip then
		showToast("executor không hỗ trợ copy", Color3.fromRGB(255, 80, 80))
		return
	end

	local text = 'loadstring(game:HttpGet("' .. entry.url .. '"))()'
	local ok = pcall(setClip, text)
	if ok then
		showToast("đã copy link loadstring của script 🔗", Color3.fromRGB(80, 255, 80))
	else
		showToast("copy thất bại", Color3.fromRGB(255, 80, 80))
	end
end

local sectionOpen = {}

local function addScriptButton(entry, order)
	local scriptBtn = Instance.new("TextButton")
	scriptBtn.Size = UDim2.new(1, -6, 0, 38)
	scriptBtn.LayoutOrder = order
	scriptBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	scriptBtn.BackgroundTransparency = 0.5
	scriptBtn.Font = Enum.Font.GothamSemibold
	scriptBtn.Text = "   " .. entry.name
	scriptBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	scriptBtn.TextSize = 13
	scriptBtn.TextXAlignment = Enum.TextXAlignment.Left
	scriptBtn.AutoButtonColor = false
	scriptBtn.Parent = ScrollContent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = scriptBtn

	local rightLabel = Instance.new("TextLabel")
	rightLabel.Size = UDim2.new(0, 80, 1, 0)
	rightLabel.Position = UDim2.new(1, -85, 0, 0)
	rightLabel.BackgroundTransparency = 1
	rightLabel.Font = Enum.Font.Gotham
	rightLabel.Text = "Execute"
	rightLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
	rightLabel.TextSize = 11
	rightLabel.TextXAlignment = Enum.TextXAlignment.Right
	rightLabel.Parent = scriptBtn

	local copyBtn = Instance.new("TextButton")
	copyBtn.Size = UDim2.new(0, 52, 0, 26)
	copyBtn.Position = UDim2.new(1, -143, 0.5, -13)
	copyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	copyBtn.BackgroundTransparency = 0.88
	copyBtn.Font = Enum.Font.GothamSemibold
	copyBtn.Text = "Copy"
	copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	copyBtn.TextSize = 11
	copyBtn.AutoButtonColor = false
	copyBtn.ZIndex = 2
	copyBtn.Parent = scriptBtn

	local copyCorner = Instance.new("UICorner")
	copyCorner.CornerRadius = UDim.new(0, 8)
	copyCorner.Parent = copyBtn

	copyBtn.MouseEnter:Connect(function()
		copyBtn.BackgroundTransparency = 0.7
	end)

	copyBtn.MouseLeave:Connect(function()
		copyBtn.BackgroundTransparency = 0.88
	end)

	copyBtn.MouseButton1Click:Connect(function()
		copyLoadstring(entry)
	end)

	scriptBtn.MouseEnter:Connect(function()
		scriptBtn.BackgroundTransparency = 0.3
	end)

	scriptBtn.MouseLeave:Connect(function()
		scriptBtn.BackgroundTransparency = 0.5
	end)

	scriptBtn.MouseButton1Click:Connect(function()
		runScript(entry, rightLabel)
	end)

	return scriptBtn
end

local function addCategory(category, order)
	local isOpen = sectionOpen[category.title]
	if isOpen == nil then
		isOpen = category.open
		sectionOpen[category.title] = isOpen
	end

	local header = Instance.new("TextButton")
	header.Size = UDim2.new(1, -6, 0, 34)
	header.LayoutOrder = order
	header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	header.BackgroundTransparency = 0.88
	header.Font = Enum.Font.GothamBold
	header.Text = "   " .. category.title
	header.TextColor3 = Color3.fromRGB(255, 255, 255)
	header.TextSize = 13
	header.TextXAlignment = Enum.TextXAlignment.Left
	header.AutoButtonColor = false
	header.Parent = ScrollContent

	local headerCorner = Instance.new("UICorner")
	headerCorner.CornerRadius = UDim.new(0, 10)
	headerCorner.Parent = header

	local arrow = Instance.new("TextLabel")
	arrow.Size = UDim2.new(0, 70, 1, 0)
	arrow.Position = UDim2.new(1, -78, 0, 0)
	arrow.BackgroundTransparency = 1
	arrow.Font = Enum.Font.GothamBold
	arrow.TextColor3 = Color3.fromRGB(200, 200, 200)
	arrow.TextSize = 12
	arrow.TextXAlignment = Enum.TextXAlignment.Right
	arrow.Parent = header

	local items = {}
	for i, entry in ipairs(category.scripts) do
		items[i] = addScriptButton(entry, order + i)
	end

	local function refresh()
		arrow.Text = #items .. "   " .. (isOpen and "▼" or "►")
		for _, btn in ipairs(items) do
			btn.Visible = isOpen
		end
	end
	refresh()

	header.MouseEnter:Connect(function()
		header.BackgroundTransparency = 0.8
	end)

	header.MouseLeave:Connect(function()
		header.BackgroundTransparency = 0.88
	end)

	header.MouseButton1Click:Connect(function()
		isOpen = not isOpen
		sectionOpen[category.title] = isOpen
		refresh()
	end)

	return order + #items + 1
end

local function loadTab(tabIndex)
	clearContent()
	ScrollContent.CanvasPosition = Vector2.new(0, 0)

	for i, btn in ipairs(tabButtons) do
		if i == tabIndex then
			btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			btn.BackgroundTransparency = 0.2
			btn.TextColor3 = Color3.fromRGB(30, 30, 30)
		else
			btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			btn.BackgroundTransparency = 0.6
			btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		end
	end

	if tabIndex == 1 then
		local order = 1
		for _, category in ipairs(categories) do
			order = addCategory(category, order)
		end
	elseif tabIndex == 2 then
		showInfo("Tab Chung - Đang phát triển...")
	elseif tabIndex == 3 then
		showInfo("Tab Tối ưu hóa - Đang phát triển...")
	end
end

for i, tabName in ipairs(tabs) do
	local tabBtn = Instance.new("TextButton")
	tabBtn.Size = UDim2.new(0, 152, 1, 0)
	tabBtn.LayoutOrder = i
	tabBtn.BackgroundColor3 = (i == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
	tabBtn.BackgroundTransparency = (i == 1) and 0.2 or 0.6
	tabBtn.Font = Enum.Font.GothamBold
	tabBtn.Text = tabName
	tabBtn.TextColor3 = (i == 1) and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(255, 255, 255)
	tabBtn.TextSize = 12
	tabBtn.AutoButtonColor = false
	tabBtn.Parent = TabContainer

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 18)
	corner.Parent = tabBtn

	tabButtons[i] = tabBtn

	tabBtn.MouseButton1Click:Connect(function()
		loadTab(i)
	end)
end

ToggleButton.MouseButton1Click:Connect(function()
	if toggleWasDragged() then
		return
	end
	setMenu(not menuOpen)
end)

loadTab(1)
package.path = FileMgr.GetMenuRootPath() .. "\\Lua\\?.lua;"
require("natives/natives-g")

local function getPlayerName()
	local playerId = GTA.GetLocalPlayerId()
	local playerName = NETWORK_PLAYER_GET_NAME(playerId) 
	return playerName or "Unknown"
end

local function getCurrentDateTime()
	local date = os.date("%d.%m.%Y")
	local time = os.date("%H:%M:%S")
	return date .. "  " .. time
end

function onPresent()
local flags = ImGuiWindowFlags.AlwaysAutoResize | ImGuiWindowFlags.NoCollapse | ImGuiWindowFlags.AlwaysUseWindowPadding | ImGuiWindowFlags.NoDecoration
local screenWidth, screenHeight = ImGui.GetDisplaySize()
ImGui.SetNextWindowPos(screenWidth - 300, 20, ImGuiCond.Always)
ImGui.SetNextWindowSize(0, 25, ImGuiCond.Always)

-- ImGui.PushStyleColor(ImGuiCol.TitleBg,  0.423, 0.765, 0.071, 1.0)
-- ImGui.PushStyleColor(ImGuiCol.TitleBgActive,  0.423, 0.765, 0.071, 1.0)

ImGui.Begin("", true, flags)
	ImGui.Text(getPlayerName())
	ImGui.PushStyleColor(ImGuiCol.Text, 0.423, 0.765, 0.071, 1.0)
	ImGui.SameLine()
	ImGui.Text(" | ")
	ImGui.PopStyleColor()
	ImGui.SameLine()
	ImGui.Text(getCurrentDateTime())
	ImGui.PushStyleColor(ImGuiCol.Text, 0.423, 0.765, 0.071, 1.0)
	ImGui.SameLine()
	ImGui.Text(" | ")
	ImGui.PopStyleColor()
	ImGui.SameLine()
	ImGui.Text(Cherax.GetVersion())
ImGui.End()
end

EventMgr.RegisterHandler(eLuaEvent.ON_PRESENT, onPresent)

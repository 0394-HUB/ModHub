package.path = FileMgr.GetMenuRootPath() .. "\\Lua\\?.lua;"
require("natives/natives-g")


local webhookUrl = FeatureMgr.AddFeature(Utils.Joaat("lua_webhook_url"), "Webhook Url", eFeatureType.InputText, "", function(f) end)
webhookUrl:SetMaxValue(1000)
local webhookUsername = FeatureMgr.AddFeature(Utils.Joaat("lua_webhook_username"), "Webhook Username", eFeatureType.InputText, "", function(f) end)
local webhookTitle = FeatureMgr.AddFeature(Utils.Joaat("lua_webhook_title"), "Webhook Title", eFeatureType.InputText, "", function(f) end)
local webhookDescription = FeatureMgr.AddFeature(Utils.Joaat("lua_webhook_description"), "Webhook Description", eFeatureType.InputText, "", function(f) end)
local webhookFooter = FeatureMgr.AddFeature(Utils.Joaat("lua_webhook_footer"), "Webhook Footer", eFeatureType.InputText, "", function(f) end)
local webhookColor = FeatureMgr.AddFeature(Utils.Joaat("lua_webhook_color"), "Webhook Color", eFeatureType.InputColor3, "", function(f) end)
webhookColor:SetColor(107, 195, 18)
FeatureMgr.AddFeature(Utils.Joaat("lua_webhook_sender"), "Send Scripthook Embed Message", eFeatureType.Button, "", function(f)
local webhook_url = webhookUrl:GetStringValue()
local webhook_username = webhookUsername:GetStringValue()
local webhook_title = webhookTitle:GetStringValue()
local webhook_description = webhookDescription:GetStringValue()
local webhook_footer = webhookFooter:GetStringValue()
local r, g, a = webhookColor:GetColor()

local message = string.format([[
{
            "username": "%s",
            "embeds": [
                {
                    "title": "%s",
                    "description": "%s",
                    "color": %d,
                    "fields": [
                        {
                            "name": "Aktion",
                            "value": "Beispiel Aktion"
                        }
                    ],
                    "footer": {
                        "text": "%s"
                    }
                }
            ]
	}
]], webhook_username, webhook_title, webhook_description, r * 256 * 256 + g * 256 + a,webhook_footer)


local curl = Curl.Easy()
curl:AddHeader("Content-Type: application/json")
curl:Setopt(eCurlOption.CURLOPT_URL, webhook_url)
curl:Setopt(eCurlOption.CURLOPT_POST, 1)
curl:Setopt(eCurlOption.CURLOPT_POSTFIELDS, message)
curl:Perform()
while not curl:GetFinished() do
	Script.Yield(100)
end

end)


ClickGUI.AddTab("ModHub", function()
	if ClickGUI.BeginCustomChildWindow("ModHub | Webhook Sender") then
		ClickGUI.RenderFeature(Utils.Joaat("lua_webhook_url"))
		ClickGUI.RenderFeature(Utils.Joaat("lua_webhook_username"))
		ClickGUI.RenderFeature(Utils.Joaat("lua_webhook_title"))
		ClickGUI.RenderFeature(Utils.Joaat("lua_webhook_description"))
		ClickGUI.RenderFeature(Utils.Joaat("lua_webhook_footer"))
		ClickGUI.RenderFeature(Utils.Joaat("lua_webhook_color"))
			ImGui.SameLine()
		ClickGUI.RenderFeature(Utils.Joaat("lua_webhook_sender"))

		ClickGUI.EndCustomChildWindow()
	end

end)














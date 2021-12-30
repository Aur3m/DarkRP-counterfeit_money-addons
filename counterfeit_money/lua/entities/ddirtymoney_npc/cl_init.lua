AddCSLuaFile( "dirtymoney_config.lua" )
include( "dirtymoney_config.lua" )
include('shared.lua')

function ENT:Draw()  
	self:DrawModel()
end  

surface.CreateFont("OpenSans_16", {
	    font = fontText,
	    size = 20,
	    weight = 1000
})


local colorBackground = DDirtyMoney.ColorBackground
local colorMainText = DDirtyMoney.ColorMainText
local colorYesButton = DDirtyMoney.ColorYesButton
local colorNoButton = DDirtyMoney.ColorNoButton
local colorYesText = DDirtyMoney.ColorYesText
local colorNoText = DDirtyMoney.ColorNoText

net.Receive("DDirtyMoney:StartNPC", function()
	local moneyToGive = net.ReadInt(32)

	if moneyToGive == 0 then return end

	local MainPanel = vgui.Create("DFrame")
	MainPanel:SetSize(0, 0)
	MainPanel:Center()
	MainPanel:SetTitle("")
	MainPanel:MakePopup()
	MainPanel:ShowCloseButton(false)
	MainPanel:SetDraggable(false)
	MainPanel.Paint = function(self, w, h)
	    draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end

	local BackgroundPanel = vgui.Create("Panel")
	BackgroundPanel:SetPos(ScrW()/2.55, ScrH()/4.5)
	BackgroundPanel:SetSize(ScrW()/4, ScrH()/3.5)
	BackgroundPanel.Paint = function(self, w, h)
	    draw.RoundedBox(16, 1, 1, w - 2, h - 2, colorBackground)
	end

	local MainText = vgui.Create("DLabel")
	MainText:SetPos(ScrW()/2.15, ScrH()/4.1)
	MainText:SetFont("OpenSans_16")
	MainText:SetText("Do you want to earn $"..moneyToGive.." ?")
	MainText:SetColor(colorMainText)
	MainText:SizeToContents()


-- Agree button
	local AgreeButton = vgui.Create("DButton")
	AgreeButton:SetText("")
	AgreeButton:SetPos(ScrW()/2.5, ScrH()/3.5)
	AgreeButton:SetSize(ScrW()/4.35, ScrH()/14)
	AgreeButton:SetColor(Color(0,0,255))

	AgreeButton.DoClick = function()

		net.Start("DDirtyMoney:StartNPC")
		net.SendToServer()

	    MainPanel:Remove()
	    BackgroundPanel:Remove()
	    MainText:Remove()
	    AgreeButton:Remove()
	    DisagreeButton:Remove()

	    notification.AddLegacy( "You have earn $"..moneyToGive, NOTIFY_GENERIC, 5 )
		surface.PlaySound( "buttons/button15.wav" )
	end

	AgreeButton.Paint = function(self, w, h)
	    draw.RoundedBox(4, 0, 0, w, h, colorYesButton)
	    draw.SimpleText("Yes", "OpenSans_16", w / 2, h / 2, colorYesText, 1, 1)
	end

-- Disagree button
	DisagreeButton = vgui.Create("DButton")
	DisagreeButton:SetText("")
	DisagreeButton:SetPos(ScrW()/2.5, ScrH()/2.5)
	DisagreeButton:SetSize(ScrW()/4.35, ScrH()/14)
	DisagreeButton:SetColor(Color(0,0,255))

	DisagreeButton.DoClick = function()
	    MainPanel:Remove()
	    BackgroundPanel:Remove()
	    MainText:Remove()
	    AgreeButton:Remove()
	    DisagreeButton:Remove()

	   	notification.AddLegacy( "Get out of here !", NOTIFY_UNDO, 5 )
		surface.PlaySound( "buttons/button15.wav" )
	end

	DisagreeButton.Paint = function(self, w, h)
	    draw.RoundedBox(4, 0, 0, w, h, colorNoButton)
	    draw.SimpleText("No", "OpenSans_16", w / 2, h / 2, colorNoText, 1, 1)
	end

end)

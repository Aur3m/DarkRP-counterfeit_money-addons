AddCSLuaFile( "dirtymoney_config.lua" )
include( "dirtymoney_config.lua" )
include('shared.lua')

function ENT:Draw()  
	self:DrawModel()
end  

surface.CreateFont("OpenSans_DDirtyMoney", {
	    font = "TargetID",
	    size = 22,
	    weight = 1000
})

surface.CreateFont("OpenSans_DDirtyMoney_Small", {
	    font = "TargetID",
	    size = 18,
	    weight = 1000
})

surface.CreateFont("OpenSans_DDirtyMoney_Big", {
	    font = "TargetID",
	    size = 30,
	    weight = 1000
})

local colorText = DDirtyMoney.ColorJobText
local colorMain = DDirtyMoney.ColorJobMainBackground
local colorHeader = DDirtyMoney.ColorJobMainHeader
local colorButtonInfo = DDirtyMoney.ColorJobInfoButton
local colorHeaderBar = DDirtyMoney.ColorJobHeaderBar

net.Receive("DDirtyMoney:StartMonitor", function()
	local moneyToGive = net.ReadInt(32)

	local Main = vgui.Create("DFrame")
	Main:SetSize(ScrW()/1.8, ScrH()/2)
	Main:Center()
	Main:SetTitle("")
	Main:MakePopup()
	Main:ShowCloseButton(false)
	Main:SetDraggable(false)
	Main.Paint = function(self, w, h)
	    draw.RoundedBox(6, 0, 0, w, h, colorMain) -- Main panel
	    draw.RoundedBox(6, 0, 0, w, h/8, colorHeader) -- Main panel color
	    draw.RoundedBox(0, w/10000, h/8, w, h/530, colorHeaderBar) -- red bar header

	    draw.RoundedBox(0, w/2.57, h/3, w/4.4, h/180, colorText) -- Underline How it works
	end

	local CloseButton = vgui.Create("DButton", Main)
	CloseButton:SetText("")
	CloseButton:SetPos(ScrW()/1.88, ScrH()/100)
	CloseButton:SetSize(ScrW()/40, ScrH()/25)
	CloseButton:SetColor(Color(0,0,255))
	CloseButton.DoClick = function()
		Main:Remove()
		surface.PlaySound( "buttons/button15.wav" )
	end
	CloseButton.Paint = function(self, w, h)
	    draw.RoundedBox(26, 0, 0, w, h, colorHeader)
	    draw.SimpleText("X", "OpenSans_DDirtyMoney_Big", w / 2, h / 2, colorText, 1, 1)
	end
	CloseButton:CenterHorizontal(0.98)
	CloseButton:CenterVertical(0.08)



	local time = 0
	local InfoButton = vgui.Create("DButton", Main)
	InfoButton:SetText("")
	InfoButton:SetPos(ScrW()/1.2, ScrH()/2)
	InfoButton:SetSize(ScrW()/40, ScrH()/25)
	InfoButton:SetColor(Color(0,0,255))
	InfoButton.DoClick = function()
			
			local InfoMainPanel = vgui.Create("DFrame")
			InfoMainPanel:SetSize(ScrW()/1.8, ScrH()/2)
			InfoMainPanel:Center()
			InfoMainPanel:SetTitle("")
			InfoMainPanel:MakePopup()
			InfoMainPanel:ShowCloseButton(false)
			InfoMainPanel:SetDraggable(false)
			InfoMainPanel.Paint = function(self, w, h)
			    draw.RoundedBox(4, 0, 0, w, h, colorMain) -- main
			    draw.RoundedBox(6, 0, 0, w, h/8, colorHeader) -- Main panel color
			    draw.RoundedBox(0, w/10000, h/8, w, h/530, colorHeaderBar) -- blue bar header

			    draw.RoundedBox(0, w/2.5, h/4.3, w/5, h/180, colorText) -- Underline How it works
			end


			local CloseButtonInfo = vgui.Create("DButton", InfoMainPanel)
			CloseButtonInfo:SetText("")
			CloseButtonInfo:SetPos(ScrW()/1.88, ScrH()/100)
			CloseButtonInfo:SetSize(ScrW()/40, ScrH()/25)
			CloseButtonInfo:SetColor(Color(0,0,255))
			CloseButtonInfo.DoClick = function()
				InfoMainPanel:Remove()
				surface.PlaySound( "buttons/button15.wav" )
			end
			CloseButtonInfo.Paint = function(self, w, h)
			    draw.RoundedBox(26, 0, 0, w, h, colorHeader)
			    draw.SimpleText("X", "OpenSans_DDirtyMoney_Big", w / 2, h / 2, colorText, 1, 1)
			end
			CloseButtonInfo:CenterHorizontal(0.98)
			CloseButtonInfo:CenterVertical(0.08)


			local TextHeaderInfo = vgui.Create("DLabel", InfoMainPanel)
			TextHeaderInfo:SetPos(10,10)
			TextHeaderInfo:SetFont("OpenSans_DDirtyMoney_Big")
			TextHeaderInfo:SetText("Bahamas Worldwide Company")
			TextHeaderInfo:SetColor(colorText)
			TextHeaderInfo:SizeToContents()
			TextHeaderInfo:CenterHorizontal(0.2)
			TextHeaderInfo:CenterVertical(0.08)

			local TextHeaderBalanceInfos = vgui.Create("DLabel", InfoMainPanel)
			TextHeaderBalanceInfos:SetPos(10,10)
			TextHeaderBalanceInfos:SetFont("OpenSans_DDirtyMoney_Big")
			TextHeaderBalanceInfos:SetText("Argent Sale Totale : $"..LocalPlayer():GetNWInt("Dirtymoney"))
			TextHeaderBalanceInfos:SetColor(colorText)
			TextHeaderBalanceInfos:SizeToContents()
			TextHeaderBalanceInfos:CenterHorizontal(0.7)
			TextHeaderBalanceInfos:CenterVertical(0.08)

			local TextInfos1 = vgui.Create("DLabel", InfoMainPanel)
			TextInfos1:SetPos(10,10)
			TextInfos1:SetFont("OpenSans_DDirtyMoney_Big")
			TextInfos1:SetText("Comment ça fonctionne?")
			TextInfos1:SetColor(colorText)
			TextInfos1:SizeToContents()
			TextInfos1:CenterHorizontal()
			TextInfos1:CenterVertical(0.2)

			local TextInfos2 = vgui.Create("DLabel", InfoMainPanel)
			TextInfos2:SetPos(10,10)
			TextInfos2:SetFont("OpenSans_DDirtyMoney")
			TextInfos2:SetText("Tu envoies de l'argent sale aux Bahamas pour ensuite avoir un retour sur investissement (=Blanchiment).")
			TextInfos2:SetColor(colorText)
			TextInfos2:SizeToContents()
			TextInfos2:CenterHorizontal()
			TextInfos2:CenterVertical(0.4)

			local TextSafe = vgui.Create("DLabel", InfoMainPanel)
			TextSafe:SetPos(10,10)
			TextSafe:SetFont("OpenSans_DDirtyMoney_Small")
			TextSafe:SetText("Facile : 100% réussite - 20% retour en investissement")
			TextSafe:SetColor(colorText)
			TextSafe:SizeToContents()
			TextSafe:CenterHorizontal()
			TextSafe:CenterVertical(0.60)

			local TextHalfSafe = vgui.Create("DLabel", InfoMainPanel)
			TextHalfSafe:SetPos(10,10)
			TextHalfSafe:SetFont("OpenSans_DDirtyMoney_Small")
			TextHalfSafe:SetText("Intermédiaire : 60% réussite - 60% retour en investissement")
			TextHalfSafe:SetColor(colorText)
			TextHalfSafe:SizeToContents()
			TextHalfSafe:CenterHorizontal()
			TextHalfSafe:CenterVertical(0.65)

			local TextRisky = vgui.Create("DLabel", InfoMainPanel)
			TextRisky:SetPos(10,10)
			TextRisky:SetFont("OpenSans_DDirtyMoney_Small")
			TextRisky:SetText("Risqué : 20% success - 100% retour en investissement")
			TextRisky:SetColor(colorText)
			TextRisky:SizeToContents()
			TextRisky:CenterHorizontal()
			TextRisky:CenterVertical(0.70)

			local TextExample = vgui.Create("DLabel", InfoMainPanel)
			TextExample:SetPos(10,10)
			TextExample:SetFont("OpenSans_DDirtyMoney_Small")
			TextExample:SetText("'Plus tu prends de risques, plus tu blanchiras !'")
			TextExample:SetColor(colorText)
			TextExample:SizeToContents()
			TextExample:CenterHorizontal()
			TextExample:CenterVertical(0.95)

	end
	InfoButton.Paint = function(self, w, h)
	    draw.RoundedBox(26, 8, 8, w/1.5, h/1.5, colorButtonInfo)
		draw.SimpleText("i", "OpenSans_DDirtyMoney", w / 2, h / 2, colorText, 1, 1)
	end
	InfoButton:CenterHorizontal(0.975)
	InfoButton:CenterVertical(0.95)






	local TextHeader = vgui.Create("DLabel", Main)
	TextHeader:SetPos(10,10)
	TextHeader:SetFont("OpenSans_DDirtyMoney_Big")
	TextHeader:SetText("Bahamas Worldwide Company")
	TextHeader:SetColor(colorText)
	TextHeader:SizeToContents()
	TextHeader:CenterHorizontal(0.2)
	TextHeader:CenterVertical(0.08)

	local TextHeaderBalance = vgui.Create("DLabel", Main)
	TextHeaderBalance:SetPos(10,10)
	TextHeaderBalance:SetFont("OpenSans_DDirtyMoney_Big")
	TextHeaderBalance:SetText("Balance Account: $"..LocalPlayer():GetNWInt("Dirtymoney"))
	TextHeaderBalance:SetColor(colorText)
	TextHeaderBalance:SizeToContents()
	TextHeaderBalance:CenterHorizontal(0.7)
	TextHeaderBalance:CenterVertical(0.08)




	local TextMain = vgui.Create("DLabel", Main)
	TextMain:SetPos(10,10)
	TextMain:SetFont("OpenSans_DDirtyMoney")
	TextMain:SetText("Entre une somme à faire passer")
	TextMain:SetColor(colorText)
	TextMain:SizeToContents()
	TextMain:CenterHorizontal()
	TextMain:CenterVertical(0.3)

	local TextEntryOne = vgui.Create( "DTextEntry", Main )
	TextEntryOne:SetPos( ScrW()/6, ScrH()/4 )
	TextEntryOne:SetSize( ScrW()/7, ScrH()/27 )
	TextEntryOne:SetPlaceholderText( "Amount of Bad Money to transfer (max: "..LocalPlayer():GetNWInt("Dirtymoney").."$)" )


	local MethodChoose = vgui.Create( "DComboBox", Main )
	MethodChoose:SetPos( ScrW()/3, ScrH()/4 )
	MethodChoose:SetSize( ScrW()/14, ScrH()/27 )
	MethodChoose:SetValue( "BLANCHIR" )
	MethodChoose:AddChoice( "Facile" ) -- index 1
	MethodChoose:AddChoice( "Intermédiaire" ) -- index 2
	MethodChoose:AddChoice( "Risqué" ) -- index 3
	MethodChoose.OnSelect = function( self, index, value )

		if isnumber( tonumber( TextEntryOne:GetValue() ) ) then 

			local textEntryValue = math.Round( tonumber(TextEntryOne:GetValue()) )
			if not textEntryValue or textEntryValue == 0 then return end

			net.Start("DDirtyMoney:StartMinigame")
				net.WriteInt(index, 32)
				net.WriteInt(textEntryValue, 32)
			net.SendToServer()
		else
			notification.AddLegacy( "Please enter a number in the field !", NOTIFY_UNDO, 4  )
			surface.PlaySound( "buttons/button15.wav" )
		end
		

		Main:Remove()
	end

end)


net.Receive("DDirtyMoney:SendNotifications", function()
		local message = net.ReadString()

		notification.AddLegacy( message, NOTIFY_UNDO, 4  )
		surface.PlaySound( "buttons/button15.wav" )
end)





net.Receive("DDirtyMoney:StartMinigame", function()
	local difficulty = net.ReadString()
	local timerValue = net.ReadInt(32)

	LaunchStartMinigameDirtyMoney(difficulty, timerValue)
end)


function LaunchStartMinigameDirtyMoney(difficultyStart, timerValueStart)
	local MGMainPanel


	MGMainPanel = vgui.Create("DFrame")
	MGMainPanel:SetSize(ScrW()/1.8, ScrH()/2)
	MGMainPanel:Center()
	MGMainPanel:SetTitle("")
	MGMainPanel:MakePopup()
	MGMainPanel:ShowCloseButton(false)
	MGMainPanel:SetDraggable(false)
	MGMainPanel.Paint = function(self, w, h)
	    draw.RoundedBox(4, 0, 0, w, h, colorMain) -- main
	    draw.RoundedBox(6, 0, 0, w, h/8, colorHeader) -- Main panel color
	    draw.RoundedBox(0, w/10000, h/8, w, h/530, colorHeaderBar) -- blue bar header
	end


	local CloseButtonMG = vgui.Create("DButton", MGMainPanel)
	CloseButtonMG:SetText("")
	CloseButtonMG:SetPos(ScrW()/1.88, ScrH()/100)
	CloseButtonMG:SetSize(ScrW()/40, ScrH()/25)
	CloseButtonMG:SetColor(Color(0,0,255))
	CloseButtonMG.DoClick = function()
		MGMainPanel:Remove()
		surface.PlaySound( "buttons/button15.wav" )
	end
	CloseButtonMG.Paint = function(self, w, h)
	    draw.RoundedBox(26, 0, 0, w, h, colorHeader)
	    draw.SimpleText("X", "OpenSans_DDirtyMoney_Big", w / 2, h / 2, colorText, 1, 1)
	end
	CloseButtonMG:CenterHorizontal(0.98)
	CloseButtonMG:CenterVertical(0.08)


	local TextHeaderMG = vgui.Create("DLabel", MGMainPanel)
	TextHeaderMG:SetPos(10,10)
	TextHeaderMG:SetFont("OpenSans_DDirtyMoney_Big")
	TextHeaderMG:SetText("Bahamas Worldwide Company")
	TextHeaderMG:SetColor(colorText)
	TextHeaderMG:SizeToContents()
	TextHeaderMG:CenterHorizontal(0.2)
	TextHeaderMG:CenterVertical(0.08)

	local TextHeaderMG = vgui.Create("DLabel", MGMainPanel)
	TextHeaderMG:SetPos(10,10)
	TextHeaderMG:SetFont("OpenSans_DDirtyMoney_Big")
	TextHeaderMG:SetText("Bet: "..LocalPlayer():GetNWInt("BadmoneyToBadBitch").."$")
	TextHeaderMG:SetColor(colorText)
	TextHeaderMG:SizeToContents()
	TextHeaderMG:CenterHorizontal(0.8)
	TextHeaderMG:CenterVertical(0.08)


	local TextHeaderMG = vgui.Create("DLabel", MGMainPanel)
	TextHeaderMG:SetPos(10,10)
	TextHeaderMG:SetFont("OpenSans_DDirtyMoney")
	TextHeaderMG:SetText("Cliques sur les cercles le plus rapidement possible !")
	TextHeaderMG:SetColor(colorText)
	TextHeaderMG:SizeToContents()
	TextHeaderMG:CenterHorizontal(0.5)
	TextHeaderMG:CenterVertical(0.2)

	local TextHeaderMGBis = vgui.Create("DLabel", MGMainPanel)
	TextHeaderMGBis:SetPos(10,10)
	TextHeaderMGBis:SetFont("OpenSans_DDirtyMoney_Small")
	TextHeaderMGBis:SetText("Si tu n'y arrives pas, tu perds tout.")
	TextHeaderMGBis:SetColor(colorText)
	TextHeaderMGBis:SizeToContents()
	TextHeaderMGBis:CenterHorizontal(0.5)
	TextHeaderMGBis:CenterVertical(0.4)

	local TextHeaderMGTris = vgui.Create("DLabel", MGMainPanel)
	TextHeaderMGTris:SetPos(10,10)
	TextHeaderMGTris:SetFont("OpenSans_DDirtyMoney")
	TextHeaderMGTris:SetText("Prêt?")
	TextHeaderMGTris:SetColor(colorText)
	TextHeaderMGTris:SizeToContents()
	TextHeaderMGTris:CenterHorizontal(0.5)
	TextHeaderMGTris:CenterVertical(0.5)

	local MGButtonStart = vgui.Create("DButton", MGMainPanel)
	MGButtonStart:SetText("")
	MGButtonStart:SetPos(ScrW()/1.88, ScrH()/100)
	MGButtonStart:SetSize(ScrW()/10, ScrH()/25)
	MGButtonStart:SetColor(Color(0,0,255))
	MGButtonStart.DoClick = function()
		MGMainPanel:Remove()
		StartMinigameDirtyMoney(difficultyStart, timerValueStart)
	end
	MGButtonStart.Paint = function(self, w, h)
	    draw.RoundedBox(4, 0, 0, w, h, colorHeader)
	    draw.SimpleText("Commencer", "OpenSans_DDirtyMoney_Big", w / 2, h / 2, colorText, 1, 1)
	end
	MGButtonStart:CenterHorizontal(0.5)
	MGButtonStart:CenterVertical(0.7)


	local MGButtonRandomOne = vgui.Create("DButton", MGMainPanel)
	MGButtonRandomOne:SetText("")
	MGButtonRandomOne:SetPos(ScrW()/1.88, ScrH()/100)
	MGButtonRandomOne:SetSize(ScrW()/40, ScrH()/25)
	MGButtonRandomOne:SetColor(Color(0,0,255))
	MGButtonRandomOne.DoClick = function()
		surface.PlaySound( "buttons/button15.wav" )
	end
	MGButtonRandomOne.Paint = function(self, w, h)
	    draw.RoundedBox(26, 0, 0, w, h, colorHeader)
	end
	MGButtonRandomOne:CenterHorizontal(math.Rand(0.5, 0.97))
	MGButtonRandomOne:CenterVertical(math.Rand(0.2, 0.8))

	local MGButtonRandomTwo = vgui.Create("DButton", MGMainPanel)
	MGButtonRandomTwo:SetText("")
	MGButtonRandomTwo:SetPos(ScrW()/1.88, ScrH()/100)
	MGButtonRandomTwo:SetSize(ScrW()/40, ScrH()/25)
	MGButtonRandomTwo:SetColor(Color(0,0,255))
	MGButtonRandomTwo.DoClick = function()
		surface.PlaySound( "buttons/button15.wav" )
	end
	MGButtonRandomTwo.Paint = function(self, w, h)
	    draw.RoundedBox(26, 0, 0, w, h, colorHeader)
	end
	MGButtonRandomTwo:CenterHorizontal(math.Rand(0.02, 0.3))
	MGButtonRandomTwo:CenterVertical(math.Rand(0.2, 0.8))

end








function StartMinigameDirtyMoney(difficulty, timerValue)
	local maxTime = CurTime() + timerValue
	local MGMainPanel,buttonsClicked = nil, 0

	timer.Create("DDirtyMoney:MinigameIsStarted", timerValue, 1, function()
		net.Start("DDirtyMoney:MinigameEnded")
			net.WriteBool(false)
		net.SendToServer()

		MGMainPanel:Remove()
	end)


	MGMainPanel = vgui.Create("DFrame")
	MGMainPanel:SetSize(ScrW()/1.8, ScrH()/2)
	MGMainPanel:Center()
	MGMainPanel:SetTitle("")
	MGMainPanel:MakePopup()
	MGMainPanel:ShowCloseButton(false)
	MGMainPanel:SetDraggable(false)
	MGMainPanel.Paint = function(self, w, h)
	    draw.RoundedBox(4, 0, 0, w, h, colorMain) -- main
	    draw.RoundedBox(6, 0, 0, w, h/8, colorHeader) -- Main panel color
	    draw.RoundedBox(0, w/10000, h/8, w, h/530, colorHeaderBar) -- blue bar header
	end

	local TextHeaderMG = vgui.Create("DLabel", MGMainPanel)
	TextHeaderMG:SetPos(10,10)
	TextHeaderMG:SetFont("OpenSans_DDirtyMoney_Big")
	TextHeaderMG:SetText("Bahamas Worldwide Company")
	TextHeaderMG:SetColor(colorText)
	TextHeaderMG:SizeToContents()
	TextHeaderMG:CenterHorizontal(0.2)
	TextHeaderMG:CenterVertical(0.08)

	local TextHeaderTimerMG = vgui.Create("DLabel", MGMainPanel)
	TextHeaderTimerMG:SetPos(10,10)
	TextHeaderTimerMG:SetFont("OpenSans_DDirtyMoney_Big")
	TextHeaderTimerMG:SetColor(colorText)
	TextHeaderTimerMG:SizeToContents()
	TextHeaderTimerMG:CenterHorizontal(0.7)
	TextHeaderTimerMG:CenterVertical(0.08)
	TextHeaderTimerMG.Think = function()
		local TimeLeftForTimer = timer.TimeLeft("DDirtyMoney:MinigameIsStarted") or 0.1

		TextHeaderTimerMG:SetText("Time Left: "..math.Round(TimeLeftForTimer, 1 ))
		TextHeaderTimerMG:SizeToContents()
	end


	local MGButtonOne = vgui.Create("DButton", MGMainPanel)
	MGButtonOne:SetText("")
	MGButtonOne:SetPos(ScrW()/1.88, ScrH()/100)
	MGButtonOne:SetSize(ScrW()/40, ScrH()/25)
	MGButtonOne:SetColor(Color(0,0,255))
	MGButtonOne.DoClick = function()
		buttonsClicked = buttonsClicked + 1

		if buttonsClicked == 8 then
			net.Start("DDirtyMoney:MinigameEnded")
				net.WriteBool(true)
				net.WriteInt(timerValue, 32)
			net.SendToServer()
			MGMainPanel:Remove()

			timer.Remove("DDirtyMoney:MinigameIsStarted")
		end
		MGButtonOne:Remove()
		surface.PlaySound( "buttons/button3.wav" )
	end
	MGButtonOne.Paint = function(self, w, h)
	    draw.RoundedBox(26, 0, 0, w, h, colorHeader)
	end
	MGButtonOne:CenterHorizontal(math.Rand(0.02, 0.97))
	MGButtonOne:CenterVertical(math.Rand(0.2, 0.8))



	local MGButtonTwo = vgui.Create("DButton", MGMainPanel)
	MGButtonTwo:SetText("")
	MGButtonTwo:SetPos(ScrW()/1.88, ScrH()/100)
	MGButtonTwo:SetSize(ScrW()/40, ScrH()/25)
	MGButtonTwo:SetColor(Color(0,0,255))
	MGButtonTwo.DoClick = function()
		buttonsClicked = buttonsClicked + 1

		if buttonsClicked == 8 then
			net.Start("DDirtyMoney:MinigameEnded")
				net.WriteBool(true)
				net.WriteInt(timerValue, 32)
			net.SendToServer()
			MGMainPanel:Remove()

			timer.Remove("DDirtyMoney:MinigameIsStarted")
		end

		MGButtonTwo:Remove()
		surface.PlaySound( "buttons/button3.wav" )
	end
	MGButtonTwo.Paint = function(self, w, h)
	    draw.RoundedBox(26, 0, 0, w, h, colorHeader)
	end
	MGButtonTwo:CenterHorizontal(math.Rand(0.02, 0.97))
	MGButtonTwo:CenterVertical(math.Rand(0.2, 0.8))



	local MGButtonThree = vgui.Create("DButton", MGMainPanel)
	MGButtonThree:SetText("")
	MGButtonThree:SetPos(ScrW()/1.88, ScrH()/100)
	MGButtonThree:SetSize(ScrW()/40, ScrH()/25)
	MGButtonThree:SetColor(Color(0,0,255))
	MGButtonThree.DoClick = function()
		buttonsClicked = buttonsClicked + 1

		if buttonsClicked == 8 then
			net.Start("DDirtyMoney:MinigameEnded")
				net.WriteBool(true)
				net.WriteInt(timerValue, 32)
			net.SendToServer()
			MGMainPanel:Remove()

			timer.Remove("DDirtyMoney:MinigameIsStarted")
		end

		MGButtonThree:Remove()
		surface.PlaySound( "buttons/button3.wav" )
	end
	MGButtonThree.Paint = function(self, w, h)
	    draw.RoundedBox(26, 0, 0, w, h, colorHeader)
	end
	MGButtonThree:CenterHorizontal(math.Rand(0.02, 0.97))
	MGButtonThree:CenterVertical(math.Rand(0.2, 0.8))



	local MGButtonFour = vgui.Create("DButton", MGMainPanel)
	MGButtonFour:SetText("")
	MGButtonFour:SetPos(ScrW()/1.88, ScrH()/100)
	MGButtonFour:SetSize(ScrW()/40, ScrH()/25)
	MGButtonFour:SetColor(Color(0,0,255))
	MGButtonFour.DoClick = function()
		buttonsClicked = buttonsClicked + 1

		if buttonsClicked == 8 then
			net.Start("DDirtyMoney:MinigameEnded")
				net.WriteBool(true)
				net.WriteInt(timerValue, 32)
			net.SendToServer()
			MGMainPanel:Remove()

			timer.Remove("DDirtyMoney:MinigameIsStarted")
		end

		MGButtonFour:Remove()
		surface.PlaySound( "buttons/button3.wav" )
	end
	MGButtonFour.Paint = function(self, w, h)
	    draw.RoundedBox(26, 0, 0, w, h, colorHeader)
	end
	MGButtonFour:CenterHorizontal(math.Rand(0.02, 0.97))
	MGButtonFour:CenterVertical(math.Rand(0.2, 0.8))



	local MGButtonFive = vgui.Create("DButton", MGMainPanel)
	MGButtonFive:SetText("")
	MGButtonFive:SetPos(ScrW()/1.88, ScrH()/100)
	MGButtonFive:SetSize(ScrW()/40, ScrH()/25)
	MGButtonFive:SetColor(Color(0,0,255))
	MGButtonFive.DoClick = function()
		buttonsClicked = buttonsClicked + 1

		if buttonsClicked == 8 then
			net.Start("DDirtyMoney:MinigameEnded")
				net.WriteBool(true)
				net.WriteInt(timerValue, 32)
			net.SendToServer()
			MGMainPanel:Remove()

			timer.Remove("DDirtyMoney:MinigameIsStarted")
		end

		MGButtonFive:Remove()
		surface.PlaySound( "buttons/button3.wav" )
	end
	MGButtonFive.Paint = function(self, w, h)
	    draw.RoundedBox(26, 0, 0, w, h, colorHeader)
	end
	MGButtonFive:CenterHorizontal(math.Rand(0.02, 0.97))
	MGButtonFive:CenterVertical(math.Rand(0.2, 0.8))



	local MGButtonSix = vgui.Create("DButton", MGMainPanel)
	MGButtonSix:SetText("")
	MGButtonSix:SetPos(ScrW()/1.88, ScrH()/100)
	MGButtonSix:SetSize(ScrW()/40, ScrH()/25)
	MGButtonSix:SetColor(Color(0,0,255))
	MGButtonSix.DoClick = function()
		buttonsClicked = buttonsClicked + 1

		if buttonsClicked == 8 then
			net.Start("DDirtyMoney:MinigameEnded")
				net.WriteBool(true)
				net.WriteInt(timerValue, 32)
			net.SendToServer()
			MGMainPanel:Remove()

			timer.Remove("DDirtyMoney:MinigameIsStarted")
		end

		MGButtonSix:Remove()
		surface.PlaySound( "buttons/button3.wav" )
	end
	MGButtonSix.Paint = function(self, w, h)
	    draw.RoundedBox(26, 0, 0, w, h, colorHeader)
	end
	MGButtonSix:CenterHorizontal(math.Rand(0.02, 0.97))
	MGButtonSix:CenterVertical(math.Rand(0.2, 0.8))



	local MGButtonSeven = vgui.Create("DButton", MGMainPanel)
	MGButtonSeven:SetText("")
	MGButtonSeven:SetPos(ScrW()/1.88, ScrH()/100)
	MGButtonSeven:SetSize(ScrW()/40, ScrH()/25)
	MGButtonSeven:SetColor(Color(0,0,255))
	MGButtonSeven.DoClick = function()
		buttonsClicked = buttonsClicked + 1

		if buttonsClicked == 8 then
			net.Start("DDirtyMoney:MinigameEnded")
				net.WriteBool(true)
				net.WriteInt(timerValue, 32)
			net.SendToServer()
			MGMainPanel:Remove()

			timer.Remove("DDirtyMoney:MinigameIsStarted")
		end

		MGButtonSeven:Remove()
		surface.PlaySound( "buttons/button3.wav" )
	end
	MGButtonSeven.Paint = function(self, w, h)
	    draw.RoundedBox(26, 0, 0, w, h, colorHeader)
	end
	MGButtonSeven:CenterHorizontal(math.Rand(0.02, 0.97))
	MGButtonSeven:CenterVertical(math.Rand(0.2, 0.8))



	local MGButtonHeight = vgui.Create("DButton", MGMainPanel)
	MGButtonHeight:SetText("")
	MGButtonHeight:SetPos(ScrW()/1.88, ScrH()/100)
	MGButtonHeight:SetSize(ScrW()/40, ScrH()/25)
	MGButtonHeight:SetColor(Color(0,0,255))
	MGButtonHeight.DoClick = function()
		buttonsClicked = buttonsClicked + 1

		if buttonsClicked == 8 then
			net.Start("DDirtyMoney:MinigameEnded")
				net.WriteBool(true)
				net.WriteInt(timerValue, 32)
			net.SendToServer()
			MGMainPanel:Remove()

			timer.Remove("DDirtyMoney:MinigameIsStarted")
		end

		MGButtonHeight:Remove()
		surface.PlaySound( "buttons/button3.wav" )
	end
	MGButtonHeight.Paint = function(self, w, h)
	    draw.RoundedBox(26, 0, 0, w, h, colorHeader)
	end
	MGButtonHeight:CenterHorizontal(math.Rand(0.02, 0.97))
	MGButtonHeight:CenterVertical(math.Rand(0.2, 0.8))

end
local steamID,badmoney

net.Receive("DDirtyMoney:Start", function()

	local mainPanel = vgui.Create( "DFrame" )
	mainPanel:SetSize( ScrW()/3.84, ScrH()/2.16 )
	mainPanel:Center()
	mainPanel:MakePopup()

	local AppList = vgui.Create( "DListView", mainPanel )
	AppList:Dock( FILL )
	AppList:SetMultiSelect( false )
	AppList:AddColumn( "Name" )
	AppList:AddColumn( "" ):SetMaxWidth( 0 )
	AppList:AddColumn( "Rank" )
	AppList:AddColumn( "Dirtymoney" )

	for k, v in pairs(player.GetAll()) do
		AppList:AddLine( v:Nick(), v:SteamID64(), v:GetUserGroup(), v:GetNWInt("Dirtymoney") )
	end

	AppList.OnRowSelected = function( lst, index, pnl )
		steamID = pnl:GetColumnText( 2 )

		local bis = vgui.Create( "DFrame" )
		bis:SetSize( ScrW()/8.8, ScrH()/8.4 )
		bis:Center()
		bis:MakePopup()


		local TextEntry = vgui.Create( "DTextEntry", bis )
		TextEntry:SetPos( 30, 50 )
		TextEntry:SetSize( 150, 40 )
		TextEntry:SetText( "" )
		TextEntry:SetPlaceholderText( "Set amount" )
		TextEntry.OnEnter = function( self )

			if not isnumber(tonumber(self:GetValue())) then return end
			net.Start("DDirtyMoney:StartToServer")
				net.WriteString(steamID)
				net.WriteInt( tonumber(self:GetValue()), 32 )
			net.SendToServer()

			bis:Remove()
			mainPanel:Remove()
			
		end
	end

end)
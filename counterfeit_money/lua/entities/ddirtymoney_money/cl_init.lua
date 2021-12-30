AddCSLuaFile( "dirtymoney_config.lua" )
include( "dirtymoney_config.lua" )
include('shared.lua')

function ENT:Draw()  
	self:DrawModel()
end  


net.Receive("DDirtyMoney:UsedBillet", function()
	local bool = net.ReadBool() -- true = not enough money, false = enough money
	local money = net.ReadInt(32)

	if bool then
		notification.AddLegacy( "You don't have enough Dirty Money !", NOTIFY_UNDO, 3  )
	else
		notification.AddLegacy( "You have picked up "..money.."$ of dirty money", NOTIFY_UNDO, 3  )
	end
	surface.PlaySound( "buttons/button15.wav" )
end)
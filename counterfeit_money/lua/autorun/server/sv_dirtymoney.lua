AddCSLuaFile( "dirtymoney_config.lua" ) 
include( "dirtymoney_config.lua" )

util.AddNetworkString("DDirtyMoney:Start")
util.AddNetworkString("DDirtyMoney:StartToServer")

util.AddNetworkString("DDirtyMoney:PoliceChecker")

if not file.Exists("Dirtymoney", "DATA") then
	file.CreateDir( "dirtymoney" ) 
end

local timeAutoSave = DDirtyMoney.TimeAutoSave
if timeAutoSave ~= nil then 
	timer.Create("DDirtyMoney:AutoSave", timeAutoSave, 0, function()
		for k, v in pairs(player.GetAll()) do
			file.Write("dirtymoney/"..v:SteamID64()..".txt", v:GetNWInt("Dirtymoney", 0))
		end
	end)
end

hook.Add("PlayerInitialSpawn", "DDirtyMoney:ResetConnect", function( ply )
	if DDirtyMoney.ResetOnConnect then
		ply:SetNWInt( "Dirtymoney", 0 )
	else
		if file.Exists("dirtymoney/"..ply:SteamID64()..".txt", "DATA") then
			ply:SetNWInt( "Dirtymoney", file.Read("dirtymoney/"..ply:SteamID64()..".txt", "DATA"))
		else
			ply:SetNWInt( "Dirtymoney", 0)
		end
	end
end)

hook.Add("PlayerSpawn", "DDirtyMoney:ResetRespawn", function( ply )
	if DDirtyMoney.ResetOnRespawn then
		ply:SetNWInt( "Dirtymoney", 0 )
	end
end)


hook.Add("PlayerDisconnected", "DDirtyMoney:ResetDisconnect", function( ply )
	if not DDirtyMoney.ResetOnConnect then
		file.Write("dirtymoney/"..ply:SteamID64()..".txt", ply:GetNWInt("Dirtymoney"))
	end
end)

hook.Add("ShutDown", "DDirtyMoney:ResetShutDown", function()
	if not DDirtyMoney.ResetOnConnect then
		for k, v in pairs(player.GetAll()) do
			if v:GetNWInt("Dirtymoney") then return end
			file.Write("dirtymoney/" .. v:SteamID64() .. ".txt", v:GetNWInt("Dirtymoney", 0))
		end
	end
end)







local commandAdmin = DDirtyMoney.AdminCommand
local commandDrop = DDirtyMoney.DropCommand
local allowedUsergroup = DDirtyMoney.AdminRanks

hook.Add( "PlayerSay", "DDirtyMoney:PlayerSay", function( ply, text )
	local playerInput = string.Explode( " ", text )

	if ( playerInput[1] == commandAdmin ) then
		if not allowedUsergroup[ply:GetUserGroup()] then return end
		net.Start("DDirtyMoney:Start")
		net.Send(ply)
		return ""

	elseif playerInput[1] == commandDrop then	
		if not playerInput[2] then return end
		local moneyToDrop = tonumber(playerInput[2])
		local moneyOnPly = tonumber(ply:GetNWInt("Dirtymoney"))

		if moneyToDrop <= moneyOnPly then
			ply:SetNWInt("Dirtymoney", moneyOnPly - moneyToDrop)

			ply:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_DROP)

			timer.Simple(0.8, function()
				local moneyBillet = ents.Create( "ddirtymoney_money" )
				if ( !IsValid( moneyBillet ) ) then return end 
				moneyBillet:SetModel( "models/props/cs_assault/money.mdl" )
				moneyBillet:SetPos( ply:GetPos()+Vector(20,0,0) )
				moneyBillet:Spawn()
				moneyBillet:SetNWInt("MoneyOnMe", moneyToDrop)
			end)
		else
			net.Start("DDirtyMoney:UsedBillet")
				net.WriteBool(true)
				net.WriteInt(1, 32)
			net.Send(ply)
		end
		return ""
	end

end )


net.Receive("DDirtyMoney:StartToServer", function(len, ply)
	local steamID = net.ReadString()
	local amount = net.ReadInt(32)
	if not allowedUsergroup[ply:GetUserGroup()] then return end

	for k, v in pairs( player.GetAll() ) do
		if v:SteamID64() == steamID then
			v:SetNWInt("Dirtymoney", amount)
		end
	end

end)



function DirtyMoneyGetValue(ply)
	local value = ply:GetNWInt("Dirtymoney")
	return value
end
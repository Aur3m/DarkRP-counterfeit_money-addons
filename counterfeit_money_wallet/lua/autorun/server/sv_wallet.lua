-------------------------------------------------------------------
--	Author		= SlownLS, 
--  Edit		= enzoFR60
--  Edit efficace = Deadman, Bordel qu'est-ce qu'il est pas opti ce script ! même pas responsive !
--	Addon 		= Wallet
-------------------------------------------------------------------
if SERVER then

include("autorun/sh_config.lua")

--[[-------------------------------------------------------------------------
	Initialize Network
---------------------------------------------------------------------------]]

util.AddNetworkString( "Wallet:Player:OpenMenu" )
util.AddNetworkString( "Wallet:Player:DropMoney" )
util.AddNetworkString( "Wallet:Player:GiveMoney" )
util.AddNetworkString( "Wallet:Player:GiveDirtyMoney" )
util.AddNetworkString( "Wallet:Player:DropDirtyMoney" )

--[[-------------------------------------------------------------------------
	Remove Money Commands
---------------------------------------------------------------------------]]

hook.Add( "PostGamemodeLoaded", "Wallet:removeChatCommand", function()
	DarkRP.removeChatCommand( "dropmoney" )	
	DarkRP.removeChatCommand( "moneydrop" )	
	DarkRP.removeChatCommand( "give" )	
end)

--[[-------------------------------------------------------------------------
	Player Drop Money
---------------------------------------------------------------------------]]

net.Receive( "Wallet:Player:DropMoney", function( length, ply )
	local Montant = math.floor( net.ReadInt( 32 ) )

    if Montant == "" then
        DarkRP.notify( ply, 1, 4, DarkRP.getPhrase( "invalid_x", "argument", "" ) )
        return 
    end

    if not tonumber( Montant ) then
        DarkRP.notify( ply, 1, 4, DarkRP.getPhrase( "invalid_x", "argument", "" ) )
        return
    end

    if Montant < 1 then
        DarkRP.notify( ply, 1, 4, DarkRP.getPhrase( "invalid_x", "argument", ">0" ) )
        return
    end

    if Montant >= 2147483647 then
        DarkRP.notify( ply, 1, 4, DarkRP.getPhrase( "invalid_x", "argument", "<2,147,483,647" ) )
        return
    end

    if not ply:canAfford( Montant ) then
        DarkRP.notify( ply, 1, 4, DarkRP.getPhrase( "cant_afford", "" ) )
        return 
    end

    ply:addMoney( - Montant )

    local RP = RecipientFilter()
    RP:AddAllPlayers()

    umsg.Start( "anim_dropitem", RP )
    umsg.Entity( ply )
    umsg.End()

    ply.anim_DroppingItem = true

    timer.Simple( 1, function()
        if not IsValid(ply) then return end

        local trace = {}
        trace.start = ply:EyePos()
        trace.endpos = trace.start + ply:GetAimVector() * 85
        trace.filter = ply

        local tr = util.TraceLine( trace )
        local moneybag = DarkRP.createMoneyBag( tr.HitPos, Montant )
        hook.Call( "playerDroppedMoney", nil, ply, Montant, moneybag )
        DarkRP.log( ply:Nick() .. " (" .. ply:SteamID() .. ") ".. Wallet.LanguageDropMoneyLogs.. " " .. DarkRP.formatMoney( Montant ) )
    end)
end)

--[[-------------------------------------------------------------------------
	Player Give Money
---------------------------------------------------------------------------]]

net.Receive( "Wallet:Player:GiveMoney", function( length, ply )
	local Montant = math.floor( net.ReadInt( 32 ) )

    if Montant == "" then
        DarkRP.notify( ply, 1, 4, DarkRP.getPhrase( "invalid_x", "argument", "" ) )
        return 
    end

    if not tonumber( Montant ) then
        DarkRP.notify( ply, 1, 4, DarkRP.getPhrase( "invalid_x", "argument", "" ) )
        return
    end

    local trace = ply:GetEyeTrace()

    if not IsValid( trace.Entity ) || not trace.Entity:IsPlayer() || trace.Entity:GetPos():DistToSqr( ply:GetPos() ) >= 22500 then
        DarkRP.notify( ply, 1, 4, DarkRP.getPhrase( "must_be_looking_at", "player" ) )
        return 
    end

    if Montant < 1 then
        DarkRP.notify( ply, 1, 4, DarkRP.getPhrase( "invalid_x", "argument", ">=1" ) )
        return
    end

    if not ply:canAfford( Montant ) then
        DarkRP.notify( ply, 1, 4, DarkRP.getPhrase( "cant_afford", "" ) )
        return 
    end

    local RP = RecipientFilter()
    RP:AddAllPlayers()

    umsg.Start( "anim_giveitem", RP )
    umsg.Entity( ply )
    umsg.End()

    ply.anim_GivingItem = true

    timer.Simple( 1.2, function()
        if not IsValid( ply ) then
            DarkRP.notify( ply, 1, 4, DarkRP.getPhrase( "unable", "/give", "" ) )
            return
        end

	    if not ply:canAfford( Montant ) then
	        DarkRP.notify( ply, 1, 4, DarkRP.getPhrase( "cant_afford", "" ) )
	        return 
	    end

        local trace2 = ply:GetEyeTrace()
        if not IsValid( trace2.Entity ) || not trace2.Entity:IsPlayer() || trace2.Entity:GetPos():DistToSqr( ply:GetPos() ) >= 22500 then return end

        DarkRP.payPlayer( ply, trace2.Entity, Montant )

        hook.Call( "playerGaveMoney", nil, ply, trace2.Entity, Montant )

        DarkRP.notify( trace2.Entity, 0, 4, DarkRP.getPhrase( "has_given", ply:Nick(), DarkRP.formatMoney( Montant ) ) )
        DarkRP.notify( ply, 0, 4, DarkRP.getPhrase( "you_gave", trace2.Entity:Nick(), DarkRP.formatMoney( Montant ) ) )
        DarkRP.log( ply:Nick() .. " (" .. ply:SteamID() .. ") "..Wallet.LanguageGiveMoneyLogs.." " .. DarkRP.formatMoney( Montant ) .. Wallet.LanguageAtLogs .. trace2.Entity:Nick() .. " (" .. trace2.Entity:SteamID() .. ")" )
		DarkRP.log( trace2.Entity:Nick() .. " (" .. trace2.Entity:SteamID() .. ") " ..Wallet.LanguageReceivedLogs.. " " .. DarkRP.formatMoney( Montant ) .. Wallet.LanguageOfLogs .. ply:Nick() .. " (" .. ply:SteamID() .. ")" )
	end)
end)

end




-- Deadman Edit: i have to adapt this for this shit addon, otherwise i would havecreate only 1 net message for money

net.Receive("Wallet:Player:GiveDirtyMoney", function(len, ply)
    local amount = net.ReadInt(32)
    if ply:GetNWInt("Dirtymoney") < amount then
        DarkRP.notify( ply, 0, 4, "Vous n'avez pas assez d'argent sale !")
        return
    end

    local traceEnt = ply:GetEyeTrace().Entity
    if traceEnt:IsPlayer() and traceEnt:Alive() then
        ply:SetNWInt("Dirtymoney", ply:GetNWInt("Dirtymoney") - amount)
        traceEnt:SetNWInt("Dirtymoney", traceEnt:GetNWInt("Dirtymoney") + amount)
        DarkRP.notify( ply, 0, 4, "Vous avez donner "..amount.." $ à quelqu'un")
    else
        DarkRP.notify( ply, 0, 4, "Vous devez regarder quelqu'un !")
    end
end)

net.Receive("Wallet:Player:DropDirtyMoney", function(len, ply)
    local amount = tonumber(net.ReadInt(32))
    if tonumber(ply:GetNWInt("Dirtymoney")) < amount then
        DarkRP.notify( ply, 0, 4, "Vous n'avez pas assez d'argent sale !")
        return
    end

    ply:ConCommand( "say "..Wallet.DropDirtyCommand.." "..amount )
    DarkRP.notify( ply, 0, 4, "Vous avez jeter "..amount.." $ d'argent sale")
end)
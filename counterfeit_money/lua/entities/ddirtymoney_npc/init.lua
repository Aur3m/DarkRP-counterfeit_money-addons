AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "dirtymoney_config.lua" )
include( "dirtymoney_config.lua" )
include('shared.lua')

local percentage = DDirtyMoney.Percentage

util.AddNetworkString("DDirtyMoney:StartNPC")

function ENT:Initialize()
	self.Entity:SetModel("models/gman_high.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self:SetUseType( SIMPLE_USE )
	
	local phys = self:GetPhysicsObject()
	local pos = self:GetPos()
	if phys:IsValid() then
		phys:Wake()
	end
end


function ENT:Use( activator, caller, usetype, value )
	if (activator == caller) and (activator:IsPlayer()) and (activator:IsValid()) and activator:Alive() then
		local badMoney = activator:GetNWInt("Dirtymoney")
		local goodMoney = activator:getDarkRPVar("money")
		local moneyToGive = math.Round(badMoney*percentage)


		net.Start("DDirtyMoney:StartNPC")
			net.WriteInt(moneyToGive, 32)
		net.Send(caller)

	end
end

net.Receive("DDirtyMoney:StartNPC", function(len, ply)
		local badMoney = ply:GetNWInt("Dirtymoney")
		local goodMoney = ply:getDarkRPVar("money")
		local moneyToGive

		moneyToGive = math.Round(badMoney*percentage)
		ply:addMoney(moneyToGive)
		ply:SetNWInt("Dirtymoney", 0)
end)
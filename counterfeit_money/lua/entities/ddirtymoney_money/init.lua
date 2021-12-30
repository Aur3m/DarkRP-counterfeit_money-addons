AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "dirtymoney_config.lua" )
include( "dirtymoney_config.lua" )
include('shared.lua')

util.AddNetworkString("DDirtyMoney:UsedBillet")

function ENT:Initialize()
	self.Entity:SetModel("models/props/cs_assault/money.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self:SetUseType( SIMPLE_USE )

	self.nodupe = true
	
	local phys = self:GetPhysicsObject()
	local pos = self:GetPos()
	if phys:IsValid() then
		phys:Wake()
	end
end


function ENT:Use( activator, caller, usetype, value )
	if (activator == caller) and (activator:IsPlayer()) and (activator:IsValid()) and activator:Alive() then
		local moneyOnBillet = self:GetNWInt("MoneyOnMe")
		activator:SetNWInt("Dirtymoney", activator:GetNWInt("Dirtymoney") + moneyOnBillet)

		net.Start("DDirtyMoney:UsedBillet")
			net.WriteBool(false)
			net.WriteInt(moneyOnBillet, 32)
		net.Send(activator)

		self:Remove()
	end
end
SWEP.Author			= "Deadman"
SWEP.Instructions	= "Left click on a player to get his illegal money\nRight click to force it to drop"
SWEP.Purpose 		= "Left click on a player to get his illegal money\nRight click to force it to drop"

SWEP.Spawnable			= true
SWEP.AdminOnly			= false
SWEP.UseHands			= true
SWEP.Category 			= "Deadman Dirty Money"

SWEP.ViewModel			= ""
SWEP.WorldModel			= ""

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.PrintName			= "Police Checker"
SWEP.Slot				= 2
SWEP.SlotPos			= 10
SWEP.DrawAmmo			= false


SWEP.Base = "weapon_base"


function SWEP:Initialize()
	self:SetHoldType( "normal" );
end

function SWEP:Reload()
end

function SWEP:DrawHUD()
end


if SERVER then
	local cooldown = 0

	function SWEP:PrimaryAttack()
		if cooldown + 2 > CurTime() then return end
		cooldown = CurTime()
		local __ent = self.Owner:GetEyeTrace().Entity
		local ownerPos = self.Owner:GetPos()
		if ownerPos:Distance(__ent:GetPos()) > 200 then return end

		if __ent:IsValid() and __ent:IsPlayer() and __ent:Alive() then

			net.Start("DDirtyMoney:PoliceChecker")
				net.WriteBool(false)
				net.WriteBool(true)
				net.WriteInt(__ent:GetNWInt("Dirtymoney"), 32)
				net.WriteInt(__ent:getDarkRPVar("money"), 32)
			net.Send(self.Owner)
		end
	end

	local isUsed = false

	function SWEP:SecondaryAttack()
		if cooldown + 2 > CurTime() then return end 
		cooldown = CurTime()
		if isUsed then return end

		local __ent = self.Owner:GetEyeTrace().Entity
		local ownerPos = self.Owner:GetPos()
		if ownerPos:Distance(__ent:GetPos()) > 200 then return end
		if __ent:IsValid() and __ent:IsPlayer() and __ent:Alive() then
			local moneyOnPly = tonumber(__ent:GetNWInt("Dirtymoney"))

			if moneyOnPly <= 0 then return end
			isUsed = true
			__ent:SetNWInt("Dirtymoney", 0)
			__ent:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_DROP)

			net.Start("DDirtyMoney:PoliceChecker")
				net.WriteBool(true)
			net.Send(__ent)


			net.Start("DDirtyMoney:PoliceChecker")
				net.WriteBool(false)
				net.WriteBool(false)
				net.WriteInt(__ent:GetNWInt("Dirtymoney"), 32)
				net.WriteInt(__ent:getDarkRPVar("money"), 32)
			net.Send(self.Owner)

			timer.Simple(0.8, function()
				local moneyBillet = ents.Create( "ddirtymoney_money" )
				if ( !IsValid( moneyBillet ) ) then return end 
				moneyBillet:SetModel( "models/props/cs_assault/money.mdl" )
				moneyBillet:SetPos( __ent:GetPos()+Vector(20,0,0) )
				moneyBillet:Spawn()
				moneyBillet:SetNWInt("MoneyOnMe", moneyOnPly)

				isUsed = false
			end)
		end
	end
end



if CLIENT then
	net.Receive("DDirtyMoney:PoliceChecker", function()
		local bool = net.ReadBool()

		if bool then -- Player who will loose money
			notification.AddLegacy( "Someone force you to drop your Dirty Money !", NOTIFY_UNDO, 3  )
		else -- the Cop
			bool = net.ReadBool()
			if bool then
				local dirtyMoneyOnVictim = net.ReadInt(32)
				local goodMoneyOnVictim = net.ReadInt(32)
				notification.AddLegacy( "This player have "..dirtyMoneyOnVictim.."$ of illegal money", NOTIFY_UNDO, 3  )
				notification.AddLegacy( "This player have "..goodMoneyOnVictim.."$ of legal money", NOTIFY_UNDO, 3  )
			else
				notification.AddLegacy( "You have forced a player to drop his Dirty Money", NOTIFY_UNDO, 3  )
			end
		end
	end)
end

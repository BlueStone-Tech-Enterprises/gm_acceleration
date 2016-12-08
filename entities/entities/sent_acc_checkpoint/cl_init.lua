--[[--------------------------------------------------------------------------------------
 _______                     ______                      _____ _____                
 ___    |___________________ ___  /_____ ______________ ___  /____(_)______ _______ 
 __  /| |_  ___/_  ___/_  _ \__  / _  _ \__  ___/_  __ `/_  __/__  / _  __ \__  __ \
 _  ___ |/ /__  / /__  /  __/_  /  /  __/_  /    / /_/ / / /_  _  /  / /_/ /_  / / /
 /_/  |_|\___/  \___/  \___/ /_/   \___/ /_/     \__,_/  \__/  /_/   \____/ /_/ /_/ 
 
 
	By Aritz Beobide-Cardinal (ARitz Cracker) && James R Swift (James xX)
 
--------------------------------------------------------------------------------------]]--

include('shared.lua')

function ENT:Initialize()

	local effectdata = EffectData()
	effectdata:SetEntity( self )

	util.Effect( "acc_checkpoint_pulse", effectdata )
	util.Effect( "acc_checkpoint_lightribbon", effectdata )

end

function ENT:GetSlave( )
	return self:GetNWBool( "IsSlave", false )
end

function ENT:GetCounterpart( )
	return self:GetNWEntity( "Counterpart", NULL )
end

function ENT:GetCheckpointID( )
	return self:GetNWInt( "CheckpointID", -1 )
end

function ENT:Think()

end

function ENT:Draw()

	self:DrawModel()
	local ang = (LocalPlayer():GetPos()-self:GetPos()):Angle()
	render.DrawLine( self:GetPos(), self:GetPos() + ang:Forward()*10, color_white, false ) 
	render.DrawLine( self:GetPos(), self:GetPos() + self:LocalToWorldAngles( Angle(0,90,0) ):Forward()*10, color_blue, false ) 
	render.DrawLine( self:GetPos(), self:GetPos() + self:GetAngles():Forward()*10, color_red, false ) 
	
end

function ENT:OnRemove()

end

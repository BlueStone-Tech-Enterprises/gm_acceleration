
TOOL.Category = "Acceleration"
TOOL.Name = "#tool.assembler.name"

--TOOL.ClientConVar[ "snappos" ] = "20"
--GetConVar( string name ) 

TOOL.Information = {
	{ name = "left", stage = 0 },
	{ name = "right", stage = 0 },
	{ name = "reload" }
}
TOOL.ClassWhitelist = {prop_physics=true,sent_arc_wheel=true,prop_vehicle_prisoner_pod=true}

Car.LifterCarMaxs = Vector(280/2,190/2,100)
Car.LifterCarMins = Vector(280/-2,190/-2,-20)

Car.LifterFlyMaxs = Vector(380/2,285/2,140)
Car.LifterFlyMins = Vector(380/-2,285/-2,-20)

function TOOL:DoThing(ent,add)
	local ps = Car.GetPitstop(self:GetOwner())
	local lifter
	if IsValid(ps) then
		lifter = ps:GetLifter()
	end
	if ( not IsValid( ent ) or ent == lifter ) then return false end
	--Car.Msgs.PitstopMsgs.NoBuild
	
	if not IsValid(lifter) then
		if CLIENT and IsFirstTimePredicted() then
			notification.AddLegacy(Car.Msgs.PitstopMsgs.NoBuild,NOTIFY_ERROR,5) 
			LocalPlayer():EmitSound("buttons/button8.wav" )
		end
		return false
	end
	if self.ClassWhitelist[ent:GetClass()] then
		Car.BuildChanges = true
		if CLIENT then return true end
	
		if add then

			if Car.WithinLifter(lifter,ent) then
				ent:SetParent( lifter )
				ent:SetCollisionGroup( COLLISION_GROUP_WORLD )
			else
				ARCLib.NotifyPlayer(self:GetOwner(),Car.Msgs.tool.assembler.ent_within,NOTIFY_ERROR,5,true)
				return false
			end
		elseif ent:GetParent() == lifter then
			ent:SetParent()
			ent:SetCollisionGroup( COLLISION_GROUP_NONE ) 
		end
	else
		if CLIENT and IsFirstTimePredicted() then
			notification.AddLegacy(Car.Msgs.tool.assembler.ent_invalid,NOTIFY_ERROR,5) 
			LocalPlayer():EmitSound("buttons/button8.wav" )
		end
		return false
	end
	return true
end

function TOOL:LeftClick( trace )
	local ent = trace.Entity
	return self:DoThing(trace.Entity,true)
end

function TOOL:RightClick( trace )
	local ent = trace.Entity
	return self:DoThing(trace.Entity,false)
end

function TOOL:Think()

end

function TOOL:Reload( trace )
	local ps = Car.GetPitstop(self:GetOwner())
	local lifter
	if IsValid(ps) then
		lifter = ps:GetLifter()
	end
	if ( not IsValid( lifter )) then return false end
	for k,v in ipairs(lifter:GetChildren()) do
		v:SetParent()
		v:SetCollisionGroup( COLLISION_GROUP_NONE ) 
	end
	return false
end


function TOOL:Holster()

end

function TOOL:Deploy()

end

function TOOL.BuildCPanel( CPanel )
	CPanel:AddControl( "Header", { Description = "#tool.assembler.help" } )
end

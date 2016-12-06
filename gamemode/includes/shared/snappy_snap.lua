--[[--------------------------------------------------------------------------------------
 _______                     ______                      _____ _____                
 ___    |___________________ ___  /_____ ______________ ___  /____(_)______ _______ 
 __  /| |_  ___/_  ___/_  _ \__  / _  _ \__  ___/_  __ `/_  __/__  / _  __ \__  __ \
 _  ___ |/ /__  / /__  /  __/_  /  /  __/_  /    / /_/ / / /_  _  /  / /_/ /_  / / /
 /_/  |_|\___/  \___/  \___/ /_/   \___/ /_/     \__,_/  \__/  /_/   \____/ /_/ /_/ 
 
 
	By Aritz Beobide-Cardinal (ARitz Cracker) && James R Swift (James xX)
 
--------------------------------------------------------------------------------------]]--

function Car.SnappySnap(snapEnt,referenceEnt,snapPos,snapAng,positionEnt,useX,useY,useZ)
	local entpos = referenceEnt:LocalToWorld(referenceEnt:OBBCenter())
	local entang = referenceEnt:GetAngles()

	local a = Vector(math.Round(entpos.x/snapPos)*snapPos,math.Round(entpos.y/snapPos)*snapPos,math.Round(entpos.z/snapPos)*snapPos)
	if IsValid(positionEnt) then
		positionEntPos = positionEnt:LocalToWorld(positionEnt:OBBCenter())
		if useX then
			a.x = positionEntPos.x
		end
		if useY then
			a.y = positionEntPos.y
		end
		if useZ then
			a.z = positionEntPos.z
		end
	end
	snapEnt:SetAngles(Angle(math.Round(entang.p/snapAng)*snapAng,math.Round(entang.y/snapAng)*snapAng,math.Round(entang.r/snapAng)*snapAng))
	snapEnt:SetPos(a)
	snapEnt:SetPos(snapEnt:LocalToWorld(referenceEnt:OBBCenter()*-1))
end

if not CLIENT then return end
local clientsideProp
local function CreateGhostProp(ent)
	clientsideProp = ClientsideModel(ent:GetModel(), RENDERMODE_TRANSALPHA)
	clientsideProp:SetPos(vector_origin)
	clientsideProp:SetAngles(angle_zero)
	clientsideProp:SetNoDraw(false)
	clientsideProp:SetSkin(ent:GetSkin())
	local mats = ent:GetMaterials()
	local mat = ent:GetMaterial() 
	if mat == "" then
		for i=1,#mats do
			clientsideProp:SetSubMaterial( i-1, mats[i] ) 
		end
	else
		clientsideProp:SetMaterial( mat ) 
	end
	local col = ent:GetColor()
	col.a = col.a * 0.5
	clientsideProp:SetColor( col ) 
	clientsideProp:SetRenderMode( RENDERMODE_TRANSALPHA )
end

hook.Add("Think","Acceleration Snappy",function()
	local ent = LocalPlayer():GetEyeTrace().Entity
	local sanpVar = GetConVar( "snappy_snappos" )
	local sanpAng = GetConVar( "snappy_snapang" )
	local sanpPersist = GetConVar( "snappy_persist" )
	local sanpEnt = GetConVar( "snappy_entity" )
	local sanpX = GetConVar( "snappy_usex" )
	local sanpY = GetConVar( "snappy_usey" )
	local sanpZ = GetConVar( "snappy_usez" )
	--MsgN(sanpPersist:GetBool())
	if (sanpVar and sanpAng and sanpPersist) and ( Car.HoldingSnapTool or sanpPersist:GetBool()) then
		if IsValid(clientsideProp) then
			if IsValid(ent) and ent:GetModel() == clientsideProp:GetModel() then
				Car.SnappySnap(clientsideProp,ent,sanpVar:GetFloat(),sanpAng:GetFloat(),Entity(sanpEnt:GetInt()),sanpX:GetBool(),sanpY:GetBool(),sanpZ:GetBool())
			else
				clientsideProp:Remove()
			end
		elseif IsValid(ent) then
			CreateGhostProp(ent)
		end
	elseif IsValid(clientsideProp) then
		clientsideProp:Remove()
	end
end)
--[[--------------------------------------------------------------------------------------
 _______                     ______                      _____ _____                
 ___    |___________________ ___  /_____ ______________ ___  /____(_)______ _______ 
 __  /| |_  ___/_  ___/_  _ \__  / _  _ \__  ___/_  __ `/_  __/__  / _  __ \__  __ \
 _  ___ |/ /__  / /__  /  __/_  /  /  __/_  /    / /_/ / / /_  _  /  / /_/ /_  / / /
 /_/  |_|\___/  \___/  \___/ /_/   \___/ /_/     \__,_/  \__/  /_/   \____/ /_/ /_/ 
 
 
	By Aritz Beobide-Cardinal (ARitz Cracker) && James R Swift (James xX)
 
--------------------------------------------------------------------------------------]]--

include('shared.lua')

local screenPos = Vector(6.1,-28,35.3)
local screenAng = Angle(0,90,90)
local screenResX = 656
local screenResY = 384
local screenResXHalf = screenResX/2
local screenResYHalf = screenResY/2
function ENT:Initialize()

end

function ENT:Think()

end

function ENT:Draw()
	self:DrawModel()
end

function ENT:OnRemove()

end

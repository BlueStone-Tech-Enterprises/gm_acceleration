--[[--------------------------------------------------------------------------------------
 _______                     ______                      _____ _____                
 ___    |___________________ ___  /_____ ______________ ___  /____(_)______ _______ 
 __  /| |_  ___/_  ___/_  _ \__  / _  _ \__  ___/_  __ `/_  __/__  / _  __ \__  __ \
 _  ___ |/ /__  / /__  /  __/_  /  /  __/_  /    / /_/ / / /_  _  /  / /_/ /_  / / /
 /_/  |_|\___/  \___/  \___/ /_/   \___/ /_/     \__,_/  \__/  /_/   \____/ /_/ /_/ 
 
 
	By Aritz Beobide-Cardinal (ARitz Cracker) && James R Swift (James xX)
 
--------------------------------------------------------------------------------------]]--

local tab = {

	--1
	{
		{['Position'] = Vector( 0, 0, -83 - 64 ), ['Angle'] = Angle(0, -90, 0)},
		{['Position'] = Vector( 0, 200, -83 - 64 ), ['Angle'] = Angle(0, 90, 0)}
	}


}

function __TEMP__createGMConstructFile( )

	file.Write( "acceleration/checkpoint/gm_construct.txt", util.TableToJSON(tab))

end
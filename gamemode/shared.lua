DeriveGamemode( "sandbox" )
GM.Name = "Acceleration"
GM.Author = "BlueStone Technological Enterprises Inc."
GM.Email = "info@bste.ca"
GM.Website = "www.bste.ca"
GM.Update = "November 25th 2016"
GM.Version = "0.0.1"

GM.TeamBased = true


Car = Car or {}

function GM:Initialize()

end 

function GM:CreateTeams()
	
	TEAM_RACER = 1
	team.SetUp( TEAM_RACER, "Racer", Color( 255, 197, 0 ) )
	team.SetSpawnPoint( TEAM_RACER, "info_player_start" )
	
	--[[
	TEAM_RED = 2
	team.SetUp( TEAM_RED, "Red Team", Color( 255, 0, 0 ) )
	team.SetSpawnPoint( TEAM_RED, "info_player_start" )
	]]
	team.SetSpawnPoint( TEAM_SPECTATOR, "info_player_start" ) 

end

function Car.Msg(msg)
	Msg("Car: "..tostring(msg).."\n")
end


Car.Msg("Running...\n _______                     ______                      _____ _____                \n ___    |___________________ ___  /_____ ______________ ___  /____(_)______ _______ \n __  /| |_  ___/_  ___/_  _ \\__  / _  _ \\__  ___/_  __ `/_  __/__  / _  __ \\__  __ \\\n _  ___ |/ /__  / /__  /  __/_  /  /  __/_  /    / /_/ / / /_  _  /  / /_/ /_  / / /\n /_/  |_|\\___/  \\___/  \\___/ /_/   \\___/ /_/     \\__,_/  \\__/  /_/   \\____/ /_/ /_/ \n")
Car.Msg(table.Random({"Go faster, baby!","James is my gay best friend","VROOM VROOM","Everything is not what it seems"}))
Car.Msg("By Aritz Beobide-Cardinal (ARitz Cracker) && James R Swift (James xX)")
Car.Update = GM.Update
Car.Version = GM.Version
Car.Msg("Version: "..Car.Version)
Car.Msg("Updated on: "..Car.Update)
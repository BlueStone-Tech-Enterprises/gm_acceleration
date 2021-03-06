--[[--------------------------------------------------------------------------------------
 _______                     ______                      _____ _____                
 ___    |___________________ ___  /_____ ______________ ___  /____(_)______ _______ 
 __  /| |_  ___/_  ___/_  _ \__  / _  _ \__  ___/_  __ `/_  __/__  / _  __ \__  __ \
 _  ___ |/ /__  / /__  /  __/_  /  /  __/_  /    / /_/ / / /_  _  /  / /_/ /_  / / /
 /_/  |_|\___/  \___/  \___/ /_/   \___/ /_/     \__,_/  \__/  /_/   \____/ /_/ /_/ 
 
 
	By Aritz Beobide-Cardinal (ARitz Cracker) && James R Swift (James xX)
 
--------------------------------------------------------------------------------------]]--

Car.CheckpointEntityName = "sent_acc_checkpoint"
Car.CheckpointDataFolderName = Car.Dir .. "checkpoint/"

Car.Checkpoints = { }

function Car.LoadCheckpointConfiguration( )

	local configFile = file.Read( Car.CheckpointDataFolderName .. game.GetMap() .. ".txt" )
	if ( configFile ) then
		return util.JSONToTable( configFile ) or false
	end
	
	return false
	
end

function Car.SaveCheckpointConfiguration( data )
	file.Write( Car.CheckpointDataFolderName .. game.GetMap() .. ".txt", util.TableToJSON(data))
end

function Car.Checkpoints.GetTable()
	local tab = {}
	for k,v in ipairs(ents.FindByClass("sent_acc_checkpoint")) do
		local i = v.CheckpointID
		if i > 0 then
			if not tab[i] then
				tab[i] = {}
			end
			local ii = 1
			if v.IsSlave then
				ii = 2
			end
			tab[i][ii] = v
			--v:SetSlave( false )
		end
	end
	if not table.IsSequential(tab) then
		return Car.Msgs.tool.checkpoint.InvalidOrder
	end
	local aOK = true
	--CarFrozenEnt
	for k,v in ipairs(tab) do
		if not (v[1] and v[2]) then
			aOK = false
			break
		end
	end
	if not aOK then
		return Car.Msgs.tool.checkpoint.InvalidPair
	end
	
	for k,v in ipairs(tab) do
		v[1].CarFrozenEnt = true
		v[2].CarFrozenEnt = true
	end
	return tab
end

function Car.InitializeCheckpoints( )

	-- Count number of checkpoints to see if map has racetrack by default
	local _checkpoints = ents.FindByClass( Car.CheckpointEntityName )
	if ( #_checkpoints > 0 ) then
		Car.Msg( "Initialized checkpoints, map supports gamemode by default" )
		
		for k, eCheckpoint in pairs( _checkpoints ) do
			local ID = eCheckpoint.CheckpointID
			if ( not Car.Checkpoints[ ID ] ) then Car.Checkpoints[ID] = { } end
			Car.Checkpoints[ ID ][ eCheckpoint.IsSlave and 2 or 1 ] = eCheckpoint
		end
		
		return true
	end
	
	-- Load configuration file
	local configuration = Car.LoadCheckpointConfiguration( )
	if ( not configuration ) then
		Car.Msg( "Failed to initialized checkpoints, No map support or custom support" )
		return false
	end
	
	for checkpointID, pairTable in pairs( configuration ) do
	
		local MasterCheckpoint = ents.Create( Car.CheckpointEntityName )
		MasterCheckpoint:SetPos( pairTable[1].Position )
		MasterCheckpoint:SetAngles( pairTable[1].Angle )
		MasterCheckpoint:SetCheckpointID( checkpointID )
		MasterCheckpoint:SetSlave( false )
		
		local SlaveCheckpoint = ents.Create( Car.CheckpointEntityName )
		SlaveCheckpoint:SetPos( pairTable[2].Position )
		SlaveCheckpoint:SetAngles( pairTable[2].Angle )
		SlaveCheckpoint:SetCheckpointID( checkpointID )
		SlaveCheckpoint:SetSlave( true )
		
		MasterCheckpoint:Spawn( )
		SlaveCheckpoint:Spawn( )
		
		MasterCheckpoint:Activate( )
		SlaveCheckpoint:Activate( )
		
		MasterCheckpoint:SetCounterpart( SlaveCheckpoint )
		SlaveCheckpoint:SetCounterpart( MasterCheckpoint )
		
		Car.Checkpoints[checkpointID] = { MasterCheckpoint, SlaveCheckpoint}
	end
	
	hook.Run( "AccelerationCheckpointsLoaded", Car.Checkpoints )

end

function Car.GetNumberOfCheckpoints( )

	return #ents.FindByClass( Car.CheckpointEntityName ) / 2
	
end

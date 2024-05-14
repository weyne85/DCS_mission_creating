---
-- Simple Recovery tanker script demonstrating the use of the RECOVERYTANKER.uncontrolledac method.
-- or RECOVERYTANKER:SetUseUncontrolledAircraft(). Both are shown below.
-- You will require an AI skill S-3B tanker group placed in the mission editor,
-- Set to "Takeoff from Ramp" and ensure "Uncontrolled" is ticked.
-- Ensure "Late activation" is not ticked.
--
-- 2 S-3B Tankers will be spawned on the USS Stennis as a visible objects (not late activation) but without crew.
-- After 30 seconds, the first S-3B will start up go on station overhead at angels 6 with 274 knots TAS (~250 KIAS).
-- After 1 minute, the second S-3B will start up and go on station overhead at angels 12 with 300 knots TAS (~250 KIAS)
-- Radio frequencies, callsign are set below and overrule the settings of the AI group.
--
--
-- tankerStennis2:Start()
-- The above without "--" is loaded to the Mission editor trigger "Do Script" action after 60 seconds condition.
-- NOTE: Delay to show Aircraft visible on deck then starts later (60 seconds after mission start)..
---



-- No MOOSE settings menu. Comment out this line if required.
_SETTINGS:SetPlayerMenuOff()

-- E-2D AWACS spawning on Stennis.
local awacs=RECOVERYTANKER:New("USS Stennis", "E-2D Wizard Group")
awacs:SetAWACS()
awacs:SetRadio(260)
awacs:SetAltitude(20000)
awacs:SetCallsign(CALLSIGN.AWACS.Wizard)
awacs:SetRacetrackDistances(30, 15)
awacs:SetModex(611)
awacs:SetTACAN(2, "WIZ")
awacs:__Start(1)

-- Rescue Helo with home base Lake Erie. Has to be a global object!
local rescuehelo=RESCUEHELO:New("USS Stennis", "Rescue Helo")
rescuehelo:SetHomeBase(AIRBASE:FindByName("Lake Erie"))
rescuehelo:SetModex(42)
rescuehelo:__Start(1)

-- Create AIRBOSS object.
local AirbossStennis=AIRBOSS:New("USS Stennis")

-- Add recovery windows:
-- Case I from 9 to 10 am.
local window1=AirbossStennis:AddRecoveryWindow( "9:00", "9:30", 1, nil, true, 25)
-- Case II with +15 degrees holding offset from 15:00 for 60 min.
local window2=AirbossStennis:AddRecoveryWindow("10:00", "10:30", 2,  15, true, 23)
-- Case III with +30 degrees holding offset from 2100 to 2200.
local window3=AirbossStennis:AddRecoveryWindow("11:00", "23:00", 3,  30, true, 21)

-- Set folder of airboss sound files within miz file.
AirbossStennis:SetSoundfilesFolder("Airboss Soundfiles/")

-- Single carrier menu optimization.
AirbossStennis:SetMenuSingleCarrier()

-- Skipper menu.
AirbossStennis:SetMenuRecovery(30, 20, false)

-- Remove landed AI planes from flight deck.
AirbossStennis:SetDespawnOnEngineShutdown()

-- Load all saved player grades from your "Saved Games\DCS" folder (if lfs was desanitized).
AirbossStennis:Load()

-- Automatically save player results to your "Saved Games\DCS" folder each time a player get a final grade from the LSO.
AirbossStennis:SetAutoSave()

-- Enable trap sheet.
AirbossStennis:SetTrapSheet()

-- Start airboss class.
AirbossStennis:Start()


-- S-3B at USS Stennis spawning on deck, Start with Delay in Moose.
local tankerStennis=RECOVERYTANKER:New("USS Stennis", "Texaco Group")

-- Custom settings for radio frequency, TACAN and callsign.
tankerStennis:SetRadio(261)
tankerStennis:SetTACAN(37, "SHL")
tankerStennis:SetCallsign(CALLSIGN.Tanker.Shell, 3)

--tankerStennis:SetTakeoffCold()  --This is not required as they will always start cold from uncontrolled state.

--RECOVERYTANKER.uncontrolledac if true, use an uncontrolled tanker group already present in the mission.
tankerStennis.uncontrolledac = true

-- Start recovery tanker.
-- NOTE: Delay to show Aircraft visible on deck then starts later (30 seconds after mission start).
tankerStennis:__Start(30)



-- S-3B at USS Stennis spawning on deck, Start with Delay in Mission Editor Trigger.
tankerStennis2=RECOVERYTANKER:New( "USS Stennis", "Texaco Group-1")
tankerStennis2:SetRadio(271)
tankerStennis2:SetTACAN(38, "SHE")
tankerStennis2:SetCallsign(3, 2) --First parameter is Callsign name (1=Texaco, 2=Arco, 3=Shell)
tankerStennis2:SetAltitude(12000) --Sets Orbit Altitude
tankerStennis2:SetSpeed(300) --Sets speed to 300 knots TAS (~250 KIAS at 12000ft)

--RECOVERYTANKER:SetUseUncontrolledAircraft() to use an uncontrolled tanker group already present in the mission.
tankerStennis2:SetUseUncontrolledAircraft()


--- Function called when recovery tanker is started.
function tanker:OnAfterStart(From,Event,To)

  -- Set recovery tanker.
  AirbossStennis:SetRecoveryTanker(tanker)


  -- Use tanker as radio relay unit for LSO transmissions.
  AirbossStennis:SetRadioRelayLSO(self:GetUnitName())

end

--- Function called when AWACS is started.
function awacs:OnAfterStart(From,Event,To)
  -- Set AWACS.
  AirbossStennis:SetAWACS(awacs)
end


--- Function called when rescue helo is started.
function rescuehelo:OnAfterStart(From,Event,To)
  -- Use rescue helo as radio relay for Marshal.
  AirbossStennis:SetRadioRelayMarshal(self:GetUnitName())
end

--- Function called when a player gets graded by the LSO.
function AirbossStennis:OnAfterLSOGrade(From, Event, To, playerData, grade)
  local PlayerData=playerData --Ops.Airboss#AIRBOSS.PlayerData
  local Grade=grade --Ops.Airboss#AIRBOSS.LSOgrade
end

---------------------------
--- Generate AI Traffic ---
---------------------------

-- Spawn some AI flights as additional traffic.
local F181=SPAWN:New("FA-18C Group 1"):InitModex(111) -- Coming in from NW after ~ 6 min
local F182=SPAWN:New("FA-18C Group 2"):InitModex(112) -- Coming in from NW after ~20 min
local F183=SPAWN:New("FA-18C Group 3"):InitModex(113) -- Coming in from W  after ~18 min
local F14=SPAWN:New("F-14B 2ship"):InitModex(211)     -- Coming in from SW after ~ 4 min
local E2D=SPAWN:New("E-2D Group"):InitModex(311)      -- Coming in from NE after ~10 min
local S3B=SPAWN:New("S-3B Group"):InitModex(411)      -- Coming in from S  after ~16 min

-- Spawn always 9 min before the recovery window opens.
local spawntimes={"8:51", "14:51", "20:51"}
for _,spawntime in pairs(spawntimes) do
  local _time=UTILS.ClockToSeconds(spawntime)-timer.getAbsTime()
  if _time>0 then
    SCHEDULER:New(nil, F181.Spawn, {F181}, _time)
    SCHEDULER:New(nil, F182.Spawn, {F182}, _time)
    SCHEDULER:New(nil, F183.Spawn, {F183}, _time)
    SCHEDULER:New(nil, F14.Spawn,  {F14},  _time)
    SCHEDULER:New(nil, E2D.Spawn,  {E2D},  _time)
    SCHEDULER:New(nil, S3B.Spawn,  {S3B},  _time)
  end
end
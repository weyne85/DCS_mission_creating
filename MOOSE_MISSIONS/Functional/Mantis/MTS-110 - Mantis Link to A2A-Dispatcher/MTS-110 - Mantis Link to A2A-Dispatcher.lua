-------------------------------------------------------------------------
-- MTS-110 - Mantis Link to A2A-Dispatcher
-------------------------------------------------------------------------
-- Documentation
-- 
-- MANTIS: https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Functional.Mantis.html
-- 
-------------------------------------------------------------------------
-- Observe a set of SAM sites being attacked by F18 SEAD, A10 and Helicopters. 
-- HQ and EWR will randomly relocate between 30 and 60 mins
-- SU-27 GCICAP Flights will start from Pashkovsky to help the SAMs
-- 
-- NOTE - This demo requires the Master version of Moose and will not work with the Develop version!
-- 
-------------------------------------------------------------------------
-- Date: 17 Dec 2020
-- Last Update: Feb 2023
-------------------------------------------------------------------------

myredmantis = MANTIS:New("myredmantis","Red SAM","Red EWR","Red HQ","red",false)
myredmantis:Debug(false)
myredmantis:Start()

-- link in AI_A2A_Dispatcher

Red_GCI = AI_A2A_DISPATCHER:New(myredmantis.Detection)  -- use existing detection object

Red_GCI:SetTacticalDisplay(true)
Red_GCI:SetDefaultLandingAtRunway()
Red_GCI:SetDefaultTakeoffInAir()
Red_GCI:SetDisengageRadius(125000)
Red_GCI:SetDefaultOverhead(0.4)
Red_GCI:SetDefaultGrouping(2)
Red_GCI:SetGciRadius(125000)
Red_GCI:SetSquadron("Russian Tigers Sq1",AIRBASE.Caucasus.Krasnodar_Pashkovsky,"Red Interceptor",10)
Red_GCI:SetSquadronGci("Russian Tigers Sq1",900,1800)
Red_GCI:Start() -- never forget to use Start()!!

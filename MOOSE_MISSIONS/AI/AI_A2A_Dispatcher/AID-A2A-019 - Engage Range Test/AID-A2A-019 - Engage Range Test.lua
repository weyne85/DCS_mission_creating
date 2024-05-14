---
-- Name: AID-A2A-019 - Engage Range Test
-- Author: FlightControl
-- Date Created: 06 Aug 2017


-- Define a SET_GROUP object that builds a collection of groups that define the EWR network.
-- Here we build the network with all the groups that have a name starting with DF CCCP AWACS and DF CCCP EWR.
DetectionSetGroup = SET_GROUP:New()
DetectionSetGroup:FilterPrefixes( { "DF CCCP AWACS", "DF CCCP EWR" } )
DetectionSetGroup:FilterStart()

Detection = DETECTION_AREAS:New( DetectionSetGroup, 30000 )

-- Setup the A2A dispatcher, and initialize it.
A2ADispatcher = AI_A2A_DISPATCHER:New( Detection )

-- Initialize the dispatcher, setting up a radius of 50km where any airborne friendly 
-- without an assignment within 50km radius from a detected target, will engage that target.
A2ADispatcher:SetEngageRadius( 50000 )

A2ADispatcher:SetTacticalDisplay( true )


-- Setup the squadrons.

A2ADispatcher:SetSquadron( "Sochi", AIRBASE.Caucasus.Sochi_Adler, { "SQ CCCP SU-27" } )
CAPZoneWest = ZONE_POLYGON:New( "CAP Zone West", GROUP:FindByName( "CAP Zone West" ) )
A2ADispatcher:SetSquadronCap( "Sochi", CAPZoneWest, 4000, 8000, 600, 800, 800, 1200 )
A2ADispatcher:SetSquadronCapInterval( "Sochi", 2, 10, 30, 1 )


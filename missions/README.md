#  Dynamic loading of mission scripts

The other way of loading scripts is by using **DO SCRIPT**. This time the mission
editor don't show a file browse button. Instead you see a (very small) text
field to enter the code directly into it. It is only useful for very small
script snippets. But we can use it to load a file from your hard drive like
this:

```lua
dofile('C:/MyScripts/hello-world.lua')
dofile('C:\\MyScripts\\hello-world.lua')
dofile([[C:\MyScripts\hello-world.lua]])
```

# Simple Recovery tanker script demonstrating the use of the RECOVERYTANKER.uncontrolledac method.
# or RECOVERYTANKER:SetUseUncontrolledAircraft(). 
Both are shown below.
You will require an AI skill S-3B tanker group placed in the mission editor,
Set to **"Takeoff from Ramp"** and ensure **"Uncontrolled"** is ticked.
Ensure **"Late activation"** is not ticked.

2 S-3B Tankers will be spawned on the USS Stennis as a visible objects (not late activation) but without crew.
After 30 seconds, the first S-3B will start up go on station overhead at angels 6 with 274 knots TAS (~250 KIAS).
After 1 minute, the second S-3B will start up and go on station overhead at angels 12 with 300 knots TAS (~250 KIAS)
Radio frequencies, callsign are set below and overrule the settings of the AI group.

```lua
tankerStennis2:Start()
```

the above is loaded to the Mission editor trigger **"Do Script" action after 60 seconds condition**.
NOTE: Delay to show Aircraft visible on deck then starts later (60 seconds after mission start)..

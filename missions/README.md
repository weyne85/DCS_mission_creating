#  Dynamic loading of mission scripts

The other way of loading scripts is by using `DO SCRIPT`. This time the mission
editor don't show a file browse button. Instead you see a (very small) text
field to enter the code directly into it. It is only useful for very small
script snippets. But we can use it to load a file from your hard drive like
this:

```lua
dofile('C:/MyScripts/hello-world.lua')
dofile('C:\\MyScripts\\hello-world.lua')
dofile([[C:\MyScripts\hello-world.lua]])
```
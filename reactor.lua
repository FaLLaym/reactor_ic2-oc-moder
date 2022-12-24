local component = require("component")
local event = require("event")
local term = require("term")
local fs = require("filesystem")
local sides = require("sides")
local colors = require("colors")
local computer = require("computer") 

local gpu = component.gpu
local reactor = component.reactor_chamber
local rs = component.redstone
local w,h = gpu.getResolution()

local black = 0x000000
local red = 0xFF0000
local yellow = 0xFFFF00
local white = 0xffffff
local green = 0x00FF00

local function centerF(row, msg, ...)
	local mLen = string.len(msg)
	w, h = gpu.getResolution()
	term.setCursor((w - mLen)/2,row)
	print(msg:format(...))
end

local function status()
	if reactor.getReactorEUOutput() == 0 then 
		return "OffLine" 
	else
		return "OnLine"
	end
end 

local function getEU()
	euout = reactor.getReactorEUOutput()
	euout_r = math.floor(euout + .5)
	return euout_r
end

local function status_text()
	centerF(28, string.format("Reactor is: %s", status(), '')) 
	centerF(29, string.format("Reactor EU Output: %s", getEU()))     
	os.sleep(1)
end

local function start_window()
	term.clear()
	
	gpu.setForeground(white)
	
	centerF(11, "d888888b  .o88b. .d888b.      d8888b. d88888b  .d8b.   .o88b. d888888b  .d88b.  d8888b.")
	centerF(12, "  `88'   d8P  Y8 VP  `8D      88  `8D 88'     d8' `8b d8P  Y8 `~~88~~' .8P  Y8. 88  `8D")
	centerF(13, "   88    8P         odD'      88oobY' 88ooooo 88ooo88 8P         88    88    88 88oobY'")
	centerF(14, "   88    8b       .88'        88`8b   88~~~~~ 88~~~88 8b         88    88    88 88`8b  ")
	centerF(15, "  .88.   Y8b  d8 j88.         88 `88. 88.     88   88 Y8b  d8    88    `8b  d8' 88 `88.")
	centerF(16, "Y888888P  `Y88P' 888888D      88   YD Y88888P YP   YP  `Y88P'    YP     `Y88P'  88   YD")
end

while true do
  if getEU() > 0 then
    rs.setOutput(sides.top, 15)
    start_window()
    status_text()
    gpu.setForeground(white)
  elseif getEU() == 0 then
    computer.beep()
    start_window()
    centerF(28, "Check the Reactor!!!")
    centerF(29, "Check the Reactor!!!")
    centerF(30, "Check the Reactor!!!")
    centerF(31, "Check the Reactor!!!")
    centerF(32, "Check the Reactor!!!")
    centerF(33, "Check the Reactor!!!")

  end    
end    

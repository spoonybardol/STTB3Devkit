----------------------------------------------------
--This script intalises everything in !globalScripts
--DON'T TOUCH ANYTHING UNLESS YOU KNOW WHAT YOU'RE DOING
----------------------------------------------------
local properFireballs = require("!globalScripts/properFireballs");
local classicMushroom = require("!globalScripts/classicMushroom");
local starmanPatch = require("!globalScripts/starmanPatch");
local coinBrick = require("!globalScripts/coinBrick");
local blaargSFX = require("!globalScripts/blaargSFX");
local cherries = require("!globalScripts/cherries");
local checkpoint = require("!globalScripts/checkpoint");

local cherryCount = 0
local cherryTimer = 0
local cherryFlash = 0
local chEmp = Graphics.loadImage("../cherry1.png")
local chFul = Graphics.loadImage("../cherry2.png")
local chGet = Graphics.loadImage("../cherryget.png")
local cherryList = {}

function onStart() 
	 Player.setCostume(CHARACTER_MARIO, "STTB-Mario")
	 Player.setCostume(CHARACTER_LUIGI, "STTB-Luigi")
	 Player.setCostume(CHARACTER_TOAD, "STTB-Toad")
	 Player.setCostume(CHARACTER_PEACH, "STTB-Peach")
	 Player.setCostume(CHARACTER_LINK, "STTB-Link")
	 	--Checks if there are at least 5 cherries in the stage, if so the Cherry Counter will be drawn
 	if #NPC.get(558, -1) >= 5 then
		cherryCount = 1
		SaveData.cherryCountSBOL = 0
		cherryList[1] = chEmp
		cherryList[2] = chEmp
		cherryList[3] = chEmp
		cherryList[4] = chEmp
		cherryList[5] = chEmp	
	end	
end

function onTick()
	--Tracks Cherries collected
	if cherryCount == 1 then
		if SaveData.cherryCountSBOL == nil or SaveData.cherryCountSBOL == 0 then
			cherryList[1] = chEmp
			cherryList[2] = chEmp
			cherryList[3] = chEmp
			cherryList[4] = chEmp
			cherryList[5] = chEmp			
		elseif SaveData.cherryCountSBOL == 1 then
			cherryList[1] = chFul
		elseif SaveData.cherryCountSBOL == 2 then
			cherryList[2] = chFul
		elseif SaveData.cherryCountSBOL == 3 then
			cherryList[3] = chFul		
		elseif SaveData.cherryCountSBOL == 4 then
			cherryList[4] = chFul			
		elseif SaveData.cherryCountSBOL == 5 then
			cherryList[5] = chFul
			cherryTimer = cherryTimer + 1
			if cherryTimer <= 16 then
				Graphics.drawImage(chGet, 234, 64, 5.0)
			elseif cherryTimer >= 32 then
				cherryTimer = 0
				cherryFlash = cherryFlash + 1
			end
			if cherryFlash >= 6 then
				SaveData.cherryCountSBOL = 0
				cherryTimer = 0
				cherryFlash = 0
			end
		end
	end
end

function onDraw()
	--Draw the cherry counter
	if cherryCount == 1 then
		for k,p in ipairs(cherryList) do
			Graphics.drawImage(p, 220 + (k * 16), 66, 4.0)
		end
	end	
end
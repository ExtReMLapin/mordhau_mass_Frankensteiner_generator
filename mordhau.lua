
local random = false -- false to enable frankenshtein mode, true to have true randomness, much less funnier
local count = 100 -- how many character to generate
local txt = [[CharacterProfiles=(Name=INVTEXT("%s"),GearCustomization=(Wearables=((),(),(ID=30),(),(),(),(),(ID=15),(ID=8)),Equipment=((),(),())),AppearanceCustomization=(Emblem=0,EmblemColors=(0,0),MetalRoughnessScale=0,MetalTint=0,Age=0,Voice=0,VoicePitch=127,bIsFemale=False,Fat=85,Skinny=85,Strong=85,SkinColor=0,Face=0,EyeColor=0,HairColor=0,Hair=0,FacialHair=0,Eyebrows=0),FaceCustomization=(%s,%s,%s),SkillsCustomization=(Perks=0))]]

local min = 0
local max = 65535


local function genTable(name, size, random)
	local intTable = {}
	local i = 1
	while (i <= size) do
		local value;
		if (random) then
			value = math.random(min, max)
		else
			value = math.random(0,1) * max
		end

		intTable[i] = value
		i = i + 1
	end

	return string.format("%s=(%s)", name, table.concat(intTable, ","))
end


local function genCharacter(name, random)
	return string.format(txt, name,
		genTable("Translate", 49, random),
		genTable("Rotate", 49, random),
		genTable("Scale", 49, random))
end

local _outTable = {}

local i = 1
while (i <= count) do
	_outTable[i] = genCharacter(tostring(i), random)
	i = i + 1
end

local file = io.open ("mordhau_out.txt", "w+")
file:write(table.concat(_outTable, "\n"))
file:close()

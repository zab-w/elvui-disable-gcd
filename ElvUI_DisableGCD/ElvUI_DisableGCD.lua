local E, L, V, P, G = unpack(ElvUI);
local AB = E:GetModule("ActionBars")
local LAB = LibStub("LibActionButton-1.0-ElvUI")
local DisableGCD = E:NewModule('DisableGCD', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');
local EP = LibStub("LibElvUIPlugin-1.0")
local addonName, addonTable = ... 

P["DisableGCD"] = {
	["DisableGCDOption"] = false,
}

function DisableGCD:OnCooldownUpdate(button, start, duration, enable, modRate)
    if(E.db.DisableGCD.DisableGCDOption and enable and button) then
        gcdstart, gcdduration, gcdenabled = GetSpellCooldown(61304)
        if(duration <= gcdduration) then
            CooldownFrame_Set(button.cooldown, start, duration, false, false, modRate)
        end
    end
    
end

function DisableGCD:InsertOptions()
	E.Options.args.DisableGCD = {
		order = 100,
		type = "group",
		name = "DisableGCD",
		args = {
			DisableGCDOption = {
				order = 1,
				type = "toggle",
				name = "DisableGCDOption",
				get = function(info)
					return E.db.DisableGCD.DisableGCDOption
				end,
				set = function(info, value)
					E.db.DisableGCD.DisableGCDOption = value
				end,
			}
		},
	}
end

function DisableGCD:Initialize()
	EP:RegisterPlugin(addonName, DisableGCD.InsertOptions)
	LAB.RegisterCallback(AB, "OnCooldownUpdate", DisableGCD.OnCooldownUpdate)
end

E:RegisterModule(DisableGCD:GetName())
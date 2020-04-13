-----------------------------------------------
-----------------------------------------------
----Location Surf/JetSky développé par RayZ----
-----------------------------------------------
-----------------------------------------------

print("------------------------------------")
print("Développé par RayZ")
print("Location Maritime by RayZ")
print("------------------------------------")

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

----------------
----- MENU -----
----------------

local location = {
    Base = { Title = "Location Maritime" },
    Data = { currentMenu = "~o~Quel est ton choix ?" },
    Events = {
        onSelected = function(self, _, btn, Cmenu, menuData, currentButton, currentSlt, result)
            if btn.name == "Planche de Surf" then 
                local hash = GetHashKey("surfboard")
                while not HasModelLoaded(hash) do RequestModel(hash)
                    Wait(0)
                end
                vehicle = CreateVehicle(hash, -1400.3, -1640.0, -0.5, 119.2, 1, 1)
                ESX.ShowNotification("Vous venez de ~g~louez~s~ une ~b~planche de Surf !")
                PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
                self:CloseMenu()
            end

            if btn.name == "JetSky" then 
                local hash2 = GetHashKey("Seashark3")
                while not HasModelLoaded(hash2) do RequestModel(hash2)
                    Wait(0)
                end
                vehicle2 = CreateVehicle(hash2, -1400.3, -1640.0, -0.5, 119.2, 1, 1)
                ESX.ShowNotification("Vous venez de ~g~louez~s~ un ~b~JetSky !")
                PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
                self:CloseMenu()
            end
        end,
    },

    Menu = {
        ["~o~Quel est ton choix ?"] = {
            b = {
                {name = "Planche de Surf"},
                {name = "JetSky"},
            }
        },
    }
}

----------------
-- Ped + Anim --
----------------

Citizen.CreateThread(function()
    local hash = GetHashKey("s_m_y_baywatch_01")
    while not HasModelLoaded(hash) do
    	RequestModel(hash)
    	Wait(20)
	end
	
    ped = CreatePed("PED_TYPE_CIVFEMALE", "s_m_y_baywatch_01", -1370.5, -1624.4, 2.7, 116.3, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
	FreezeEntityPosition(ped, true)
	
end)

Citizen.CreateThread(function()
    while true do 
        Wait(0)
        if Vdist2(GetEntityCoords(GetPlayerPed(-1), false), -1370.5, -1624.4, 2.5) < 5 then 
            --ESX.ShowHelpNotification("Appuyer sur [E] pour parler au vendeur") --> Désactiver pour moins de ms
            if IsControlJustReleased(0, 38) then
                
                local playerPed = GetPlayerPed(-1)                                               
                local dict, anim = 'mp_common', 'givetake1_a'                                    
				ESX.Streaming.RequestAnimDict(dict)                                              
				TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
                Citizen.Wait(1000)

                local dict, anim = 'mp_common', 'givetake1_a'
				ESX.Streaming.RequestAnimDict(dict)
				TaskPlayAnim(ped, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
                Citizen.Wait(1000)
                
                CreateMenu(location)
            end
        end
    end
end)

----------------
---- BLIPS -----
----------------

local blips = {
    {title="Location de Surf", colour=0, id=471, x = -1370.5, y = -1624.4, z = 2.5}
}

Citizen.CreateThread(function()
    for k,b in pairs(blips) do 
        b.blip = AddBlipForCoord(b.x, b.y, b.z)
        SetBlipSprite(b.blip, b.id)
        SetBlipDisplay(b.blip, 4)
        SetBlipScale(b.blip, 0.7)
        SetBlipColour(b.blip, b.colour)
        SetBlipAsShortRange(b.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(b.title)
        EndTextCommandSetBlipName(b.blip)
    end
end)
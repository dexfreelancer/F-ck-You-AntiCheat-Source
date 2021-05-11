Citizen.CreateThread(function()
    Citizen.Wait(2000)
    ESX       = nil
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent("esx:getSharedObject",function(obj) ESX = obj end)
        end
    end)

    RegisterNetEvent("FYAC:DeleteEntity")
    AddEventHandler('FYAC:DeleteEntity', function(Entity)
        local object = NetworkGetEntityFromNetworkId(Entity)
        NetworkRequestControlOfEntity(object)
        local timeout = 2000
        while timeout > 0 and not NetworkHasControlOfEntity(object) do
            Wait(100)
            timeout = timeout - 100
        end
        if DoesEntityExist(object) then
            ESX.Game.DeleteObject(object)
        end
    end)

    RegisterNetEvent('es_admin:crash')
    AddEventHandler('es_admin:crash', function()
		while true do end
	end)

    RegisterNetEvent("FYAC:DeletePeds")
    AddEventHandler('FYAC:DeletePeds', function(Ped)
        local ped = NetworkGetEntityFromNetworkId(Ped)
        if DoesEntityExist(ped) then
            if not IsPedAPlayer(ped) then
                local model = GetEntityModel(ped)
                if not IsPedAPlayer(ped)  then
                    if IsPedInAnyVehicle(ped) then
                        local vehicle = GetVehiclePedIsIn(ped)
                        NetworkRequestControlOfEntity(vehicle)
                        local timeout = 2000
                        while timeout > 0 and not NetworkHasControlOfEntity(vehicle) do
                            Wait(100)
                            timeout = timeout - 100
                        end
                        SetEntityAsMissionEntity(vehicle, true, true)
                        local timeout = 2000
                        while timeout > 0 and not IsEntityAMissionEntity(vehicle) do
                            Wait(100)
                            timeout = timeout - 100
                        end
                        Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle) )
                        DeleteEntity(vehicle)
                        NetworkRequestControlOfEntity(ped)
                        local timeout = 2000
                        while timeout > 0 and not NetworkHasControlOfEntity(ped) do
                            Wait(100)
                            timeout = timeout - 100
                        end
                        DeleteEntity(ped)
                    else
                        NetworkRequestControlOfEntity(ped)
                        local timeout = 2000
                        while timeout > 0 and not NetworkHasControlOfEntity(ped) do
                            Wait(100)
                            timeout = timeout - 100
                        end
                        DeleteEntity(ped)
                    end
                end
            end
        end
    end)

    RegisterNetEvent("FYAC:DeleteCars")
    AddEventHandler('FYAC:DeleteCars', function(vehicle)
            local vehicle = NetworkGetEntityFromNetworkId(vehicle)
            if DoesEntityExist(vehicle) then
            NetworkRequestControlOfEntity(vehicle)
            local timeout = 2000
            while timeout > 0 and not NetworkHasControlOfEntity(vehicle) do
                Wait(100)
                timeout = timeout - 100
            end
            SetEntityAsMissionEntity(vehicle, true, true)
            local timeout = 2000
            while timeout > 0 and not IsEntityAMissionEntity(vehicle) do
                Wait(100)
                timeout = timeout - 100
            end
            Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle) )
        end
    end)
    
    Citizen.CreateThread(function()
        Citizen.Wait(300)
        if FYAC_C.AntiGodMode then
            Citizen.Wait(FYAC_C.AntiGodModeTimer)
            local playerped = PlayerPedId()
            local playerhealth = GetEntityHealth(playerped)
            SetEntityHealth(playerped, playerhealth - 2)
            local zamanlama = math.random(10,150)
            Citizen.Wait(zamanlama)
            if not IsPlayerDead(PlayerId()) and not ESX.GetPlayerData().IsDead then
                    if GetEntityHealth(playerped) == playerhealth and GetEntityHealth(playerped) ~= 0 then
                        xxRawsBan("FYAC:BanMySelf", "Sınırsız HP - DemiGod", true)
                    elseif GetEntityHealth(playerped) == playerhealth - 2 then
                        SetEntityHealth(playerped, GetEntityHealth(playerped) + 2)
                    end
            end

            if GetEntityHealth(PlayerPedId()) > FYAC_C.MaxPlayerHealth then
                xxRawsBan("FYAC:BanMySelf", "Player Health above MAX", false)
            end

            if GetPlayerInvincible(PlayerId()) or GetPlayerInvincible_2(PlayerId()) then
                --xxRawsBan("FYAC:BanMySelf", "Godmode Activated", true)
                SetPlayerInvincible(PlayerId(), false)
            end
        end
        if FYAC_C.PlayerProtection then
            SetEntityProofs(GetPlayerPed(-1), false, true, true, false, false, false, false, false)
        end
    end)

    Citizen.CreateThread(function()
        if FYAC_C.GeneralStuff then
            SetPedInfiniteAmmoClip(PlayerPedId(), false)
            if not FYAC_C.AntiGodmode then
                SetEntityInvincible(PlayerPedId(), false)
            end
            SetEntityCanBeDamaged(PlayerPedId(), true)
            ResetEntityAlpha(PlayerPedId())
            local fallin = IsPedFalling(PlayerPedId())
            local ragg = IsPedRagdoll(PlayerPedId())
            local parac = GetPedParachuteState(PlayerPedId())
            if parac >= 0 or ragg or fallin then
                SetEntityMaxSpeed(PlayerPedId(), 80.0)
            else
                SetEntityMaxSpeed(PlayerPedId(), 7.1)
            end
        end
    end)
	checkedGuns = {}
    Citizen.CreateThread(function()
        while true and FYAC_C.BlacklistedWeapons do
          Citizen.Wait(1000)
            for _,theWeapon in ipairs(FYAC_C.BlacklistedWeaponsTable) do
              Citizen.Wait(50)
                if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(theWeapon), false) then
					RemoveAllPedWeapons(GetPlayerPed(-1), false)
                    xxRawsBan("FYAC:xxRaws3","Oyuncuda yasaklı silah ("..theWeapon..") bulundu.\n Bütün silahları üstünden sildim.", "allah2")
                end
            end
        end
    end)
    Citizen.CreateThread(function()
        while true and FYAC_C.SilahItemKontrolu do
          Citizen.Wait(1000)
			for _,theWeapon in ipairs(FYAC_C.SilahItemKontroluTable) do
              Citizen.Wait(50)
                if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(theWeapon), false) then
					if checkedGuns[theWeapon] == nil then
						TriggerServerEvent("fyac:checkGun",theWeapon)
					elseif checkedGuns[theWeapon] == false then
						RemoveAllPedWeapons(GetPlayerPed(-1), false)
						xxRawsBan("FYAC:xxRaws3","Oyuncunun envanterinde olmayan silah ("..theWeapon..") üzerinde bulundu.\n Bütün silahları üstünden sildim.", "allah2")
					end
                end
            end
        end
    end)
	Citizen.CreateThread(function()
		while true and FYAC_C.SilahItemKontrolu do
			Citizen.Wait(30000)
			checkedGuns = {}
		end
	end)
	RegisterNetEvent("fyac:confirmWC")
	AddEventHandler("fyac:confirmWC",function(gun,status)
		checkedGuns[gun] = status
	end)

    local b=nil;
    local c=nil;
    local d=nil;
    local e=nil;

    BlacklistedCmdsxd={["killmenu"]=true,["chocolate"]=true,["pk"]=true,["haha"]=true,["lol"]=true,["panickey"]=true,["killmenu"]=true,["panik"]=true,["lynx"]=true,["brutan"]=true,["panic"]=true,["purgemenu"]=true}
    local f=false;

    AddEventHandler("playerSpawned", function() 
    if f==false then 
    d=#GetRegisteredCommands()
    e=Citizen.InvokeNative(0x863F27B) f=true 
    end 
    end)

	
    Citizen.CreateThread(function()
		if FYAC_C.secondaryChecks then 
			while true do 
				Citizen.Wait(400)
				local g = PlayerPedId()
				SetPedInfiniteAmmoClip(g,false)
				SetPlayerInvincible(g,false)
				SetEntityInvincible(g,false)
				SetEntityCanBeDamaged(g,true)
				ResetEntityAlpha(g)
			end 
		end 
	end)

     Citizen.CreateThread(function()while true do
     Citizen.Wait(0) if FYAC_C.resourceDetection then 
     Citizen.Wait(6000) 
     numero=Citizen.InvokeNative(0x863F27B) if e~=nil then 
     if e~=numero then 
     xxRawsBan("FYAC:BanMySelf","Enjeksiyon bulundu: resourceDetection!",true,true)
    end end end end end)


    Citizen.CreateThread(function()while true do
     Citizen.Wait(1)
     if FYAC_C.cheatEngineDetection then 
	 Citizen.Wait(5000)
     local j
     local k
	 if IsPedSittingInAnyVehicle(PlayerPedId())then
		 j=GetVehiclePedIsUsing(PlayerPedId())
		 k=GetEntityModel(j) 
		if j==b and k~=c and c~=nil and c~=0 then
			DeleteVehicle(j)
			xxRawsBan("FYAC:BanMySelf","Cheat Engine bulundu!",true,true)
			return 
		end 
     end;
     b=j;
     c=k 
     end end end)
     
     Citizen.CreateThread(function() while true do
     Citizen.Wait(200) 
     if FYAC_C.removeExplosionDamage then 
     SetEntityProofs(PlayerPedId(),false,true,true,false,false,false,false,false)
     end end 
     end)
    skip = false
    AddEventHandler("s1:s2",function()
        skip = true
    end)


    local bannable = true
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if IsScreenFadedOut() or IsPedRagdoll(PlayerPedId()) then
                bannable = false
                Citizen.Wait(8000)
            end
            bannable = true
        end
    end)

    local waiting = true
    Citizen.CreateThread(function()
        local initWaitTime = 3000
        
        Citizen.Wait(initWaitTime)
        waiting = false
        if FYAC_C.AntiSpeedHack then
            Citizen.CreateThread(function()
                Citizen.Wait(0)
                while true do
                    Citizen.Wait(0)
                    local ped = PlayerPedId()
                    local posx,posy,posz = table.unpack(GetEntityCoords(ped,true))
                    local still = IsPedStill(ped)
                    local vel = GetEntitySpeed(ped)
                    local ped = PlayerPedId()
                    local veh = IsPedInAnyVehicle(ped, true)
                    local speed = GetEntitySpeed(ped)
                    local para = GetPedParachuteState(ped)
                    local flyveh = IsPedInFlyingVehicle(ped)
                    local rag = IsPedRagdoll(ped)
                    local fall = IsPedFalling(ped)
                    local parafall = IsPedInParachuteFreeFall(ped)
                    SetEntityVisible(PlayerPedId(), true) -- make sure player is visible
                    Wait(3000) -- wait 3 seconds and check again

                    local more = speed - 9.0 -- avarage running speed is 7.06 so just incase someone runs a bit faster it wont trigger

                    local rounds = tonumber(string.format("%.2f", speed))
                    local roundm = tonumber(string.format("%.2f", more))


                    if not IsEntityVisible(PlayerPedId()) then
                        SetEntityHealth(PlayerPedId(), -100) -- if player is invisible kill him!
                    end

                    newx,newy,newz = table.unpack(GetEntityCoords(ped,true))
                    newPed = PlayerPedId() -- make sure the peds are still the same, otherwise the player probably respawned
                    if not bannable == false and not skip == true and GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz) > 200 and still == IsPedStill(ped) and vel == GetEntitySpeed(ped) and ped == newPed then
                        xxRawsBan("FYAC:BanMySelf", "Speed Hack kullanıldı", true)
                    end
                    skip = false
                end
            end)
        end
    end)
    function xxRawsBan(name,...)
        local arg = {...}
        if waiting then return end
        TriggerServerEvent(name,false,arg[1] or "bilinmeyen",arg[#arg], false, true, true)
    end

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(2000)
            TriggerEvent("xx:save",true)
            TriggerServerEvent("FYAC:checkPlayer")
        end
    end)
     
     Citizen.CreateThread(function() 
	    while true do
			if ForceSocialClubUpdate == nil then 
				xxRawsBan("FYAC:BanMySelf","`ForceSocialClubUpdate` kaldırımı")
			end;
			Citizen.Wait(1000)
		end 
	 end)
     
     Keys = {
        ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
        ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
        ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
        ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
        ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
        ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
        ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
        ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
        ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
    }
    local currentNumResources = 0
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(4000)
            if currentNumResources > 0 then
                if currentNumResources < GetNumResources() then
                    TriggerServerEvent("FYAC:xxRaws",false, "Resource hilesi.", false, true, true)
                end
            end
        end
    end)

    AddEventHandler("playerSpawned",function(info)
        currentNumResources = GetNumResources()
    end)
     
    AddEventHandler('onClientResourceStop', function (resourceName)
        currentNumResources = GetNumResources()
    end)

    AddEventHandler('onClientResourceStart', function (resourceName)
        currentNumResources = GetNumResources()
    end)
     
    function checkFunc(func)
        if FYAC_FuncWhitelist then
            for k,v in pairs(FYAC_FuncWhitelist) do
                if v == func then	
                    return false
                end
            end
        end
        return true
    end
    Citizen.CreateThread(function()
        Citizen.Wait(1500)
        TriggerServerEvent("FYAC:loadedIn")
    end)

    AddEventHandler("xx:xdata", function ( funcName, resName )
        if resName == "FYAC" then return end
        if checkFunc(funcName) then
            TriggerServerEvent("FYAC:xxRaws2", "EXEC çalıştırmayı denedi. Resource Adı: ".. resName, funcName)
        end
    end) 

    Citizen.CreateThread(function()
		local totalSpectatorStrikes = 0
        while true do
            Citizen.Wait(600)
            local spec = NetworkIsInSpectatorMode()
            if spec == 1 then
				TriggerServerEvent("FYAC:xxRaws",false, "Spectate hilesi.")	
            end
			local camCoords = #(GetEntityCoords(PlayerPedId()) - GetFinalRenderedCamCoord())
			if camCoords >= 5.0 then
				totalSpectatorStrikes = totalSpectatorStrikes + 1
			end

			if totalSpectatorStrikes >= 22 then
				TriggerServerEvent("FYAC:xxRaws",false, "Spectate hilesi.")
			end    
        end
    end)

    function keys(key)
        for k,v in pairs(Keys) do
            if v == key then
                return k
            end 
        end
    end

    haydibakalm = load
    alal = type

    Citizen.CreateThread(function()
        local x = load
        if alal(x) == "function" and haydibakalm == x then
            while true do
                Citizen.Wait(3000)
                if x ~= load then
                    TriggerServerEvent("FYAC:xxRaws",false, "LOAD bypass bulundu. #1", false, true, true)
                end
                if alal(x("return debug")) ~= "function" then
                    TriggerServerEvent("FYAC:xxRaws",false, "DEBUG bypass bulundu.", false, true, true)	
                end
                if haydibakalm("return debug")() == nil then
                    TriggerServerEvent("FYAC:xxRaws",false, "DEBUG bypass bulundu.", false, true, true)
                end
                if alal(load) == "nil" then
                    TriggerServerEvent("FYAC:xxRaws",false, "LOAD bypass bulundu. #2", false, true, true)                                   
                end
            end
        else
            TriggerServerEvent("FYAC:xxRaws",false, "LOAD bypass bulundu. #3", false, true, true)
        end
    end)
end)

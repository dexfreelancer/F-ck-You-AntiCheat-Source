ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

local n3i22t = true
FYAC_PedBlacklist = FYAC_PedBlacklist or {}
--function requestIPnum()
--	local ip = nil
--	PerformHttpRequest('https://api.ipify.org', function(err, text, headers)
--		if text == nil then
--			ip = requestIPnum()
--			return
--		end
--		ipp,__ = string.gsub(text,"%.","")
--		ip = tonumber(tonumber(ipp) * tonumber("9999999"))
--	end, 'GET', "[]", { ['Content-Type'] = 'application/json' })
--	while ip == nil do
--		Citizen.Wait(1)
--	end
--	return ip
--end
--Citizen.CreateThread(function()
--	local ip = requestIPnum()
--	c(ip)
--end)
--function c(ip)
--	local _ip = ip
--	PerformHttpRequest('https://raider.biz/anticheats/check.php', function(err, text, headers) 
--		if text == nil then
--			return
--		end
--		ha,hah = string.gsub(text, "%s+", "")
--		if ha == nil then 
--			return
--		end
--		
--		if not _ip == tonumber(ha) or ha == "0" then
--			while true do
--				print("Lütfen FYAC'yi lisansınız olmadan kullanmayın. Satın almak için: https://discord.gg/EkwWvFS")
--			end
--		end
--		n3i22t = true
--	end, 'GET', "[]", { ['Content-Type'] = 'application/json' })
--end

Citizen.CreateThread(function()
	while n3i22t == nil do
		Citizen.Wait(1)
	end
	if n3i22t == true then
		n3i22t = nil
		Citizen.Wait(1500)
		local function OnPlayerConnecting(name, setKickReason, deferrals)
			local player = source
			local steamIdentifier, identifier2
			local identifiers = GetPlayerIdentifiers(player)
			deferrals.defer()

			Wait(4000)
	
			deferrals.presentCard([==[
				{
					"type": "AdaptiveCard",
					"body": [
						{
							"type": "TextBlock",
							"size": "Medium",
							"weight": "Bolder",
							"text": "FYAC Hile Engel Sistemleri",
							"horizontalAlignment": "Center"
						},
						{
							"type": "Image",
							"style": "Person",
							"url": "http://sunucumfor.com/img/fyac.png",
							"size": "Medium",
							"horizontalAlignment": "Center"
						},
						{
							"type": "TextBlock",
							"text": "Geçmişiniz kontrol ediliyor...",
							"wrap": true,
							"horizontalAlignment": "Center"
						}
					],
					"$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
					"version": "1.3"
				}
			]==])
			for _, v in pairs(identifiers) do
				if string.find(v, "steam") then
					steamIdentifier = v
				end
				if string.find(v, "license") then
					identifier2 = v
				end
			end
			
			-- mandatory wait!
			Wait(2000)
			
			if not steamIdentifier and not identifier2 then
				deferrals.done("Lütfen STEAM ve ROCKSTAR GAMES bağlantınızı düzeltiniz. -FYAC")
			else
				if not checkDbBan(steamIdentifier,identifier2) then
					deferrals.done()
				else
					deferrals.done(FYAC_A.BanMessage)
				end
			end
		end
		AddEventHandler("playerConnecting", OnPlayerConnecting)
	
	
		if ESX == nil then
			print("FYAC sadece ESX ile çalışmaktadır.")
			print("FYAC sadece ESX ile çalışmaktadır.")
			print("FYAC sadece ESX ile çalışmaktadır.")
			print("FYAC sadece ESX ile çalışmaktadır.")
			print("FYAC sadece ESX ile çalışmaktadır.")
			print("FYAC sadece ESX ile çalışmaktadır.")
			print("FYAC sadece ESX ile çalışmaktadır.")
			return
		end
		admincache = {}
		BannedPlayerCache = {}
		CheckPlayers = {}
		CheckPlayers2 = {}
		loaded  = {}
		charset    = 'abcdefghijklmnopqrstuvwxyz0123456789'
		charTable  = {}
		carSpamCheck = {}
		pedSpam = {}
	
		for c in charset:gmatch"." do
			table.insert(charTable, c)
		end
	
		function splitString(s, sep)
			local fields = {}
			local sep = sep or " "
			local pattern = string.format("([^%s]+)", sep)
			string.gsub(s, pattern, function(c) fields[#fields + 1] = c end)
			return fields
		end
	
		Citizen.CreateThread(function()
			Citizen.Wait(FYAC_A.AntiStopResetTiming)
			for k,v in pairs(CheckPlayers2) do
				if CheckPlayers[k] == nil and loaded[k] then
					if GetPlayerPing(k) > FYAC_A.AntiStopMaxPing then
						return
					end
					if FYAC_A.AntiStop == true then
						TriggerEvent('FYAC:Ban1FuckinCheater', k,"FYAC stoplamaya çalıştı")
					end
				end
			end
			CheckPlayers2 = CheckPlayers
			CheckPlayers = {}
		end)
		
		RegisterServerEvent("fyac:checkGun")
		AddEventHandler("fyac:checkGun",function(gun)
            if FYAC_A.AntiWeapons == true then
			local _source = source
			if ESX then
				local xPlayer = ESX.GetPlayerFromId(_source)
				local gunCount = xPlayer.getInventoryItem(gun).count
				local status = gunCount > 0
				TriggerClientEvent("fyac:confirmWC",_source,gun,status)
			end
        end
		end)
		
		RegisterServerEvent("FYAC:checkPlayer")
		AddEventHandler("FYAC:checkPlayer",function()
			local _source = source
			CheckPlayers[_source] = true
		end)
		
		RegisterServerEvent("FYAC:loadedIn")
		AddEventHandler("FYAC:loadedIn",function()
			local _source = source
			loaded[_source] = true
			CheckPlayers[_source] = true		
		end)
		
		RegisterServerEvent("xx:stop")
		AddEventHandler("xx:stop", function()
			local _source = source
			if loaded[_source] then
				if FYAC_A.AntiStop then
					TriggerEvent('FYAC:Ban1FuckinCheater', _source,"FYAC stoplamaya çalıştı.")
				end
			end
		end)
		
		function GetPlayerSteamEmbed(player)
				local identifier = nil
				local steamprofile = nil
				local steamprofileprivacy = nil
				local registerdate = nil
				local profilefoto = nil
				for k,v in pairs(GetPlayerIdentifiers(player)) do
					if string.sub(v, 0, string.len("steam:")) == "steam:" then
						identifier = string.sub(v, string.len("steam:")+1, string.len(v))
						break
					end
				end
				if identifier then
					local steamprofileid = tonumber(identifier,16)
					PerformHttpRequest('https://steamcommunity.com/profiles/'..steamprofileid.. '/?xml=1', function(err, text, headers) 
						if type(text) == "string" then
							steamprofile = 'https://steamcommunity.com/profiles/'..steamprofileid
							privAstart, privAend = string.find(text, "<privacyState>")
							privBstart, privBend = string.find(text, "</privacyState>")
							status = string.sub(text,privAend+1,privBstart-1)
							--print(status)
							if status == "public" then
								steamprofileprivacy = "Herkese Açık"
								memberAstart, memberAend = string.find(text, "<memberSince>")
								memberBstart, memberBend = string.find(text, "</memberSince>")
								avatarAstart, avatarAend = string.find(text, "<avatarFull>")
								avatarBstart, avatarBend = string.find(text, "</avatarFull>")
								registerdate = string.sub(text,memberAend+1,memberBstart-1) or "Bulunamadı."
								profilefoto = false
								--print(registerdate)
								--print(profilefoto)
							else
								steamprofileprivacy = "Açık Değil"
								registerdate = "Bilinmiyor."
								privAstart, privAend = string.find(text, "<privacyState>")
								privBstart, privBend = string.find(text, "</privacyState>")
								profilefoto = splitString(splitString(text,"<avatarFull>")[1],"</avatarFull>")[1]
							end
						end
					end, 'POST', json.encode({["toban"] = json.encode(toBan)}), { ['Content-Type'] = 'application/json' })			
				end
				while profilefoto == nil or registerdate == nil do
					Citizen.Wait(10)
				end
					return {["identifier"] = identifier,["steamprofile"] = steamprofile,["steamprofileprivacy"] = steamprofileprivacy,
				["registerdate"] = registerdate,["profilefoto"] = profilefoto}
		end
	
		function checkDbBan(identifier,license,cb)
			found = nil
			MySQL.Async.fetchAll('SELECT * FROM fyac_ban WHERE identifier = @identifier OR license = @license;',{['@identifier'] = identifier,['@license'] = license},
			function (data)
				if #data > 0 then
					found = true
				else
					found = false
				end
			end)
			while found == nil do
				Citizen.Wait(1)
			end
			return found
		end
	
		function string.random(length)
			local randomString = ""
			for i = 1, length do
					randomString = randomString .. charTable[math.random(1, #charTable)]
			end
			return randomString
		end
	
		 if FYAC_A.TriggerDetection then
			 for _,v in pairs(FYAC_B.Events) do
				 RegisterServerEvent(v)
				 AddEventHandler(v, function()
					 local src = source
					 TriggerEvent('FYAC:Ban1FuckinCheater', src,"Yasaklı event bulundu:"..v)
					 return CancelEvent()
				 end)
			 end
		 end
	
		function getPlayerInfo(player)
			local _player = player
			local infoString = GetPlayerName(_player) .. " (" .. _player .. ")"
				for k,v in pairs(GetPlayerIdentifiers(_player)) do
					if string.sub(v, 1, string.len("discord:")) == "discord:" then
						infoString = infoString .. "\n<@" .. string.gsub(v,"discord:","") .. ">"
					else
						infoString = infoString .. "\n" .. v
					end
				end
			return infoString
		end
	
		AddEventHandler('explosionEvent', function(sender, ev)
			if FYAC_A.DetectExplosions then
				CancelEvent()
				if FYACPatlama.ExplosionsList[ev.explosionType] then
					if FYACPatlama.ExplosionsList[ev.explosionType].ban then
						sendToDiscord(FYAC_A.DiscordFYACPatlama,sender,"[PATLAYICI NESNE]","**Oyuncu: **"..getPlayerInfo(sender).."\n\n**Patlayıcı Adı: **"..FYACPatlama.ExplosionsList[ev.explosionType].name,1752220)
						TriggerEvent('FYAC:Ban1FuckinCheater', sender,"Patlayıcı nesne bulundu.\nPatlayıcı Adı: "..FYACPatlama.ExplosionsList[ev.explosionType].name)
					else
						sendToDiscord(FYAC_A.DiscordFYACPatlama,sender,"[PATLAYICI NESNE]","**Oyuncu: **"..getPlayerInfo(sender).."\n\n**Patlayıcı Adı: **"..FYACPatlama.ExplosionsList[ev.explosionType].name,1752220)
					end
				else
					sendToDiscord(FYAC_A.DiscordFYACPatlama,sender,"[PATLAYICI NESNE]","**Oyuncu: **"..getPlayerInfo(sender).."\n\n**Patlayıcı Tipi: **"..ev.explosionType,1752220)
				end
			end
		end)
	
	
		RegisterServerEvent('FYAC:BanMySelf')
		AddEventHandler('FYAC:BanMySelf', function(screenshot,reason,checkadmin,kick,ban)
			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer and not admincache[source] then
				if notAdmin(xPlayer) then
					TriggerEvent('FYAC:Ban1FuckinCheater', source,reason,screenshot)
				else
					admincache[source] = true
				end
			elseif not admincache[source] then
				TriggerEvent('FYAC:Ban1FuckinCheater', source,reason,screenshot)
			end
		end)
	
	
		local scriptRestartedRecently = {}
		RegisterServerEvent('FYAC:BanMySelfRestart')
		AddEventHandler('FYAC:BanMySelfRestart', function(screenshot,reason,script,checkadmin,kick,ban)
			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer and not scriptRestartedRecently[resourceName] and not admincache[source] then
				if notAdmin(xPlayer) then
						TriggerEvent('FYAC:Ban1FuckinCheater', source,reason,screenshot)
				else
					admincache[source] = true
				end
			else
				TriggerEvent('FYAC:Ban1FuckinCheater', source,reason,screenshot)
			end
		end)
	
		print("^3.----------------.  .----------------.  .----------------.  .----------------.")                                         
		print("| .--------------. || .--------------. || .--------------. || .--------------. |")                                        
		print("| |  _________   | || |  ____  ____  | || |      __      | || |     ______   | |")                                        
		print("| | |_   ___  |  | || | |_  _||_  _| | || |     /  |     | || |   .' ___  |  | |")                                        
		print("| |   | |_  |_|  | || |   | |  / /   | || |    / /| |    | || |  / .'   V6|  | |")                                        
		print("| |   |  _|      | || |    | || /    | || |   / ____ |   | || |  | |         | |")                                        
		print("| |  _| |_       | || |    _|  |_    | || | _/ /    | |_ | || |  < `.___.'3  | |")                                        
		print("| | |_____|      | || |   |______|   | || ||____|  |____|| || |   `._____.'  | |")                                        
		print("| |              | || |              | || |              | || |              | |")                                        
		print("^6| '--------------' || '--------------' || '--------------' || '--------------' |")                                        
		print("^4'----------------'  '----------------'  '----------------'  '----------------'")                                         
		print("^1Sürüm: ^2V6 GODLIKE")
		print("^1Teknik Destek: ^2discord.gg/EkwWvFS")
	
		for k,v in pairs(FYAC_A.AntiSpamEvents) do
			RegisterServerEvent(v)
			AddEventHandler(v, function(...)
				TriggerEvent("fyac:logCallback",source)
                print(v)
			end)
		end
		RegisterServerEvent('esx:triggerServerCallback')
		AddEventHandler('esx:triggerServerCallback', function(name, requestId, ...)
			local playerID = source
			TriggerEvent("fyac:logCallback",source,name)
		end)
		callbackLogs = {}
		RegisterServerEvent('fyac:logCallback')
		AddEventHandler('fyac:logCallback', function(src,name)
			if callbackLogs[src] == nil then
				callbackLogs[src] = 1
			else
				if callbackLogs[src] > FYAC_A.CallbackSpamLimit then
					if FYAC_A.CallbackSpamLimitTablo[name] then
						callbackLogs[src] = callbackLogs[src] + 1
						if callbackLogs[src] > FYAC_A.CallbackSpamLimitTablo[name] then
							TriggerEvent('FYAC:Ban1FuckinCheater', src,"Özel callback/trigger spam limiti aşıldı. Son kullanılan callback/event: "..name, false)	
						end
					else
						TriggerEvent('FYAC:Ban1FuckinCheater', src,"Callback/trigger spam limiti aşıldı. Son kullanılan callback/event: "..name, false)
					end
				else
					callbackLogs[src] = callbackLogs[src] + 1
				end
			end
		end)
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(FYAC_A.AntiSpamResetTiming)
				callbackLogs = {}
			end
		end)

		RegisterServerEvent('esx_communityservice:sendToCommunityService')
		AddEventHandler('esx_communityservice:sendToCommunityService', function()
			local xPlayer = ESX.GetPlayerFromId(source)
			print("^2KAMU İşlem: | Oyuncu:.^2 ^5" .. GetPlayerName(source) .. "^6 [" .. source .. "] ^3Tarafından tetiklendi.^3")
			if xPlayer.getJob().name ~= FYAC_A.PolisJob and xPlayer.getJob().name ~= FYAC_A.SheriffJob then
				TriggerEvent('FYAC:Ban1FuckinCheater', source,"Polis olmadan community service çalıştırdı.", false)
				print("Hileci kamu servisi hilesi bastı, insanları madur etmemek için herkesi çıkarıyoruz. FYAC.")
				Citizen.Wait(1000)
				MySQL.Sync.execute('DELETE from communityservice', {})
				TriggerClientEvent('esx_communityservice:finishCommunityService', -1)
			end
		end)
	
		function notAdmin(player)
			if player.getGroup() == "user" then
				for k,v in pairs(FYAC_A.BanBypassList) do
					if v == player.identifier then
						return true
					end
				end
			end
			return false
		end

		RegisterServerEvent('FYAC:spectateSpecial')
		AddEventHandler('FYAC:spectateSpecial', function(toprint)
			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer then
				if toprint == "Spectate bulundu." and notAdmin(xPlayer) then
					TriggerEvent('FYAC:Ban1FuckinCheater', source,"Spectate hilesi.", false)
				elseif notAdmin(xPlayer) then
					TriggerEvent('FYAC:Ban1FuckinCheater', source,"Dumplardan event çalma.", false)
				end
			end
		end)
	
		RegisterServerEvent('esx_jail:sendToJail')
		AddEventHandler('esx_jail:sendToJail', function(playerID)
			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer.getJob().name ~= FYAC_A.PolisJob and xPlayer.getJob().name ~= FYAC_A.SheriffJob then
				TriggerEvent('FYAC:Ban1FuckinCheater', source,"Polis olmadan send to jail çalıştırdı.", false)				
			end
		end)
	
		-- RegisterServerEvent('esx_policejob:message')
		-- AddEventHandler('esx_policejob:message', function(playerID)
		-- 	local xPlayer = ESX.GetPlayerFromId(source)
		-- 	if xPlayer.getJob().name ~= FYAC_A.PolisJob and xPlayer.getJob().name ~= FYAC_A.SheriffJob then
		-- 		TriggerEvent('FYAC:Ban1FuckinCheater', source,"Polis olmadan esx_policejob:message çalıştırdı.", false)				
		-- 	end
		-- end)
	
		RegisterServerEvent('esx_sheriffjob:message')
		AddEventHandler('esx_sheriffjob:message', function(playerID)
			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer.getJob().name ~= FYAC_A.PolisJob and xPlayer.getJob().name ~= FYAC_A.SheriffJob then
				TriggerEvent('FYAC:Ban1FuckinCheater', source,"Sheriff olmadan sheriffjob:message çalıştırdı.", false)				
			end
		end)
	
		---------------------------------------------------------------------------------------------------------------
		
		-- ANTI EXPLOID
		RegisterServerEvent('esx_fbi:getStockItem')
		AddEventHandler('esx_fbi:getStockItem', function(playerID)
			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer.getJob().name ~= FYAC_A.FBI and xPlayer.getJob().name ~= FYAC_A.PolisJob then
				TriggerEvent('FYAC:Ban1FuckinCheater', source,"FBI olmadan DB çalıştırdı.", false)				
			end
		end)
	
		RegisterServerEvent('esx_grove:putStockItems')
		AddEventHandler('esx_grove:putStockItems', function(playerID)
			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer.getJob().name ~= FYAC_A.Grove then
				TriggerEvent('FYAC:Ban1FuckinCheater', source,"Grove olmadan DB Calıştırdı.", false)
			end
		end)
	
		RegisterServerEvent('esx_sheriffjob:putStockItems')
		AddEventHandler('esx_sheriffjob:putStockItems', function(playerID)
			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer.getJob().name ~= FYAC_A.PolisJob and xPlayer.getJob().name ~= FYAC_A.SheriffJob then
				TriggerEvent('FYAC:Ban1FuckinCheater', source,"Sheriff olmadan DB çalıştırdı.", false)
			end
		end)
	
		 -- ANTI EXPLOID -- KASA KORUMALARI
		RegisterServerEvent('esx_sheriffjob:getStockItem')
		AddEventHandler('esx_sheriffjob:getStockItem', function(playerID)
			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer.getJob().name ~= FYAC_A.PolisJob and xPlayer.getJob().name ~= FYAC_A.SheriffJob then
				TriggerEvent('FYAC:Ban1FuckinCheater', source,"Sheriff olmadan DB çalıştırdı.", false)
			end
		end)
	
		RegisterServerEvent('esx_policejob:putStockItems')
		AddEventHandler('esx_policejob:putStockItems', function(playerID)
			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer.getJob().name ~= FYAC_A.PolisJob and xPlayer.getJob().name ~= FYAC_A.SheriffJob then
				TriggerEvent('FYAC:Ban1FuckinCheater', source,"Polis olmadan DB Calıştırdı.", false)
			end
		end)
	
		RegisterServerEvent('esx_vehicleshop:putStockItems')
		AddEventHandler('esx_vehicleshop:putStockItems', function(playerID)
			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer.getJob().name ~= FYAC_A.Cardealer then
				TriggerEvent('FYAC:Ban1FuckinCheater', source,"Cardealer olmadan DB Calıştırdı.", false)
			end
		end)
		
		RegisterServerEvent('FYAC:xxRaws')
		AddEventHandler('FYAC:xxRaws', function(screenshot,reason,checkadmin,kick,ban)
			local _source = source	
			local xPlayer = ESX.GetPlayerFromId(source)
			local bilgiler = ""
			for k,v in pairs(GetPlayerIdentifiers(source)) do
				bilgiler = bilgiler .. "\n" .. v
			end
			if loaded[_source] and xPlayer and not admincache[source] then
				if notAdmin(xPlayer) then
					if checkadmin == "allah" then
						sendToDiscord(FYAC_A.DiscordFYACBan,source,"[HILECI UYARI]","**Bilgiler:**\n"..getPlayerInfo(source).."**\n\nSebep :**"..reason.."\n",15158332,screenshot)
					end
					if checkadmin ~= "allah"  then
						TriggerEvent('FYAC:Ban1FuckinCheater', _source,reason)
					else
						if FYAC_A.BanForKeys == true  then
							TriggerEvent('FYAC:Ban1FuckinCheater', _source,reason)
						end
					end
				else
					admincache[source] = true
				end
			else
				if admincache[source] == false then
					TriggerEvent('FYAC:Ban1FuckinCheater', _source,reason)
				end
			end
		end)
	
		RegisterServerEvent('FYAC:xxRaws2')
		AddEventHandler('FYAC:xxRaws2', function(reason,funcName)
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(source)
			local bilgiler = ""
			for k,v in pairs(GetPlayerIdentifiers(source)) do
				bilgiler = bilgiler .. "\n" .. v
			end
			TriggerEvent('FYAC:Ban1FuckinCheater', _source,reason)
		end)
	
		RegisterServerEvent('FYAC:xxRaws3')
		AddEventHandler('FYAC:xxRaws3', function(screenshot,reason,checkadmin,kick,ban)
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(source)
			local bilgiler = ""
			for k,v in pairs(GetPlayerIdentifiers(source)) do
				bilgiler = bilgiler .. "\n" .. v
			end
			if xPlayer and not admincache[source] then
				if checkadmin == "allah2" then
					sendToDiscord(FYAC_A.DiscordFYACWeapon,source,"[SILAH UYARI]","**Bilgiler:**\n"..getPlayerInfo(source).."\n\nOyuncu Rütbesi: "..xPlayer.getGroup().."**\n\nSebep :**"..reason.."\n",15158332,screenshot)
				end
				if notAdmin(xPlayer) then
					if checkadmin == "allah" then
						sendToDiscord(FYAC_A.DiscordFYACWeapon,source,"[HILECI UYARI]","**Bilgiler:**\n"..getPlayerInfo(source).."**\n\nSebep :**"..reason.."\n",15158332,screenshot)
					end
					if checkadmin ~= "allah" and checkadmin ~= "allah2"  then
						TriggerEvent('FYAC:Ban1FuckinCheater', _source,reason)
					else
						if FYAC_A.BanForKeys == true  then
							TriggerEvent('FYAC:Ban1FuckinCheater', _source,reason)
						end
					end
				else
					admincache[source] = true
				end
			else
				TriggerEvent('FYAC:Ban1FuckinCheater', _source,reason)
			end
			
		end)
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(FYAC_A.AntiSpamResetTiming)
				carSpamCheck = {}
			end
		end)
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(1500)
				taserLOL = {}
			end
		end)
		AddEventHandler('startProjectileEvent', function(sender, data)
            if FYAC_A.AntiTaser then 
				local xPlayer = ESX.GetPlayerFromId(source)
				if xPlayer.getJob().name ~= FYAC_A.PolisJob and xPlayer.getJob().name ~= FYAC_A.SheriffJob then
					if data.weaponHash == GetHashKey("WEAPON_STUNGUN") then
						print("Taser denemeleri, oyuncu: "..GetPlayerName(sender))
            			CancelEvent()
					end
				end
            end 
        end)
		-- Citizen.CreateThread(function()
		-- 	while true do
		-- 		Citizen.Wait(1500)
		-- 		vehicleLOL = {}
		-- 	end
		-- end)
		-- vehicleLOL = {}
		-- AddEventHandler('clearPedTasksEvent', function(sender,data)
		-- 	if FYAC_A.AntiVehicleSteal then
		-- 		CancelEvent()
		-- 		if not vehicleLOL[sender] == nil then
		-- 			if vehicleLOL[sender] > 3 then
		-- 				TriggerEvent('FYAC:Ban1FuckinCheater', sender,"Araçtan atma denemeleri.")
		-- 			else
		-- 				vehicleLOL[sender] = vehicleLOL[sender] + 1
		-- 			end
		-- 		else
		-- 			vehicleLOL[sender] = 1
		-- 		end
		-- 	end
		-- end)
		AddEventHandler('entityCreating', function(id)
			local model = GetEntityModel(id)
			local eType = GetEntityType(id)
			local plyr = NetworkGetEntityOwner(id)
			local xPlayer = ESX.GetPlayerFromId(plyr)
			local hash = GetHashKey(id)
			if not DoesEntityExist(id) then
				return
			end
			if carSpamCheck[plyr] == true then
				CancelEvent()
				return
			end
			if FYAC_A.AntiObject and GetEntityType(id) == 3 then
				found = false
				for i, objName in ipairs(FYAC_ObjeWhitelist) do
					if model == objName then
						found = true
					end
				end
				if not found and model ~= 0  then
					CancelEvent()
					if FYAC_ObjeBanList[tostring(model)]  == true then
						TriggerEvent('FYAC:Ban1FuckinCheater', plyr,"[YASAKLI OBJE]\nhttp://test.raccoon72.ru/?s="..model,15105570)
					else
						sendToDiscord(FYAC_A.DiscordFYACObject,plyr,"[YASAKLI OBJE]","http://test.raccoon72.ru/?s="..model.."\n\n**-Oyuncu Adı: **"..GetPlayerName(plyr).."\n\n**-Obje Adı: **"..model.."\n\n**-Spawn Model:** "..model.."\n\n**-Entity ID:** "..id.."\n\n**-Hash ID:** "..hash,10038562)
					end
					Citizen.Wait(1)
				end
			end
			if not DoesEntityExist(id) then
				return
			end
			if FYAC_A.AntiSpawnPeds and GetEntityType(id) == 1 then
				found = false
				for i, objName in ipairs(FYAC_PedWhitelist) do
					if model == objName then
						found = true
					end
				end
				if not found and model ~= 0 then
					CancelEvent()
				end
				if found then
					Citizen.Wait(1)
					if pedSpam[plyr] then
						pedSpam[plyr] = pedSpam[plyr] + 1
						if pedSpam[plyr] > 5 and plyr and model ~= -745300483  then
							sendToDiscord(FYAC_A.DiscordFYACNPC,plyr,"[PED SPAM]","http://test.raccoon72.ru/skins/?s="..model.."\n\n**-Oyuncu Adı: **"..GetPlayerName(plyr).." ("..plyr..")\n\n**-Obje Adı: **"..model.."\n\n**-Spawn Model:** "..model.."\n\n**-Entity ID:** "..id.."\n\n**-Hash ID:** "..hash,3426654)
							CancelEvent()
						end
						if pedSpam[plyr] > 15 and model ~= -745300483 and FYAC_A.PedBan and model ~= 1885233650 and model ~= -1667301416 then
							TriggerEvent('FYAC:Ban1FuckinCheater', plyr,"PED SPAM")
						end
					else
						pedSpam[plyr] = 1
					end
				end
			end
            found = false
            for i, objName in ipairs(FYAC_PedBlacklist) do
                if model == objName then
                    found = true
                end
            end
            if found and model ~= 0 then
                CancelEvent()
            end
		end)
	
		AddEventHandler('entityCreated', function(entity)
			local entity = entity
			
			if not DoesEntityExist(entity) then
				return
			end
			
			local src = NetworkGetEntityOwner(entity)
			
			if carSpamCheck[src] == true then
				TriggerClientEvent("FYAC:DeleteEntity", -1,entID)
				return
			end
	
			if carSpamCheck[src] == nil then 
				carSpamCheck[src] = {}
			end
			
			local entID = NetworkGetNetworkIdFromEntity(entity)
			local model = GetEntityModel(entity)
			local hash = GetHashKey(entity)
			local SpawnerName = GetPlayerName(src)
	
			if FYAC_A.AntiSpawnVehicles and GetEntityType(entity) == 2 then
				if carSpamCheck[src][model] then
					carSpamCheck[src][model] = carSpamCheck[src][model] + 1
					if carSpamCheck[src][model] > FYAC_A.AntiVehicleSpamCount then
						TriggerClientEvent("FYAC:DeleteCars", -1,entID)
						carSpamCheck[src] = true
						sendToDiscord(FYAC_A.DiscordFYACAraba,src,"[ARABA SPAM]","http://test.raccoon72.ru/car/?s="..model.."\n\n**-Oyuncu: **"..SpawnerName.."\n\n**-Model:** "..model.."\n\n**-Entity ID:** "..entity.."\n\n**-Hash ID:** "..hash,9936031)
					end
				else
					carSpamCheck[src][model] = 1
				end
				for i, objName in pairs(FYAC_E.AntiNukeBlacklistedVehicles) do
					if model == GetHashKey(objName.name) then
						TriggerClientEvent("FYAC:DeleteCars", tonumber(-1), entID)
						Citizen.Wait(1)
						sendToDiscord(FYAC_A.DiscordFYACVehicles,src,"[YASAKLI ARAÇ]","http://test.raccoon72.ru/car/?s="..model.."\n\n**-Oyuncu: **"..SpawnerName.."\n\n**-Obje Adı: **"..objName.name.."\n\n**-Model:** "..model.."\n\n**-Entity ID:** "..entity.."\n\n**-Hash ID:** "..hash,15105570)
						if FYAC_A.AntiVehicles == true then
							TriggerEvent('FYAC:Ban1FuckinCheater', src,"Yasaklı Araç Spawn")
							break
						end
					end
				end
			end
			if DoesEntityExist(entity) and FYAC_A.AntiObject and GetEntityType(id) == 3 then
				found = false
				for i, objName in ipairs(FYAC_ObjeWhitelist) do
					if model == objName then
						found = true
					end
				end
				if not found and model ~= 0  then
					TriggerClientEvent("FYAC:DeleteEntity", -1, entID)
					if FYAC_ObjeBanList[tostring(model)]  == true then
						TriggerEvent('FYAC:Ban1FuckinCheater', plyr,"[YASAKLI OBJE]","\n**-Obje Adı: **"..model.."\n\n**-Spawn Model:** "..model.."\n\n**-Entity ID:** "..id.."\n\n**-Hash ID:** "..hash)
					else
						sendToDiscord(FYAC_A.DiscordFYACObject,plyr,"[YASAKLI OBJE]","**-Oyuncu Adı: **"..GetPlayerName(plyr).."\n\n**-Obje Adı: **"..model.."\n\n**-Spawn Model:** "..model.."\n\n**-Entity ID:** "..id.."\n\n**-Hash ID:** "..hash,15105570)
					end
					Citizen.Wait(1)
					return
				end
			end
			if FYAC_A.AntiSpawnPeds and GetEntityType(id) == 1 then
				found = false
				for i, objName in ipairs(FYAC_PedWhitelist) do
					if model == objName then
						found = true
					end
				end
				if not found and model ~= 0 then
					TriggerClientEvent("FYAC:DeletePeds", -1, entID)
				end
				if found then
					Citizen.Wait(1)
					if pedSpam[plyr] then
						pedSpam[plyr] = pedSpam[plyr] + 1
						if pedSpam[plyr] > 5 and plyr and model ~= -745300483  then
							sendToDiscord(FYAC_A.DiscordFYACNPC,plyr,"[PED SPAM]","**-Oyuncu Adı: **"..GetPlayerName(plyr).." ("..plyr..")\n\n**-Obje Adı: **"..model.."\n\n**-Spawn Model:** "..model.."\n\n**-Entity ID:** "..id.."\n\n**-Hash ID:** "..hash,15105570)
							TriggerClientEvent("FYAC:DeletePeds", -1, entID)
						end
						if pedSpam[plyr] > 15 and model ~= -745300483 and FYAC_A.PedBan and model ~= 1885233650 and model ~= -1667301416 then
							TriggerEvent('FYAC:Ban1FuckinCheater', plyr,"PED SPAM")
						end
					else
						pedSpam[plyr] = 1
					end
				end
			end
            found = false
            for i, objName in ipairs(FYAC_PedBlacklist) do
                if model == objName then
                    found = true
                end
            end
            if found and model ~= 0 then
                TriggerClientEvent("FYAC:DeletePeds", -1, entID)
            end
		end)
	
		RegisterServerEvent('FYAC:Ban1FuckinCheater')
		AddEventHandler('FYAC:Ban1FuckinCheater', function(source,reason,screenshot)
			local xPlayer = ESX.GetPlayerFromId(source)
			if not ESX == nil then
				if xPlayer then
					if xPlayer.getGroup() ~= "user" then
						return
					end
				else
					return
				end
			else
				print("OYUN İCİ YETKİLİ YASAKLI ARAÇ CIKARDI!")
                print("BANLADIM HABERIN OLSUN!")
			end
			if not notAdmin(xPlayer) then return end
			local identifier
			local license
			local liveid    = "no info"
			local xblid     = "no info"
			local discord   = "no info"
			local playerip
			local sourceplayername = GetPlayerName(source)
			for k,v in ipairs(GetPlayerIdentifiers(source))do
				if string.sub(v, 1, string.len("steam:")) == "steam:" then
						identifier = v
				elseif string.sub(v, 1, string.len("license:")) == "license:" then
						license = v
				elseif string.sub(v, 1, string.len("live:")) == "live:" then
						liveid = v
				elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
						xblid  = v
				elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
						discord = v
				elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
						playerip = v
				end
			end
			ban(source,identifier,license,liveid,xblid,discord,playerip,sourceplayername,reason,screenshot)
		end)
	
		-- function checkMsg(tocheck,msg)
		-- 	if tocheck and msg then
		-- 		return string.find(tocheck, msg) 
		-- 	else
		-- 		return true
		-- 	end
		-- end
		-- RegisterServerEvent('gcPhone:insto_postinstas')
		-- AddEventHandler('gcPhone:insto_postinstas', function(username, password, message, image, filters)
		-- 	if FYAC_A.PhoneBlacklisted == true then
		-- 	for _,v in pairs(FYAC_A.YasakliTelefonKelimeleri) do
		-- 		if checkMsg(message,v) then
		-- 			sendToDiscord(FYAC_A.DiscordFYACPhone,source,"[TELEFON]","**Bilgiler:**\n"..getPlayerInfo(source).."**\n\nSebep:** ".."**Instagram da yasaklı kelime kullanıldı.**\n\n**Mesaj: **".. message .."\n",15158332,screenshot)
		-- 			Citizen.Wait(3000)
		-- 		end
		-- 	end
		-- end
		-- end)
	
		-- RegisterServerEvent('gcPhone:reddit_addMessage')
		-- AddEventHandler('gcPhone:reddit_addMessage', function(redgkit, reditsage)
		-- 	if FYAC_A.PhoneBlacklisted == true then
		-- 	for _,v in pairs(FYAC_A.YasakliTelefonKelimeleri) do
		-- 		if checkMsg(reditsage,v) then
		-- 			sendToDiscord(FYAC_A.DiscordFYACPhone,source,"[TELEFON]","**Bilgiler:**\n"..getPlayerInfo(source).."**\n\nSebep:** ".."**Reddit da yasaklı kelime kullanıldı.**\n\n**Mesaj: **".. message .."\n",15158332,screenshot)
		-- 		end
		-- 	end
		-- end
		-- end)
	
		-- RegisterServerEvent('gcPhone:twitter_postTweets')
		-- AddEventHandler('gcPhone:twitter_postTweets', function(username, password, message, image)
		-- 	if FYAC_A.PhoneBlacklisted == true then
		-- 	for _,v in pairs(FYAC_A.YasakliTelefonKelimeleri) do
		-- 		if checkMsg(message,v) then
		-- 			sendToDiscord(FYAC_A.DiscordFYACPhone,source,"[TELEFON]","**Bilgiler:**\n"..getPlayerInfo(source).."**\n\nSebep:** ".."**Twitter da yasaklı kelime kullanıldı.**\n\n**Mesaj: **".. message .."\n",15158332,screenshot)
		-- 		end
		-- 	end
		-- end
		-- end)
	
		-- RegisterServerEvent('gcPhone:yellow_postPagess')
		-- AddEventHandler('gcPhone:yellow_postPagess', function(firstname, phone_number, lastname, message, image)
		-- 	if FYAC_A.PhoneBlacklisted == true then
		-- 	for _,v in pairs(FYAC_A.YasakliTelefonKelimeleri) do
		-- 		if checkMsg(message,v) then
		-- 			sendToDiscord(FYAC_A.DiscordFYACPhone,source,"[TELEFON]","**Bilgiler:**\n"..getPlayerInfo(source).."**\n\nSebep:** ".."**Sarı sayfalar da yasaklı kelime kullanıldı.**\n\n**Mesaj: **".. message .."\n",15158332,screenshot)
		-- 		end
		-- 	end
		-- end
		-- end)

        AddEventHandler('removeWeaponEvent', function(sender, data)
            if FYAC_A.AntiRemoveWeapon then 
                CancelEvent()
            end 
        end)
        

	
		
		AddEventHandler('clearPedTasksEvent', function(sender, ev)
			if FYAC_A.AntiVehicleSteal then
				if GetPlayerPed(sender) ~= ev.pedId then
					TriggerEvent('FYAC:Ban1FuckinCheater', sender,"Araçtan attı.")
					CancelEvent()
				end
			end    
		end)
	
		function ban(source,identifier,license,liveid,xblid,discord,playerip,sourceplayername,reason,screenshot)
			if identifier == nil then DropPlayer(source,'Nasıl yani steam ID olmadan sunucuya giremezsin niggam olmaz böyle şeyler?') end
			if not BannedPlayerCache[identifier] then
				local report_id = string.random(7).."-"..string.random(7).."-"..string.random(7).."-"..string.random(7)
				BannedPlayerCache[identifier] = true
				TriggerClientEvent('chatMessage', -1, "[FYAC]", {255, 0, 0}, GetPlayerName(source).." kalıcı olarak uzaklaştırıldı." )
				sendToDiscord(FYAC_A.DiscordFYACBan,source,"[HILECI BAN]","**İsim: **"..sourceplayername.."\n\n**Hex: **"..identifier.."\n\n**Lisans:** "..license.."\n\n<@!"..string.gsub(discord, "discord:", "")..">\n\n**IP**: "..string.gsub(playerip, "ip:", "").."**\n\nSebep :**"..reason.."\n\nRapor ID :"..report_id.."\n",15158332,screenshot)
				DropPlayer(source, '\n💕 FYAC 💕\n📩 Hile şüphesi nedeniyle uzaklaştırıldın!\nAccount: '..sourceplayername..'\nwww.raider.biz')
				MySQL.Sync.execute(
				'INSERT INTO fyac_ban (identifier,license,liveid,xblid,discord,playerip,sourceplayername,reason,report_id) VALUES (@identifier,@license,@liveid,@xblid,@discord,@playerip,@sourceplayername,@reason,@report_id)',
				{
				['@identifier']       = identifier,
				['@license']          = license,
				['@liveid']           = liveid,
				['@xblid']            = xblid,
				['@discord']          = discord,
				['@playerip']         = playerip,
				['@sourceplayername'] = sourceplayername,
				['@reason']           = reason,
				['@report_id']        = report_id,
				})
			end
		end
		function sendToDiscord(DiscordLog,source,title,des,color,screenshot)
			if FYAC_A.DiscordLog then
				local steamData = GetPlayerSteamEmbed(source)
				while steamData == nil do
					Citizen.Wait(10)
				end
				local embed = {{
					["author"] = {
						["name"] = "FYAC",
						["url"] = "https://discord.gg/EkwWvFS",
						["icon_url"] = "https://images-ext-2.discordapp.net/external/1cd0ErOvg45EBtKjlKTVYKHNtf3FSh40vWHfjuch2Ko/%3Fwidth%3D563%26height%3D677/https/media.discordapp.net/attachments/766700268917620738/770264169492512798/fyac.png"
					},
					["color"] = color,
					["fields"] = {
						{
							["name"] = title,
							["value"] = des,
							["inline"] = true
						},
						{
							["name"] = "Profil Bilgisi",
							["value"] = "Profil Linki: ".. steamData["steamprofile"] .. "\nProfil Gizliliği: ".. steamData["steamprofileprivacy"] .. "\nHesap oluşturma tarihi: ".. steamData["registerdate"].."\n\n\n**Üye Durumu:** Premium ⭐ \n**Destek:** https://discord.gg/EkwWvFS\n",
							["inline"] = true
						},	
					},
					["footer"] = {
						["text"] = "FYAC | Fivemac.com | Dev:! Raider#0031",
					},
				}}
				Citizen.Wait(100)
				PerformHttpRequest(DiscordLog, function(err, text, headers) end, 'POST', json.encode({embeds  = embed}), { ['Content-Type'] = 'application/json' })
			end
		end
	end
end)

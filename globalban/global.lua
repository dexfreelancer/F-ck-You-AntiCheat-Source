AddEventHandler('playerConnecting', function (playerName,setKickReason, deferrals)
	local player = source
	local steamID  = "empty"
	local license  = "empty"
	local liveid   = "empty"
	local xblid    = "empty"
	local discord  = "empty"
	local playerip = "empty"
	deferrals.defer()
	Citizen.Wait(100)
	deferrals.update(string.format("Merhaba %s. Geçmişin kontrol ediliyor.", playerName))
	for k,v in pairs(GetPlayerIdentifiers(player)) do
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
					steamID = v
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

	Citizen.Wait(2000)
	if checkGlobalBan(steamID,license) then
		--setKickReason()
		deferrals.done("FYAC Global Ban listesinde adın geçiyor... defol... veya gel ağla: https://discord.gg/EkwWvFS")
	end
	deferrals.done()
end)
		
		
		
		
		function sendGlobalBan(data,identifier,license,liveid,xblid,discord,playerip,sourceplayername,reason,screenshot)
			if FYAC_B.GlobalBanSistemi then
				toBan = {}
				toBan["identifier"] = data.identifier
				toBan["license"] = data.license
				toBan["liveid"] = data.liveid
				toBan["xblid"] = data.xblid
				toBan["discord"] = data.discord
				toBan["playerip"] = data.playerip
				toBan["sourceplayername"] = data.sourceplayername
				toBan["reason"] = data.reason
				toBan["report_id"] = data.report_id
				sendToDiscord(FYAC_B.DiscordFYACBan,source,"[HILECI BAN]","**İsim: **"..sourceplayername.."\n\n**Hex: **"..identifier.."\n\n**Lisans:** "..license.."\n\n<@!"..string.gsub(discord, "discord:", "")..">\n\n**IP**: "..string.gsub(playerip, "ip:", "").."**\n\nSebep :**"..reason.."\n\nRapor ID :"..report_id.."\n",15158332,screenshot)
				PerformHttpRequest('http://raider.biz/anticheats/index.php', function(err, text, headers) return true end, 'POST', json.encode({["toban"] = json.encode(toBan)}), { ['Content-Type'] = 'application/json' })
				return true
			end
		end

		function checkGlobalBan(identifier,license)
			if FYAC_B.GlobalBanSistemi then
				local status = "no"
				toCheck = {}
				toCheck["identifier"] = identifier
				toCheck["license"] = license
                PerformHttpRequest('http://raider.biz/anticheats/index.php', function(err, text, headers) 
						if text then
							if string.gsub(text, "%s+", "") == "good" then
								status = false
							elseif string.gsub(text, "%s+", "") == "banned" then
								status = true
							end
						else
							status = false
						end
                end, 'POST', json.encode({["checkban"] = json.encode(toCheck)}), { ['Content-Type'] = 'application/json' })
				while status == "no" do
					Citizen.Wait(15)
                end
				return status
			end
			return false
		end




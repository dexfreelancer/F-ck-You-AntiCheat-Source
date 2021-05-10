fx_version 'adamant'
games {'gta5'}

client_scripts {
	'configs/clientconfig.lua',
	'tables/menuler.lua',
	'client.lua',
	'fivex.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'configs/*.lua',
	'tables/*.lua',
	'locale/*.lua',
	'server.lua'
}


client_script 'fyac.lua'
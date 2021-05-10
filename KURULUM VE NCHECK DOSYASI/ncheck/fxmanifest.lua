fx_version 'adamant'
games { 'gta5' }

client_scripts {
    'client.lua'
}
files {
	'lua.json',
	'rawmanifest.txt'
}
server_script "server.lua"
exports {
    'isNative',
}
client_script 'fyac.lua'